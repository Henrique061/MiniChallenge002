//
//  ClasseGenericaLixo.swift
//  MiniChallenge002 iOS
//
//  Created by Luana Moraes on 24/11/22.
//

import Foundation
import SpriteKit

public enum JunkPosition : CGFloat, CaseIterable {
    case treadmill_0 = -180
    case treadmill_1 = -105
    case treadmill_2 = -10
}

public enum TipoLixo : String, CaseIterable {
    case papel = "Papel"
    case plastico = "Plástico"
    case vidro = "Vidro"
    case metal = "Metal"
    case organico = "Orgânico"
}

class Lixo : SKNode {
    var lixoNode = SKSpriteNode()
    var positionPoint: CGPoint
    var tipoLixo: TipoLixo
    var nomeImagem: String
    var esteiraIndex: Int
    var isOrganic: Bool
    var rollVelocity: CGFloat
    var moveDirection: Direction
    
    //MARK: CONSTRUTOR
    init(xPos: CGFloat, tipoLixo: TipoLixo, nomeImagem: String, esteiraIndex: Int) {
        self.tipoLixo = tipoLixo
        self.nomeImagem = nomeImagem
        self.esteiraIndex = esteiraIndex
        self.positionPoint = .zero // esteira 0 = -180 / esteira 1 = -105 / esteira 2 = -10
        self.rollVelocity = CGFloat.random(in: 0.5...8.0)
        
        switch esteiraIndex {
            case 0:
                self.positionPoint = CGPoint(x: xPos, y: JunkPosition.treadmill_0.rawValue)
                self.moveDirection = .left
                break
            
            case 1:
                self.positionPoint = CGPoint(x: xPos, y: JunkPosition.treadmill_1.rawValue)
                self.moveDirection = .right
                break
            
            case 2:
                self.positionPoint = CGPoint(x: xPos, y: JunkPosition.treadmill_2.rawValue)
                self.moveDirection = .left
                break
            
            default:
                self.positionPoint = CGPoint(x: xPos, y: JunkPosition.treadmill_0.rawValue);
                self.moveDirection = .left
                break
        }
        
        if tipoLixo == .organico { self.isOrganic = true }
        else { self.isOrganic = false }
        
        super.init()
        
    // criar node das imagens
        self.lixoNode = SKSpriteNode(imageNamed: nomeImagem)
        self.lixoNode.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        self.lixoNode.position = self.positionPoint
        self.lixoNode.setScale(0.9)
        
    //add node na cena
        self.addChild(lixoNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
