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
      
        
        guard let scene = SKScene(fileNamed: "Info") as? Info else {
            print("Failed to load Info.sks")
            abort()
        }
        
        scene.scaleMode = .resizeFill
        
        return scene
    }
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: 1920, height: 1080)
        backgroundColor = .white
        
        let nome = SKLabelNode(fontNamed: "Party Confetti")
        nome.text = "Voltar"
        nome.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
        nome.position = CGPoint(x: self.size.width * 0.12, y: self.size.height * 0.88)
        nome.fontSize = 60
        nome.horizontalAlignmentMode = .left

        addChild(nome)
        let levelManager = LevelManager()
        let jogar = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.78, y: self.size.height * 0.20), spriteSize: CGSize(width:500, height: 166), labelText: "Jogar", fontSize: 100, textureName: "spr_buttonIdle", buttonType: .sprite, action: {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = LevelScene(levelManager: levelManager)
            self.view?.presentScene(scene, transition: transition)
        })
        
        addChild(jogar)
        
        let lixo = SKSpriteNode(imageNamed: "LixoVerde2")
        lixo.size = CGSize(width: 1300, height: 1500)
        
        lixo.position = CGPoint(x: self.size.width * 0.17, y: self.size.height * 0.2)
        
        addChild(lixo)
        
        
        let texto = SKLabelNode(fontNamed: "Party Confetti")
        texto.text = "Você Sabia?"
        texto.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
        texto.position = CGPoint(x: self.size.width * 0.55, y: self.size.height * 0.77)
        texto.fontSize = 100
        texto.lineBreakMode = NSLineBreakMode.byWordWrapping
        texto.numberOfLines = 0
        texto.preferredMaxLayoutWidth = 500
        
        addChild(texto)
        
        let texto1 = SKLabelNode(fontNamed: "Party Confetti")
        texto1.text = "A reciclagem de uma única lata de alumínio economiza energia suficiente para manter uma TV ligada durante três horas."
        texto1.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
        texto1.position = CGPoint(x: self.size.width * 0.55, y: self.size.height * 0.25)
        texto1.fontSize = 60
        texto1.lineBreakMode = NSLineBreakMode.byWordWrapping
        texto1.numberOfLines = 0
        texto1.preferredMaxLayoutWidth = 500
        
        addChild(texto1)
        let voltar = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.09, y: self.size.height * 0.9), spriteSize: CGSize(width: 60, height: 70), labelText: "", fontSize: 0, textureName: "voltar", buttonType: .withoutAnim, action: {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = MenuScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        })
        addChild(voltar)
        
    }
}
