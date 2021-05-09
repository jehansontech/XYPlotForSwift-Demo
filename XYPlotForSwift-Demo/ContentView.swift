//
//  ContentView.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 4/30/21.
//

import SwiftUI
import UIStuffForSwift
import XYPlotForSwift

struct ContentView: View {

    @EnvironmentObject var dataSources: DemoDataSources

    @State var selectedPlot: Int = 2

    var body: some View {
        VStack {
            PlotSelector($selectedPlot)

            if selectedPlot == 1 {
                XYPlotView(dataSources.dataSource1)
                    .padding(UIConstants.pageInsets)
                    .foregroundColor(UIConstants.offWhite)
                    .background(UIConstants.offBlack)
            }
            else if selectedPlot == 2 {
                TickMaker()
                    .padding(UIConstants.pageInsets)
            }

        }
    }
}

