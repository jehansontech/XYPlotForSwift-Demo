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

    @StateObject var model = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }

    init() {
        setDebug(enabled: true)
    }
}
