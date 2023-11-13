//
//  ConsumptionViewModel.swift
//  LinkyAPIExample
//
//  Created by Karim Angama on 02/07/2023.
//

import Foundation
import LinkyAPI
import Combine

struct Item: Identifiable {
    var id = UUID()
    let type: Date
    let value: Int
}

enum ConsumptionType: Int {
    case daily
    case maxpower
    case loadcurve
}

class ConsumptionViewModel: ObservableObject {
    
    var cancellable = Set<AnyCancellable>()
    
    @Published var items: [Item]
    @Published var isHiddenProgressView = true
    @Published var isDisabled = false
    @Published var consumption: ConsumptionType = .daily
    
    init(items: [Item] = []) {
        self.items = items
        self.observer()
    }
    
    private func observer() {
        self.$items.sink { [weak self] items in
            self?.isDisabled = items.count == 0
        }.store(in: &cancellable)
        
        self.$consumption.sink { [weak self] tag in
            self?.isHiddenProgressView = true
            switch tag {
            case .daily:
                self?.daily()
            case .maxpower:
                self?.maxpower()
            case .loadcurve:
                self?.loadcurve()
            }
        }.store(in: &cancellable)
    }
    
    private func daily() {
        LinkyConsumption.shared.daily(
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
    
    private func maxpower() {
        LinkyConsumption.shared.maxpower(
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
    
    private func loadcurve() {
        LinkyConsumption.shared.loadcurve(
            start: LinkyConsumptionDate(year: .year(2023), month: .month(6), day: .day(1)),
            end: LinkyConsumptionDate(year: .year(2023), month: .month(6), day: .day(2))) { [weak self] consumption, error in
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
