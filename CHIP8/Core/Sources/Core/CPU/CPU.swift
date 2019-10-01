//
//  CPU.swift
//  
//
//  Created by Hugo Lundin on 2019-10-01.
//

import Foundation
import os.log

public final class CPU {
    private var pc = Register<Int>(400)
    private var sp = Register<Int>(0x00)
    private var stack = Stack<UInt16>(0x00, size: Constants.Stack.size)
    private var memory = Memory<UInt8>(0x00, size: Constants.Memory.size)
    
    private var v0 = Register<UInt8>(0x00)
    private var v1 = Register<UInt8>(0x00)
    private var v2 = Register<UInt8>(0x00)
    private var v3 = Register<UInt8>(0x00)
    private var v4 = Register<UInt8>(0x00)
    private var v5 = Register<UInt8>(0x00)
    private var v6 = Register<UInt8>(0x00)
    private var v7 = Register<UInt8>(0x00)
    private var v8 = Register<UInt8>(0x00)
    private var v9 = Register<UInt8>(0x00)
    private var va = Register<UInt8>(0x00)
    private var vb = Register<UInt8>(0x00)
    private var vc = Register<UInt8>(0x00)
    private var vd = Register<UInt8>(0x00)
    private var ve = Register<UInt8>(0x00)
    private var vf = Register<UInt8>(0x00)
    private var delay = Register<UInt8>(0x00)
    private var sound = Register<UInt8>(0x00)
    
    public var keypad: Keypad = Keypad()
    public var display: Display<Bool> = Display(false, width: Constants.Display.width, height: Constants.Display.height)
    
    public init() {
        memory.load(characters, at: 0x00)
        
        let program: [UInt8] = [
            0x01, 0x01,
            0x00, 0x00,
            0x00, 0x00,
            0x00, 0x00,
            0x00, 0x00,
            0x01, 0x01,
            0x00, 0x00,
            0x00, 0x00,
            0x00, 0x00,
            0x00, 0x00,
            0x02, 0x09
        ]
        
        memory.load(program, at: 400)
    }
    
    public func clock() {
        // 1. Fetch instruction
        // 2. Decode instruction
        // 3. Check for key presses
        // 4. Execute instruction
        // 5. Decrement timers and check if we should play a sound.
        execute(decode(fetch()))
    }
    
    private func fetch() -> (msb: UInt8, lsb: UInt8) {
        guard pc.content < memory.contents.count else {
            os_log("Out of bounds")
            return (0x00, 0x00)
        }
        
        let msb = self.memory.contents[self.pc.content]
        let lsb = self.memory.contents[self.pc.content + 1]
        
        self.pc.content += 2
    
        return (msb: msb, lsb: lsb)
    }
    
    private func decode(_ bytes: (msb: UInt8, lsb: UInt8)) -> Instruction {
        if bytes.msb == 0x01 {
            return .toggle(x: Int(bytes.lsb), y: 0)
        }
        
        if bytes.msb == 0x02 {
            return .jmp(pc: Int(bytes.lsb))
        }
        
        return .nop
    }
    
    private func execute(_ instruction: Instruction) {
        switch instruction {
        case .nop:
            return
            
        case .toggle(let x, let y):
//            if case .success(let current) = self.display.get(x, y: y) {
//                self.display.set(!current, x: x, y: y)
//            }
            self.display.contents[y][x].toggle()
            self.display.shouldRefresh = true
            
        case .jmp(let difference):
            self.pc.content -= difference * 2
        }
    }
    
    private let characters: [UInt8] = [
        0xF0, 0x90, 0x90, 0x90, 0xF0, // = 0
        0x20, 0x60, 0x20, 0x20, 0x70, // = 1
        0xF0, 0x10, 0xF0, 0x80, 0xF0, // = 2
        0xF0, 0x10, 0xF0, 0x10, 0xF0, // = 3
        0x90, 0x90, 0xF0, 0x10, 0x10, // = 4
        0xF0, 0x80, 0xF0, 0x10, 0xF0, // = 5
        0xF0, 0x80, 0xF0, 0x90, 0xF0, // = 6
        0xF0, 0x10, 0x20, 0x40, 0x40, // = 7
        0xF0, 0x90, 0xF0, 0x90, 0xF0, // = 8
        0xF0, 0x90, 0xF0, 0x10, 0xF0, // = 9
        0xF0, 0x90, 0xF0, 0x90, 0x90, // = A
        0xE0, 0x90, 0xE0, 0x90, 0xE0, // = B
        0xF0, 0x80, 0x80, 0x80, 0xF0, // = C
        0xE0, 0x90, 0x90, 0x90, 0xE0, // = D
        0xF0, 0x80, 0xF0, 0x80, 0xF0, // = E
        0xF0, 0x80, 0xF0, 0x80, 0x80  // = F
    ]
}
