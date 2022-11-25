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
    var color: UIColor
    var colorSwitch: UIColor
    var positionPoint: CGPoint
    var labelText: String
    var action: (() -> Void)?
    var rectangleSize: CGSize?
    var buttonShapeNode: SKShapeNode
    var buttonSpriteNode: SKSpriteNode
    var isSprite: Bool
    
    //MARK: CONSTRUTOR SPRITE
    /**
     * Constroi um botao utlizando textura (versao final)
     */
    init (texture: SKTexture, color: UIColor, colorSwitch: UIColor, positionPoint: CGPoint, labelText: String, action: @escaping () -> Void) {
        self.texture = texture
        self.color = color
        self.colorSwitch = colorSwitch
        self.positionPoint = positionPoint
        self.labelText = labelText
        self.action = action
        self.buttonShapeNode = SKShapeNode()
        self.buttonSpriteNode = SKSpriteNode()
        self.isSprite = true
        super.init()
    }
    
    //MARK: CONSTRUTOR SHAPE
    /**
     * Constroi um botao de testes, utilizando apenas forma de retangulo
     */
    init (color: UIColor, colorSwitch: UIColor, positionPoint: CGPoint, labelText: String, rectangleSize: CGSize, action: @escaping () -> Void) {
        self.color = color
        self.colorSwitch = colorSwitch
        self.positionPoint = positionPoint
        self.labelText = labelText
        self.rectangleSize = rectangleSize
        self.action = action
        self.buttonShapeNode = SKShapeNode()
        self.buttonSpriteNode = SKSpriteNode()
        self.isSprite = false
        super.init()
        self.isUserInteractionEnabled = true
        
        // cria node do retangulo
        self.buttonShapeNode = SKShapeNode(rectOf: rectangleSize)
        self.buttonShapeNode.position = positionPoint
        self.buttonShapeNode.fillColor = color
        self.buttonShapeNode.zPosition = 0
        self.buttonShapeNode.name = "jogar"
        
        // cria node do texto dentro do botao
        let text = SKLabelNode(text: labelText)
        text.fontColor = .black
        text.verticalAlignmentMode = .center
        text.horizontalAlignmentMode = .center
        text.zPosition = 1
        
        // adiciona os botoens no node principal da classe
        self.buttonShapeNode.addChild(text)
        self.addChild(self.buttonShapeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: TOUCH BEGAN
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // sequencia de animacao se for um botao de shape
        if !self.isSprite {
            self.clickedShape()
        }
        
        // sequencia de animacao se for um botao de sprite
        else {
            self.clickedSprite()
        }
    }
    
    //MARK: CLICK SHAPE
    func clickedShape() {
        let sequenceAnim = SKAction.sequence([
            .run {
                self.isUserInteractionEnabled = false
                self.buttonShapeNode.fillColor = self.colorSwitch
            },
            AnimationUtils.pressedAnim(0.7),
            .run(self.action!),
            .run {
                self.isUserInteractionEnabled = true
                self.buttonShapeNode.fillColor = self.color
            }
        ])
        
        self.run(sequenceAnim)
    }
    
    //MARK: CLICK SPRITE
    func clickedSprite() {
        
    }
}
