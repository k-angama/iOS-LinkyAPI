//
//  LinkyContractsMapper.swift
//  LinkyAPI
//
//  Created by Karim Angama on 28/01/2024.
//

import Foundation

struct LinkyContractsMapper {
    
    static func rawToEntity(raw: LinkyCustomerRaw) -> LinkyCustomerEntity {
        LinkyCustomerEntity(
            customer: LinkyContractsCustomerEntity(
                customerId: raw.customer?.customer_id ?? "",
                usagePoints: raw.customer?.usage_points?.compactMap({ raw in
                    LinkyContractsUsagePointsEntity(
                        usagePoint: LinkyContractsUsagePointEntity(
                            usagePointId: raw.usage_point?.usage_point_id ?? "",
                            usagePointStatus: raw.usage_point?.usage_point_status ?? "",
                            meterType: raw.usage_point?.meter_type ?? ""
                        ),
                        contracts: LinkyContractsEntity(
                            segment: raw.contracts?.segment ?? "",
                            subscribedPower: raw.contracts?.subscribed_power ?? "",
                            lastActivationDate: raw.contracts?.last_activation_date?.date() ?? Date.null,
                            distributionTariff: raw.contracts?.distribution_tariff ?? "",
                            offpeakHours: raw.contracts?.offpeak_hours ?? "",
                            contractType: raw.contracts?.contract_type ?? "",
                            contractStatus: raw.contracts?.contract_status ?? "",
                            lastDistributionTariffChangeDate: raw.contracts?.last_distribution_tariff_change_date?.date() ?? Date.null
                        )
                    )
                }) ?? []
            )
        )
        
    }
    
}
