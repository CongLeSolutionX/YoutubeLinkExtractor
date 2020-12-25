//
//  Array+SafeSubscript.swift
//  YoutubeLinkExtractor
//
//  Created by Cong Le on 12/24/20.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return Int(index) < count ? self[Int(index)] : nil
    }
}
