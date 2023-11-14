//
//  LinkyServiceAPIImplMock.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 06/08/2023.
//

import Foundation
import XCTest
@testable import LinkyAPI

class LinkyServiceAPIImplMock: LinkyServiceAPI {
    
    override func accessToken(block: @escaping (LinkyAccessTokenRaw?, Error?) -> Void) {
        let url = URL(string: "http://fake.url.com/oauth2/v3/token")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let entity = LinkyAccessTokenRaw(
            access_token: "1234",
            token_type: "Bearer",
            expires_in: 12600,
            scope: nil
        )
        let data = try? JSONEncoder().encode(entity)
        self.dataTaskResponse(response: response, data: data, error: nil, intercepResponse: nil, block: block)
    }
    
    override func dataTask<T>(with urlRequest: URLRequest, block: @escaping (T?, Error?) -> Void) where T : Decodable, T : Encodable {
        let url = URL(string: "http://fake.url.com\(LinkyAPIRoute.dailyConsumption)")!
        let entity = LinkyConsumptionRaw(
            meter_reading: MeterReadingRaw(
                usage_point_id: "75FUF748YG",
                start: "2023-06-10",
                end: "2023-06-20",
                quality: "w",
                reading_type: nil,
                interval_reading: [])
        )
        let data = try? JSONEncoder().encode(entity)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        // XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authorization"), "Bearer 1234")
        self.dataTaskInterceptTokenResponse(with: urlRequest, response: response, data: data, error: nil, block: block)
    }
    
    
}
