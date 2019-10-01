//
//  ContentView.swift
//  CHIP8
//
//  Created by Hugo Lundin on 2019-10-01.
//  Copyright © 2019 Hugo Lundin. All rights reserved.
//

import SpriteKit
import SwiftUI
import Core

struct ContentView: View {
    var emulator: CPU
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    VStack {
                        SceneView(scene: EmulatorDisplayScene(
                            size: CGSize(width: geometry.size.width, height: geometry.size.width * 0.5),
                                        emulator: self.emulator)
                        ).frame(width: geometry.size.width, height: geometry.size.width * 0.5)
                            .padding([.bottom], 400)
                    }
                }
            }
        .navigationBarTitle("CHIP8")
        }.colorScheme(.dark)
    }
}
