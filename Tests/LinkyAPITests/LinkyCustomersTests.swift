//
//  LinkyCustomersTests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 28/01/2024.
//

import XCTest
@testable import LinkyAPI

final class LinkyCustomersTests: XCTestCase {
    
    var linkyCustomer: LinkyCustomer!
    var linkyService: LinkyServiceAPIMock!

    override func setUpWithError() throws {
        let account = LinkyAccountMock()
        let linkyConfig = LinkyConfiguration(
            clientId: "832d-451c-9005",
            clientSecret: "AfGT8-4f6d-a345-1208",
            redirectURI: URL(string: "fake.url-redirect.com")!
        )
        linkyService = LinkyServiceAPIMock(configuration: linkyConfig, account: account)
        linkyCustomer  = LinkyCustomer.shared
        linkyCustomer.linkyAPI = linkyService
    }

    override func tearDownWithError() throws {
        linkyCustomer = nil
        linkyService = nil
    }

    func testContracts() throws {
        let exp = XCTestExpectation(description: "Success closure should be executed")
        
        let customer_id = "1358019319"
        let usage_point_id =  "12345678910123"
        let usage_point_status = "com"
        let meter_type = "AMM"
        let segment = "C5"
        let subscribed_power = "9 kVA"
        let last_activation_date = "2013-08-14+01:00"
        let distribution_tariff = "BTINFCUST"
        let offpeak_hours = "HC (23h00-7h30)"
        let contract_type = "CRAE"
        let contract_status = "SERVC"
        let last_distribution_tariff_change_date = "2017-05-25+01:00"
        
        linkyService.customerRaw = LinkyCustomerRaw(
            customer: LinkyContractsCustomerRaw(
                customer_id: customer_id,
                usage_points:[
                    LinkyContractsUsagePointsRaw(
                        usage_point: LinkyContractsUsagePointRaw(
                            usage_point_id: usage_point_id,
                            usage_point_status: usage_point_status,
                            meter_type: meter_type
                        ),
                        contracts: LinkyContractsRaw(
                            segment: segment,
                            subscribed_power: subscribed_power,
                            last_activation_date: last_activation_date,
                            distribution_tariff: distribution_tariff,
                            offpeak_hours: offpeak_hours,
                            contract_type: contract_type,
                            contract_status: contract_status,
                            last_distribution_tariff_change_date: last_distribution_tariff_change_date
                        )
                    )
                ]
            )
        )
        
        linkyCustomer.contracts()
        { contracts, error in
            guard let contracts = contracts else { return }
            XCTAssertEqual(contracts.customer.customerId, customer_id)
            XCTAssertEqual(contracts.customer.usagePoints.isEmpty, false)
            for item in contracts.customer.usagePoints {
                XCTAssertEqual(item.usagePoint.usagePointId, usage_point_id)
                XCTAssertEqual(item.usagePoint.usagePointStatus, usage_point_status)
                XCTAssertEqual(item.usagePoint.meterType, meter_type)
                XCTAssertEqual(item.contracts.segment, segment)
                XCTAssertEqual(item.contracts.subscribedPower, subscribed_power)
                XCTAssertEqual(
                    item.contracts.lastActivationDate.ISO8601Format(),
                    last_activation_date.date().ISO8601Format()
                )
                XCTAssertEqual(item.contracts.distributionTariff, distribution_tariff)
                XCTAssertEqual(item.contracts.offpeakHours, offpeak_hours)
                XCTAssertEqual(item.contracts.contractType, contract_type)
                XCTAssertEqual(item.contracts.contractStatus, contract_status)
                XCTAssertEqual(
                    item.contracts.lastDistributionTariffChangeDate.ISO8601Format(),
                    last_distribution_tariff_change_date.date().ISO8601Format()
                )
            }
            XCTAssertNil(error)
            exp.fulfill()
         }
        
        wait(for: [exp], timeout: 3)
    }

}
