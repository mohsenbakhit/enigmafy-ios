//
//  enigmaMachine.swift
//  enigmafy
//
//  Created by Mohsen Bakhit on 2024-07-01.
//

import Foundation

enum EnigmaError: Error {
    case asciiNotExist
}

class EnigmaMachine {
    // As this is an M3 simulator, we have 3 Rotors and a Reflector
    var r1: Rotor
    var r2: Rotor
    var r3: Rotor
    var reflector: Reflector
    private var count: Int

    var plugboard: Plugboard
    private let wiring1: [Character] = ["E","K","M","F","L","G","D","Q","V","Z","N","T","O","W","Y","H","X","U","S","P","A","I","B","R","C","J"]
    private let wiring2: [Character] = ["A","J","D","K","S","I","R","U","X","B","L","H","W","T","M","C","Q","G","Z","N","P","Y","F","V","O","E"]
    private let wiring3: [Character] = ["B","D","F","H","J","L","C","P","R","T","X","V","Z","N","Y","E","I","W","G","A","K","M","U","S","Q","O"]

    init(startChar1: Character, startChar2: Character, startChar3: Character) {
        self.r1 = Rotor(startChar: startChar1, wiring: wiring1)
        self.r2 = Rotor(startChar: startChar2, wiring: wiring2)
        self.r3 = Rotor(startChar: startChar3, wiring: wiring3)
        self.reflector = Reflector(wiring: Array("YRUHQSLDPXNGOKMIEBFZCWVJAT"))
        self.plugboard = Plugboard()
        self.count = 0
    }

    init(startChar1: Character, startChar2: Character, startChar3: Character, plugboard: [Character: Character]) {
        self.r1 = Rotor(startChar: startChar1, wiring: wiring1)
        self.r2 = Rotor(startChar: startChar2, wiring: wiring2)
        self.r3 = Rotor(startChar: startChar3, wiring: wiring3)
        self.reflector = Reflector(wiring: Array("YRUHQSLDPXNGOKMIEBFZCWVJAT"))
        self.plugboard = Plugboard(mapping: plugboard)
        self.count = 0
    }

    func encrypt(_ plaintext: String) throws -> String {
        var cipher = ""
        for char in plaintext.uppercased() {
            do {
                try cipher.append(encryptChar(char))
            } catch (EnigmaError.asciiNotExist) {
                throw EnigmaError.asciiNotExist
            }
        }
        return cipher
    }

    private func encryptChar(_ input: Character) throws -> Character {
        guard input.isLetter else { return input }
        rotateRotors()
        do {
            var output = try plugboard.retrieve(input: input)
            output = try r1.forwardEncrypt(input: output)
            output = try r2.forwardEncrypt(input: output)
            output = try r3.forwardEncrypt(input: output)
            output = try reflector.reflect(input: output)
            output = try r3.backwardEncrypt(input: output)
            output = try r2.backwardEncrypt(input: output)
            output = try r1.backwardEncrypt(input: output)
            output = plugboard.retrieve(input: output)
            return output
        } catch (EnigmaError.asciiNotExist) {
            throw EnigmaError.asciiNotExist
        }
    }

    private func rotateRotors() {
        count += 1
        r1.incrementCount()
        if count % 26 == 0 {
            r2.incrementCount()
        }
        if count % (26 * 26) == 0 {
            r3.incrementCount()
        }
    }
}

