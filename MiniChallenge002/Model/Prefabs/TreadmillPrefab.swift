//
//  TreadmillPrefab.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 24/11/22.
//

import Foundation
import SpriteKit

class TreadmillPrefab : SKNode {
    var treadmillNode: SKSpriteNode
    var id: Int
    var texture: SKTexture
    var rollVelocity: Float
    var animationTexturesName: String
    var junksAttached: Int
    
    //MARK: INIT
    init(id: Int, texture: SKTexture, rollVelocity: Float, animationTexturesName: String) {
        self.treadmillNode = SKSpriteNode()
        self.id = id
        self.texture = texture
        self.rollVelocity = rollVelocity
        self.animationTexturesName = animationTexturesName
        self.junksAttached = 0
        super.init()
        
        //cria posicao
        var positionPoint = CGPoint.zero
        
        switch id {
        case 0:
            positionPoint = CGPoint(x: 0, y: 10)
            break
        case 1:
            positionPoint = CGPoint(x: 0, y: 20)
            break
        default:
            positionPoint = CGPoint(x: 0, y: 30)
            break
        }
        
        // cria node
        self.treadmillNode = SKSpriteNode(texture: texture)
        self.treadmillNode.position = positionPoint
        self.addChild(treadmillNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: GETTERS SETTERS
    public func setRollVelocity(_ value: Float) {
        self.rollVelocity = value
    }
    
    public func getJunksAttached() -> Int {
        return self.junksAttached
    }
    
    public func setJunksAttached(_ value: Int) {
        self.junksAttached = value
    }
    
    //MARK: METHODS
    public func startRollAnimation() {
        self.treadmillNode.run(AnimationUtils.repeatForeverFrameAnim(texturesName: self.animationTexturesName, numberOfFrames: 4, fps: 0.3))
    }
}
