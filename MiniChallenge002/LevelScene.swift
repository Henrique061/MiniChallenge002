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
    public var junkCounter: Int = 0
    public var score: Int = 0
    var counter = 0
    var counterTime = Timer()
    var isGameOver = false
    
    lazy var junkCountLbl: SKLabelNode = {
      var texto = SKLabelNode(fontNamed: "Party Confetti")
       texto.fontSize = CGFloat(100)
       texto.zPosition = 10
       texto.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
       texto.horizontalAlignmentMode = .center
       texto.verticalAlignmentMode = .center
        
       texto.text = ("\(junkCounter)")
        return texto
   }()
   

  lazy var timeLeftCount: SKLabelNode = {
       var label = SKLabelNode(fontNamed: "Party Confetti")
       label.fontSize = CGFloat(100)
       label.zPosition = 10
       label.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
       label.horizontalAlignmentMode = .left
       label.verticalAlignmentMode = .center
       return label
   }()
    
    lazy var collectTypeLbl: SKLabelNode = {
        var label = SKLabelNode(fontNamed: "Party Confetti")
        label.fontSize = CGFloat(100)
        label.zPosition = 10
        label.position.y = 425
        label.horizontalAlignmentMode = .center
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
        self.generateJunks()
        self.setSceneParams()
        self.configNodes()
        self.connectVirtuallController()
        self.configTime()
        
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
        self.playerNode = PlayerPrefab(trashColor: self.levelManager.getPlayerTrashColor())
        self.playerNode.zPosition = 4
        self.playerMovement = PlayerMovement(player: playerNode)
        
        // text nodes
        self.junkCountLbl.position = CGPoint(x: self.frame.width * 0.3983, y: -245)
        
        self.timeLeftCount.position = CGPoint(x: self.frame.width * -0.45, y: 425)
        self.timeLeftCount.text = "\(self.levelManager.TimeLeft)"
        
        self.collectTypeLbl.text = "Conte os \(self.levelManager.getTypeCollectInfo())!"
        self.collectTypeLbl.fontColor = self.levelManager.getTypeCollectColor()
        
        // counter nodes
        self.botaoRemove = ButtonPrefab(positionPoint: CGPoint(x: self.frame.width * 0.41, y: -400), spriteSize: CGSize(width: 150, height: 170), labelText: "", fontSize: 0, textureName: "triangulo 2", buttonType: .withoutAnim, action: {
            self.removeScore()
            self.junkCountLbl.text = ("\(self.junkCounter)")
        })
  
        self.botaoAdd = ButtonPrefab(positionPoint: CGPoint(x: self.frame.width * 0.41, y: -100), spriteSize: CGSize(width: 150, height: 170), labelText: "", fontSize: 0, textureName: "triangulo 1", buttonType: .withoutAnim, action: {
            self.addScore()
            self.junkCountLbl.text=("\(self.junkCounter)")
        })
        
        self.botaoOk = ButtonPrefab(positionPoint: CGPoint(x: self.frame.width * 0.3, y: -300) , spriteSize: CGSize(width: 285, height: 300), labelText: "", fontSize: 0, textureName: "ok", buttonType: .withoutAnim, action: {
            self.pressedOk()
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
        self.hudNode.addChild(self.collectTypeLbl)

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
        let moveX = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value ?? 0))
        self.playerMovement?.movePlayer(moveX)
        
        // methods
        self.moveCamera()
        self.moveJunks()
    }
    
    //MARK: TIME
    private func configTime() {
        self.counter = self.levelManager.TimeLeft
        self.startCounter()
    }
    
    private func startCounter() {
        self.counterTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc func decrementCounter(){
        if !isGameOver {
            self.counter -= 1
            self.levelManager.TimeLeft = self.counter
            self.timeLeftCount.text = "\(counter)"
            let minutos = self.counter/60
            let segundos = self.counter % 60
            let minutoTexto = minutos < 10 ? "0\(minutos)" : "\(minutos)"
            let segundosTexto = segundos < 10 ? "0\(segundos)" : "\(segundos)"
            
            self.timeLeftCount.text = "\(minutoTexto):\(segundosTexto)"
        }
        
        if counter <= 0{
            isGameOver = true
            self.gameOver()
        }
    }
    
    //MARK: COUNTER
    private func removeScore() {
        if self.junkCounter > 0 {
            self.junkCounter -= 1
        }
    }
    
    private func addScore() {
        if self.junkCounter < self.levelManager.getActualLevelModel().maxTotalJunk {
            self.junkCounter += 1
        }
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
    
    //MARK: OK PRESSED
    private func pressedOk() {
        if junkCounter == self.levelManager.CorrectJunkQuantity {
            self.levelManager.TimeLeft += 30
            self.counterTime.invalidate()
            self.virtualController?.disconnect()
            print("Ganhou")
        }
        
        else {
            self.counter -= 10
            self.levelManager.TimeLeft -= 10
        }
    }
    
    //MARK: GAMEOVER
    private func gameOver() {
        if !isGameOver { return }
        self.counterTime.invalidate()
        self.virtualController?.disconnect()
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
                   let scene:SKScene = GameOver(size: self.size)
                   self.view?.presentScene(scene, transition: transition)
        print("perdeu")
    }
}
