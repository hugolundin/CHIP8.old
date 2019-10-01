//
//  EmulatorDisplayScene.swift
//  CHIP8
//
//  Created by Hugo Lundin on 2019-10-01.
//  Copyright © 2019 Hugo Lundin. All rights reserved.
//

import Foundation
import SpriteKit
import os.log
import Core

final class EmulatorDisplayScene: SKScene {
    var emulator: CPU
    var pixels = [[SKSpriteNode]]()
    
    init(size: CGSize, emulator: CPU) {
        
        let dimensions = floor(size.width / CGFloat(CPU.Constants.Display.width))
        let pixelSize = CGSize(width: dimensions, height: dimensions)
        
        for (column, rows) in emulator.display.contents.enumerated() {
            var pixelRow = [SKSpriteNode]()
            
            for (index, value) in rows.enumerated() {
                let pixel = SKSpriteNode(color: value ? .red : .black, size: pixelSize)
                
                pixel.position = CGPoint(
                    x: 20 + CGFloat(index) * dimensions,
                    y: 10 + CGFloat(column) * dimensions
                )
                
                pixelRow.append(pixel)
            }
            
            pixels.append(pixelRow)
        }
        
        self.emulator = emulator
        super.init(size: size)
        
        for row in pixels {
            for pixel in row {
                addChild(pixel)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {

    }
    
    override func update(_ currentTime: TimeInterval) {
        emulator.clock()
        
        if emulator.display.shouldRefresh {
            os_log("shouldRefresh = %@", String(emulator.display.shouldRefresh))
            
            for (column, rows) in emulator.display.contents.enumerated() {
                for (index, value) in rows.enumerated() {
                    pixels[column][index].color = value ? .red : .black
                }
            }
            
            emulator.display.commitRefresh()
        }
    }
    
    override func sceneDidLoad() {
        self.backgroundColor = .black
    }
}
