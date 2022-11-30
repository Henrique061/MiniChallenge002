//
//  AjustesScene.swift
//  MiniChallenge002 iOS
//
//  Created by Jamile Polycarpo on 22/11/22.
//

import Foundation
import SpriteKit

class AjustesScene: SKScene {
    
    
    
    class func ajustesScene() -> AjustesScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "AjustesScene") as? AjustesScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        return scene
    }
    
    override func didMove(to view: SKView) {
        
        var musica = SKLabelNode(fontNamed: "SFUI-Bold")
        musica.text = "Musica"
        musica.fontColor = .white
        musica.position = CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.3)
        musica.fontSize = 30
        
        addChild(musica)
        
        var som = SKLabelNode(fontNamed: "SFUI-Bold")
        som.text = "Som"
        som.fontColor = .white
        som.position = CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.7)
        som.fontSize = 30
        
        addChild(som)
        
        let politica = ButtonPrefab(color: .red, colorSwitch: .black, positionPoint: CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.5), labelText: "P.P", rectangleSize: CGSize(width: 100, height: 40)) {
            
    
        }
        addChild(politica)
        
        let termos = ButtonPrefab(color: .green, colorSwitch: .black, positionPoint: CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.7), labelText: "T.U", rectangleSize: CGSize(width: 100, height: 40)) {
        }
        addChild(termos)
        
        let creditos = ButtonPrefab(color: .blue, colorSwitch: .black, positionPoint: CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.3), labelText: "Cred", rectangleSize: CGSize(width: 100, height: 40)) {
                    }
        addChild(creditos)
        
    }
}
