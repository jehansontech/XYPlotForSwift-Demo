//
//  XYPlotForSwift_DemoApp.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 4/30/21.
//

import SwiftUI
import Wacoma

@main
struct XYPlotForSwift_DemoApp: App {

    @StateObject var displayState = DisplayState()
    @StateObject var dataSources = DataSources()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(displayState)
                .environmentObject(dataSources)
        }
    }

    init() {
        setDebug(enabled: true)
    }
}
