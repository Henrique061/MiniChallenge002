//
//  MenuMudancaFase.swift
//  MiniChallenge002 iOS
//
//  Created by Luana Moraes on 28/11/22.
//

import Foundation
import SpriteKit

class MenuMudancaFase: SKScene {
    let levelManager: LevelManager
    
    init(levelManager: LevelManager) {
        self.levelManager = levelManager
        super.init(size: CGSize(width: 1920, height: 1080))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: 1920, height: 1080)
        print("level info: \(self.levelManager.GameLevel)")
        backgroundColor = .white
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .resizeFill
        addChild(botaoJogar())
        
        //add contador
        var textoNode: SKLabelNode
        textoNode = SKLabelNode(fontNamed: "Party Confetti")
        textoNode.text = "\(self.levelManager.CorrectJunkQuantity)"
        textoNode.zPosition = 10
        textoNode.position = CGPoint(x: self.size.width * -0.3, y: self.size.height * -0.32)
        textoNode.fontSize = 120
        addChild(textoNode)
        // converter SKLabelNode p/ inteiro
        
        var texto = SKLabelNode(fontNamed: "Party Confetti")
        texto.fontSize = 100
        texto.text = "Muito bem, passe para a próxima fase!"
        texto.horizontalAlignmentMode = .left
        texto.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
        texto.position = CGPoint(x: self.size.width * -0.1, y: self.size.height * 0.1)
        texto.lineBreakMode = NSLineBreakMode.byWordWrapping
        texto.numberOfLines = 0
        texto.preferredMaxLayoutWidth = 900
        addChild(texto)
        
        var lataSelecionada: String = ""
        let lataCor: TrashColor = self.levelManager.getPlayerTrashColor()
        
        var lixos: [String] = JunkData.getJunkList(.papel)
        switch lataCor {
        case .yellow:
            lataSelecionada = "Lixo amarelo"
            lixos = JunkData.getJunkList(.metal)
        case .brown:
            lataSelecionada = "Lixo marrom"
            lixos = JunkData.getJunkList(.organico)
        case .green:
            lataSelecionada = "Lixo verde "
            lixos = JunkData.getJunkList(.vidro)
        case .red:
            lataSelecionada = "Lixo vermelho"
            lixos = JunkData.getJunkList(.plastico)
        default:
            lataSelecionada = "Lixo azul"
            lixos = JunkData.getJunkList(.papel)
        }
        
        for nomeLixo in lixos {
            lixo = SKSpriteNode(imageNamed: nomeLixo)
            lixo.physicsBody = SKPhysicsBody()
            lixo.physicsBody?.affectedByGravity = true
            lixo.physicsBody?.isDynamic = true
            lixo.position = CGPoint(x: self.size.width * -0.3, y: self.size.height * 0.9)
            lixo.size = CGSize(width: 100, height: 100)
            lixo.zPosition = 5
            //addChild(lixo)
            
        }
        
 
        //lixeira
        self.addChild(criarLixeira(tipo: lataSelecionada))
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
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
            lixo.physicsBody?.velocity = CGVector(dx: 0, dy: -150)
            lixo.removeFromParent() // para sumir
        }
    }
    
    // criando lixinhos
    var lixo = SKSpriteNode(imageNamed: "MacaOrganico")
    
    var latas = ["Lixoamarelo","Lixomarrom","Lixoverde","Lixovermelho","Lixoazul"]
    
   
    
    var yPos: CGFloat = 200
    
    // criando o botao de jogar
    func botaoJogar() -> SKNode  {
        self.levelManager.addOneLevel()
        let botaoJogar = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.2, y: self.size.height * -0.3), spriteSize: CGSize(width: 600, height: 200), labelText: "Jogar", fontSize:70, textureName: "spr_buttonIdle", buttonType: .sprite) {
            let transition:SKTransition = SKTransition.fade(withDuration: 1) //determinar a transição entre telas
            let scene:SKScene = LevelScene(levelManager: self.levelManager) // chamando tela principal
            self.view?.presentScene(scene, transition: transition) // chamar a transição
        }
        
        return botaoJogar
    }
    
    // criando node que será a lixeira
    func criarLixeira(tipo: String) -> SKSpriteNode {
        let lixeira = SKSpriteNode(imageNamed: tipo)
        lixeira.position = CGPoint(x: self.size.width * -0.3, y: self.size.height * -0.1)
        lixeira.size = CGSize(width: 900, height: 1000)
        
        return lixeira
    }
    
    
}
