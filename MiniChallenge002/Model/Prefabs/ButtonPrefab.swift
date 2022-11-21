//
//  ButtonPrefab.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 21/11/22.
//

import Foundation
import SpriteKit

class ButtonPrefab : SKNode {
    var texture: SKTexture?
    var color: UIColor?
    var positionPoint: CGPoint?
    var labelText: String?
    var action: (() -> Void)?
    var rectangleSize: CGSize?
    
    /**
     * Constroi um botao utlizando textura (versao final)
     */
    init (texture: SKTexture, positionPoint: CGPoint, labelText: String, action: @escaping () -> Void) {
        self.texture = texture
        self.positionPoint = positionPoint
        self.labelText = labelText
        self.action = action
        super.init()
    }
    
    /**
     * Constroi um botao de testes, utilizando apenas forma de retangulo
     */
    init (color: UIColor, positionPoint: CGPoint, labelText: String, rectangleSize: CGSize, action: @escaping () -> Void) {
        self.color = color
        self.positionPoint = positionPoint
        self.labelText = labelText
        self.rectangleSize = rectangleSize
        self.action = action
        super.init()
        self.isUserInteractionEnabled = true
        
        // cria node do retangulo
        let rectangleNode = SKShapeNode(rectOf: rectangleSize)
        rectangleNode.position = positionPoint
        rectangleNode.fillColor = color
        rectangleNode.zPosition = 0
        
        // cria node do texto dentro do botao
        let text = SKLabelNode(text: labelText)
        text.fontColor = .black
        text.zPosition = 1
        
        // adiciona os botoens no node principal da classe
        rectangleNode.addChild(text)
        self.addChild(rectangleNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let sequenceAnim = SKAction.sequence([
            .run { self.isUserInteractionEnabled = false },
            AnimationUtils.pressedAnim(0.7),
            .run(self.action!),
            .run { self.isUserInteractionEnabled = true }
        ])
        
        self.run(sequenceAnim)
    }
}
