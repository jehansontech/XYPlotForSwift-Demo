//
//  ContentView.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 4/30/21.
//

import SwiftUI
import XYPlotForSwift

struct ContentView: View {

    @EnvironmentObject var dataSources: DataSources

    @State var selectedPlot: Int = 1

    var body: some View {

        VStack {
            VStack(alignment: .leading, spacing: 0) {
                DisplayControls()
                    .padding()
                PageView()
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }

//            PlotSelector($selectedPlot)
//
//            if selectedPlot == 1 {
//                XYPlotView(dataSources.dataSource1)
//                    .padding(UIConstants.pageInsets)
//                    .foregroundColor(UIConstants.offWhite)
//                    .background(UIConstants.offBlack)
//            }
//            else if selectedPlot == 2 {
//                TickMaker()
//                    .padding(UIConstants.pageInsets)
//            }

        }
    }
}


struct DisplayControls: View {

    @EnvironmentObject var displayState: DisplayState

    var body: some View {
        HStack(alignment: .center, spacing: 10) {

            Button(action: {
                displayState.dark = !displayState.dark
            }) {
                Text(displayState.dark ? "Dark" : "Light")
            }

            Picker("", selection: $displayState.currentPage) {
                ForEach(Page.allCases, id: \.self) { p in
                    Text(p.rawValue).tag(p)
                }
            }
            .pickerStyle(.segmented)
        }
        .preferredColorScheme(displayState.dark ? .dark : .light) // put it here for convenience

    }
}

struct PageView: View {

    @EnvironmentObject var displayState: DisplayState

    var body: some View {
        Group {
            switch displayState.currentPage {
            case .plot1:
                Plot1Page()
            case .tickMaker:
                TickMaker()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

