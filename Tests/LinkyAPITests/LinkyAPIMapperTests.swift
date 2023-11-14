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

}
