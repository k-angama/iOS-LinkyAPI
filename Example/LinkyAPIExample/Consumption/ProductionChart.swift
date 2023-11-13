//
//  ProductionChart.swift
//  LinkyAPIExample
//
//  Created by Karim Angama on 02/07/2023.
//

import SwiftUI
import Charts

struct ProductionChart: View {
    
    @ObservedObject var viewModel = ProductionViewModel()
    
    var body: some View {
        VStack {
            Picker("Choice", selection: $viewModel.production) {
                Text("dailyprod").tag(ProductionType.dailyprod)
                Text("loadcurveprod").tag(ProductionType.loadcurveprod)
            }
            .pickerStyle(.segmented)
            GeometryReader { geo in
                GroupBox {
                    ScrollView(.horizontal, showsIndicators: false) {
                        Chart(viewModel.items) { item in
                            BarMark(
                                x: .value("Day", item.type),
                                y: .value("W", item.value),
                                width: 22
                            )
                            .annotation(position: .top) {
                                Text("\(CGFloat(item.value) / 1000.0, specifier: "%.1f")").font(.footnote)
                            }
                            .foregroundStyle(.red)
                        }
                        .chartYAxis() {
                            AxisMarks() {  value in
                                AxisTick()
                                AxisGridLine()
                            }
                        }
                        .chartXAxis() {
                            if viewModel.production == .loadcurveprod {
                                AxisMarks(
                                    preset: .aligned,
                                    position: .bottom,
                                    values: .stride(by: .hour)) { value in
                                        let label = value.as(Date.self)?.time
                                        AxisValueLabel(label ?? "").foregroundStyle(.black)
                                    }
                            }else{
                                AxisMarks(
                                    preset: .aligned,
                                    position: .bottom,
                                    values: .stride(by: .day)) { value in
                                        AxisValueLabel(
                                            format: .dateTime.weekday(.short))
                                    }
                            }
                            
                        }
                        .frame(width: geo.sizeChar(viewModel.items.count))
                        .padding(.horizontal)
                    }
                } label: {
                    Text("Produtcion")
                }
            }
            .groupBoxStyle(.automatic)
            .overlay {
                if viewModel.isHiddenProgressView {
                    ProgressView()
                        .scaleEffect(2.0, anchor: .center)
                } else if viewModel.items.count == 0 {
                    Text("No data")
                }
            }
        }
        .frame(height: 300)
        .disabled(viewModel.isDisabled)
    }
}

struct ProductionChart_Previews: PreviewProvider {
    static var previews: some View {
        ProductionChart(viewModel: ProductionViewModel(items: [
            Item(type: Date.format("2023-07-01 09:00:00"), value: 49171),
            Item(type: Date.format("2023-07-02 09:00:00"), value: 44101),
            Item(type: Date.format("2023-07-03 09:00:00"), value: 38218),
            Item(type: Date.format("2023-07-04 09:00:00"), value: 39894),
            Item(type: Date.format("2023-07-05 09:00:00"), value: 34943),
            Item(type: Date.format("2023-07-06 09:00:00"), value: 26429),
            Item(type: Date.format("2023-07-07 09:00:00"), value: 39894),
            Item(type: Date.format("2023-07-08 09:00:00"), value: 44101),
            Item(type: Date.format("2023-07-09 09:00:00"), value: 34943),
            Item(type: Date.format("2023-07-10 09:00:00"), value: 26429),
            Item(type: Date.format("2023-07-11 09:00:00"), value: 44101),
            Item(type: Date.format("2023-07-12 09:00:00"), value: 39894),
            Item(type: Date.format("2023-07-13 09:00:00"), value: 44101),
            Item(type: Date.format("2023-07-14 09:00:00"), value: 26429)
        ]))
    }
}
