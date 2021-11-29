//
//  AppModel.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 11/28/21.
//

import SwiftUI
import XYPlotForSwift

enum Page: String, CaseIterable {
    case threeBugs = "Three Bugs"
    // case tickMaker  = "TickMaker"
}

class AppModel: ObservableObject {

    @Published var colorScheme = ColorScheme.dark

    @Published var currentPage: Page = .threeBugs

    @Published var threeBugsDataSource = ThreeBugs()
    
    func toggleColorScheme() {
        switch colorScheme {
        case .dark:
            colorScheme = .light
        case .light:
            colorScheme = .dark
        @unknown default:
            fatalError("Unknown color scheme")
        }
    }

}
