//
//  CreditosScene.swift
//  MiniChallenge002 iOS
//
//  Created by Jamile Marian Polycarpo on 01/12/22.
//

import Foundation
import SpriteKit


class CreditosScene: SKScene{
    
    private var lixo: SKNode?
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        let lixo = SKSpriteNode(imageNamed: "LixoVerde21")
        lixo.position = CGPoint(x: self.size.width * 0.75, y: self.size.height * 0.38)
        lixo.size = CGSize(width: 900, height: 900)
        
        addChild(lixo)
        
        let creditos = SKLabelNode(fontNamed: "Party Confetti")
        creditos.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.85)
        creditos.text = "Créditos"
        creditos.fontSize = 110
        creditos.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
        
        addChild(creditos)
        
        let musica = SKLabelNode(fontNamed: "Party Confetti")
        musica.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.2)
        musica.text = "Músicas: Kevin MacLeod (incompetech.com)"
        musica.fontSize = 70
        musica.fontColor = .black
        musica.horizontalAlignmentMode = .left
        musica.lineBreakMode = NSLineBreakMode.byWordWrapping
        musica.numberOfLines = 0
        musica.preferredMaxLayoutWidth = 1000
        addChild(musica)
        
       let efeitosSonoros = SKLabelNode(fontNamed: "Party Confetti")
        efeitosSonoros.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.6)
        efeitosSonoros.text = "Efeitos Sonoros: "
        efeitosSonoros.fontSize = 70
        efeitosSonoros.fontColor = .black
        efeitosSonoros.horizontalAlignmentMode = .left
        //addChild(efeitosSonoros)
        
        let design = SKLabelNode(fontNamed: "Party Confetti")
        design.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.6)
        design.text = "Design: Mari Higashi "
        design.fontSize = 70
        design.fontColor = .black
        design.horizontalAlignmentMode = .left
        addChild(design)
        
        
       let devs = SKLabelNode(fontNamed: "Party Confetti")
        devs.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.4)
        devs.text = "Desenvolvedores: Henrique Batista, Jamile Polycarpo, Luana Moraes "
        devs.fontSize = 70
        devs.fontColor = .black
        devs.horizontalAlignmentMode = .left
        devs.lineBreakMode = NSLineBreakMode.byWordWrapping
        devs.numberOfLines = 0
        devs.preferredMaxLayoutWidth = 1000
        addChild(devs)
        
       let nome = SKLabelNode(fontNamed: "Party Confetti")
        nome.text = "Voltar"
        nome.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
        nome.position = CGPoint(x: self.size.width * 0.12, y: self.size.height * 0.88)
        nome.fontSize = 60
        nome.horizontalAlignmentMode = .left

        addChild(nome)
        
        let voltar = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.09, y: self.size.height * 0.9), spriteSize: CGSize(width: 60, height: 70), labelText: "", fontSize: 0, textureName: "voltar", buttonType: .withoutAnim, action: {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = AjustesScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        })
        addChild(voltar)
    }
}
