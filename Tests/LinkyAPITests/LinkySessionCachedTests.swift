//
//  LinkySessionCachedTests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 16/01/2024.
//

import XCTest
@testable import LinkyAPI

final class LinkySessionCachedTests: XCTestCase {
    
    var linkySessionCached: LinkySessionCachedMock!

    override func setUpWithError() throws {
        linkySessionCached = LinkySessionCachedMock()
    }

    override func tearDownWithError() throws {
        linkySessionCached = nil
    }
    
    func testDelegateWithData() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let request = URLRequest(url: URL(string: "fake.url-redirect.com")!)
        linkySessionCached.dataTask(request: request) { data, response, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            exp.fulfill()
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request)
        linkySessionCached.urlSession(session, dataTask: dataTask, didReceive: Data())
        
        wait(for: [exp], timeout: 1)
    }
    
    func testDelegateWithError() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let request = URLRequest(url: URL(string: "fake.url-redirect.com")!)
        linkySessionCached.dataTask(request: request) { data, response, error in
            XCTAssertNotNil(error)
            XCTAssertNil(data)
            exp.fulfill()
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request)
        let error = NSError(domain: "fake.domain.com", code: 500)
        linkySessionCached.urlSession(session, task: dataTask, didCompleteWithError: error)
        
        wait(for: [exp], timeout: 3)
    }
    
    func testDelegateWithURLErrorCancelled() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let request = URLRequest(url: URL(string: "fake.url-redirect.com")!)
        linkySessionCached.dataTask(request: request) { data, response, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            exp.fulfill()
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request)
        let error = URLError(URLError.cancelled)
        linkySessionCached.urlSession(session, dataTask: dataTask, didReceive: Data())
        linkySessionCached.urlSession(session, task: dataTask, didCompleteWithError: error)
        wait(for: [exp], timeout: 3)
    }
    
    func testDelegateWithURLError() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let request = URLRequest(url: URL(string: "fake.url-redirect.com")!)
        linkySessionCached.dataTask(request: request) { data, response, error in
            XCTAssertNotNil(error)
            XCTAssertNil(data)
            exp.fulfill()
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request)
        let error = URLError(URLError.unknown)
        linkySessionCached.urlSession(session, task: dataTask, didCompleteWithError: error)
        wait(for: [exp], timeout: 3)
    }
    
    func testDelegateWithErrorIsNull() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let request = URLRequest(url: URL(string: "fake.url-redirect.com")!)
        linkySessionCached.dataTask(request: request) { data, response, error in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            exp.fulfill()
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request)
        linkySessionCached.urlSession(session, task: dataTask, didCompleteWithError: nil)
        linkySessionCached.urlSession(session, dataTask: dataTask, didReceive: Data())
        
        wait(for: [exp], timeout: 3)
        
    }
    
    func testCachedURLResponseWhenCacheControlIsNull() throws {
        
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let request = URLRequest(url: URL(string: "fake.url-redirect.com")!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request)
        let cachedURLResponse = getCachedURLResponse(
            session: session,
            dataTask: dataTask,
            headerFields: nil
        )
        linkySessionCached.expirationDuration = 69020
        linkySessionCached.urlSession(session, dataTask: dataTask, willCacheResponse: cachedURLResponse) { cachedResponse in
            if let httpResponse = cachedResponse?.response as? HTTPURLResponse,
               let headers = httpResponse.allHeaderFields as? [String : String] {
                XCTAssertNotNil(headers["Cache-Control"])
                XCTAssertEqual(headers["Cache-Control"], "max-age=69020")
                exp.fulfill()
               }
        }
        
        wait(for: [exp], timeout: 3)
        
    }
    
    func testCachedURLResponseWhenCacheControlIsNotNull() throws {
        
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let request = URLRequest(url: URL(string: "fake.url-redirect.com")!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request)
        let cachedURLResponse = getCachedURLResponse(
            session: session,
            dataTask: dataTask,
            headerFields: ["Cache-Control": "max-age=69020"]
        )
        linkySessionCached.expirationDuration = 99020
        linkySessionCached.urlSession(session, dataTask: dataTask, willCacheResponse: cachedURLResponse) { cachedResponse in
            if let httpResponse = cachedResponse?.response as? HTTPURLResponse,
               let headers = httpResponse.allHeaderFields as? [String : String] {
                XCTAssertNotNil(headers["Cache-Control"])
                XCTAssertEqual(headers["Cache-Control"], "max-age=69020")
                exp.fulfill()
               }
        }
        
        wait(for: [exp], timeout: 3)
        
    }
    
    func testWhenCachePolicyIsNotUseProtocolCachePolicyAndHeaderFieldsIsNull() throws {
        
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let request = URLRequest(
            url: URL(string: "fake.url-redirect.com")!,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData
        )
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request)
        let cachedURLResponse = getCachedURLResponse(
            session: session,
            dataTask: dataTask,
            headerFields: nil
        )
        linkySessionCached.expirationDuration = 99020
        linkySessionCached.urlSession(session, dataTask: dataTask, willCacheResponse: cachedURLResponse) { cachedResponse in
            if let httpResponse = cachedResponse?.response as? HTTPURLResponse,
               let headers = httpResponse.allHeaderFields as? [String : String] {
                XCTAssertNil(headers["Cache-Control"])
                exp.fulfill()
               }
        }
        
        wait(for: [exp], timeout: 3)

    }
    
    private func getCachedURLResponse(
        session: URLSession,
        dataTask: URLSessionDataTask,
        headerFields: [String : String]?
    ) -> CachedURLResponse {
        let response = HTTPURLResponse(
            url: dataTask.currentRequest!.url!,
            statusCode: 200,
            httpVersion: "HTTP/1.1",
            headerFields: headerFields
        )
        return CachedURLResponse(response: response!, data: Data())
    }

}
