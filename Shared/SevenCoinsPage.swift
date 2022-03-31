//
//  SevenCoinsPage.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 3/12/22.
//

import SwiftUI
import XYPlotForSwift
import Wacoma

struct SevenCoinsPage: View {

    @EnvironmentObject var model: AppModel

    @State var isSnapshotRequested: Bool = false

    var plotView: XYPlotView {
        XYPlotView(model.sevenCoinsDemo.plotModel)
    }

    var body: some View {
        ZStack {
            plotView
            SevenCoinsButtons(model.sevenCoinsDemo, $isSnapshotRequested)
        }
        .onChange(of: isSnapshotRequested) { newValue in
            if newValue {
                isSnapshotRequested = false
                do {
                    // This creates a new instance of the view!
                    try plotView.takeSnapshot().save()
                    print("Snapshot saved")
                }
                catch {
                    print("Problem saving snapshot: \(error)")
                }
            }
        }
    }
}

struct SevenCoinsButtons: View {

    @ObservedObject var demo: SevenCoinsDemo

    @Binding var isSnapshotRequested: Bool

    @State var isLayerSelectionSheetPresented: Bool = false

    @State var isCustomizationSheetPresented: Bool = false

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                    .frame(height: 150)
                dataButtons
                Spacer()
                    .frame(height: 50)
                plotButtons
                Spacer()
            }
            .buttonStyle(OverlayButtonStyle())
        }
    }

    @ViewBuilder var dataButtons: some View {

        Button {
            demo.reset()
        } label: {
            Image(systemName: "arrow.counterclockwise")
        }
        .popover(isPresented: $isLayerSelectionSheetPresented) {
            LayerPicker(demo.plotModel)
                .padding()
        }

        if demo.running {
            Button {
                demo.stop()
            } label: {
                Image(systemName: "pause.fill")
            }
        }
        else {
            Button {
                demo.start()
            } label: {
                Image(systemName: "play.fill")
            }

            Button {
                demo.step()
            } label: {
                Image(systemName: "forward.frame.fill")
            }
        }
    }

    @ViewBuilder var plotButtons: some View {
        Button {
            isLayerSelectionSheetPresented = true
        } label: {
            Image(systemName: "square.3.layers.3d.down.left")

        }

        Button {
            isCustomizationSheetPresented = true
        } label: {
            Image(systemName: "pencil")
        }
        .popover(isPresented: $isCustomizationSheetPresented) {
            CaptionEditorView(demo.plotModel)
                .padding()
        }

        Button {
            isSnapshotRequested = true
        } label: {
            Image(systemName: "camera.on.rectangle")
        }
    }

    init(_ demo: SevenCoinsDemo, _ isSnapshotRequested: Binding<Bool>) {
        self.demo = demo
        self._isSnapshotRequested = isSnapshotRequested
    }
}

public struct OverlayButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .buttonStyle(.plain)
            .foregroundColor(Color.accentColor)
            .imageScale(.large)
            .frame(width: 35, height: 35)
            .border(Color.accentColor)
            .grayscale(grayscaleAmount(configuration.isPressed))
    }

    public init() {}

    private func grayscaleAmount(_ isPressed: Bool) -> Double {
        return isEnabled ? (isPressed ? 0.8 : 0) : 1
    }
}

