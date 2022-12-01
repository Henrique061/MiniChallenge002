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
    // scene
    let sceneName = "LevelScene"
    var audioManager: AudioManager? = nil
    let cameraNode = SKCameraNode()
    
    // level
    let levelManager: LevelManager = LevelManager()
    var gameStarted = false
    
    //controller
    var virtualController: GCVirtualController? = nil
    
    //player
    var playerMovement: PlayerMovement?
    var playerNode: PlayerPrefab = PlayerPrefab(trashColor: .yellow)
    
    // time
    var lastTimeInterval: TimeInterval = 0
    var deltaTime: TimeInterval = 0
    
    //nodes
    var gameNode = SKNode()
    var pauseNode = SKNode()
    
    //MARK: INIT
//    init(levelManager: LevelManager) {
//        self.levelManager = levelManager
//        super.init()
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    //MARK: DID LOADS
    override func sceneDidLoad() {
        self.setSceneParams()
        self.configNodes()
        self.connectVirtuallController()
    }
    
    //MARK: INITIALIZATION
    private func setSceneParams() {
        self.name = sceneName
        self.size = CGSize(width: 1920, height: 1080)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.camera = self.cameraNode
        self.audioManager = AudioManager(scene: self)
        self.gameNode.position = CGPoint.zero
        self.pauseNode.position = CGPoint.zero
    }
    
    private func configNodes() {
        // bg
        let background = SKSpriteNode(imageNamed: "cenário")
        background.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        background.position = CGPoint(x: 0.0, y: -self.size.height / 2)
        background.size = CGSize(width: 4000, height: self.size.height + 400)
        background.zPosition = -1
        background.physicsBody = SKPhysicsBody(edgeLoopFrom: background.frame)
        
        // treadmill
        let treadmillNode = TreadmillPrefab()
        treadmillNode.zPosition = 0
        
        // player
        self.playerNode = PlayerPrefab(trashColor: .yellow)
        self.playerNode.zPosition = 1
        self.playerMovement = PlayerMovement(player: playerNode)
        
        // game nodes
        self.gameNode.addChild(treadmillNode)
        self.gameNode.addChild(background)
        self.gameNode.addChild(self.playerNode)
        
        //pause nodes
        
        // scene nodes
        self.addChild(self.gameNode)
        self.addChild(self.pauseNode)
    }
    
    //MARK: UPDATE
    override func update(_ currentTime: TimeInterval) {
        // delta time
        self.deltaTime = currentTime - self.lastTimeInterval
        self.lastTimeInterval = currentTime
        
        // move player
        let moveX = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!)
        self.playerMovement?.movePlayer(moveX)
        
        // methods
        self.moveCamera()
        
        if gameStarted { self.countdownTime() }
    }
    
    //MARK: METHODS
    private func countdownTime() {
        self.levelManager.timeCountdown(self.deltaTime)
    }
    
    //MARK: CAMERA
    private func moveCamera() {
        let cameraBounds = self.frame.width / 2
        let bounds = self.calculateAccumulatedFrame().width/2 - cameraBounds
        
        let positionPlayer = self.playerNode.playerNode.position.x
        
        if positionPlayer < bounds && positionPlayer > -(bounds) {
            self.camera?.position.x = positionPlayer
        }
    }
    
    //MARK: VIRTUAL CONTROLLER
    func connectVirtuallController() {
        
        let controllerConfic = GCVirtualController.Configuration()
        controllerConfic.elements = [GCInputLeftThumbstick]
        
        let controller = GCVirtualController(configuration: controllerConfic)
        controller.connect()
        self.virtualController = controller
    }
}
