//
//  File.swift
//  
//
//  Created by Hugo Lundin on 2019-10-01.
//

import Foundation

enum Instruction {
    case nop
    case toggle(x: Int, y: Int)
    case jmp(pc: Int)
}
