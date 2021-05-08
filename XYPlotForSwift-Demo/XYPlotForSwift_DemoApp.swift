//
//  XYPlotForSwift_DemoApp.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 4/30/21.
//

import SwiftUI
import Taconic

@main
struct XYPlotForSwift_DemoApp: App {

    @StateObject var dataSources = DemoDataSources()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataSources)
                .preferredColorScheme(.dark)
        }
    }

    init() {
        setDebug(enabled: true)
    }
}
