//
//  MenuMudancaFase.swift
//  MiniChallenge002 iOS
//
//  Created by Luana Moraes on 28/11/22.
//

import Foundation
import SpriteKit

class MenuMudancaFase: SKScene {
        
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .resizeFill
        addChild(botaoJogar())
    }

    // criando o botao de jogar
    func botaoJogar() -> SKNode  {
        let botaoJogar = ButtonPrefab(positionPoint: CGPoint(x: 200, y: -80), spriteWidth: 150, labelText: "Jogar", fontSize: 25) {
            let transition:SKTransition = SKTransition.fade(withDuration: 1) //determinar a transição entre telas
            let scene:SKScene = MovimentoPersonagem(size: self.size) // chamando tela principal
            
            self.view?.presentScene(scene, transition: transition) // chamar a transição
        }
        
        return botaoJogar
    }
    
    // criando node que será a lixeira
    func criarLixeira() -> SKNode {
        let lixeira = ButtonPrefab(color: .orange, colorSwitch: .orange, positionPoint: CGPoint(x: 20, y: -100), labelText: "Lixeira", rectangleSize: CGSize(width: 200, height: 400)) {
    
        }
        
        return lixeira
    }
}
