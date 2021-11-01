//
//  DemoDataSources.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 5/8/21.
//

import Foundation
import SwiftUI
import Wacoma
import XYPlotForSwift

class DemoDataSources: ObservableObject {

    @Published var dataSource1: XYDataSource

    init() {
        self.dataSource1 = SimpleDataSource()
    }
}

struct SimpleDataSource: XYDataSource {

    var xAxisName: String = "Time"

    var xAxisUnits: String? = "sec"

    var yAxisName: String = "Distance"

    var yAxisUnits: String? = "m"

    var dataSets: [XYDataSet] = [XYDataSet]()

    init() {
        dataSets.append(RandomWalk("Bug #1", Color.red, 0, 1, 0.05, 101))
        dataSets.append(RandomWalk("Bug #2", Color.green, 0, 1, 0.05, 101))
        dataSets.append(RandomWalk("Bug #3", Color.blue, 0, 1, 0.05, 101))
    }
}

struct RandomWalk: XYDataSet {

    var name: String?

    var color: Color?

    var points: [XYPoint]

    var bounds: XYRect? = nil

    init(_ name: String?, _ color: Color?, _ min: Double, _ max: Double, _ fuzzFactor: Double, _ count: Int) {
        self.name = name
        self.color = color
        self.points = [XYPoint]()
        addPoints(min, max, fuzzFactor, count)
    }

    mutating func addPoints(_ min: Double, _ max: Double, _ fuzzFactor: Double, _ count: Int) {
        let fuzz = -fuzzFactor...fuzzFactor
        var x: Double = 0
        var y: Double = min + 0.5 * (max - min) + Double.random(in: fuzz)
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
