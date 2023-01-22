//
//  AjustesScene.swift
//  MiniChallenge002 iOS
//
//  Created by Jamile Polycarpo on 22/11/22.
//

import Foundation
import SpriteKit

class AjustesScene: SKScene {
    var onOffMusica = SKLabelNode(fontNamed: "Party Confetti")
    let onOffEfeitos = SKLabelNode(fontNamed: "Party Confetti")
    
    let xLigado: CGFloat = 0.435
    let xDesligado: CGFloat = 0.416
    let yMusica: CGFloat = 0.606
    let yEfeitos: CGFloat = 0.402
    
    class func ajustesScene() -> AjustesScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "AjustesScene") as? AjustesScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        return scene
    }
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .white
       
        //MARK: NOME
        let nome = SKLabelNode(fontNamed: "Party Confetti")
        nome.text = "Configurações"
        nome.fontColor = UIColor(red: 0.0, green: 0.51, blue: 0.22, alpha: 1)
        nome.position = CGPoint(x: self.size.width * 0.12, y: self.size.height * 0.88)
        nome.fontSize = 60
        nome.horizontalAlignmentMode = .left

        addChild(nome)
        
        //MARK: MUSICA
        let musica = SKLabelNode(fontNamed: "Party Confetti")
        musica.text = "Música"
        musica.fontColor = .black
        musica.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.6)
        musica.fontSize = 70
        musica.horizontalAlignmentMode = .left
        
        addChild(musica)
        
        let soundLine = SKShapeNode(rect: CGRect(x: self.size.width * 0.08, y: self.size.height * 0.52, width: 950, height: 4))
        soundLine.fillColor = .black
        self.addChild(soundLine)
        
        //MARK: SOM
        let som = SKLabelNode(fontNamed: "Party Confetti")
        som.text = "Efeitos Sonoros"
        som.fontColor = .black
        som.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.4)
        som.fontSize = 70
        som.horizontalAlignmentMode = .left
        addChild(som)
        
        //MARK: POLITICA
        let politica = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.4), spriteSize: CGSize(width: 380, height: 160), labelText: "", fontSize: 0,textureName: "politica",  buttonType: .withoutAnim, action:  {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = PoliticaPrivacidade(size: self.size)
            self.view?.presentScene(scene, transition: transition)
    
        })
        addChild(politica)
        
        //MARK: TERMOS
//        let termos = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.3), spriteSize: CGSize(width: 380, height: 160), labelText: "", fontSize: 0, textureName: "termo", buttonType: .withoutAnim, action:  {
//
//
//        })
        //addChild(termos)
        
        //MARK: CREDITOS
        let creditos = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.6), spriteSize: CGSize(width: 380, height: 160), labelText: "", fontSize: 0, textureName: "creditos", buttonType: .withoutAnim, action:  {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = CreditosScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
            
    
        })
        addChild(creditos)
        
        let voltar = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.09, y: self.size.height * 0.9), spriteSize: CGSize(width: 60, height: 70), labelText: "", fontSize: 0, textureName: "voltar", buttonType: .withoutAnim, action: {
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene:SKScene = MenuScene(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        })
        addChild(voltar)
        
        //MARK: LIGADO E DESLIGADO
        self.onOffMusica.fontColor = .black
        self.onOffMusica.fontSize = 55
        self.onOffMusica.horizontalAlignmentMode = .left
        addChild(self.onOffMusica)
        
        self.onOffEfeitos.fontColor = .black
        self.onOffEfeitos.fontSize = 55
        self.onOffEfeitos.horizontalAlignmentMode = .left
        
        self.checkOnOffLabel()
        addChild(self.onOffEfeitos)
       
        //MARK: SETAS DE MUTE MUSICA
        let esquerdaBgm = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.4, y: self.size.height * 0.625), spriteSize: CGSize(width: 30, height: 40), labelText: "", fontSize: 0, textureName:"ligado" , buttonType: .withoutAnim, action: {
            VolumeOptions.toggleMusicVolume(onOffLabel: self.onOffMusica, scene: self)
        })
        addChild(esquerdaBgm)
        
        let direitaBgm = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.55, y: self.size.height * 0.625), spriteSize: CGSize(width: 30, height: 40), labelText: "", fontSize: 0, textureName:"desligado" , buttonType: .withoutAnim, action: {
            VolumeOptions.toggleMusicVolume(onOffLabel: self.onOffMusica, scene: self)
        })
        addChild(direitaBgm)
        
        //MARK: SETAS DE MUTE EFEITOS
        let esquerdaSfx = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.4, y: self.size.height * 0.42), spriteSize: CGSize(width: 30, height: 40), labelText: "", fontSize: 0, textureName:"ligado" , buttonType: .withoutAnim, action: {
            VolumeOptions.toggleSoundEffectsVolume(onOffLabel: self.onOffEfeitos, scene: self)
        })
        addChild(esquerdaSfx)
        
       let direitaSfx = ButtonPrefab(positionPoint: CGPoint(x: self.size.width * 0.55, y: self.size.height * 0.42), spriteSize: CGSize(width: 30, height: 40), labelText: "", fontSize: 0, textureName:"desligado" , buttonType: .withoutAnim, action: {
           VolumeOptions.toggleSoundEffectsVolume(onOffLabel: self.onOffEfeitos, scene: self)
        })
        addChild(direitaSfx)
    }
    
    private func checkOnOffLabel() {
        // se o volume da musica esta ligado, fica na label de "ligado"
        if UserDefaults.standard.float(forKey: "bgmVolume") >= 1 {
            self.onOffMusica.text = "Ligado"
            self.onOffMusica.position = CGPoint(x: self.size.width * xLigado, y: self.size.height * yMusica)
        }
        
        else {
            self.onOffMusica.text = "Desligado"
            self.onOffMusica.position = CGPoint(x: self.size.width * xDesligado, y: self.size.height * yMusica)
        }
        
        // se o volume dos efeitos sonoros esta ligado, fica na label de "ligado"
        if UserDefaults.standard.float(forKey: "sfxVolume") >= 1 {
            self.onOffEfeitos.text = "Ligado"
            self.onOffEfeitos.position = CGPoint(x: self.size.width * xLigado, y: self.size.height * yEfeitos)
        }
        
        else {
            self.onOffEfeitos.text = "Desligado"
            self.onOffEfeitos.position = CGPoint(x: self.size.width * xDesligado, y: self.size.height * yEfeitos)
        }
    }
}
