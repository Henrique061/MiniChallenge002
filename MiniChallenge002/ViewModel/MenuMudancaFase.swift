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
        
        backgroundColor = .white
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .resizeFill
        addChild(botaoJogar())
        
        
        //lixo
        lixo.physicsBody = SKPhysicsBody()
        lixo.physicsBody?.affectedByGravity = true
        lixo.physicsBody?.isDynamic = true
        lixo.position = .init(x: -225, y: 200)
        lixo.size = CGSize(width: 50, height: 50)
        lixo.zPosition = 5
        
        
        addChild(lixo)
        
        //lixeira
        
        self.addChild(criarLixeira())
        
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
    
    let lixo = SKSpriteNode(imageNamed: "MacaOrganico")
    
//    var lixos: [SKSpriteNode] = ["MacaOrganico", "OvoOrganico","PeixeOrganico"]
    
    
    
   let imagens = ["MacaOrganico", "OvoOrganico", "PeixeOrganico" ]
    

//        let lixos = [SKSpriteNode(fileNamed: "MacaOrganico"),
//                     SKSpriteNode(imageNamed: "OvoOrganico"),
//                     SKSpriteNode(imageNamed: "PeixeOrganico")]


    
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
    func criarLixeira() -> SKSpriteNode {
        let lixeira = SKSpriteNode(imageNamed: "Lixoamarelo")
        lixeira.position = CGPoint(x: -200, y: -100)
        lixeira.size = CGSize(width: 400, height: 500)
        
        return lixeira
    }
    
    
}
