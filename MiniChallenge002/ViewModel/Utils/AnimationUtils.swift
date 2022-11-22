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
    public static func bounceAnim(node: SKNode ,bounceForce: CGFloat, bounceDuration: TimeInterval) -> SKAction {
        let nodeYPos: CGFloat = node.position.y
        let bouncedYPos: CGFloat = nodeYPos - bounceForce
        
        let bounceDown = SKAction.moveTo(y: bouncedYPos, duration: bounceDuration)
        let bounceUp = SKAction.moveTo(y: nodeYPos + 20, duration: bounceDuration)
        let normalPos = SKAction.moveTo(y: nodeYPos, duration: 0.1)
        
        return SKAction.sequence([
            bounceDown,
            bounceUp,
            normalPos
        ])
    }
    
    //MARK: REPEAT FOREVER
    /**
     * Retorna uma animação que repete para sempre um vetor de SKTextures
     */
    public static func repeatForeverFrameAnim(texturesName: String, numberOfFrames: Int, fps: TimeInterval) -> SKAction {
        return SKAction.repeatForever(.animate(with: .init(format: "\(texturesName)%@", frameCount: 0...numberOfFrames), timePerFrame: fps))
    }
    
    //MARK: REPEAT COUNTED
    /**
     * Retorna uma animação que repete por um número determinado de vezes, um vetor de SKTextures. Esse número de repetições é determinado pelo count.
     */
    public static func repeatCountedFrameAnim(texturesName: String, numberOfFrames: Int, fps: TimeInterval, count: Int) -> SKAction {
        return SKAction.repeat(.animate(with: .init(format: "\(texturesName)%@", frameCount: 0...numberOfFrames), timePerFrame: fps), count: count)
    }
    
    //MARK: STOP ANIM
    /**
     * Para todas as animações de um Node
     */
    public static func stopAllAnims(_ node: SKNode) {
        node.removeAllActions()
    }
}
