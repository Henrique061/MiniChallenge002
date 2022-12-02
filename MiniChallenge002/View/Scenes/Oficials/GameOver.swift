//
//  GameOver.swift
//  MiniChallenge002 iOS
//
//  Created by Jamile Marian Polycarpo on 01/12/22.
//

import Foundation
import SpriteKit


class GameOver: SKScene{
    
    
    var lixoPerdeu: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .white
        
        let perdeu = SKLabelNode(fontNamed: "Party Confetti")
        perdeu.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
        perdeu.fontSize = 150
        perdeu.text = "Você Perdeu!"
        perdeu.position = CGPoint(x: self.size.width * 0.3, y: self.size.height * 0.75)
        perdeu.horizontalAlignmentMode = .left
        
        addChild(perdeu)
        
        let jogarNovamente = SKLabelNode(fontNamed: "Party Confetti")
        jogarNovamente.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
        jogarNovamente.fontSize = 70
        jogarNovamente.text = "Jogar Novamente?"
        jogarNovamente.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.4)
        perdeu.horizontalAlignmentMode = .left
        
        addChild(jogarNovamente)
        
        lixoPerdeu = SKSpriteNode(imageNamed: "Lixo verde game over")
        lixoPerdeu?.position = CGPoint(x: self.size.width * 0.15, y: self.size.height * 0.25)
        lixoPerdeu?.size = CGSize(width: 900, height: 1000)
        
        addChild(lixoPerdeu!)
        
        let jogarSim = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.2), spriteSize: CGSize(width: 600, height: 250), labelText: "Sim", fontSize: 60, textureName: "Botão verde garrafa", buttonType: .withoutAnim, action: {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = LevelScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
            
        })
        let jogarNao = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.7, y: self.size.height * 0.2), spriteSize: CGSize(width: 500, height: 400), labelText: "Não", fontSize: 60, textureName: "Botão vermelho lata", buttonType: .withoutAnim, action: {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = MenuScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
            
        })
        
        addChild(jogarSim)
        addChild(jogarNao)
        
        

    }
    
    
}
