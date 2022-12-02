//
//  ButtonPrefab.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 21/11/22.
//

import Foundation
import SpriteKit

public enum ButtonType {
    case sprite
    case test
    case withoutAnim
}

class ButtonPrefab : SKNode {
    var color: UIColor?
    var colorSwitch: UIColor?
    var positionPoint: CGPoint
    var labelText: String
    var action: (() -> Void)?
    var rectangleSize: CGSize?
    var buttonShapeNode: SKShapeNode
    var buttonSpriteNode: SKSpriteNode
    var textureName: String
    var buttonType: ButtonType
    
    //MARK: CONSTRUTOR SPRITE
    /**
     * Constroi um botao utlizando textura (versao final)
     */
    init (positionPoint: CGPoint, spriteSize: CGSize, labelText: String, fontSize: CGFloat, textureName: String, buttonType: ButtonType, action: @escaping () -> Void) {
        self.positionPoint = positionPoint
        self.labelText = labelText
        self.action = action
        self.buttonShapeNode = SKShapeNode()
        self.buttonSpriteNode = SKSpriteNode()
        self.textureName = textureName
        self.buttonType = buttonType
        super.init()
        self.isUserInteractionEnabled = true
        
        // cria sprite
        self.buttonSpriteNode = SKSpriteNode(imageNamed: textureName)
        self.buttonSpriteNode.position = positionPoint
        self.buttonSpriteNode.size = spriteSize
        self.buttonSpriteNode.anchorPoint.x = 0.65
        self.buttonSpriteNode.zPosition = 0
        
        // cria texto
        let text = SKLabelNode(text: labelText)
        text.fontName = "Party Confetti"
        text.fontSize = fontSize
        text.fontColor = .white
        text.verticalAlignmentMode = .center
        text.horizontalAlignmentMode = .center
        text.zPosition = 1
        
        // adiciona nodes
        self.buttonSpriteNode.addChild(text)
        self.addChild(self.buttonSpriteNode)
    }
    
    //MARK: CONSTRUTOR SHAPE
    /**
     * Constroi um botao de testes, utilizando apenas forma de retangulo
     */
    init(positionPoint: CGPoint, spriteWidth: CGFloat, labeltext: String, action: @escaping() -> Void) {
        self.positionPoint = positionPoint
        self.labelText = labeltext
        self.action = action
        self.buttonShapeNode = SKShapeNode()
        self.buttonSpriteNode = SKSpriteNode()
        self.buttonType = .test
        self.textureName = ""
        super.init()
        self.isUserInteractionEnabled = true
        
        self.buttonSpriteNode = SKSpriteNode(imageNamed: "triangulo")
        self.buttonSpriteNode.position = positionPoint
        self.buttonSpriteNode.size = CGSize(width: spriteWidth, height: spriteWidth / 2)
        self.buttonSpriteNode.anchorPoint.x = 0.65
        self.buttonSpriteNode.zPosition = 0
        
        self.addChild(self.buttonSpriteNode)
        
    }
    
    
    init (color: UIColor, colorSwitch: UIColor, positionPoint: CGPoint, labelText: String, rectangleSize: CGSize, action: @escaping () -> Void) {
        self.color = color
        self.colorSwitch = colorSwitch
        self.positionPoint = positionPoint
        self.labelText = labelText
        self.rectangleSize = rectangleSize
        self.action = action
        self.buttonShapeNode = SKShapeNode()
        self.buttonSpriteNode = SKSpriteNode()
        self.buttonType = .test
        self.textureName = ""
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
        
        // adiciona os botoes no node principal da classe
        self.buttonShapeNode.addChild(text)
        self.addChild(self.buttonShapeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: TOUCH BEGAN
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // sequencia de animacao se for um botao de shape
        if self.buttonType == .test {
            self.clickedShape()
        }
        
        // sequencia de animacao se for um botao de sprite
        else if self.buttonType == .sprite {
            self.clickedSprite()
        }
        
        else {
            self.clickedWithoutAnim()
        }
    }
    
    //MARK: CLICK SHAPE
    func clickedShape() {
        let sequenceAnim = SKAction.sequence([
            .run {
                self.isUserInteractionEnabled = false
                self.buttonShapeNode.fillColor = self.colorSwitch ?? UIColor.black
            },
            AnimationUtils.pressedAnim(0.7),
            .run(self.action!),
            .run {
                self.isUserInteractionEnabled = true
                self.buttonShapeNode.fillColor = self.color ?? UIColor.yellow
            }
        ])
        
        self.run(sequenceAnim)
    }
    
    //MARK: CLICK SPRITE
    func clickedSprite() {
        let sequenceAnim = SKAction.sequence([
            .run {
                self.isUserInteractionEnabled = false
            },
            AnimationUtils.pressedAnim(0.7),
            .run(self.action!),
            .run {
                self.isUserInteractionEnabled = true
            }
        ])
        
        self.buttonSpriteNode.run(sequenceAnim)
    }
    
    //MARK: CLICK WITHOUT ANIM
    func clickedWithoutAnim() {
        let actionAnim = SKAction.run(self.action!)
        
        self.run(actionAnim)
    }
}
