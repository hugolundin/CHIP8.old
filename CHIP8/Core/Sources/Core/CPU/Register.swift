//
//  Register.swift
//  
//
//  Created by Hugo Lundin on 2019-10-01.
//

import Foundation

struct Register<V> {
    var content: V
    
    init(_ content: V) {
        self.content = content
    }
}
