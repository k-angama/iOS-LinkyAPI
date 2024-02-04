//
//  LinkyContractsEntity.swift
//  LinkyAPI
//
//  Created by Karim Angama on 28/01/2024.
//

import Foundation

public struct LinkyCustomerEntity: Codable {
    public let customer: LinkyContractsCustomerEntity
}

public struct LinkyContractsCustomerEntity: Codable {
    public let customerId: String
    public let usagePoints: [LinkyContractsUsagePointsEntity]
}

public struct LinkyContractsUsagePointsEntity: Codable {
    public let usagePoint: LinkyContractsUsagePointEntity
    public let contracts: LinkyContractsEntity
}

public struct LinkyContractsUsagePointEntity: Codable {
    public let usagePointId: String
    public let usagePointStatus: String
    public let meterType: String
}

public struct LinkyContractsEntity: Codable {
    public let segment: String
    public let subscribedPower: String
    public let lastActivationDate: Date
    public let distributionTariff: String
    public let offpeakHours: String
    public let contractType: String
    public let contractStatus: String
    public let lastDistributionTariffChangeDate: Date
}
