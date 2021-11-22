//
//  PaletteEditor.swift
//  EmojiArt
//
//  Created by Ylarod on 2021/11/22.
//

import SwiftUI

struct PaletteEditor: View {
    
    @Binding var palette: Palette
    
    var body: some View {
        Form {
            nameSection
            addEmojisSection
            removeEmojisSection
        }
        .frame(minWidth: 300, minHeight: 350)
        .navigationTitle("Edit \(palette.name)")
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $palette.name)
        }
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }
    
    var removeEmojisSection: some View {
        Section(header: Text("Remove Emojis")) {
            let emojis = palette.emojis.withNoRepeatedCharacters.map { String($0) }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            palette.emojis.removeAll(where: { String($0) == emoji })
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            palette.emojis = (emojis + palette.emojis)
                .filter { $0.isEmoji }
                .withNoRepeatedCharacters
        }
    }
}

struct PaletteEditor_Previews: PreviewProvider {
    static var previews: some View {
        PaletteEditor(palette: .constant(PaletteStore(named: "Test").palette(at: 2)))
    }
}
