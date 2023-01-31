//
//  MenuScene.swift
//  MiniChallenge002 iOS
//
//  Created by Jamile Marian Polycarpo on 01/12/22.
//

import Foundation
import SpriteKit

class MenuScene: SKScene{
    
    var jogar: SKNode?
    
    var nome = SKSpriteNode(imageNamed: "trash catch")
    
    var config: SKSpriteNode?

    override func didMove(to view: SKView) {
        self.size = CGSize(width: 1920, height: 1080)
        
        //audio
        if UserDefaults.standard.bool(forKey: "playMenuMusicAgain")
        {
            let menuMusic: [String : String] = ["file" : "MenuMusic"]
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PlaySound"), object: self, userInfo: menuMusic)
            UserDefaults.standard.set(false, forKey: "playMenuMusicAgain")
        }

        //Logo
        backgroundColor = .white
        nome = SKSpriteNode(imageNamed: "trash catch")
        nome.size = CGSize(width:450, height:550)
        nome.position = CGPoint(x: 0, y: 250)
        nome.zPosition = 10
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
//        var teste = SKShapeNode(circleOfRadius: 300)
//        teste.fillColor = .white
//        teste.position = .zero
        addChild(nome)
//        self.addChild(teste)
        
        let ajustes = ButtonPrefab(positionPoint: CGPoint(x: 750, y: 390), spriteSize: CGSize(width: 120, height:150), labelText: "", fontSize: 0, textureName: "engrenagem", buttonType: .sprite, action: {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = AjustesScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        })

        addChild(ajustes)
        
        //botao de jogar
        let botao = ButtonPrefab(positionPoint:  CGPoint(x: 20, y: -250), spriteSize: CGSize(width: 400, height: 200), labelText: "Iniciar", fontSize: 100, textureName: "Botao verde",  buttonType: .sprite, action: {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = Info(size: self.size)
                
            
            self.view?.presentScene(scene, transition: transition)
        })
          addChild(botao)


    }
    
}


