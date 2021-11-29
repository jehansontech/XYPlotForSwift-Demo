//
//  Plot1.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 11/28/21.
//

import SwiftUI
import XYPlotForSwift

struct ThreeBugsPage: View {

    @EnvironmentObject var model: AppModel

    var body: some View {
        ThreeBugsPlot(model.threeBugsDataSource)
    }
}


struct ThreeBugsPlot: View {

    @State var plotModel: XYPlotModel

    var body: some View {
        XYPlotView($plotModel)
    }

    init(_ dataSource: XYDataSource) {
        self._plotModel = State(initialValue: XYPlotModel(dataSource))
    }
}
