//
//  DemoDataSources.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 5/8/21.
//

import Foundation
import SwiftUI
import XYPlotForSwift
import Taconic

class DemoDataSources: ObservableObject {

    @Published var dataSource1: XYDataSource

    init() {
        self.dataSource1 = SimpleDataSource("Bug #1")
    }
}

struct SimpleDataSource: XYDataSource {

    var xAxisName: String = "Time"

    var xAxisUnits: String? = "sec"

    var yAxisName: String = "Distance"

    var yAxisUnits: String? = "m"

    var dataSets: [XYDataSet] = [XYDataSet]()

    init(_ name: String?) {
        dataSets.append(RandomWalk(name, Color.red, 0, 1, 0.1, 100))
    }
}

struct RandomWalk: XYDataSet {

    var name: String?

    var color: Color?

    var points: [XYPoint]

    var bounds: XYRect?

    init(_ name: String?, _ color: Color?, _ min: Double, _ max: Double, _ fuzzFactor: Double, _ count: Int) {
        self.name = name
        self.color = color
        self.points = [XYPoint]()
        self.bounds = nil
        addPoints(min, max, fuzzFactor, count)
    }

    mutating func addPoints(_ min: Double, _ max: Double, _ fuzzFactor: Double, _ count: Int) {
        let fuzz = -fuzzFactor...fuzzFactor
        var x: Double = 0
        var y: Double = max - 0.5 * min + Double.random(in: fuzz)
        for _ in 0..<count {
            addPoint(x, y)
            x += 1
            y += Double.random(in: fuzz)
        }
    }

    mutating func addPoint(_ x: Double, _ y: Double) {
        let p = XYPoint(x: x, y: y)
        points.append(p)
        if let oldBounds = bounds {
            self.bounds = oldBounds.cover(p)
        }
        else {
            self.bounds = XYRect(p)
        }
        debug("RandomWalk", "addPoint p=\(p) bounds=\(bounds!)")
    }
}
