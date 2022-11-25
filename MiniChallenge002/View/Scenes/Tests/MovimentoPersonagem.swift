//
//  MovimentoPersonagem.swift
//  MiniChallenge002 iOS
//
//  Created by Luana Moraes on 22/11/22.
//

import Foundation
import SpriteKit
import GameController

class MovimentoPersonagem: SKScene {
    let player = SKSpriteNode(imageNamed: "Pink_Monster")
    let cameraNode = SKCameraNode()
    let retangulo = SKShapeNode(rectOf: CGSize(width: 200, height: 200))
    var virtualController: GCVirtualController?
    var playerPosx : CGFloat = 0.5
    
    override func didMove(to view: SKView) {
        scene?.anchorPoint = .zero
        scene?.size = CGSize(width: 100, height: 200) // tamanho da cena
        scene?.scaleMode = .aspectFill
        scene?.camera = cameraNode
        player.position = CGPoint.zero
        player.zPosition = 10
        player.setScale(0.5) // tamanho do personagem
        retangulo.fillColor = .red
        retangulo.position = player.position
        retangulo.zPosition = -1
        addChild(player)
        self.camera?.position = player.position
// add camera seguindo o jogador
        connectVirtuallController()
        self.addChild(retangulo)
    }
    
    override func update(_ currentTime: TimeInterval) { // carrega a posição do personagem em relação ao controle
        
        
        playerPosx = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!)
        
        player.position.x += playerPosx // movimenta o controle de acordo com a posição do personagem
        
        
        print(self.camera?.position ?? 0)
        
        //limitar tamanho da camera ao cenario (camera bounds)
        let cameraBounds = self.frame.width / 2
        //calcula o tamanho da cena
        let bounds = self.calculateAccumulatedFrame().width/2 - cameraBounds
        print("camerabounds: \(cameraBounds), bounds: \(bounds), player: \(player.position.x)")
        
        let positionPlayer = self.player.position
        
        if positionPlayer.x < bounds && positionPlayer.x > -(bounds) {
            print("muda camera pos")
            self.camera?.position = player.position

//            self.camera?.run(.moveTo(x: player.position.x, duration: 0.3))
        }
        
    }
    func connectVirtuallController() { // conf do controle
        
        let controllerConfic = GCVirtualController.Configuration()
        controllerConfic.elements = [GCInputLeftThumbstick]
        
        let controller = GCVirtualController(configuration: controllerConfic)
        controller.connect()
        virtualController = controller
        
        
    }
}
