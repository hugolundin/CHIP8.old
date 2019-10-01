//
//  Display.swift
//  
//
//  Created by Hugo Lundin on 2019-10-01.
//

import Foundation
import os.log

public struct Display<V> {
    public enum Error: Swift.Error {
        case outOfBounds
    }
    
    public let width: Int
    public let height: Int
    public var contents: [[V]]
    public internal (set) var shouldRefresh: Bool
    
    init(_ content: V, width: Int, height: Int) {
        self.width = width
        self.height = height
        self.contents = Array.init(
            repeating: Array.init(
                repeating: content, count: CPU.Constants.Display.width
        ), count: CPU.Constants.Display.height)
        self.shouldRefresh = false
    }
    
    @discardableResult
    mutating func set(_ value: V, x: Int, y: Int) -> Result<Void, Error> {
        guard x < width && y < height else {
            return .failure(.outOfBounds)
        }
        
        contents[y][x] = value
        shouldRefresh = true
        
        return .success(())
    }
    
    func get(_ x: Int, y: Int) -> Result<V, Error> {
        return .success(contents[x][y])
    }
    
    mutating func clear(_ value: V) {
        contents = contents.map { row in row.map { _ in value }}
    }
    
    public mutating func commitRefresh() {
        self.shouldRefresh = false
    }
}
