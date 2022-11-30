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
        let positionPoint = CGPoint(x: 0, y: -50)
        
        // cria node
        let treadmillNode = SKSpriteNode(texture: SKTexture.init(imageNamed: "Esteira"))
        treadmillNode.position = positionPoint
        treadmillNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        treadmillNode.size = CGSize(width: 3800, height: 1400)

        self.addChild(treadmillNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
