//
//  CreditosScene.swift
//  MiniChallenge002 iOS
//
//  Created by Jamile Marian Polycarpo on 01/12/22.
//

import Foundation
import SpriteKit


class CreditosScene: SKScene{
    
    private var lixo: SKNode?
    

    
    
    
    override func didMove(to view: SKView) {
        
   
        backgroundColor = .white
        var lixo = SKSpriteNode(imageNamed: "LixoVerde21")
        lixo.position = CGPoint(x: self.size.width * 0.75, y: self.size.height * 0.38)
        lixo.size = CGSize(width: 900, height: 900)
        
        addChild(lixo)
        
        var creditos = SKLabelNode(fontNamed: "Party Confetti")
        creditos.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.85)
        creditos.text = "Créditos"
        creditos.fontSize = 110
        creditos.fontColor = .black
        addChild(creditos)
    }
    
    
    
}
