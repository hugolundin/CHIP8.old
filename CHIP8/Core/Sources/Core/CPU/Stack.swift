//
//  Stack.swift
//  
//
//  Created by Hugo Lundin on 2019-10-01.
//

import Foundation

struct Stack<V> {
    enum Error: Swift.Error {
        case full
        case empty
    }
    
    let size: Int
    var contents: [V]
    
    init(_ value: V, size: Int) {
        self.size = size
        self.contents = []
    }
    
    @discardableResult
    mutating func push(_ value: V) -> Result<Void, Error> {
        if contents.count < self.size {
            self.contents.append(value)
            return .success(())
        }
        
        return .failure(.full)
    }
    
    @discardableResult
    mutating func pop() -> Result<V, Error> {
        if let value = self.contents.popLast() {
            return .success(value)
        }
        
        return .failure(.empty)
    }
}
