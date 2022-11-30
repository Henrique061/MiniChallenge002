//
//  TreadmillPrefab.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 24/11/22.
//

import Foundation
import SpriteKit

public enum Direction : String {
    case left = "Esquerda"
    case right = "Direita"
}

class TreadmillPrefab : SKNode {
    
    //MARK: INIT
    override init() {
        super.init()
        
        //cria posicao
        var positionPoint = CGPoint.zero
        
        // cria node
        var treadmillNode = SKSpriteNode(texture: SKTexture.init(imageNamed: "Esteira"))
        treadmillNode.position = positionPoint
        self.addChild(treadmillNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
