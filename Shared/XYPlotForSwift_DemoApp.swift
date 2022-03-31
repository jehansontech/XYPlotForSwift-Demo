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

    @Environment(\.scenePhase) private var scenePhase

    @StateObject var model = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .onChange(of: scenePhase) { newPhase in
                    // EMPIRICAL: Gotta attach this onChange to the ContentView not the WindowGroup
                    // because if we do the latter then the macOS version doesn't get the initial
                    // transition to 'active' during app startup; whereas if we attach it here, it does.
                    scenePhaseChanged(newPhase)
                }
                .onChange(of: model.currentPage) { newPage in
                    pageChanged(newPage)
                }
        }
    }

    init() {
        setDebug(enabled: true)
    }

    func scenePhaseChanged(_ newPhase: ScenePhase) {
        switch newPhase {
        case .background:
            break
        case .active:
            break
        case .inactive:
            // We might go through this state both when opening and closing.
            // self.scenePhase holds the value we're changing from.
            if scenePhase == .active {
                model.sevenCoinsDemo.stop()
            }
        @unknown default:
            break
        }

    }

    func pageChanged(_ newPage: Page) {
        switch newPage {
        case .sevenCoins:
            // model.sevenCoinsDemo.start()
            break
        }
    }
}
