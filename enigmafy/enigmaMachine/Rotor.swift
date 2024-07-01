//
//  Rotor.swift
//  enigmafy
//
//  Created by Mohsen Bakhit on 2024-07-01.
//

import Foundation

class Rotor {
    private static let ALPHABET = Array("abcdefghijklmnopqrstuvwxyz")
    var wiring: [Character]
    private var count: Int
    
    init(startChar: Character, wiring: [Character]) {
        self.count = Rotor.ALPHABET.firstIndex(of: startChar) ?? 0
        self.wiring = wiring
    }
    
    func forwardEncrypt(input: Character) -> Character? {
        guard let inputIndex = Rotor.ALPHABET.firstIndex(of: input) else {return nil}
        let index = (inputIndex + count) % 26
        return wiring[index]
    }
    
    func backwardEncrypt(input: Character) -> Character?{
        guard let wiringIndex = wiring.firstIndex(of: input) else {return nil}
        let index = (wiringIndex - count + 26) % 26
        return Rotor.ALPHABET[index]
    }
    
    func incrementCount() {
        self.count = (self.count + 1) % 26
    }
    
    func getCount() -> Int {
        return self.count
    }
    
}