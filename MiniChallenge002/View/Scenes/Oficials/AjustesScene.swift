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
        
        backgroundColor = .white
        
       let nome = SKLabelNode(fontNamed: "Party Confetti")
        nome.text = "Configurações"
        nome.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
        nome.position = CGPoint(x: self.size.width * 0.12, y: self.size.height * 0.88)
        nome.fontSize = 60
        nome.horizontalAlignmentMode = .left

        addChild(nome)
        
  
        let musica = SKLabelNode(fontNamed: "Party Confetti")
        musica.text = "Música"
        musica.fontColor = .black
        musica.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.6)
        musica.fontSize = 70
        musica.horizontalAlignmentMode = .left
        
        //addChild(musica)
        
        let som = SKLabelNode(fontNamed: "Party Confetti")
        som.text = "Efeitos Sonoros"
        som.fontColor = .black
        som.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.4)
        som.fontSize = 70
        som.horizontalAlignmentMode = .left
        //addChild(som)
        
        let politica = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.5), spriteSize: CGSize(width: 380, height: 160), labelText: "", fontSize: 0,textureName: "politica",  buttonType: .withoutAnim, action:  {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = PoliticaPrivacidade(size: self.size)
            self.view?.presentScene(scene, transition: transition)
    
        })
        addChild(politica)
        
        let termos = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.3), spriteSize: CGSize(width: 380, height: 160), labelText: "", fontSize: 0, textureName: "termo", buttonType: .withoutAnim, action:  {
            
    
        })
        addChild(termos)
        
        let creditos = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.7), spriteSize: CGSize(width: 380, height: 160), labelText: "", fontSize: 0, textureName: "creditos", buttonType: .withoutAnim, action:  {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = CreditosScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
            
    
        })
        addChild(creditos)
        
        let voltar = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.09, y: self.size.height * 0.9), spriteSize: CGSize(width: 60, height: 70), labelText: "", fontSize: 0, textureName: "voltar", buttonType: .withoutAnim, action: {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = MenuScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        })
        addChild(voltar)
        
       let ligado = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.4, y: self.size.height * 0.625), spriteSize: CGSize(width: 30, height: 40), labelText: "", fontSize: 0, textureName:"ligado" , buttonType: .withoutAnim, action: {
            
        })
        //addChild(ligado)
        
        let desligado = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.55, y: self.size.height * 0.625), spriteSize: CGSize(width: 30, height: 40), labelText: "", fontSize: 0, textureName:"desligado" , buttonType: .withoutAnim, action: {
            
            
        })
        //addChild(desligado)
        
        let ligadoSom = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.4, y: self.size.height * 0.42), spriteSize: CGSize(width: 30, height: 40), labelText: "", fontSize: 0, textureName:"ligado" , buttonType: .withoutAnim, action: {
            
        })
        //addChild(ligadoSom)
        
       let desligadoSom = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.55, y: self.size.height * 0.42), spriteSize: CGSize(width: 30, height: 40), labelText: "", fontSize: 0, textureName:"desligado" , buttonType: .withoutAnim, action: {
            
        })
        //addChild(desligadoSom)
    }
    
    
    
}
