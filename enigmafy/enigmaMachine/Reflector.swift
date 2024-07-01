//
//  Reflector.swift
//  enigmafy
//
//  Created by Mohsen Bakhit on 2024-07-01.
//

import Foundation

class Reflector {
    private var wiring: [Character]
    
    init(wiring: [Character]){
        self.wiring = wiring
    }
    
    func reflect(input: Character) -> Character? {
        let asciiValue = input.asciiValue
        let index = Int(asciiValue - Character("A").asciiValue!)
        return wiring[index]
    }
}
