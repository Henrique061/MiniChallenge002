//
//  Menu.swift
//  MiniChallenge002 iOS
//
//  Created by Jamile Polycarpo on 22/11/22.
//

import SpriteKit

class Menu: SKScene{
    
    var jogar: SKNode?
    
    var nome:SKSpriteNode?
    
    var config: SKSpriteNode?

    override func didMove(to view: SKView) {
        
        backgroundColor = .red
        nome = SKSpriteNode(imageNamed: "trash catch")
        nome?.size = CGSize(width: 190, height: 190)
        nome!.position = CGPoint(x: 0, y: 90)

        addChild(nome!)
        
        let ajustes = ButtonPrefab(color: .red, colorSwitch: .black, positionPoint: CGPoint(x: 350, y: 150), labelText: "", rectangleSize: CGSize(width: 50, height: 25)) {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = AjustesScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
            
        }
        addChild(ajustes)
        
        let botao = ButtonPrefab(positionPoint:  CGPoint(x: 20, y: -90), spriteSize: CGSize(width: 150, height: 50), labelText: "Jogar", fontSize: 30, textureName: "spr_buttonIdle", buttonType: .sprite, action: {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = Info(size: self.size)
                
            
            self.view?.presentScene(scene, transition: transition)
        })
          addChild(botao)


    }
    
}

