//
//  TickMaker.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 5/9/21.
//

import SwiftUI
import Taconic
import UIStuffForSwift


struct DataBounds {

    var minX: Double = 0

    var maxX: Double {
        return minX + width
    }

    var minY: Double = 0

    var maxY: Double {
        return minY + height
    }

    var width: Double = 1

    var height: Double = 1

    var fminX: CGFloat {
        return CGFloat(minX)
    }

    var fwidth: CGFloat {
        return CGFloat(width)
    }

    var fminY: CGFloat {
        return CGFloat(minY)
    }

    var fheight: CGFloat {
        return CGFloat(height)
    }
}

struct XTicks: View {

    let fontSize: CGFloat = 15

    let charHeight: CGFloat = 20

    let tickLength: CGFloat = 10

    let formatter: NumberFormatter = NumberFormatter()

    @Binding var dataBounds: DataBounds

    var numbers: [Int] {
        return makeNumbers()
    }

    func makeNumbers() -> [Int] {
        // TODO
        return [2,20,40,60,80,102]
    }

    var magnitude: CGFloat {
        return CGFloat(max(orderOfMagnitude(dataBounds.minX), orderOfMagnitude(dataBounds.maxX)))
    }

    var body: some View {

        GeometryReader { proxy in

            let t1 = CGAffineTransform
                .identity
                .scaledBy(x: proxy.frame(in: .local).width / dataBounds.fwidth,
                          y: 1)
                .translatedBy(x: -dataBounds.fminX, y: -dataBounds.fminY)

            ForEach(numbers, id: \.self) { n in
                Text(formatter.string(for: n)!)
                    .font(Font.system(size: fontSize, design: .monospaced))
                    .fixedSize()
                    .position(CGPoint(x: magnitude * CGFloat(n), y: (proxy.frame(in: .local).minY  + charHeight)).applying(t1))
            }

            Path { path in
                for n in numbers {
                    path.move(to:    CGPoint(x: magnitude * CGFloat(n), y: proxy.frame(in: .local).minY))
                    path.addLine(to: CGPoint(x: magnitude * CGFloat(n), y: proxy.frame(in: .local).minY + tickLength))
                }
            }
            .applying(t1)
            .stroke()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }

    init(_ dataBounds: Binding<DataBounds>) {
        self._dataBounds = dataBounds
    }
}

struct YTicks: View {

    let fontSize: CGFloat = 15

    let charWidth: CGFloat = 20

    let tickLength: CGFloat = 10

    let formatter: NumberFormatter = NumberFormatter()

    @Binding var dataBounds: DataBounds

    var numbers: [Int] {
        return makeNumbers()
    }

    var magnitude: CGFloat {
        return CGFloat(max(orderOfMagnitude(dataBounds.minY), orderOfMagnitude(dataBounds.maxY)))
    }

    var body: some View {

        GeometryReader { proxy in

            let t1 = CGAffineTransform
                .identity
                .scaledBy(x: 1, y: -1)
                .translatedBy(x: 0, y: -proxy.frame(in: .local).height)
                .scaledBy(x: 1,
                          y: proxy.frame(in: .local).height / dataBounds.fheight)
                .translatedBy(x: 0, y: -dataBounds.fminY)

            ForEach(numbers, id: \.self) { n in
                Text(formatter.string(for: n)!)
                    .font(Font.system(size: fontSize, design: .monospaced))
                    .fixedSize()
                    .position(CGPoint(x: proxy.frame(in: .local).maxX - numberOffset(n), y: magnitude * CGFloat(n)).applying(t1))
            }

            Path { path in
                for n in numbers {
                    path.move(   to: CGPoint(x: proxy.frame(in: .local).maxX,              y: magnitude * CGFloat(n)))
                    path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX - tickLength, y: magnitude * CGFloat(n)))
                }
            }
            .applying(t1)
            .stroke()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    init(_ dataBounds: Binding<DataBounds>) {
        self._dataBounds = dataBounds
    }

    func makeNumbers() -> [Int] {
        // TODO
        return [1,2,4,6,8,10,11]
    }

    func numberOffset(_ n: Int) -> CGFloat {
        return 2 * tickLength
        // FIXME
        // return CGFloat(digitCount(n)) * charWidth / 2
    }

    func digitCount(_ n: Int) -> Int {
        // TODO
        if (n > 99) {
            return 3
        }
        else if (n > 9) {
            return 2
        }
        else {
            return 1
        }
    }
}


struct Plot: View {

    @Binding var dataBounds: DataBounds

    var body: some View {
        ZStack {
            GeometryReader { proxy in

                let t1 = CGAffineTransform
                    .identity
                    .scaledBy(x: 1, y: -1)
                    .translatedBy(x: 0, y: -proxy.frame(in: .local).height)
                    .scaledBy(x: proxy.frame(in: .local).width / dataBounds.fwidth,
                              y: proxy.frame(in: .local).height / dataBounds.fheight)
                    .translatedBy(x: -dataBounds.fminX, y: -dataBounds.fminY)

                Path { path in
                    path.addRect(CGRect(x: 12, y: 2, width: 80, height: 8))
                    path.addRect(CGRect(x: 12, y: 2, width: 10, height: 1))
                }
                .applying(t1)
                .stroke()
                .clipped()

            }
            // .coordinateSpace(name: "plot")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    init(_ dataBounds: Binding<DataBounds>) {
        self._dataBounds = dataBounds
    }
}

struct DataBoundsControls : View {

    @Binding var dataBounds: DataBounds

    @State var group = SettingsGroup().itemStyle(.narrow)

    var body: some View {
        VStack {
            RangeSetting("xMin", $dataBounds.minX, $group, -100, 100, 0.1)
            RangeSetting("width", $dataBounds.width, $group, 0.1, 200, 0.1)
            RangeSetting("yMin", $dataBounds.minY, $group, -10, 10, 0.1)
            RangeSetting("height", $dataBounds.height, $group, 0.1, 200, 0.1)
        }
    }

    init(_ dataBounds: Binding<DataBounds>) {
        self._dataBounds = dataBounds
    }
}

struct TickMaker : View {

    @State var dataBounds = DataBounds(minX: 2, minY: 1, width: 100, height: 10)

    let plotWidth: CGFloat = 500

    let plotHeight: CGFloat = 500

    let ticksViewSize: CGFloat = 50

    var body: some View {

        HStack {

            // Begin Settings area

            DataBoundsControls($dataBounds)

            // Begin Plot area

            VStack(alignment: .leading, spacing: 0) {

                Spacer()

                HStack(spacing: 0) {

                    YTicks($dataBounds)
                        // .background(UIConstants.offBlack)
                        .frame(width: ticksViewSize, height: plotHeight)

                    Plot($dataBounds)
                        .background(UIConstants.offBlack)
                        .frame(width: plotWidth, height: plotHeight)
                        .border(UIConstants.offWhite)

                    Spacer()
                        .frame(width: ticksViewSize, height: plotHeight)
                }

                HStack(spacing: 0) {

                    Spacer()
                        .frame(width: ticksViewSize, height: ticksViewSize)

                    XTicks($dataBounds)
                        // .background(UIConstants.offBlack)
                        .frame(width: plotWidth, height: ticksViewSize)

                    Spacer()
                        .frame(width: ticksViewSize, height: ticksViewSize)

                }

                Spacer()
            }
            // end Plot area
        }
    }
}
