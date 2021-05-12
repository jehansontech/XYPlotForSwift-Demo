//
//  PlotSelector.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 5/9/21.
//

import SwiftUI
import WacomaUI

struct PlotSelector: View {

    @Binding var selectedPlot: Int

    var body: some View {
        HStack(alignment: .top, spacing: UIConstants.buttonSpacing) {

            Button(action: { selectedPlot = 1 }) {
                Text("1")
            }
            .foregroundColor(UIConstants.controlColor)
            .modifier(SymbolButtonStyle())

            Button(action: { selectedPlot = 2 }) {
                Text("2")
            }
            .foregroundColor(UIConstants.controlColor)
            .modifier(SymbolButtonStyle())
        }
    }


    init(_ selectedPlot: Binding<Int>) {
        self._selectedPlot = selectedPlot
    }
}
