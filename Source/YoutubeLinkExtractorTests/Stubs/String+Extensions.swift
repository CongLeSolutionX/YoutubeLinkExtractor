//
//  Stub.swift
//  YoutubeLinkExtractorTests
//
//  Created by Cong Le on 12/24/20.
//

import Foundation

// Handling the string content of stub text file
extension String {
    
    init?(contentsOfBundleFile file: String?, type: String?) {
        guard let bundle = Bundle.allBundles.first(where: { $0.bundleIdentifier?.contains("Tests") ?? false }),
        let path = bundle.path(forResource: file, ofType: type),
        let contents = try? String(contentsOfFile: path, encoding: .utf8) else {
            return nil
        }
        
        self = contents.replacingOccurrences(of: "\n", with: "")
    }
}
