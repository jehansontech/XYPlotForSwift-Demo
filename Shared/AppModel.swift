//
//  AppModel.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 11/28/21.
//

import SwiftUI
import XYPlotForSwift

enum Page: String, CaseIterable {
    case sevenCoins = "Seven Coins"
}

class AppModel: ObservableObject {

    @Published var colorScheme = ColorScheme.dark

    @Published var currentPage: Page = .sevenCoins

    @Published var sevenCoinsDemo = SevenCoinsDemo()

    func toggleColorScheme() {
        switch colorScheme {
        case .dark:
            colorScheme = .light
        case .light:
            colorScheme = .dark
        @unknown default:
            fatalError("Unsupported color scheme: \(colorScheme)")
        }
    }

}
