//
//  Menu.swift
//  MiniChallenge002 iOS
//
//  Created by Jamile Polycarpo on 22/11/22.
//

import SpriteKit

class Menu: SKScene{
    
    var jogar: SKNode?
    
    var nome: SKLabelNode?
    
    class func menuScene() -> Menu {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "Menu") as? Menu else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        return scene
    }
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .white
        nome = SKLabelNode(text: "NOME JOGO")
        nome!.position = CGPoint(x: 0, y: 100)
        nome!.fontColor = SKColor.black
        nome!.fontSize = 40
        
        addChild(nome!)
        
        let ajustes = ButtonPrefab(color: .red, colorSwitch: .black, positionPoint: CGPoint(x: 350, y: 150), labelText: "", rectangleSize: CGSize(width: 50, height: 25)) {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = AjustesScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
            
        }
        addChild(ajustes)
        
        
         jogar = ButtonPrefab(color: .green, colorSwitch: .brown, positionPoint: CGPoint(x: 0, y: 0), labelText: "Jogar", rectangleSize: CGSize(width: 100, height: 50)) {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
             let scene:SKScene = Info(size: self.size)
          
            self.view?.presentScene(scene, transition: transition)
        }

        addChild(jogar!)
    }
    
   
}
