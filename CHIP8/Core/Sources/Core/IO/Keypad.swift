//
//  Keypad.swift
//  
//
//  Created by Hugo Lundin on 2019-10-01.
//

import Foundation

public struct Keypad {
    public enum Error: Swift.Error {
        
    }
    
    var keys: [Bool]
    
    init() {
        self.keys = Array.init(repeating: false, count: 16)
    }
    
    public var pressed: [Int] {
        var pressed = [Int]()
        
        for (index, key) in keys.enumerated() {
            if key {
                pressed.append(index)
            }
        }
        
        return pressed
    }
}
