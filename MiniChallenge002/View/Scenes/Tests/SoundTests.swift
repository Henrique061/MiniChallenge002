//
//  SoundTests.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 22/11/22.
//

import Foundation
import SpriteKit
import AVFoundation

class SoundTests : SKScene {
    var audioManager: AudioManager? = nil
    
    override func sceneDidLoad() {
        self.name = "SoundTest"
        self.size = CGSize(width: 1920, height: 1080)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        self.audioManager = AudioManager(scene: self)
//        self.audioManager?.addGameMusic(fileName: "testMusic")
//        self.audioManager?.addGameSound(fileName: "testSound")
//        self.audioManager?.addUISound(fileName: "testSound2")
//        self.audioManager?.addGameMusic(fileName: "testMusic2")
//        
//        self.audioManager?.stopAll()
//        self.audioManager?.playAudio("testMusic")
        
        let playerTeste = SKSpriteNode(imageNamed: "LixoAmarelo0")
        playerTeste.size = CGSize(width: 250, height: 250)
        playerTeste.run(AnimationUtils.repeatForeverFrameAnim(texturesName: "LixoAmarelo", numberOfFrames: 3, fps: 0.15))
        self.addChild(playerTeste)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.audioManager?.muteAll()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.audioManager?.unMuteAll()

    }
}
