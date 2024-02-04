//
//  LinkyContractsRaw.swift
//  LinkyAPI
//
//  Created by Karim Angama on 28/01/2024.
//

import Foundation

struct LinkyCustomerRaw: Codable {
    let customer: LinkyContractsCustomerRaw?
}

struct LinkyContractsCustomerRaw: Codable {
    let customer_id: String?
    let usage_points: [LinkyContractsUsagePointsRaw]?
}

struct LinkyContractsUsagePointsRaw: Codable {
    let usage_point: LinkyContractsUsagePointRaw?
    let contracts: LinkyContractsRaw?
}

struct LinkyContractsUsagePointRaw: Codable {
    let usage_point_id: String?
    let usage_point_status: String?
    let meter_type: String?
}

struct LinkyContractsRaw: Codable {
    let segment: String?
    let subscribed_power: String?
    let last_activation_date: String?
    let distribution_tariff: String?
    let offpeak_hours: String?
    let contract_type: String?
    let contract_status: String?
    let last_distribution_tariff_change_date: String?
}
