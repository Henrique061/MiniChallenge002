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
    
    var isFacingRight = true
    var isWalking = false
    
    //MARK: INIT
    init(player: PlayerPrefab) {
        self.player = player
        self.playerStateMachine = GKStateMachine(states: [
            PlayerIdle(self.player),
            PlayerWalk(self.player)
        ])
    }
    
    //MARK: MOVE
    public func movePlayer(_ moveValue: CGFloat) {
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
    
    init(_ player: PlayerPrefab) {
        self.player = player
    }
    
    override func didEnter(from previousState: GKState?) {
        self.player.playerNode.removeAllActions()
        self.player.playerNode.run(.setTexture(.init(imageNamed: "\(player.trashAnimName)0")))
    }
}

//MARK: WALK STATE
class PlayerWalk : GKState {
    var player: PlayerPrefab
    
    init(_ player: PlayerPrefab) {
        self.player = player
    }
    
    override func didEnter(from previousState: GKState?) {
        self.player.playerNode.removeAllActions()
        self.player.playerNode.run((AnimationUtils.repeatForeverFrameAnim(texturesName: player.trashAnimName, numberOfFrames: 3, fps: 0.15)))
    }
}
