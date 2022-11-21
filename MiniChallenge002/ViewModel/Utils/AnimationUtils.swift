//
//  AnimationUtils.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 11/11/22.
//

import Foundation
import SpriteKit

class AnimationUtils {
    //MARK: PRESSED ANIM
    /**
     * Retorna uma animação que simula um efeito de  botão pressioando, modificando sua escala
     */
    public static func pressedAnim(_ scaleFactor: CGFloat) -> SKAction {
        let scaleDown = SKAction.scale(to: scaleFactor, duration: 0.1)
        let scaleUp = SKAction.scale(to: 1, duration: 0.1)
        
        return SKAction.sequence([
            scaleDown,
            scaleUp
        ])
    }
    
    //MARK: BOUNCE ANIM
    /**
     * Retorna uma animação que simula um efeito de quicar (llixeira quicando quando cai um lixo por exemplo)
     */
    public static func bounceAnim() -> SKAction {
        return SKAction()
    }
    
    //MARK: REPEAT FOREVER
    /**
     * Retorna uma animação que repete para sempre um vetor de SKTextures
     */
    public static func repeatForeverFrameAnim(_ textures: [SKTexture]) -> SKAction {
        return SKAction()
    }
    
    //MARK: REPEAT COUNTED
    /**
     * Retorna uma animação que repete por um número determinado de vezes, um vetor de SKTextures
     */
    public static func repeatCountedFrameAnim(_ textures: [SKTexture], _ count: Int) -> SKAction {
        return SKAction()
    }
    
    //MARK: PRESSED ANIM
    /**
     * Para todas as animações de um Node
     */
    public static func stopAllAnims(_ node: SKNode) {
        node.removeAllActions()
    }
}
