//
//  productionViewModel.swift
//  LinkyAPIExample
//
//  Created by Karim Angama on 02/07/2023.
//

import Foundation
import LinkyAPI
import Combine

enum ProductionType: Int {
    case dailyprod
    case loadcurveprod
}

class ProductionViewModel: ObservableObject {
    
    var cancellable = Set<AnyCancellable>()
    
    @Published var items: [Item]
    @Published var isHiddenProgressView = true
    @Published var isDisabled = false
    @Published var production: ProductionType = .dailyprod
    
    init(items: [Item] = []) {
        self.items = items
        self.observer()
    }
    
    private func observer() {
        self.$items.sink { [weak self] items in
            self?.isDisabled = items.count == 0
        }.store(in: &cancellable)
        
        self.$production.sink { [weak self] tag in
            self?.isHiddenProgressView = true
            switch tag {
            case .dailyprod:
                self?.dailyprod()
            case .loadcurveprod:
                self?.loadcurveprod()
            }
        }.store(in: &cancellable)
    }
    
    
    private func dailyprod() {
        LinkyConsumption.shared.dailyprod(
            start: LinkyConsumptionDate(year: .year(2023), month: .month(6), day: .day(1)),
            end: LinkyConsumptionDate(year: .year(2023), month: .month(6), day: .day(7))) { [weak self] consumption, error in
                DispatchQueue.main.async {
                    self?.items.removeAll()
                    self?.isHiddenProgressView = false
                    guard let consumption = consumption else { return }
                    let array = consumption.meterReading.intervalReading.map { entity in
                        return Item(type: entity.date, value: Int(entity.value) ?? 0)
                    }
                    self?.items.append(
                        contentsOf: array
                    )
                }
            }
    }
    
    private func loadcurveprod() {
        LinkyConsumption.shared.loadcurveprod(
            start: LinkyConsumptionDate(year: .year(2023), month: .month(6), day: .day(1)),
            end: LinkyConsumptionDate(year: .year(2023), month: .month(6), day: .day(7))) { [weak self] consumption, error in
                DispatchQueue.main.async {
                    self?.items.removeAll()
                    self?.isHiddenProgressView = false
                    guard let consumption = consumption else { return }
                    let array = consumption.meterReading.intervalReading.map { entity in
                        return Item(type: entity.date, value: Int(entity.value) ?? 0)
                    }
                    self?.items.append(
                        contentsOf: array
                    )
                }
            }
    }
    
}
