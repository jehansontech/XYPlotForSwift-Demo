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
    
    var body: some View {
        ZStack {
            XYPlotView(dataSources.dataSource1)
                .padding(UIConstants.pageInsets)
                .foregroundColor(UIConstants.offWhite)
                .background(UIConstants.offBlack)
        }
    }
}

