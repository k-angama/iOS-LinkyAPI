//
//  ContractsView.swift
//  LinkyAPIExample
//
//  Created by Karim Angama on 29/01/2024.
//

import SwiftUI

struct ContractsView: View {
    
    @ObservedObject var viewModel = ContractsViewModel()
    
    var body: some View {
        
        VStack {
            Text("Contract")
                .font(.title)
                .padding(.bottom, 4.0)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("Subscribed Power")
                    .font(.body)
                Spacer()
                Text(viewModel.subscribedPower)
                    .font(.caption)
            }
            HStack {
                Text("Distribution Tariff")
                    .font(.body)
                Spacer()
                Text(viewModel.distributionTariff)
                    .font(.caption)
            }
            HStack {
                Text("Off-Peak house")
                    .font(.body)
                Spacer()
                Text(viewModel.offpeakHours)
                    .font(.caption)
            }
        }
        .onAppear() {
            viewModel.getContracts()
        }
    }
}

#Preview {
    ContractsView()
}
