//
//  Scientist.swift
//  Example
//
//  Created by Alex Nolasco on 2/10/19.
//

import Foundation

@objc class Scientist: NSObject {
    let name: String
    let contribution: String
    override init() {
        name = ""
        contribution = ""
    }
    init(name: String, contribution: String) {
        self.name = name
        self.contribution = contribution
    }
}

extension Scientist {
    static func == (lhs: Scientist, rhs: Scientist) -> Bool {
        return lhs.name == rhs.name
    }
}
