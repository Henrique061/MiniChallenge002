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
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        return scene
    }
    
    //start
    override func didMove(to view: SKView) {
        let button = ButtonPrefab(color: .green, positionPoint: CGPoint.zero, labelText: "Teste", rectangleSize: CGSize(width: 100, height: 50)) {
            print("to funfando")
        }
        
        self.addChild(button)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

