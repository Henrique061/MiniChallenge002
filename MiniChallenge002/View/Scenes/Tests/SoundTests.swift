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
        self.audioManager = AudioManager(scene: self)
        self.audioManager?.addGameMusic(fileName: "testMusic")
        self.audioManager?.addGameSound(fileName: "testSound")
        self.audioManager?.addUISound(fileName: "testSound2")
        self.audioManager?.addGameMusic(fileName: "testMusic2")
        
        self.audioManager?.stopAll()
        self.audioManager?.playAudio("testMusic")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.audioManager?.muteAll()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.audioManager?.unMuteAll()

    }
}
