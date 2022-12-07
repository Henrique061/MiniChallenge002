//
//  PlayerMovement.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Assis on 30/11/22.
//

import Foundation
import SpriteKit
import GameplayKit

class PlayerMovement {
    var player: PlayerPrefab
    let playerStateMachine: GKStateMachine
    let walkSpeed: CGFloat = 12
    var actualSpeed: CGFloat = 0
    
    var animTexture: SKTexture
    var animTextures: [SKTexture]
    
    var isFacingRight = true
    var isWalking = false
    
    //MARK: INIT
    init(player: PlayerPrefab) {
        self.player = player
        self.animTexture = SKTexture(imageNamed: "\(player.trashAnimName)0")
        self.animTextures = [SKTexture(imageNamed: "\(player.trashAnimName)1"), SKTexture(imageNamed: "\(player.trashAnimName)2"), SKTexture(imageNamed: "\(player.trashAnimName)3")]
        
        self.playerStateMachine = GKStateMachine(states: [
            PlayerIdle(self.player, self.animTexture),
            PlayerWalk(self.player, self.animTextures)
        ])
    }
    
    //MARK: MOVE
    public func movePlayer(_ moveValue: CGFloat) {
        self.actualSpeed = moveValue * self.walkSpeed
        self.player.playerNode.position.x += moveValue * self.walkSpeed
        
        if moveValue == 0 && isWalking { self.playerStateMachine.enter(PlayerIdle.self); isWalking.toggle() }
        else if moveValue != 0 && !isWalking { self.playerStateMachine.enter(PlayerWalk.self); isWalking.toggle() }
        
        if self.needsToFlip(moveValue) { self.flipPlayer() }
    }
    
    //MARK: FLIP
    // retorna true se precisa flipar o persomagem
    private func needsToFlip(_ moveValue: CGFloat) -> Bool {
        if self.isFacingRight {
            return moveValue < 0
        }
        
        else {
            return moveValue > 0
        }
    }
    
    private func flipPlayer() {
        self.isFacingRight.toggle()
        self.player.playerNode.xScale *= -1
    }
}

//MARK: IDLE STATE
class PlayerIdle : GKState {
    var player: PlayerPrefab
    var animTexture: SKTexture
    
    init(_ player: PlayerPrefab, _ animTexture: SKTexture) {
        self.player = player
        self.animTexture = animTexture
        self.animTexture.preload {}
    }
    
    override func didEnter(from previousState: GKState?) {
        self.player.playerNode.removeAllActions()
        self.player.playerNode.run(.setTexture(self.animTexture))
    }
}

//MARK: WALK STATE
class PlayerWalk : GKState {
    var player: PlayerPrefab
    var animTextures: [SKTexture]
    
    init(_ player: PlayerPrefab, _ animTextures: [SKTexture]) {
        self.player = player
        self.animTextures = animTextures
        for texture in animTextures {
            texture.preload {}
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        self.player.playerNode.removeAllActions()
        self.player.playerNode.run(.repeatForever(.animate(with: self.animTextures, timePerFrame: 0.15)))
    }
}
