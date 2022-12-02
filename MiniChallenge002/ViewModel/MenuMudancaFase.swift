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
        
        backgroundColor = .black
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .resizeFill
        addChild(botaoJogar())
        
        let lataSelecionada = latas[Int.random(in: 1..<4)]
        
        var lixos: [String] = JunkData.getJunkList(.papel)
        switch lataSelecionada {
        case "Lixoamarelo":
            lixos = JunkData.getJunkList(.metal)
        case "Lixomarrom":
            lixos = JunkData.getJunkList(.organico)
        case "Lixoverde":
            lixos = JunkData.getJunkList(.vidro)
        case "Lixovermelho":
            lixos = JunkData.getJunkList(.plastico)
        default:
            lixos = JunkData.getJunkList(.papel)
        }
        
        for nomeLixo in lixos {
            lixo = SKSpriteNode(imageNamed: nomeLixo)
            lixo.physicsBody = SKPhysicsBody()
            lixo.physicsBody?.affectedByGravity = true
            lixo.physicsBody?.isDynamic = true
            lixo.position = .init(x: -225, y: 200)
            lixo.size = CGSize(width: 100, height: 100)
            lixo.zPosition = 5
            addChild(lixo)
        }
 
        //lixeira
        self.addChild(criarLixeira(tipo: lataSelecionada))
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        lixo.physicsBody?.velocity = CGVector(dx: 0, dy: -200)
        
        // para arredondar o eixo y e parar de caior
        if round(lixo.position.y) == 8.0 ||
            round(lixo.position.y) == 9.0 ||
            round(lixo.position.y) == 10.0 ||
            round(lixo.position.y) == 11.0 ||
            round(lixo.position.y) == 12.0 ||
            round(lixo.position.y) == 13.0 ||
            round(lixo.position.y) == 14.0 ||
            round(lixo.position.y) == 15.0 ||
            round(lixo.position.y) < 0 // parar de cair
        {
            lixo.removeFromParent() // para sumir
        }
    }
    
    // criando lixinhos
    var lixo = SKSpriteNode(imageNamed: "MacaOrganico")
    var latas = ["Lixoamarelo","Lixomarrom","Lixoverde","Lixovermelho","Lixoazul"]
   
    
    var yPos: CGFloat = 200
    
    // criando o botao de jogar
    func botaoJogar() -> SKNode  {
        let botaoJogar = ButtonPrefab(positionPoint: CGPoint(x: 250, y: -100), spriteWidth: 200, labelText: "Jogar", fontSize: 25) {
            let transition:SKTransition = SKTransition.fade(withDuration: 1) //determinar a transição entre telas
            let scene:SKScene = MovimentoPersonagem(size: self.size) // chamando tela principal
            
            self.view?.presentScene(scene, transition: transition) // chamar a transição
        }
        
        return botaoJogar
    }
    
    // criando node que será a lixeira
    func criarLixeira(tipo: String) -> SKSpriteNode {
        let lixeira = SKSpriteNode(imageNamed: tipo)
        lixeira.position = CGPoint(x: -200, y: -100)
        lixeira.size = CGSize(width: 400, height: 500)
        
        return lixeira
    }
    
    
}
