//
//  CPU+Constants.swift
//  
//
//  Created by Hugo Lundin on 2019-10-01.
//

import Foundation

extension CPU {
    public enum Constants {
        public enum Display {
            public static let width = 64
            public static let height = 32
        }
        
        public enum Memory {
            public static let size = 4096
        }
        
        public enum Stack {
            public static let size = 16
        }
    }
}
