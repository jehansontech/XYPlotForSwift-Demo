//
//  ContentView.swift
//  XYPlotForSwift-Demo
//
//  Created by Jim Hanson on 4/30/21.
//

import SwiftUI
import XYPlotForSwift

struct ContentView: View {

    var body: some View {

        VStack {
            VStack(alignment: .leading, spacing: 0) {
                DisplayControls()
                Divider()
                PageView()
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}


struct DisplayControls: View {

    @EnvironmentObject var model: AppModel

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Button(action: {
                model.toggleColorScheme()
            }) {
                Image(systemName: "sun.max.fill")
            }

//            Picker("", selection: $model.currentPage) {
//                ForEach(Page.allCases, id: \.self) { p in
//                    Text(p.rawValue).tag(p)
//                }
//            }
//            .pickerStyle(.menu)

            Spacer()
                .frame(maxWidth: .infinity)
        }
        .preferredColorScheme(model.colorScheme) // put it here for convenience
    }
}

struct PageView: View {

    @EnvironmentObject var model: AppModel

    var body: some View {
        Group {
            switch model.currentPage {
            case .sevenCoins:
                SevenCoinsPage()
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

