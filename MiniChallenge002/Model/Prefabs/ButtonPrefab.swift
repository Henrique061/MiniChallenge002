//
//  ButtonPrefab.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 21/11/22.
//

import Foundation
import SpriteKit

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
    var isSprite: Bool
    
    //MARK: CONSTRUTOR SPRITE
    /**
     * Constroi um botao utlizando textura (versao final)
     */
    init (positionPoint: CGPoint, spriteSize: CGSize, labelText: String, fontSize: CGFloat, textureName: String, action: @escaping () -> Void) {
        self.positionPoint = positionPoint
        self.labelText = labelText
        self.action = action
        self.buttonShapeNode = SKShapeNode()
        self.buttonSpriteNode = SKSpriteNode()
        self.textureName = textureName
        self.isSprite = true
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
        self.isSprite = true
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
        self.isSprite = false
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
        let clickedTexture = SKTexture(image: UIImage(named: "spr_buttonClicked")!)
        let idleTexture = SKTexture(image: UIImage(named: "spr_buttonIdle")!)
        
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
        
        self.run(sequenceAnim)
    }
}
