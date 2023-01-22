//
//  PausePrefab.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Assis on 21/01/23.
//

import Foundation
import SpriteKit

class PausePrefab : SKNode {
    public static var gameIsPaused: Bool = false
    
    var resumirJogo: ButtonPrefab? = nil // node do botao de resumir o game na tela de pause
    var sairJogo: ButtonPrefab? = nil // node do botao de voltar pro menu principal na tela de pause
    var leftBgm: ButtonPrefab? = nil
    var rightBgm: ButtonPrefab? = nil
    var leftSfx: ButtonPrefab? = nil
    var rightSfx: ButtonPrefab? = nil
    
    var verifyAudio: () -> Void
    
    let cena: SKScene
    let resumeExitBts = SKNode()
    let btsDistance: CGFloat = 170
    
    let blackBg: SKShapeNode
    let menuBg: SKShapeNode
    let soundLine: SKShapeNode
    
    let bgmLbl: SKLabelNode
    let sfxLbl: SKLabelNode
    let onOffBgmLbl: SKLabelNode
    let onOffSfxLbl: SKLabelNode
    
    init(scene: SKScene, exitAction: @escaping () -> Void, resumeAction: @escaping () -> Void, verifyAudioAction: @escaping () -> Void) {
        self.cena = scene
        self.blackBg = SKShapeNode(rect: CGRect(x: scene.frame.minX, y: scene.frame.minY, width: scene.frame.width * 1.2, height: scene.frame.height * 1.2))
        self.menuBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 800, height: 650), cornerRadius: 100)
        self.soundLine = SKShapeNode(rectOf: CGSize(width: 620, height: 4))
        
        self.bgmLbl = SKLabelNode(text: "Música")
        self.sfxLbl = SKLabelNode(text: "Efeitos Sonoros")
        self.onOffBgmLbl = SKLabelNode(fontNamed: "Inter")
        self.onOffSfxLbl = SKLabelNode(fontNamed: "Inter")
        
        self.verifyAudio = verifyAudioAction
        
        super.init()
        
        self.leftBgm = self.createOnOffButton(spriteName: "leftBlack", onOffLabel: self.onOffBgmLbl, position: CGPoint(x: 60, y: 177))
        self.rightBgm = self.createOnOffButton(spriteName: "rightBlack", onOffLabel: self.onOffBgmLbl, position: CGPoint(x: 305, y: 177))
        self.leftSfx = self.createOnOffButton(spriteName: "leftBlack", onOffLabel: self.onOffSfxLbl, position: CGPoint(x: 60, y: 16), isMusic: false)
        self.rightSfx = self.createOnOffButton(spriteName: "rightBlack", onOffLabel: self.onOffSfxLbl, position: CGPoint(x: 305, y: 16), isMusic: false)
        
        self.resumirJogo = ButtonPrefab(positionPoint: CGPoint(x: -btsDistance, y: 0), spriteSize: CGSize(width: 600, height: 250), labelText: "Jogar", fontSize: 60, textPosition: CGPoint(x: -120, y: 15), textureName: "Botão verde garrafa", buttonType: .withoutAnim, action: resumeAction)
        
        self.sairJogo = ButtonPrefab(positionPoint: CGPoint(x: btsDistance, y: 0), spriteSize: CGSize(width: 500, height: 400), labelText: "Sair", fontSize: 60, textPosition: CGPoint(x: -90, y: 0), textureName: "Botão vermelho lata", buttonType: .withoutAnim, action: exitAction)
        
        self.addNodes()
        self.positionNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addNodes() {
        self.resumeExitBts.addChild(self.resumirJogo!)
        self.resumeExitBts.addChild(self.sairJogo!)
        self.resumeExitBts.zPosition = 10
        
        self.bgmLbl.fontColor = .black
        self.bgmLbl.fontName = "Inter"
        self.bgmLbl.horizontalAlignmentMode = .left
        self.bgmLbl.fontSize = 44
        self.bgmLbl.zPosition = 10
        
        self.onOffBgmLbl.fontColor = .black
        self.onOffBgmLbl.horizontalAlignmentMode = .center
        self.onOffBgmLbl.fontSize = 40
        self.onOffBgmLbl.zPosition = 10
        
        self.leftBgm?.zPosition = 10
        self.rightBgm?.zPosition = 10
        self.leftSfx?.zPosition = 10
        self.rightSfx?.zPosition = 10
        
        self.soundLine.fillColor = .black
        self.soundLine.zPosition = 10
        
        self.sfxLbl.fontColor = .black
        self.sfxLbl.fontName = "Inter"
        self.sfxLbl.horizontalAlignmentMode = .left
        self.sfxLbl.fontSize = 44
        self.sfxLbl.zPosition = 10
        
        self.onOffSfxLbl.fontColor = .black
        self.onOffSfxLbl.horizontalAlignmentMode = .center
        self.onOffSfxLbl.fontSize = 40
        self.onOffSfxLbl.zPosition = 10
        
        self.setOnOffLabel()
        
        self.menuBg.fillColor = .systemGray5
        self.menuBg.zPosition = 9
        
        self.blackBg.fillColor = .black
        self.blackBg.alpha = 0.7
        self.blackBg.zPosition = 8
        
        self.addChild(self.resumeExitBts)
        self.addChild(self.bgmLbl)
        self.addChild(self.onOffBgmLbl)
        self.addChild(self.leftBgm!)
        self.addChild(self.rightBgm!)
        self.addChild(self.soundLine)
        self.addChild(self.sfxLbl)
        self.addChild(self.onOffSfxLbl)
        self.addChild(self.leftSfx!)
        self.addChild(self.rightSfx!)
        self.addChild(self.menuBg)
        self.addChild(self.blackBg)
    }
    
    private func positionNodes() {
        self.resumeExitBts.position = CGPoint(x: self.cena.frame.width * 0.05, y: self.cena.frame.height * -0.17)
        
        self.menuBg.position = CGPoint(x: -400, y: -320)
        
        self.bgmLbl.position = CGPoint(x: -310, y: 160)
        self.onOffBgmLbl.position = CGPoint(x: 180, y: 160)
        //--
        self.soundLine.position = CGPoint(x: 0, y: 95)
        //--
        self.sfxLbl.position = CGPoint(x: -310, y: 0)
        self.onOffSfxLbl.position = CGPoint(x: 180, y: 0)
    }
    
    private func createOnOffButton(spriteName: String, onOffLabel: SKLabelNode, position: CGPoint, isMusic: Bool = true) -> ButtonPrefab {
        if isMusic {
            return ButtonPrefab(positionPoint: position, spriteSize: CGSize(width: 30, height: 40), labelText: "", fontSize: 0, textureName: spriteName , buttonType: .withoutAnim, action: {
                VolumeOptions.toggleMusicVolume(onOffLabel: onOffLabel, scene: self.cena, fromMenu: false)
                self.verifyAudio()
            })
        }
        
        return ButtonPrefab(positionPoint: position, spriteSize: CGSize(width: 30, height: 40), labelText: "", fontSize: 0, textureName: spriteName , buttonType: .withoutAnim, action: {
            VolumeOptions.toggleSoundEffectsVolume(onOffLabel: onOffLabel, scene: self.cena, fromMenu: false)
            self.verifyAudio()
        })
        
    }
    
    public func setOnOffLabel() {
        let bgmKey = "bgmVolume"
        let sfxKey = "sfxVolume"
        let onTxt = "Ligado"
        let offTxt = "Desligado"
        
        if UserDefaults.standard.float(forKey: bgmKey) >= 1 { self.onOffBgmLbl.text = onTxt }
        else { self.onOffBgmLbl.text = offTxt }
        
        if UserDefaults.standard.float(forKey: sfxKey) >= 1 { self.onOffSfxLbl.text = onTxt }
        else { self.onOffSfxLbl.text = offTxt }
    }
}
