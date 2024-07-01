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
    
    func reflect(input: Character) throws -> Character {
        guard let asciiValue = input.asciiValue else {throw EnigmaError.asciiNotExist}
        let index = Int(asciiValue - Character("A").asciiValue!)
        return wiring[index]
    }
}
