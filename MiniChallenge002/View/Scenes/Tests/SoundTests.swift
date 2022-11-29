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
        
        let buttonTeste = ButtonPrefab(positionPoint: CGPoint.zero, spriteWidth: 500, labelText: "Jogar", fontSize: 100) {
            print("teste")
        }
        
        self.addChild(buttonTeste)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.audioManager?.muteAll()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.audioManager?.unMuteAll()

    }
}
