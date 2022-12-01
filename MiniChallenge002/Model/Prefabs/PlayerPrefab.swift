//
//  PlayerPrefab.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Assis on 30/11/22.
//

import Foundation
import SpriteKit

public enum TrashType : String {
    case metal = "Metal"
    case plastic = "Plástico"
    case paper = "Papel"
    case glass = "Vidro"
    case organic = "Orgânico"
}

public enum TrashColor : String {
    case yellow = "LixoAmarelo"
    case red = "LixoVermelho"
    case blue = "LixoAzul"
    case green = "LixoVerde"
    case brown = "LixoMarrom"
}

class PlayerPrefab : SKNode {
    var trashAnimName: String
    var playerNode: SKSpriteNode
    
    //MARK: INITS
    init(trashColor: TrashColor) {
        //cria node
        self.playerNode = SKSpriteNode(imageNamed: "\(trashColor.rawValue)0")
        self.trashAnimName = trashColor.rawValue
        super.init()
        
        self.playerNode.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        self.playerNode.position = CGPoint(x: 0.0, y: -520)
        self.playerNode.size = CGSize(width: 570, height: 760)
        self.playerNode.physicsBody = SKPhysicsBody(rectangleOf: playerNode.size)
        self.playerNode.physicsBody?.affectedByGravity = false
        
        self.addChild(playerNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: METHODS
    public func setTrashColor(_ trashColor: TrashColor) {
        self.playerNode.run(.setTexture(.init(imageNamed: "\(trashColor.rawValue)0")))
        self.trashAnimName = trashColor.rawValue
    }
}
