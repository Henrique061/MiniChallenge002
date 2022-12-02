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
    var junksInScene: [Lixo] = []
    var gameStarted = false
    
    //controller
    var virtualController: GCVirtualController? = nil
    
    //player
    var playerMovement: PlayerMovement?
    var playerNode: PlayerPrefab = PlayerPrefab(trashColor: .yellow)
    
    //hud
    var botaoOk: ButtonPrefab?
    var botaoRemove: ButtonPrefab?
    var botaoAdd: ButtonPrefab?
    
    // time
    var lastTimeInterval: TimeInterval = 0
    var deltaTime: TimeInterval = 0
    
    //nodes
    var gameNode = SKNode()
    var pauseNode = SKNode()
    var hudNode = SKNode()
    
    // counter
    public var cont: Int = 0
    public var score: Int = 0
    var counter = 0
    var counterTime = Timer()
    var isGameOver = false
    
    lazy var junkCountLbl: SKLabelNode = {
      var texto = SKLabelNode(fontNamed: "Party Confetti")
       texto.fontSize = CGFloat(100)
       texto.zPosition = 10
       texto.fontColor = SKColor.black
       texto.horizontalAlignmentMode = .center
       texto.verticalAlignmentMode = .center
        
       texto.text = ("\(cont)")
        return texto
   }()
   

  lazy var timeLeftCount: SKLabelNode = {
       var label = SKLabelNode(fontNamed: "Party Confetti")
       label.fontSize = CGFloat(100)
       label.zPosition = 10
       label.fontColor = SKColor.black
       label.horizontalAlignmentMode = .left
       label.verticalAlignmentMode = .center
       return label
   }()
   
    
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
        self.generateJunks()
        
        print("""
                correct junk qnt: \(levelManager.CorrectJunkQuantity)
                correct junk type: \(levelManager.CorrectJunkType)
                game level: \(levelManager.GameLevel)
                junk qnt: \(levelManager.JunkQuantity)
                junk variety: \(levelManager.getActualLevelModel().junkVariety.rawValue)
                num of variety: \(levelManager.getActualLevelModel().numOfVariety)
                """)
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
        self.scene?.scaleMode = .fill
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
        self.playerNode.zPosition = 4
        self.playerMovement = PlayerMovement(player: playerNode)
        
        // text nodes
        self.junkCountLbl.position = CGPoint(x: self.frame.width * 0.3983, y: -245)
        
        self.timeLeftCount.position = CGPoint(x: self.frame.width * -0.45, y: 425)
        self.timeLeftCount.text = "\(self.levelManager.TimeLeft)"
        
        // counter nodes
        self.botaoRemove = ButtonPrefab(positionPoint: CGPoint(x: self.frame.width * 0.41, y: -400), spriteSize: CGSize(width: 150, height: 170), labelText: "", fontSize: 0, textureName: "triangulo 2", buttonType: .withoutAnim, action: {
            self.removeScore()
            self.junkCountLbl.text = ("\(self.cont)")
        })
  
        self.botaoAdd = ButtonPrefab(positionPoint: CGPoint(x: self.frame.width * 0.41, y: -100), spriteSize: CGSize(width: 150, height: 170), labelText: "", fontSize: 0, textureName: "triangulo 1", buttonType: .withoutAnim, action: {
            self.addScore()
            self.junkCountLbl.text=("\(self.cont)")
        })
        
        self.botaoOk = ButtonPrefab(positionPoint: CGPoint(x: self.frame.width * 0.3, y: -300) , spriteSize: CGSize(width: 285, height: 300), labelText: "", fontSize: 0, textureName: "ok", buttonType: .withoutAnim, action: {
            
        })
        botaoOk!.zPosition = 10
        botaoRemove!.zPosition = 10
        botaoAdd!.zPosition = 10
        
        // game nodes
        self.gameNode.addChild(self.playerNode)
        self.gameNode.addChild(treadmillNode)
        self.gameNode.addChild(background)
        self.gameNode.addChild(self.hudNode)
        
        // hud node
        self.hudNode.addChild(self.junkCountLbl)
        self.hudNode.addChild(self.timeLeftCount)
        self.hudNode.addChild(self.botaoOk!)
        self.hudNode.addChild(self.botaoAdd!)
        self.hudNode.addChild(self.botaoRemove!)

        //pause nodes
        
        // scene nodes
        self.addChild(self.gameNode)
        self.addChild(self.pauseNode)
    }
    
    private func generateJunks() {
        self.junksInScene = self.levelManager.generateJunksLevel()
        
        for junk in self.junksInScene {
            self.gameNode.addChild(junk)
        }
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
        self.moveJunks()
        
        if gameStarted { self.countdownTime() }
    }
    
    //MARK: TIME
    private func countdownTime() {
        self.levelManager.timeCountdown(self.deltaTime)
    }
    
    private func configTime() {
        self.counter = Int(self.levelManager.TimeLeft)
        self.startCounter()
    }
    
    private func startCounter() {
        self.counterTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc func decrementCounter(){
        if !isGameOver {
            counter -= 1
            timeLeftCount.text = "\(counter)"
            let minutos = counter/60
            let segundos = counter % 60
            let minutoTexto = minutos < 10 ? "0\(minutos)" : "\(minutos)"
            let segundosTexto = segundos < 10 ? "0\(segundos)" : "\(segundos)"
            
            timeLeftCount.text = "\(minutoTexto):\(segundosTexto)"
        }
        
        if counter <= 0{
            isGameOver = true
        }
    }
    
    //MARK: COUNTER
    private func removeScore() {
        if self.cont > 0 {
            self.cont -= 1
        }
    }
    
    private func addScore() {
        self.cont += 1
    }
    
    //MARK: CAMERA
    private func moveCamera() {
        guard let lastCamPos = self.camera?.position.x else { return }
        
        let cameraBounds = self.frame.width / 2
        let bounds = self.calculateAccumulatedFrame().width/2 - cameraBounds
        
        let positionPlayer = self.playerNode.playerNode.position.x
        
        if positionPlayer < bounds && positionPlayer > -(bounds) {
            self.camera?.position.x = positionPlayer
        }
        
        guard let actualCamPos = self.camera?.position.x else { return }
        
        if lastCamPos != actualCamPos {
            self.hudNode.position.x += self.playerMovement?.actualSpeed ?? 12
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
    
    //MARK: MOVE JUNKS
    func moveJunks() {
        for junk in self.junksInScene {
            // rola pra esquerda
            if junk.moveDirection == .left {
                junk.lixoNode.position.x -= junk.rollVelocity
            }
            
            // rola pra direita
            else {
                junk.lixoNode.position.x += junk.rollVelocity
            }
            
            // da esquerda pra direita
            if junk.lixoNode.position.x <= -1700 {
                junk.moveDirection = .right
            }
            
            // da direita para esquerda
            else if junk.lixoNode.position.x >= 1700 {
                junk.moveDirection = .left
            }
        }
    }
}
