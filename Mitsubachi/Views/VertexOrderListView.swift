//
//  VertexOrderListView.swift
//  Mitsubachi
//  
//  Created by yamada-k-25 on 2024/09/07
//  
//

import SwiftUI

struct VertexOrderListView {
    @Binding var vertexOrderListText: String
    @State private var tempText: String = ""
}

extension VertexOrderListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Vertext Order Input")
                    .font(.headline)
                Spacer()
                Button("Submit") {
                    self.vertexOrderListText = self.tempText
                }
            }
            TextEditor(text: self.$tempText)
                .textEditorStyle(.plain)
                .fontDesign(.monospaced)
                .border(.gray, width: 1)
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    VertexOrderListView(vertexOrderListText: $text)
}
