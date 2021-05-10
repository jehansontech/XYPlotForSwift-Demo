//
//  TickMaker.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 5/9/21.
//

import SwiftUI
import UIStuffForSwift


struct XTicks: View {

    let fontSize: CGFloat = 15

    let charHeight: CGFloat = 20

    let tickLength: CGFloat = 10

    let formatter: NumberFormatter = NumberFormatter()

    @Binding var dataBounds: CGRect

    var numbers: [Int] {
        // TODO
        return [2,20,40,60,80,102]
    }

    var magnitude: CGFloat {
        // TODO
        return 1 // dataBounds.width
    }

    var body: some View {

        GeometryReader { proxy in

            let t1 = CGAffineTransform
                .identity
                .scaledBy(x: proxy.frame(in: .local).width / dataBounds.width,
                          y: 1)
                .translatedBy(x: -dataBounds.minX, y: -dataBounds.minY)

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

    init(_ dataBounds: Binding<CGRect>) {
        self._dataBounds = dataBounds
    }
}

struct YTicks: View {

    let fontSize: CGFloat = 15

    let charWidth: CGFloat = 20

    let tickLength: CGFloat = 10

    let formatter: NumberFormatter = NumberFormatter()

    @Binding var dataBounds: CGRect

    var numbers: [Int] {
        // TODO
        return [1,2,4,6,8,10,11]
    }

    var magnitude: CGFloat {
        // TODO
        return 1 // dataBounds.height / 10
    }

    var body: some View {

        GeometryReader { proxy in

            let t1 = CGAffineTransform
                .identity
                .scaledBy(x: 1, y: -1)
                .translatedBy(x: 0, y: -proxy.frame(in: .local).height)
                .scaledBy(x: 1,
                          y: proxy.frame(in: .local).height / dataBounds.height)
                .translatedBy(x: 0, y: -dataBounds.minY)

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

    init(_ dataBounds: Binding<CGRect>) {
        self._dataBounds = dataBounds
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

    @Binding var dataBounds: CGRect

    var body: some View {
        ZStack {
            GeometryReader { proxy in

                let t1 = CGAffineTransform
                    .identity
                    .scaledBy(x: 1, y: -1)
                    .translatedBy(x: 0, y: -proxy.frame(in: .local).height)
                    .scaledBy(x: proxy.frame(in: .local).width / dataBounds.width,
                              y: proxy.frame(in: .local).height / dataBounds.height)
                    .translatedBy(x: -dataBounds.minX, y: -dataBounds.minY)

                Path { path in
                    path.addRect(CGRect(x: 12, y: 2, width: 80, height: 8))
                    path.addRect(CGRect(x: 12, y: 2, width: 10, height: 1))
                }
                .applying(t1)
                .stroke()

            }
            // .coordinateSpace(name: "plot")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    init(_ dataBounds: Binding<CGRect>) {
        self._dataBounds = dataBounds
    }
}

struct TickMaker : View {

    @State var dataBounds = CGRect(x: 2, y: 1, width: 100, height: 10)

    let plotWidth: CGFloat = 500
    let plotHeight: CGFloat = 500
    let axisSize: CGFloat = 100
    let tickLength: CGFloat = 10

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            Spacer()
            
            HStack(spacing: 0) {

                YTicks($dataBounds)
                    .background(UIConstants.offBlack)
                    .frame(width: axisSize, height: plotHeight)

                Plot($dataBounds)
                    .background(UIConstants.offBlack)
                    .frame(width: plotWidth, height: plotHeight)
                    .border(UIConstants.offWhite)

                Spacer()
                    .frame(width: axisSize, height: plotHeight)
            }

            HStack(spacing: 0) {

                Spacer()
                    .frame(width: axisSize, height: axisSize)

                XTicks($dataBounds)
                    .background(UIConstants.offBlack)
                    .frame(width: plotWidth, height: axisSize)

                Spacer()
                    .frame(width: axisSize, height: axisSize)

            }

            Spacer()
        }

    }
}
