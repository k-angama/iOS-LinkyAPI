//
//  LinkyAPITests.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 13/06/2023.
//

import XCTest
@testable import LinkyAPI

final class LinkyAPIMapperTests: XCTestCase {

    func testRetunNullParamsLinkyAccessTokenRaw() throws {
        let entity = LinkyAccessTokenMapper.rawToEntity(
            raw: LinkyAccessTokenRaw(
                access_token: nil,
                token_type: nil,
                expires_in: nil,
                scope: nil
            )
        )
        XCTAssertEqual(entity.accessToken, "")
        XCTAssertEqual(entity.tokenType, "")
        XCTAssertEqual(entity.expiresIn, 0)
        XCTAssertEqual(entity.scope, "")
    }
    
    func testRetunNotNullParamsLinkyAccessTokenRaw() throws {
        let accessToken = "TZhNi00MzVmLWI0MjQtMzg4MmIwMGI2ZTI1In"
        let tokenType = "Bearer"
        let expiresIn = 12600
        let scope = "am_application_scope default"
        let entity = LinkyAccessTokenMapper.rawToEntity(
            raw: LinkyAccessTokenRaw(
                access_token: accessToken,
                token_type: tokenType,
                expires_in: expiresIn,
                scope: scope
            )
        )
        XCTAssertEqual(entity.accessToken, accessToken)
        XCTAssertEqual(entity.tokenType, tokenType)
        XCTAssertEqual(entity.expiresIn, expiresIn)
        XCTAssertEqual(entity.scope, scope)
    }

    func testRetunNullLinkyConsumptionRaw() throws {
        let raw = LinkyConsumptionMapper.rawToEntity(
            raw: LinkyConsumptionRaw(
                meter_reading: MeterReadingRaw(
                    usage_point_id: nil,
                    start: nil,
                    end: nil,
                    quality: nil,
                    reading_type: nil,
                    interval_reading: nil
                )
            )
        )
        let entity = raw.meterReading
        XCTAssertEqual(entity.usagePointId, "")
        XCTAssertEqual(entity.start, Date.null)
        XCTAssertEqual(entity.end, Date.null)
        XCTAssertEqual(entity.quality, "")
        XCTAssertEqual(entity.readingType.aggregate, "")
        XCTAssertEqual(entity.readingType.unit, "")
        XCTAssertEqual(entity.readingType.aggregate, "")
        XCTAssertEqual(entity.intervalReading.count, 0)
    }
    
    func testRetunNullLinkyConsumptionRawAndLinkyConsumptionIntervalReadingRaw() throws {
        let raw = LinkyConsumptionMapper.rawToEntity(
            raw: LinkyConsumptionRaw(
                meter_reading: MeterReadingRaw(
                    usage_point_id: nil,
                    start: nil,
                    end: nil,
                    quality: nil,
                    reading_type: LinkyConsumptionReadingTypeRaw(
                        measurement_kind: nil,
                        unit: nil,
                        aggregate: nil
                    ),
                    interval_reading: [
                        LinkyConsumptionIntervalReadingRaw(
                            value: nil, 
                            date: nil
                        )
                    ]
                )
            )
        )
        let entity = raw.meterReading
        XCTAssertEqual(entity.usagePointId, "")
        XCTAssertEqual(entity.start, Date.null)
        XCTAssertEqual(entity.end, Date.null)
        XCTAssertEqual(entity.quality, "")
        XCTAssertEqual(entity.readingType.measurementKind, "")
        XCTAssertEqual(entity.readingType.unit, "")
        XCTAssertEqual(entity.readingType.aggregate, "")
        for item in entity.intervalReading {
            XCTAssertEqual(item.date, Date.null)
            XCTAssertEqual(item.value, "0")
        }
    }
    
    func testRetunNotNullLinkyConsumptionRaw() throws {
        let usagePointId = "42900589957121"
        let start = "2023-01-10"
        let end = "2023-04-01 12:00:44"
        let quality = "BRUT"
        let measurementKind = "energy"
        let unit = "Wh"
        let aggregate = "sum"
        let value = "49171"
        let date = "2023-01-10 22:00:44"
        let raw = LinkyConsumptionMapper.rawToEntity(
            raw: LinkyConsumptionRaw(
                meter_reading: MeterReadingRaw(
                    usage_point_id: usagePointId,
                    start: start,
                    end: end,
                    quality: quality,
                    reading_type: LinkyConsumptionReadingTypeRaw(
                        measurement_kind: measurementKind,
                        unit: unit,
                        aggregate: aggregate
                    ),
                    interval_reading: [
                        LinkyConsumptionIntervalReadingRaw(
                            value: value,
                            date: date
                        )
                    ]
                )
            )
        )
        let entity = raw.meterReading
        XCTAssertEqual(entity.usagePointId, usagePointId)
        XCTAssertEqual(entity.start, start.date())
        XCTAssertEqual(entity.end, end.date())
        XCTAssertEqual(entity.quality, quality)
        XCTAssertEqual(entity.readingType.measurementKind, measurementKind)
        XCTAssertEqual(entity.readingType.unit, unit)
        XCTAssertEqual(entity.readingType.aggregate, aggregate)
        for item in entity.intervalReading {
            XCTAssertEqual(item.date, date.date())
            XCTAssertEqual(item.value, value)
        }
    }
    
    func testRetunNullParamsLinkyContractsRaw() throws {
        var entity = LinkyContractsMapper.rawToEntity(
            raw: LinkyCustomerRaw(
                customer: nil
            )
        )
        XCTAssertEqual(entity.customer.customerId, "")
        XCTAssertEqual(entity.customer.usagePoints.isEmpty, true)
        
        entity = LinkyContractsMapper.rawToEntity(
            raw: LinkyCustomerRaw(
                customer: LinkyContractsCustomerRaw(
                    customer_id: "",
                    usage_points:nil
                )
            )
        )
        XCTAssertEqual(entity.customer.customerId, "")
        XCTAssertEqual(entity.customer.usagePoints.isEmpty, true)
        
        entity = LinkyContractsMapper.rawToEntity(
            raw: LinkyCustomerRaw(
                customer: LinkyContractsCustomerRaw(
                    customer_id: nil,
                    usage_points:[
                        LinkyContractsUsagePointsRaw(
                            usage_point: nil,
                            contracts: nil
                        )
                    ]
                )
            )
        )
        XCTAssertEqual(entity.customer.customerId, "")
        XCTAssertEqual(entity.customer.usagePoints.isEmpty, false)
        for item in entity.customer.usagePoints {
            XCTAssertEqual(item.usagePoint.usagePointId, "")
            XCTAssertEqual(item.usagePoint.usagePointStatus, "")
            XCTAssertEqual(item.usagePoint.meterType, "")
            XCTAssertEqual(item.contracts.segment, "")
            XCTAssertEqual(item.contracts.subscribedPower, "")
            XCTAssertEqual(item.contracts.lastActivationDate, Date.null)
            XCTAssertEqual(item.contracts.distributionTariff, "")
            XCTAssertEqual(item.contracts.offpeakHours, "")
            XCTAssertEqual(item.contracts.contractType, "")
            XCTAssertEqual(item.contracts.contractStatus, "")
            XCTAssertEqual(item.contracts.lastDistributionTariffChangeDate, Date.null)
        }
    }
    
    func testRetunNotNullParamsLinkyContractsRaw() throws {
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
        
        let entity = LinkyContractsMapper.rawToEntity(
            raw: LinkyCustomerRaw(
                customer: LinkyContractsCustomerRaw(
                    customer_id: customer_id,
                    usage_points: [
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
        )
        XCTAssertEqual(entity.customer.customerId, customer_id)
        XCTAssertEqual(entity.customer.usagePoints.isEmpty, false)
        for item in entity.customer.usagePoints {
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
    }

}
