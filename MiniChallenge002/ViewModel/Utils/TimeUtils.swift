//
//  TimeUtils.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 11/11/22.
//

import Foundation
import SpriteKit

class TimeUtils : SKScene{
    /**
     * Retorna uma SKAction, rodando um bloco de código após um determinado tempo em segundos
     */
    public static func actionAfterAsyncTime(waitTime: TimeInterval, action: @escaping () -> Void) -> SKAction {
        let wait = SKAction.wait(forDuration: waitTime)
        
        return SKAction.sequence([
            wait,
            .run(action)
        ])
    }
}
