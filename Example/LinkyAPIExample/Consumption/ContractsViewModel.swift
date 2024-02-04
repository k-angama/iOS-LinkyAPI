//
//  ContractsViewModel.swift
//  LinkyAPIExample
//
//  Created by Karim Angama on 29/01/2024.
//

import Foundation
import LinkyAPI
import Combine


class ContractsViewModel: ObservableObject {
    
    @Published var subscribedPower = "-"
    @Published var distributionTariff = "-"
    @Published var offpeakHours = "-"

    func getContracts() {
        LinkyCustomer.shared.contracts { [weak self] consumption, error in
            if error == nil {
                DispatchQueue.main.async {
                    let contracts = consumption?.customer.usagePoints.first?.contracts
                    self?.subscribedPower = contracts?.subscribedPower ?? "-"
                    self?.distributionTariff = contracts?.distributionTariff ?? "-"
                    self?.offpeakHours = contracts?.offpeakHours ?? "-"
                }
            }
        }
    }
}
