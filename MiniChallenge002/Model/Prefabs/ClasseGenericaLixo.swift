//
//  ClasseGenericaLixo.swift
//  MiniChallenge002 iOS
//
//  Created by Luana Moraes on 24/11/22.
//

import Foundation
import SpriteKit

public enum TipoLixo : String {
    case papel = "Papel"
    case plastico = "Plástico"
    case vidro = "Vidro"
    case metal = "Metal"
    case organico = "Orgânico"
}

class Lixo : SKNode {
    var texture: SKTexture?
    var positionPoint: CGPoint
    var tipoLixo: TipoLixo
    var nomeImagem: String
    
    //MARK: CONSTRUTOR
    init(texture: SKTexture? = nil, positionPoint: CGPoint, tipoLixo: TipoLixo, nomeImagem: String) {
        self.texture = texture
        self.positionPoint = positionPoint
        self.tipoLixo = tipoLixo
        self.nomeImagem = nomeImagem
        super.init()
        
        
    // criar node das imagens
        let lixoNode = SKSpriteNode(imageNamed: nomeImagem)
        lixoNode.position = positionPoint
        
        
    //add node na cena
        self.addChild(lixoNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
