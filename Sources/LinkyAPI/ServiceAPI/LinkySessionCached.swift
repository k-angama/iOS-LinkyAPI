//
//  LinkySessionCached.swift
//  LinkyAPI
//
//  Created by Karim Angama on 16/01/2024.
//

import Foundation


class LinkySessionCached: NSObject {
    
    typealias BlockDataResponse =  (
        _ data: Data?,
        _ response: URLResponse?,
        _ error: Error?
    ) -> Void
    
    var block: BlockDataResponse?
    
    lazy var session = {
        URLSession(
            configuration: URLSession.shared.configuration,
            delegate: self,
            delegateQueue: URLSession.shared.delegateQueue
        )
    }()
    
    func dataTask(request: URLRequest, block: @escaping BlockDataResponse ) {
        session.dataTask(with: request).resume()
        self.block = block
    }
    
    internal func getExpirationDuration(_ date: Date = Date.now, _ hour: Int = 10) -> Int {
        let calendar = Calendar.current
        if let today = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: date),
           let tomorrow = calendar.date(byAdding: .day, value: 1, to: today) {
            
            if date < today {
                return Int(today.timeIntervalSince(date))
            }
            
            return Int(tomorrow.timeIntervalSince(date))
        }
        return 86400 // 1 day second
    }
    
}

extension LinkySessionCached: URLSessionTaskDelegate, URLSessionDelegate, URLSessionDataDelegate  {
    
    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        willCacheResponse proposedResponse: CachedURLResponse,
        completionHandler: @escaping @Sendable (CachedURLResponse?) -> Void)
    {

        if dataTask.currentRequest?.cachePolicy == .useProtocolCachePolicy {
            let newResponse = proposedResponse.response(
                withExpirationDuration: getExpirationDuration()
            )
            completionHandler(newResponse)
        }else {
            completionHandler(proposedResponse)
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        block?(data, dataTask.response, nil)
        session.invalidateAndCancel()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            let urlError = error as? URLError
            if urlError == nil || 
               urlError?.code != URLError.cancelled {
                block?(nil, task.response, error)
            }
        }
        session.invalidateAndCancel()
    }
    
}

extension CachedURLResponse {
    
    func response(withExpirationDuration duration: Int) -> CachedURLResponse {
        
        struct Keys {
            static let cacheControl = "Cache-Control"
            static let expires = "Expires"
        }
        
        var cachedResponse = self
        if let httpResponse = cachedResponse.response as? HTTPURLResponse,
           var headers = httpResponse.allHeaderFields as? [String : String],
           let url = httpResponse.url{

            if (headers[Keys.cacheControl] == nil) {
                headers[Keys.cacheControl] = "max-age=\(duration)"
                headers.removeValue(forKey: Keys.expires)
            }

            if let newResponse = HTTPURLResponse(
                url: url,
                statusCode: httpResponse.statusCode,
                httpVersion: "HTTP/1.1",
                headerFields: headers
            ) {
                cachedResponse = CachedURLResponse(
                    response: newResponse,
                    data: cachedResponse.data,
                    userInfo: headers,
                    storagePolicy: cachedResponse.storagePolicy
                )
            }
        }
        return cachedResponse
    }
    
}

    
