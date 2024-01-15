//
//  LinkyServiceAPI.swift
//  LinkyAPI
//
//  Created by Karim Angama on 20/06/2023.
//

import Foundation


protocol LinkyAPI {
    init(configuration: LinkyConfiguration, account: LinkyAccount)
    func accessToken(block: @escaping (_ accessToken: LinkyAccessTokenRaw?, _ error: Error?) -> Void)
    func consumption(start: String, end: String, route: LinkyAPIRoute, block: @escaping (LinkyConsumptionRaw?, Error?) -> Void)
}

class LinkyServiceAPI: NSObject, LinkyAPI {
    
    var configuration: LinkyConfiguration
    var account: LinkyAccount
    var sessionCached: LinkySessionCached {
        LinkySessionCached()
    }
    
    required init(configuration: LinkyConfiguration, account: LinkyAccount) {
        self.configuration = configuration
        self.account = account
    }
    
    func accessToken(block: @escaping (LinkyAccessTokenRaw?, Error?) -> Void) {
        guard let url =  URL(string: "\(configuration.mode.baseUrlEnvironment)\(LinkyAPIRoute.auth.rawValue)"),
        let authorization = "\(configuration.clientId):\(configuration.clientSecret)"
            .data(using: .utf8)?
            .base64EncodedString() else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(
            authorization,
            forHTTPHeaderField: "Authorization"
        )
        urlRequest.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = "grant_type=client_credentials&client_id=\(configuration.clientId)&client_secret=\(configuration.clientSecret)"
            .data(using: .utf8)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            self.dataTaskResponse(response: response, data: data, error: error, intercepResponse: nil, block: block)
        }.resume()
    }
    
    func consumption(start: String, end: String, route: LinkyAPIRoute, block: @escaping (LinkyConsumptionRaw?, Error?) -> Void) {
        
        guard start.date() <= end.date() else {
            block(nil, LinkyAPIErro.dateError)
            return
        }
        
        guard var urlComps = URLComponents(string: "\(configuration.mode.baseUrlEnvironment)\(route.rawValue)")  else { return }
        urlComps.queryItems = [
            URLQueryItem(name: "usage_point_id", value: account.getUsagePointsId()),
            URLQueryItem(name: "start", value: start),
            URLQueryItem(name: "end", value: end),
        ]

        var urlRequest = URLRequest(url: urlComps.url!)
        urlRequest.httpMethod = "GET"
        
        dataTask(with: urlRequest, block: block)
        
    }

    internal func dataTask<T: Codable>(
        with urlRequest: URLRequest,
        block: @escaping (T?, Error?) -> Void) {
            
            sessionCached.dataTask(request: updateAccessToken(to: urlRequest)) { data, response, error in
                self.dataTaskInterceptTokenResponse(
                    with: urlRequest,
                    response: response,
                    data: data,
                    error: nil, block: block
                )
            }
    }
    
    internal func dataTaskInterceptTokenResponse<T: Codable>(
        with urlRequest: URLRequest,
        response: URLResponse?,
        data: Data?,
        error: Error?,
        block: @escaping (T?, Error?) -> Void) {
        
        dataTaskResponse(response: response, data: data, error: error, intercepResponse: { [weak self] in
            guard let self = self else { return false }
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 401 && !self.checkRouteAccessToken(urlRequest.url) {
                self.accessToken { accessToken, error in
                    
                    if let token = accessToken {
                        let accessToken = LinkyAccessTokenMapper.rawToEntity(raw: token)
                        self.account.setExpireAccessToken(accessToken.expiresIn)
                        self.account.setAcceesToken(accessToken.accessToken)
                        self.dataTask(with: self.updateAccessToken(to: urlRequest), block: block)
                    }else{
                        self.account.deleteAcceesToken()
                        self.account.deleteUsagePointsId()
                        self.account.setExpireAccessToken(0)
                        block(nil, error)
                    }
                }
                return true
            }
            return false
        }, block: block)
        
    }
    
    internal func dataTaskResponse<T: Codable>(
        response: URLResponse?,
        data: Data?, error: Error?,
        intercepResponse: (() -> Bool)?,
        block: @escaping (T?, Error?) -> Void) {
            
            if let error = error {
                block(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let httpResponse = response as? HTTPURLResponse
                
                if let inter = intercepResponse, inter() {
                    return
                }
                
                var messageError = "Not error message"
                if let data = data {
                    messageError = String(data: data, encoding: .utf8) ?? "-"
                }
                
                block(nil, NSError(
                    domain: "com.angama.LinkyServiceAPI",
                    code: httpResponse?.statusCode ?? 500,
                    userInfo: [NSLocalizedDescriptionKey: messageError])
                )
                return
            }
            
            do {
                guard let data = data else {
                    throw NSError(
                        domain: "com.angama.LinkyServiceAPI",
                        code: 500,
                        userInfo: [NSLocalizedDescriptionKey: "Data error"]
                    )
                    
                }
                let entity = try JSONDecoder().decode(T.self, from: data)
                block(entity, nil)
            } catch {
                block(nil, error)
            }
            
    }
    
    // MARK: - Private Methode
    
    private func checkRouteAccessToken(_ url: URL?) -> Bool {
        url?.absoluteString.contains("\(LinkyAPIRoute.auth.rawValue)") ?? false
    }
    
    private func addAccessToken(to urlRequest: URLRequest) -> URLRequest {
        var urlRequest = urlRequest
        if !checkRouteAccessToken(urlRequest.url) {
            urlRequest.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.addValue("Bearer \(account.getAcceesToken() ?? "")", forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
    
    private func updateAccessToken(to urlRequest: URLRequest) -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(self.account.getAcceesToken() ?? "")", forHTTPHeaderField: "Authorization")
        return urlRequest
    }

    
}
