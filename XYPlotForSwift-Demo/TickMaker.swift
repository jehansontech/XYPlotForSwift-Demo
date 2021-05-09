//
//  TickMaker.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 5/9/21.
//

import SwiftUI
import UIStuffForSwift


struct XTicks: View {

    let tickLength: CGFloat = 10

    @Binding var dataBounds: CGRect

    var body: some View {

        GeometryReader { proxy in

            let t1 = CGAffineTransform
                .identity
                .scaledBy(x: proxy.frame(in: .local).width / dataBounds.width,
                          y: 1)
                .translatedBy(x: -dataBounds.minX, y: -dataBounds.minY)


            Path { path in

                path.move(to:    CGPoint(x: dataBounds.minX + 0.0 * dataBounds.width, y: proxy.frame(in: .local).minY))
                path.addLine(to: CGPoint(x: dataBounds.minX + 0.0 * dataBounds.width, y: proxy.frame(in: .local).minY + tickLength))

                path.move(to:    CGPoint(x: dataBounds.minX + 0.1 * dataBounds.width, y: proxy.frame(in: .local).minY))
                path.addLine(to: CGPoint(x: dataBounds.minX + 0.1 * dataBounds.width, y: proxy.frame(in: .local).minY + tickLength))

                path.move(to:    CGPoint(x: dataBounds.minX + 0.2 * dataBounds.width, y: proxy.frame(in: .local).minY))
                path.addLine(to: CGPoint(x: dataBounds.minX + 0.2 * dataBounds.width, y: proxy.frame(in: .local).minY + tickLength))

                path.move(to:    CGPoint(x: dataBounds.minX + 0.3 * dataBounds.width, y: proxy.frame(in: .local).minY))
                path.addLine(to: CGPoint(x: dataBounds.minX + 0.3 * dataBounds.width, y: proxy.frame(in: .local).minY + tickLength))

                path.move(to:    CGPoint(x: dataBounds.minX + 0.4 * dataBounds.width, y: proxy.frame(in: .local).minY))
                path.addLine(to: CGPoint(x: dataBounds.minX + 0.4 * dataBounds.width, y: proxy.frame(in: .local).minY + tickLength))

                path.move(to:    CGPoint(x: dataBounds.minX + 0.5 * dataBounds.width, y: proxy.frame(in: .local).minY))
                path.addLine(to: CGPoint(x: dataBounds.minX + 0.5 * dataBounds.width, y: proxy.frame(in: .local).minY + tickLength))

                path.move(to:    CGPoint(x: dataBounds.minX + 0.6 * dataBounds.width, y: proxy.frame(in: .local).minY))
                path.addLine(to: CGPoint(x: dataBounds.minX + 0.6 * dataBounds.width, y: proxy.frame(in: .local).minY + tickLength))

                path.move(to:    CGPoint(x: dataBounds.minX + 0.7 * dataBounds.width, y: proxy.frame(in: .local).minY))
                path.addLine(to: CGPoint(x: dataBounds.minX + 0.7 * dataBounds.width, y: proxy.frame(in: .local).minY + tickLength))

                path.move(to:    CGPoint(x: dataBounds.minX + 0.8 * dataBounds.width, y: proxy.frame(in: .local).minY))
                path.addLine(to: CGPoint(x: dataBounds.minX + 0.8 * dataBounds.width, y: proxy.frame(in: .local).minY + tickLength))

                path.move(to:    CGPoint(x: dataBounds.minX + 0.9 * dataBounds.width, y: proxy.frame(in: .local).minY))
                path.addLine(to: CGPoint(x: dataBounds.minX + 0.9 * dataBounds.width, y: proxy.frame(in: .local).minY + tickLength))

                path.move(to:    CGPoint(x: dataBounds.minX + 1.0 * dataBounds.width, y: proxy.frame(in: .local).minY))
                path.addLine(to: CGPoint(x: dataBounds.minX + 1.0 * dataBounds.width, y: proxy.frame(in: .local).minY + tickLength))

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

    let tickLength: CGFloat = 10

    @Binding var dataBounds: CGRect


    var body: some View {

        GeometryReader { proxy in

            let t1 = CGAffineTransform
                .identity
                .scaledBy(x: 1, y: -1)
                .translatedBy(x: 0, y: -proxy.frame(in: .local).height)
                .scaledBy(x: 1,
                          y: proxy.frame(in: .local).height / dataBounds.height)
                .translatedBy(x: 0, y: -dataBounds.minY)

            Path { path in

                path.move(to: CGPoint(x: proxy.frame(in: .local).maxX,               y: dataBounds.minY + 0.0 * dataBounds.height))
                path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX-tickLength, y: dataBounds.minY + 0.0 * dataBounds.height))

                path.move(to: CGPoint(x: proxy.frame(in: .local).maxX,               y: dataBounds.minY + 0.1 * dataBounds.height))
                path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX-tickLength, y: dataBounds.minY + 0.1 * dataBounds.height))

                path.move(to: CGPoint(x: proxy.frame(in: .local).maxX,               y: dataBounds.minY + 0.2 * dataBounds.height))
                path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX-tickLength, y: dataBounds.minY + 0.2 * dataBounds.height))

                path.move(to: CGPoint(x: proxy.frame(in: .local).maxX,               y: dataBounds.minY + 0.3 * dataBounds.height))
                path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX-tickLength, y: dataBounds.minY + 0.3 * dataBounds.height))

                path.move(to: CGPoint(x: proxy.frame(in: .local).maxX,               y: dataBounds.minY + 0.4 * dataBounds.height))
                path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX-tickLength, y: dataBounds.minY + 0.4 * dataBounds.height))

                path.move(to: CGPoint(x: proxy.frame(in: .local).maxX,               y: dataBounds.minY + 0.5 * dataBounds.height))
                path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX-tickLength, y: dataBounds.minY + 0.5 * dataBounds.height))

                path.move(to: CGPoint(x: proxy.frame(in: .local).maxX,               y: dataBounds.minY + 0.6 * dataBounds.height))
                path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX-tickLength, y: dataBounds.minY + 0.6 * dataBounds.height))

                path.move(to: CGPoint(x: proxy.frame(in: .local).maxX,               y: dataBounds.minY + 0.7 * dataBounds.height))
                path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX-tickLength, y: dataBounds.minY + 0.7 * dataBounds.height))

                path.move(to: CGPoint(x: proxy.frame(in: .local).maxX,               y: dataBounds.minY + 0.8 * dataBounds.height))
                path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX-tickLength, y: dataBounds.minY + 0.8 * dataBounds.height))

                path.move(to: CGPoint(x: proxy.frame(in: .local).maxX,               y: dataBounds.minY + 0.9 * dataBounds.height))
                path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX-tickLength, y: dataBounds.minY + 0.9 * dataBounds.height))

                path.move(to: CGPoint(x: proxy.frame(in: .local).maxX,               y: dataBounds.minY + 1.0 * dataBounds.height))
                path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX-tickLength, y: dataBounds.minY + 1.0 * dataBounds.height))
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
