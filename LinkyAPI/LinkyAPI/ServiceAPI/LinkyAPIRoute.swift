//
//  LinkyAPIRoute.swift
//  LinkyAPI
//
//  Created by Karim Angama on 04/08/2023.
//

import Foundation

enum LinkyAPIRoute: String {
    case auth = "/oauth2/v3/token"
    case dailyConsumption = "/metering_data_dc/v5/daily_consumption"
    case loadcurveConsumption = "/metering_data_clc/v5/consumption_load_curve"
    case maxpowerConsumption = "/metering_data_dcmp/v5/daily_consumption_max_power"
    case dailyprodConsumption = "/metering_data_dp/v5/daily_production"
    case loadcurveprodConsumption = "/metering_data_plc/v5/production_load_curve"
}
