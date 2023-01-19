//
//  GameViewController.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 11/11/22.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    var bgSoundPlayer: AVAudioPlayer?

    //MARK: DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        // audio (para a musica do menu continuar tocando entre diferentes cenas)
        UserDefaults.standard.set(true, forKey: "playMenuMusicAgain")
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.playBackgroundSound(_:)), name: NSNotification.Name(rawValue: "PlaySound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.stopBackgroundSound(_:)), name: NSNotification.Name(rawValue: "StopSound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.unmuteBackgroundSound(_:)), name: NSNotification.Name(rawValue: "UnmuteSound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.muteBackgroundSound(_:)), name: NSNotification.Name(rawValue: "MuteSound"), object: nil)
        
        // checking if the user has opened the app for the first time, then creates de user defaults for the volumes
        if UserDefaults.standard.object(forKey: "bgmVolume") == nil {
            UserDefaults.standard.set(1.0, forKey: "bgmVolume")
            UserDefaults.standard.set(1.0, forKey: "sfxVolume")
        }
        
        let scene = MenuScene()

        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: AUDIO
    @objc func playBackgroundSound(_ notification: Notification) {
        let name = (notification as NSNotification).userInfo!["file"] as! String
         
        if (bgSoundPlayer != nil){
             
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
        }
         
        if (name != ""){
            let fileURL:URL = Bundle.main.url(forResource:name, withExtension: "wav")!
             
            do {
                bgSoundPlayer = try AVAudioPlayer(contentsOf: fileURL)
            } catch _{
                bgSoundPlayer = nil
            }
            
            // setar volume aqui
            bgSoundPlayer!.volume = UserDefaults.standard.float(forKey: "bgmVolume")
            bgSoundPlayer!.numberOfLoops = -1
            bgSoundPlayer!.prepareToPlay()
            bgSoundPlayer!.play()
        }
    }
    
    @objc func stopBackgroundSound(_ notification: Notification) {
        let name = (notification as NSNotification).userInfo!["file"] as! String
         
        if (bgSoundPlayer != nil){
             
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
        }
         
        if (name != ""){
            let fileURL:URL = Bundle.main.url(forResource:name, withExtension: "wav")!
             
            do {
                bgSoundPlayer = try AVAudioPlayer(contentsOf: fileURL)
            } catch _{
                bgSoundPlayer = nil
            }
             
            bgSoundPlayer!.stop()
        }
    }
    
    @objc func muteBackgroundSound(_ notification: Notification) {
        if (bgSoundPlayer == nil) { print("som nao achado"); return }

        UserDefaults.standard.set(0.0, forKey: "bgmVolume")
        bgSoundPlayer!.volume = 0.0
    }
    
    @objc func unmuteBackgroundSound(_ notification: Notification) {
        if (bgSoundPlayer == nil) { print("som nao achado"); return }
         
        UserDefaults.standard.set(1.0, forKey: "bgmVolume")
        bgSoundPlayer!.volume = 1.0
    }
}
