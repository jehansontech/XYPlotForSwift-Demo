////
////  TickMaker.swift
////  XYPlotForSwift-Demo
////
////  Created by Jim Hanson on 5/9/21.
////
//
//import SwiftUI
//
//struct DataBounds {
//
//    var minX: Double = 0
//
//    var maxX: Double {
//        return minX + width
//    }
//
//    var minY: Double = 0
//
//    var maxY: Double {
//        return minY + height
//    }
//
//    var width: Double = 1
//
//    var height: Double = 1
//
//    var fminX: CGFloat {
//        return CGFloat(minX)
//    }
//
//    var fwidth: CGFloat {
//        return CGFloat(width)
//    }
//
//    var fminY: CGFloat {
//        return CGFloat(minY)
//    }
//
//    var fheight: CGFloat {
//        return CGFloat(height)
//    }
//
//    var exponentX: Int {
//        let m1 = Double.orderOfMagnitude(minX)
//        let m2 = Double.orderOfMagnitude(maxX)
//        let m3 = Double.orderOfMagnitude(width)
//        let max = max(max(m1, m2), m3)
//        return max - 1
//    }
//
//    var exponentY: Int {
//        let m1 = Double.orderOfMagnitude(minY)
//        let m2 = Double.orderOfMagnitude(maxY)
//        let m3 = Double.orderOfMagnitude(height)
//        let max = max(max(m1, m2), m3)
//        return max - 1
//    }
//}
//
//
//struct XTicks: View {
//
//    let fontSize: CGFloat = 15
//
//    let charHeight: CGFloat = 20
//
//    let tickLength: CGFloat = 10
//
//    let formatter: NumberFormatter = NumberFormatter()
//
//    @Binding var dataBounds: DataBounds
//
//    var numbers: [Int] {
//        return makeNumbers()
//    }
//
//    var fmultiplier: CGFloat {
//        return CGFloat(multiplier)
//    }
//
//    var multiplier: Double {
//        return pow(10,Double(dataBounds.exponentX))
//    }
//
//    var body: some View {
//
//        VStack(spacing: 10) {
//
//            GeometryReader { proxy in
//
//                let t1 = CGAffineTransform
//                    .identity
//                    .scaledBy(x: proxy.frame(in: .local).width / dataBounds.fwidth,
//                              y: 1)
//                    .translatedBy(x: -dataBounds.fminX, y: -dataBounds.fminY)
//
//                ForEach(numbers, id: \.self) { n in
//
//                    Path { path in
//                        path.move(to:    CGPoint(x: fmultiplier * CGFloat(n), y: proxy.frame(in: .local).minY))
//                        path.addLine(to: CGPoint(x: fmultiplier * CGFloat(n), y: proxy.frame(in: .local).minY + tickLength))
//                    }
//                    .applying(t1)
//                    .stroke()
//
//                    Text(formatter.string(for: n)!)
//                        .font(Font.system(size: fontSize, design: .monospaced))
//                        .fixedSize()
//                        .position(CGPoint(x: fmultiplier * CGFloat(n), y: (proxy.frame(in: .local).minY  + charHeight)).applying(t1))
//                }
//            }
//
//            Text(makeLabel())
//                .font(Font.system(size: fontSize, design: .monospaced))
//
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//
//    }
//
//    init(_ dataBounds: Binding<DataBounds>) {
//        self._dataBounds = dataBounds
//    }
//
//    func makeNumbers() -> [Int] {
//        var numbers = [Int]()
//        let min = Int(floor(dataBounds.minX / multiplier))
//        let max = Int(ceil(dataBounds.maxX / multiplier))
//        for n in stride(from: min, through: max, by: getStride(max - min)) {
//            numbers.append(n)
//        }
//        return numbers
//    }
//
//    func getStride(_ delta: Int) -> Int{
//        if delta > 50 {
//            return 10
//        }
//        else if delta > 20 {
//            return 5
//        }
//        else if delta > 10 {
//            return 2
//        }
//        else {
//            return 1
//        }
//    }
//
//    func makeLabel() -> String {
//        switch dataBounds.exponentX {
//        case 0:
//            return "X (units)"
//        case 1:
//            return "X (units x 10)"
//        default:
//            return "X (units x 10^\(dataBounds.exponentX))"
//        }
//    }
//}
//
//struct YTicks: View {
//
//    let fontSize: CGFloat = 15
//
//    let charWidth: CGFloat = 20
//
//    let tickLength: CGFloat = 10
//
//    let formatter: NumberFormatter = NumberFormatter()
//
//    @Binding var dataBounds: DataBounds
//
//    var numbers: [Int] {
//        return makeNumbers()
//    }
//
//    var fmultiplier: CGFloat {
//        return CGFloat(multiplier)
//    }
//
//    var multiplier: Double {
//        return pow(10,Double(dataBounds.exponentY))
//    }
//
//    var body: some View {
//
//        HStack(spacing: 10) {
//
//            Text(makeLabel())
//                .font(Font.system(size: fontSize, design: .monospaced))
//                .rotated(by: .degrees(-90))
//
//            GeometryReader { proxy in
//
//                let t1 = CGAffineTransform
//                    .identity
//                    .scaledBy(x: 1, y: -1)
//                    .translatedBy(x: 0, y: -proxy.frame(in: .local).height)
//                    .scaledBy(x: 1,
//                              y: proxy.frame(in: .local).height / dataBounds.fheight)
//                    .translatedBy(x: 0, y: -dataBounds.fminY)
//
//                ForEach(numbers, id: \.self) { n in
//
//                    Text(formatter.string(for: n)!)
//                        .font(Font.system(size: fontSize, design: .monospaced))
//                        .fixedSize()
//                        .position(CGPoint(x: proxy.frame(in: .local).maxX - numberOffset(n), y: fmultiplier * CGFloat(n)).applying(t1))
//
//                    Path { path in
//                        path.move(   to: CGPoint(x: proxy.frame(in: .local).maxX,              y: fmultiplier * CGFloat(n)))
//                        path.addLine(to: CGPoint(x: proxy.frame(in: .local).maxX - tickLength, y: fmultiplier * CGFloat(n)))
//                    }
//                    .applying(t1)
//                    .stroke()
//
//                }
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//
//    init(_ dataBounds: Binding<DataBounds>) {
//        self._dataBounds = dataBounds
//    }
//
//    func makeNumbers() -> [Int] {
//        var numbers = [Int]()
//        let min = Int(floor(dataBounds.minY / multiplier))
//        let max = Int(ceil(dataBounds.maxY / multiplier))
//        for n in stride(from: min, through: max, by: getStride(max - min)) {
//            numbers.append(n)
//        }
//        return numbers
//    }
//
//    func getStride(_ delta: Int) -> Int{
//        if delta > 50 {
//            return 10
//        }
//        else if delta > 20 {
//            return 5
//        }
//        else if delta > 10 {
//            return 2
//        }
//        else {
//            return 1
//        }
//    }
//
//    func makeLabel() -> String {
//        switch dataBounds.exponentY {
//        case 0:
//            return "(units)"
//        case 1:
//            return "(units x 10)"
//        default:
//            return "(units x 10^\(dataBounds.exponentY))"
//        }
//    }
//
//    func numberOffset(_ n: Int) -> CGFloat {
//        return 2 * tickLength
//        // FIXME
//        // return CGFloat(digitCount(n)) * charWidth / 2
//    }
//
//    func digitCount(_ n: Int) -> Int {
//        // TODO
//        if (n > 99) {
//            return 3
//        }
//        else if (n > 9) {
//            return 2
//        }
//        else {
//            return 1
//        }
//    }
//}
//
//
//struct TickMakerPlot: View {
//
//    let fontSize: CGFloat = 12
//
//    @Binding var dataBounds: DataBounds
//
//    var body: some View {
//
//        GeometryReader { proxy in
//
//            let t1 = CGAffineTransform
//                .identity
//                .scaledBy(x: 1, y: -1)
//                .translatedBy(x: 0, y: -proxy.frame(in: .local).height)
//                .scaledBy(x: proxy.frame(in: .local).width / dataBounds.fwidth,
//                          y: proxy.frame(in: .local).height / dataBounds.fheight)
//                .translatedBy(x: -dataBounds.fminX, y: -dataBounds.fminY)
//
//            Text("(0, 0)")
//                .font(Font.system(size: fontSize, design: .monospaced))
//                .position(CGPoint(x: 0, y: 0).applying(t1))
//
//            Group {
//                Text("(0.1, 0.1)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: 0.1, y: 0.1).applying(t1))
//
//                Text("(1, 1)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: 1, y: 1).applying(t1))
//
//                Text("(10, 10)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: 10, y: 10).applying(t1))
//
//                Text("(100, 100)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: 100, y: 100).applying(t1))
//            }
//
//            Group {
//                Text("(-0.1, -0.1)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: -0.1, y: -0.1).applying(t1))
//
//                Text("(-1, -1)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: -1, y: -1).applying(t1))
//
//                Text("(-10, -10)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: -10, y: -10).applying(t1))
//
//                Text("(-100, -100)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: -100, y: -100).applying(t1))
//            }
//
//            Group {
//                Text("(0.1, -0.1)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: 0.1, y: -0.1).applying(t1))
//
//                Text("(1, -1)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: 1, y: -1).applying(t1))
//
//                Text("(10, -10)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: 10, y: -10).applying(t1))
//
//                Text("(100, -100)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: 100, y: -100).applying(t1))
//            }
//
//            Group {
//                Text("(-0.1, 0.1)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: -0.1, y: 0.1).applying(t1))
//
//                Text("(-1, 1)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: -1, y: 1).applying(t1))
//
//                Text("(-10, 10)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: -10, y: 10).applying(t1))
//
//                Text("(-100, 100)")
//                    .font(Font.system(size: fontSize, design: .monospaced))
//                    .position(CGPoint(x: -100, y: 100).applying(t1))
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//
//    init(_ dataBounds: Binding<DataBounds>) {
//        self._dataBounds = dataBounds
//    }
//}
//
//struct DataBoundsControls : View {
//
//    @Binding var dataBounds: DataBounds
//
//    // @State var group = SettingsGroup().itemStyle(.narrow)
//
//    var body: some View {
//        VStack {
////            RangeSetting("xMin", $dataBounds.minX, $group, -100, 100, 0.1)
////            RangeSetting("width", $dataBounds.width, $group, 0.1, 200, 0.1)
////            RangeSetting("yMin", $dataBounds.minY, $group, -10, 10, 0.1)
////            RangeSetting("height", $dataBounds.height, $group, 0.1, 200, 0.1)
//        }
//    }
//
//    init(_ dataBounds: Binding<DataBounds>) {
//        self._dataBounds = dataBounds
//    }
//}
//
//struct TickMaker : View {
//
//    @State var dataBounds = DataBounds(minX: 2, minY: 1, width: 100, height: 10)
//
//    let plotWidth: CGFloat = 500
//
//    let plotHeight: CGFloat = 500
//
//    let ticksViewSize: CGFloat = 50
//
//    var body: some View {
//
//        HStack(spacing: 10) {
//
//            // Begin Settings area
//
//            DataBoundsControls($dataBounds)
//
//            // Begin Plot area
//
//            VStack(alignment: .leading, spacing: 0) {
//
//                Spacer()
//
//                HStack(spacing: 0) {
//
//                    YTicks($dataBounds)
//                        // .background(UIConstants.offBlack)
//                        .frame(width: ticksViewSize, height: plotHeight)
//                        // .clipped()
//
//                    TickMakerPlot($dataBounds)
//                        // .background(UIConstants.offBlack)
//                        .frame(width: plotWidth, height: plotHeight)
//                        // .border(UIConstants.offWhite)
//                        .clipped()
//
//                    Spacer()
//                        .frame(width: ticksViewSize, height: plotHeight)
//                }
//
//                HStack(spacing: 0) {
//
//                    Spacer()
//                        .frame(width: ticksViewSize, height: ticksViewSize)
//
//                    XTicks($dataBounds)
//                        // .background(UIConstants.offBlack)
//                        .frame(width: plotWidth, height: ticksViewSize)
//
//                    Spacer()
//                        .frame(width: ticksViewSize, height: ticksViewSize)
//
//                }
//
//                Spacer()
//            }
//            // end Plot area
//        }
//    }
//}
