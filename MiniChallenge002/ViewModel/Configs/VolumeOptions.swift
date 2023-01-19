//
//  VolumeOptions.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Assis on 18/01/23.
//

import Foundation
import SpriteKit

class VolumeOptions {
    //MARK: MUSICS
    /**
     * Muda de ligado e desligado (e vice-versa) o volume das músicas no UserDefaults.
     * fromMenu indica se veio da tela do menu principal, não atribua nada para essa variável se for true, agora, se
     * veio da tela de pause, marque o fromMenu como false.
     */
    public static func toggleMusicVolume(onOffLabel label: SKLabelNode, scene: SKScene, fromMenu: Bool = true) {
        let musicVolumeKey = "bgmVolume"
        var xLigado: CGFloat = 0
        var xDesligado: CGFloat = 0
        var yMusica: CGFloat = 0
        
        if fromMenu {
            xLigado = 0.435
            xDesligado = 0.416
            yMusica = 0.606
        }
        
        // se esta com volume ativo, vai para o mudo
        if UserDefaults.standard.float(forKey: musicVolumeKey) == 1.0 {
            UserDefaults.standard.set(0.0, forKey: musicVolumeKey)
            if fromMenu {
                label.position = CGPoint(x: scene.size.width * xDesligado, y: scene.size.height * yMusica)
                label.text = "Desligado"
                NotificationCenter.default.post(name: Notification.Name(rawValue: "MuteSound"), object: self, userInfo: ["file" : "MenuMusic"])
                return
            }
            
            // codigo para o pause aqui
            return
        }
        
        // se esta mudo, vai para ativo
        UserDefaults.standard.set(1.0, forKey: musicVolumeKey)
        if fromMenu {
            print("era pra desmutar")
            label.position = CGPoint(x: scene.size.width * xLigado, y: scene.size.height * yMusica)
            label.text = "Ligado"
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UnmuteSound"), object: self, userInfo: ["file" : "MenuMusic"])
            return
        }
        
        // codigo para o pause aqui
    }
    
    //MARK: SOUND EFFECTS
    /**
     * Muda de ligado e desligado (e vice-versa) o volume dos efeitos sonoros no UserDefaults.
     * fromMenu indica se veio da tela do menu principal, não atribua nada para essa variável se for true, agora, se
     * veio da tela de pause, marque o fromMenu como false.
     */
    public static func toggleSoundEffectsVolume(onOffLabel label: SKLabelNode, scene: SKScene, fromMenu: Bool = true) {
        let sfxVolumeKey = "sfxVolume"
        var xLigado: CGFloat = 0
        var xDesligado: CGFloat = 0
        var yEfeitos: CGFloat = 0
        
        if fromMenu {
            xLigado = 0.435
            xDesligado = 0.416
            yEfeitos = 0.402
        }

        // se esta com volume ativo, vai para o mudo
        if UserDefaults.standard.float(forKey: sfxVolumeKey) == 1.0 {
            UserDefaults.standard.set(0.0, forKey: sfxVolumeKey)
            if fromMenu {
                label.position = CGPoint(x: scene.size.width * xDesligado, y: scene.size.height * yEfeitos)
                label.text = "Desligado"
                return
            }
            
            // codigo para o pause aqui
            return
        }
        
        // se esta mudo, vai para ativo
        UserDefaults.standard.set(1.0, forKey: sfxVolumeKey)
        if fromMenu {
            label.position = CGPoint(x: scene.size.width * xLigado, y: scene.size.height * yEfeitos)
            label.text = "Ligado"
            return
        }
        
        // codigo para o pause aqui
    }
}
