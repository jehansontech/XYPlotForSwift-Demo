//
//  DisplayState.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 11/28/21.
//

import SwiftUI

enum Page: String, CaseIterable {
    case plot1 = "Plot #1"
    case tickMaker  = "TickMaker"

    // var id: String { return self.rawValue }
}

class DisplayState: ObservableObject {

    @Published var dark: Bool = true

    @Published var currentPage: Page = .plot1
}
