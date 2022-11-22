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
    
    var virtualController: GCVirtualController?
    var playerPosx : CGFloat = 0.5
    
    override func didMove(to view: SKView) {
        scene?.anchorPoint = .zero
        scene?.size = CGSize(width: 100, height: 200) // "tamanho"da cena
        scene?.scaleMode = .aspectFill
    
        player.position = CGPoint(x: size.width / 2, y: size.height / 2)
        player.zPosition = 10
        player.setScale(0.5) // tamanho do personagem
        addChild(player)
        connectVirtuallController()
    }
    
    override func update(_ currentTime: TimeInterval) { // carrega a posição do personagem em relação ao controle
        playerPosx = CGFloat((virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value)!)
        
        player.position.x += playerPosx // movimenta o controle de acorfo com a posição do poersonagem
    }
    func connectVirtuallController() { // conf do controle
        
        let controllerConfic = GCVirtualController.Configuration()
        controllerConfic.elements = [GCInputLeftThumbstick]
        
        let controller = GCVirtualController(configuration: controllerConfic)
        controller.connect()
        virtualController = controller
        
        
    }
}
