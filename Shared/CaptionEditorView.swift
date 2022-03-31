//
//  CaptionEditorView.swift
//
//
//  Created by Jim Hanson on 3/31/22.
//

import SwiftUI
import XYPlotForSwift

struct CaptionEditorView: View {

    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var model: XYPlotModel

    @State var captionText: String

    var textEditorPadding = EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

    public var body: some View {
        VStack(spacing: 5) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Caption")
                TextEditor(text: $captionText)
                    .disableAutocorrection(true)
                    .frame(minWidth: 600, minHeight: XYPlotConstants.captionHeight)
                    .border(Color.accentColor)
                    .padding(textEditorPadding)
            }
            Button {
                model.caption = captionText
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Submit")
            }
        }
    }

    public init(_ model: XYPlotModel) {
        self.model = model
        self._captionText = State(initialValue: model.caption)
    }
}

