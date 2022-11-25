//
//  ArrayUtils.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 21/11/22.
//

import Foundation
import SpriteKit

extension Array where Element == SKTexture {
    /**
     * Rodar uma sequência de texturas dentro de um vetor automaticamente. Usado para animação
     */
    init(format: String, frameCount: ClosedRange<Int>) {
        self = frameCount.map({ (index) in
            let imageName = String(format: format, "\(index)")
            return SKTexture(imageNamed: imageName)
        })
    }
}
