//
//  ContentChart.swift
//  LinkyAPIExample
//
//  Created by Karim Angama on 05/07/2023.
//

import SwiftUI

struct ContentChart: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 20) {
                    ConsumptionChart()
                    Spacer() 
                    ProductionChart()
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .tint(.gray)
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentChart_Previews: PreviewProvider {
    static var previews: some View {
        ContentChart()
    }
}
