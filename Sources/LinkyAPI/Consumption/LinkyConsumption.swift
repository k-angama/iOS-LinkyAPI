//
//  LinkyConsumption.swift
//  LinkyAPI
//
//  Created by Karim Angama on 22/06/2023.
//

import Foundation

/// Retries the daily consumption
///
/// - Parameter shared: The shared singleton session object.
///
public struct LinkyConsumption {
    
    /// The shared singleton session object.
    public static var shared = LinkyConsumption()
    
    internal var linkyAPI: LinkyAPI?
    
    private init() {}
    
    /// Retries the daily consumption between two date
    ///
    /// - Parameter start: start date
    /// - Parameter end: end date
    /// - Parameter completionHandler: The completion handler to call when the load request is complete.
    ///
    public func daily(
        start: LinkyConsumptionDate,
        end: LinkyConsumptionDate,
        completionHandler: @escaping (_ consumption: LinkyConsumptionEntity?, _ error: Error?) -> Void) {
            linkyAPI?.consumption(start: start.date, end: end.date, route: .dailyConsumption) { consumption, error in
            if let consumption = consumption {
                completionHandler(LinkyConsumptionMapper.rawToEntity(raw: consumption), nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    /// Retrieves the average power consumed over a 30 min interval
    ///
    /// - Parameter start: start date
    /// - Parameter end: end date
    /// - Parameter completionHandler: The completion handler to call when the load request is complete.
    ///
    public func loadcurve(
        start: LinkyConsumptionDate,
        end: LinkyConsumptionDate,
        block: @escaping (_ consumption: LinkyConsumptionEntity?, _ error: Error?) -> Void) {
            linkyAPI?.consumption(start: start.date, end: end.date, route: .loadcurveConsumption) { consumption, error in
                if let consumption = consumption {
                    block(LinkyConsumptionMapper.rawToEntity(raw: consumption), nil)
                } else {
                    block(nil, error)
                }
            }
    }
    
    /// Retrieves the maximum consumption power reached daily
    ///
    /// - Parameter start: start date
    /// - Parameter end: end date
    /// - Parameter completionHandler: The completion handler to call when the load request is complete.
    public func maxpower(
        start: LinkyConsumptionDate,
        end: LinkyConsumptionDate,
        block: @escaping (_ consumption: LinkyConsumptionEntity?, _ error: Error?) -> Void) {
            linkyAPI?.consumption(start: start.date, end: end.date, route: .maxpowerConsumption) { consumption, error in
                if let consumption = consumption {
                    block(LinkyConsumptionMapper.rawToEntity(raw: consumption), nil)
                } else {
                    block(nil, error)
                }
            }
        
    }
    
    /// Retrieves daily production between two date
    ///
    /// - Parameter start: start date
    /// - Parameter end: end date
    /// - Parameter completionHandler: The completion handler to call when the load request is complete.
    public func dailyprod(
        start: LinkyConsumptionDate,
        end: LinkyConsumptionDate,
        block: @escaping (_ consumption: LinkyConsumptionEntity?, _ error: Error?) -> Void) {
            linkyAPI?.consumption(start: start.date, end: end.date, route: .dailyprodConsumption) { consumption, error in
                if let consumption = consumption {
                    block(LinkyConsumptionMapper.rawToEntity(raw: consumption), nil)
                } else {
                    block(nil, error)
                }
            }
    }
    
    /// Retrieves the average power produced, over a 30 min interval
    ///
    /// - Parameter start: start date
    /// - Parameter end: end date
    /// - Parameter completionHandler: The completion handler to call when the load request is complete.
    public func loadcurveprod(
        start: LinkyConsumptionDate,
        end: LinkyConsumptionDate,
        block: @escaping (_ consumption: LinkyConsumptionEntity?, _ error: Error?) -> Void) {
            linkyAPI?.consumption(start: start.date, end: end.date, route: .loadcurveprodConsumption) { consumption, error in
                if let consumption = consumption {
                    block(LinkyConsumptionMapper.rawToEntity(raw: consumption), nil)
                } else {
                    block(nil, error)
                }
            }
    }
    
}
