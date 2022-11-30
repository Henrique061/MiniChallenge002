//
//  LevelScene.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Assis on 30/11/22.
//

import Foundation
import SpriteKit
import GameController

class LevelScene : SKScene {
    let sceneName = "LevelScene"
    var audioManager: AudioManager? = nil
    
    //nodes
    var gameNode = SKNode()
    var pauseNode = SKNode()
    
    //MARK: INIT
    override init() {
        super.init()
        self.setSceneParams()
        self.configNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: DID LOADS
    override func sceneDidLoad() {
        
    }
    
    //MARK: INITIALIZATION
    private func setSceneParams() {
        self.name = sceneName
        self.size = CGSize(width: 1920, height: 1080)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.audioManager = AudioManager(scene: self)
        self.gameNode.position = CGPoint.zero
        self.pauseNode.position = CGPoint.zero
    }
    
    private func configNodes() {
        let treadmillNode = TreadmillPrefab()
        
        self.gameNode.addChild(treadmillNode)
        
        self.addChild(self.gameNode)
        self.addChild(self.pauseNode)
    }
}
