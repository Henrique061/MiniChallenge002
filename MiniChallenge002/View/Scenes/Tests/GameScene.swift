//
//  GameScene.swift
//  MiniChallenge002 Shared
//
//  Created by Henrique Batista de Assis on 11/11/22.
//

import SpriteKit

class GameScene: SKScene {
    
    
    fileprivate var label : SKLabelNode?
    fileprivate var spinnyNode : SKShapeNode?

    class func newGameScene() -> GameScene {
      
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }    // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        return scene
    }
    
    //start
    override func didMove(to view: SKView) {
        var texto: SKLabelNode?
        self.scaleMode = .resizeFill
        let button = ButtonPrefab(color: .green, colorSwitch: .blue, positionPoint: CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5), labelText: "Teste", rectangleSize: CGSize(width: 100, height: 50)) {
            print("to funfando")
        }
        
        self.addChild(button)
        
        let botao = ButtonPrefab(positionPoint: CGPoint(x:self.size.width * 0.8, y: self.size.height * 0.40), spriteWidth: 20, labeltext: "") {
            Contador.shared.addScore()
            texto  = SKLabelNode(fileNamed: "Score: \(Contador.shared.contador)")
        }

        self.addChild(botao)
        self.addChild(texto!)
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

