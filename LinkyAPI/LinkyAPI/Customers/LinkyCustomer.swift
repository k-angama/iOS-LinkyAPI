//
//  LinkyCustomers.swift
//  LinkyAPI
//
//  Created by Karim Angama on 28/01/2024.
//

import Foundation

/// Retries the daily consumption
///
/// - Parameter shared: The shared singleton session object.
///
public struct LinkyCustomers {
    
    /// The shared singleton session object.
    public static var shared = LinkyCustomers()
    
    internal var linkyAPI: LinkyAPI?
    
    private init() {}
    
    /// Retries the user's contacts
    ///
    /// - Parameter completionHandler: The completion handler to call when the load request is complete.
    ///
    func contracts(completionHandler: @escaping (_ consumption: LinkyCustomerEntity?, _ error: Error?) -> Void) {
        linkyAPI?.customer(route: .customerContracts) { contracts, error in
            if let contracts = contracts {
                completionHandler(LinkyContractsMapper.rawToEntity(raw: contracts), nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
}
