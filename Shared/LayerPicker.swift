//
//  LayerPicker.swift
//
//
//  Created by Jim Hanson on 3/31/22.
//

import SwiftUI
import XYPlotForSwift

struct LayerPicker: View {

    @Environment(\.dismiss) private var dismiss

    @ObservedObject var model: XYPlotModel

    public var body: some View {
        VStack(alignment: .leading) {
            Text("Show")

            ForEach(model.layers.indices, id: \.self) { idx in
                Button {
                    model.selectedLayer = idx
                    dismiss()
                } label: {
                    Text(model.layers[idx].title)
                        .padding(.leading)
                }
                .buttonStyle(.plain)
                .foregroundColor(Color.accentColor)
            }
        }
    }

    public init(_ model: XYPlotModel) {
        self.model = model
    }

}
