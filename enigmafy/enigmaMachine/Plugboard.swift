//
//  Plugboard.swift
//  enigmafy
//
//  Created by Mohsen Bakhit on 2024-07-01.
//

import Foundation

class Plugboard {
    private var mapping: [Character: Character]

    init(mapping: [Character: Character] = [:]) {
        self.mapping = mapping
    }

    func plug(input: Character, output: Character) {
        if let removable = mapping[input] {
            mapping.removeValue(forKey: input)
            mapping.removeValue(forKey: removable)
        } else if let removable = mapping[output] {
            mapping.removeValue(forKey: output)
            mapping.removeValue(forKey: removable)
        }
        mapping[input] = output
        mapping[output] = input
    }

    func retrieve(input: Character) -> Character {
        return mapping[input] ?? input
    }
}

