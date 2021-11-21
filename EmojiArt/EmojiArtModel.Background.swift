//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Created by Ylarod on 2021/11/20.
//

import Foundation

extension EmojiArtModel{
    
    // No need to implement encode & decode like the course while using swift 5.5
    enum Background: Equatable, Codable{
        case blank
        case url(URL)
        case imageData(Data)
        
        var url: URL? {
            switch self{
            case .url(let url): return url
            default: return nil
            }
        }
        
        var imageData: Data? {
            switch self{
            case .imageData(let data): return data
            default: return nil
            }
        }
        
    }
    
}
