//
//  SceneView.swift
//  CHIP8
//
//  Created by Hugo Lundin on 2019-10-01.
//  Copyright © 2019 Hugo Lundin. All rights reserved.
//

import SwiftUI
import SpriteKit

struct SceneView: UIViewRepresentable {
    let scene: SKScene
    
    func makeUIView(context: UIViewRepresentableContext<SceneView>) -> SKView {
        return SKView(frame: .zero)
    }
    
    func updateUIView(_ uiView: SKView, context: UIViewRepresentableContext<SceneView>) {
        uiView.presentScene(scene)
    }
}
