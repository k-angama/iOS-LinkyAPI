//
//  LinkyConsumptionMapper.swift
//  LinkyAPI
//
//  Created by Karim Angama on 26/06/2023.
//

import Foundation

struct LinkyConsumptionMapper {
    
    static func rawToEntity(raw: LinkyConsumptionRaw) -> LinkyConsumptionEntity {
        LinkyConsumptionEntity(
            meterReading: MeterReadingEntity(
                usagePointId: raw.meter_reading?.usage_point_id ?? "",
                start: raw.meter_reading?.start?.date() ?? Date.null,
                end: raw.meter_reading?.end?.date() ?? Date.null,
                quality: raw.meter_reading?.quality ?? "",
                readingType: LinkyConsumptionReadingTypeEntity(
                    measurementKind: raw.meter_reading?.reading_type?.measurement_kind ?? "",
                    unit: raw.meter_reading?.reading_type?.unit ?? "",
                    aggregate: raw.meter_reading?.reading_type?.aggregate ?? ""
                ),
                intervalReading: raw.meter_reading?.interval_reading?.compactMap({ raw in
                    return LinkyConsumptionIntervalReadingEntity(
                        value: raw.value ?? "0",
                        date: raw.date?.date() ?? Date.null
                    )
                }) ?? []
            )
        )
    }
    
}
