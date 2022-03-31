//
//  SevenCoinsDemo.swift
//  XYPlotForSwift-Demo (iOS)
//
//  Created by Jim Hanson on 3/11/22.
//

import SwiftUI
import XYPlotForSwift

class SevenCoinsDemo: ObservableObject {

    static var coins = [
        "Australian Dollar",
        "Canadian Dollar",
        "Franc",
        "Pound",
        "Quarter",
        "Real",
        "Rupee"
    ]

    static var colors = [
        Color.red,
        Color.green,
        Color.blue,
        Color.yellow,
        Color.purple,
        Color.orange,
        Color.cyan
    ]

    var stepInterval: TimeInterval = 0.1

    var stepScheduled: Bool = false

    var stopRequested: Bool = false

    var headsCount: [Int]

    var tailsCount: [Int]

    var flipCount: Int = 0

    @Published var running: Bool = false

    @Published var plotModel: XYPlotModel

    init() {

        self.headsCount = Array<Int>(repeating: 0, count: Self.coins.count)
        self.tailsCount = Array<Int>(repeating: 0, count: Self.coins.count)

        self.plotModel = XYPlotModel(title: Page.sevenCoins.rawValue)
        self.plotModel.layers.append(XYLayer(xLabel: AxisLabel("#Flips", nil), yLabel: AxisLabel("Heads Fraction", nil)))
        self.plotModel.layers.append(XYLayer(xLabel: AxisLabel("#Flips", nil), yLabel: AxisLabel("Excess Heads", nil)))

        for layerIndex in 0..<2 {
            for coinIndex in 0..<Self.coins.count {
                self.plotModel.layers[layerIndex].addDataSet(Self.coins[coinIndex], Self.colors[coinIndex])
            }
        }
        takeMeasurements()
    }

    func start() {
        if !running {
            running = true
            step()
        }
    }

    func stop() {
        running = false
    }

    func step() {
        flip()
        if running {
            possiblyScheduleNextStep()
        }
    }

    func reset() {
        for i in Self.coins.indices {
            headsCount[i] = 0
            tailsCount[i] = 0
        }
        flipCount = 0
        self.plotModel.layers[0].clearData()
        takeMeasurements()
    }

    private func flip() {
        for i in Self.coins.indices {
            if Bool.random() {
                headsCount[i] += 1
            }
            else {
                tailsCount[i] += 1
            }
        }
        flipCount += 1
        takeMeasurements()
    }

    private func takeMeasurements() {
        for i in Self.coins.indices {
            let headsFraction = flipCount == 0 ? 0 : CGFloat(headsCount[i]) / CGFloat(flipCount)
            let excessHeads = headsCount[i] - tailsCount[i]
            self.plotModel.layers[0].addPoint(i, XYPoint(x: CGFloat(flipCount), y: headsFraction))
            self.plotModel.layers[1].addPoint(i, XYPoint(x: flipCount, y: excessHeads))

        }
    }

    private func possiblyScheduleNextStep() {
        if !stepScheduled {
            stepScheduled = true
            // TODO: what's the shorthand for schedule-on-main-thread?
            DispatchQueue.main.asyncAfter(deadline: .now() + stepInterval) {
                self.stepScheduled = false
                self.step()
            }
        }
    }
}

