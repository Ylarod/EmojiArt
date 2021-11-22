//
//  PaletteManager.swift
//  EmojiArt
//
//  Created by Ylarod on 2021/11/22.
//

import SwiftUI

struct PaletteManager: View {
    @EnvironmentObject var store: PaletteStore
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List{
                ForEach(store.palettes) { palette in
                    NavigationLink(destination: PaletteEditor(palette: $store.palettes[palette])) {
                        VStack(alignment: .leading) {
                            Text(palette.name)
                            Text(palette.emojis)
                        }
                    }
                }
                .onDelete { indexSet in
                    store.palettes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.palettes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle("Manage Palettes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                ToolbarItem {
                    if EnvironmentValues().isPresented, UIDevice.current.userInterfaceIdiom != .pad {
                        Button("Close"){
                            EnvironmentValues().dismiss()
                        }
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }
    }
}

struct PaletteManager_Previews: PreviewProvider {
    static var previews: some View {
        PaletteManager()
            .previewDevice("iPhone 8")
            .environmentObject(PaletteStore(named: "Test"))
    }
}
