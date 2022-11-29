//
//  Contador.swift
//  MiniChallenge002 iOS
//
//  Created by Jamile Polycarpo on 25/11/22.
//

import Foundation
import SpriteKit

class Contador{
    
    public static var shared = Contador()
    
    public var contador: Int = 0
    
    public var score: Int = 0
    
    public func addScore(){
        self.contador += 1
    }
    
    public func removeScore(){
        self.contador -= 1
    }

    
}
