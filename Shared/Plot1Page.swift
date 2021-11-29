//
//  Plot1.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 11/28/21.
//

import SwiftUI
import XYPlotForSwift

struct Plot1Page: View {

    @State var model1 = XYPlotModel(SimpleDataSource())

    var body: some View {
        XYPlotView($model1)
        //                    .padding(UIConstants.pageInsets)
        //                    .foregroundColor(UIConstants.offWhite)
        //                    .background(UIConstants.offBlack)
    }
}
