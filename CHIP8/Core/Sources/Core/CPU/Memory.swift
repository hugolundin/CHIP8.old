//
//  Memory.swift
//  
//
//  Created by Hugo Lundin on 2019-10-01.
//

import Foundation

struct Memory<V> {
    enum Error: Swift.Error {
        case outOfBounds
        case tooLarge
    }
    
    let size: Int
    var contents: [V]
    
    init(_ content: V, size: Int) {
        self.size = size
        self.contents = Array(repeating: content, count: size)
    }
    
    @discardableResult
    mutating func load(_ data: [V], at address: Int) -> Result<Void, Error> {
        // If the given address is larger than the
        // last index of the contents array, return
        // en error.
        if address > size {
            return .failure(.outOfBounds)
        }
        
        // If the given data is larger than the whole memory,
        // return an error.
        if data.count > size {
            return .failure(.tooLarge)
        }
        
        // Store the given data at the given address in memory.
        self.contents[address..<address + data.count] = data[0..<data.count]
        return .success(())
    }
    
    @discardableResult
    mutating func load(_ data: V, at address: Int) -> Result<Void, Error> {
        // If the given address is larger than the
        // last index of the contents array, return
        // en error.
        if address > size {
            return .failure(.outOfBounds)
        }
        
        self.contents[address] = data
        return .success(())
    }
}
