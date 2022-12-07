//
//  PoliticaPrivacidade.swift
//  MiniChallenge002 iOS
//
//  Created by Luana Moraes on 02/12/22.
//

import Foundation
import SpriteKit

class PoliticaPrivacidade: SKScene {
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .white
        self.size = CGSize(width: 1920, height: 1080)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .resizeFill
        
        let politicaPrivacidade = SKLabelNode(text: "O jogo Trash Catch foi criado e é mantido por Henrique Batista, Jamile Polycarpo, Luana Moraes e Mari Higashi. O intuito do aplicativo é entreter o usuário e também conscientizá-lo sobre a separação correta de lixo. Não é feita nenhuma coleta de dados pessoais ou sensíveis, e também não há necessidade de fazer login do usuário. A Política de Privacidade foi atualizada pela última vez em 02/12/2022. Reservamo-nos o direito de modificar, a qualquer momento, as normas vigentes, caso haja futuras alterações em nosso aplicativo, seja pela disponibilização de novas funcionalidades, supressão ou modificações daquelas já existentes ou ainda a disponibilidade de uma versão premium. Para quaisquer dúvidas e sugestões sobre a Política de Privacidade, entre em contato conosco por meio dos email abaixo: Luana Moraes - moraes.luana@unifesp.br")
        politicaPrivacidade.fontName = "SFProCompact"
        politicaPrivacidade.fontColor = .black
        politicaPrivacidade.zPosition = 5
        politicaPrivacidade.lineBreakMode = NSLineBreakMode.byWordWrapping
        politicaPrivacidade.numberOfLines = 0
        politicaPrivacidade.preferredMaxLayoutWidth = 1000
        politicaPrivacidade.position = CGPoint(x: 0, y: 0)
        politicaPrivacidade.fontSize = 40
        politicaPrivacidade.verticalAlignmentMode = .center
        
        addChild(politicaPrivacidade)
        
        let voltar = ButtonPrefab(positionPoint: CGPoint(x: -750, y: 400), spriteSize: CGSize(width: 60, height: 70), labelText: "", fontSize: 0, textureName: "voltar", buttonType: .withoutAnim, action: {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = MenuScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        })
        addChild(voltar)
    }
}
