//
//  Info.swift
//  MiniChallenge002 iOS
//
//  Created by Jamile Polycarpo on 23/11/22.
//

import Foundation
import SpriteKit

class Info: SKScene {
    
   
    class func infoScene() -> Info {
        // Load 'GameScene.sks' as an SKScene.
        
        guard let scene = SKScene(fileNamed: "Info") as? Info else {
            print("Failed to load Info.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        return scene
    }
    
    override func didMove(to view: SKView) {
        
        var jogar = ButtonPrefab(color: .green, colorSwitch: .red, positionPoint: CGPoint(x: self.size.width * 0.85, y: self.size.height * 0.25), labelText: "Jogar", rectangleSize: CGSize(width: 100, height: 50)) {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = GameScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        }
        
        addChild(jogar)
        
        var retangulo = SKShapeNode(rectOf: CGSize(width: 100, height: 250))
        
        retangulo.position = CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.35)
        
        addChild(retangulo)
        
        
        var texto = SKLabelNode(fontNamed: "SFUI-Bold")
        texto.text = "O Lixo organico blalalalalalalalalal"
        texto.fontColor = .white
        texto.position = CGPoint(x: self.size.width * 0.6, y: self.size.height * 0.7)
        texto.fontSize = 30
        
        addChild(texto)
    }
    
}
