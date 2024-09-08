//
//  VertextListView.swift
//  Mitsubachi
//  
//  Created by yamada-k-25 on 2024/09/07
//  
//

import SwiftUI

struct VertexListView {
    @Binding var vertexListText: String
    @State private var tempText: String = ""
}

extension VertexListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Vertext Input")
                    .font(.headline)
                Spacer()
                Button("Submit") {
                    self.vertexListText = self.tempText
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
    @Previewable @State var textListText = ""
    VertexListView(vertexListText: $textListText)
        .frame(height: 300)
}
