//
//  AudioManager.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 22/11/22.
//

import Foundation
import SpriteKit

class AudioManager {
    var scene: SKScene
    
    var musicNode = SKNode()
    var soundNode = SKNode()
    
    var gameBGMNode = SKNode()
    var gameSFXNode = SKNode()
    var uiSFXNode = SKNode()
    
    //MARK: INIT
    init (scene: SKScene) {
        self.scene = scene
        
        self.musicNode.addChild(self.gameBGMNode) // music
        self.soundNode.addChild(self.gameSFXNode) // sound
        self.soundNode.addChild(self.uiSFXNode) // sound - pause
        
        self.scene.addChild(self.musicNode)
        self.scene.addChild(self.soundNode)
    }
    
    //MARK: ADD ////////////////////////////////////
    
    //MARK: ADD GAME MUSIC
    /**
     * Adiciona um áudio no node de músicas (BGM). fileName é o nome do arquivo de áudio apenas, sem sua extensão.
     */
    public func addGameMusic(fileName: String) {
        let audioNode = SKAudioNode(fileNamed: "\(fileName).wav")
        audioNode.name = fileName
        audioNode.autoplayLooped = true
        
        self.gameBGMNode.addChild(audioNode)
    }
    
    //MARK: ADD GAME MUSICS
    /**
     * Adiciona uma lista de áudios no node de músicas (BGM). fileNames é o nome dos arquivos de áudio apenas, sem sua extensão.
     */
    public func addGameMusics(fileNames: [String]) {
        var audioNode = SKAudioNode()
        
        for fileName in fileNames {
            audioNode = SKAudioNode(fileNamed: "\(fileName).wav")
            audioNode.name = fileName
            audioNode.autoplayLooped = true
            
            self.gameBGMNode.addChild(audioNode)
        }
    }
    
    //MARK: ADD GAME SOUND
    /**
     * Adiciona um áudio no node de sons (SFX). fileName é o nome do arquivo de áudio apenas, sem sua extensão.
     */
    public func addGameSound(fileName: String) {
        let audioNode = SKAudioNode(fileNamed: "\(fileName).wav")
        audioNode.name = fileName
        audioNode.autoplayLooped = false
        
        self.gameSFXNode.addChild(audioNode)
    }
    
    //MARK: ADD GAME SOUNDS
    /**
     * Adiciona uma lista de áudios no node de sons (SFX). fileNames é o nome dos arquivos de áudio apenas, sem sua extensão.
     */
    public func addGameSounds(fileNames: [String]) {
        var audioNode = SKAudioNode()
        
        for fileName in fileNames {
            audioNode = SKAudioNode(fileNamed: "\(fileName).wav")
            audioNode.name = fileName
            audioNode.autoplayLooped = false
            
            self.gameSFXNode.addChild(audioNode)
        }
    }
    
    //MARK: ADD UI SOUND
    /**
     * Adiciona um áudio no node de sons  de UI (SFX). fileName é o nome do arquivo de áudio apenas, sem sua extensão.
     */
    public func addUISound(fileName: String) {
        let audioNode = SKAudioNode(fileNamed: "\(fileName).wav")
        audioNode.name = fileName
        audioNode.autoplayLooped = false
        
        self.uiSFXNode.addChild(audioNode)
    }
    
    //MARK: ADD UI SOUNDS
    /**
     * Adiciona uma lista de áudios no node de sons (SFX). fileNames é o nome dos arquivos de áudio apenas, sem sua extensão.
     */
    public func addUISounds(fileNames: [String]) {
        var audioNode = SKAudioNode()
        
        for fileName in fileNames {
            audioNode = SKAudioNode(fileNamed: "\(fileName).wav")
            audioNode.name = fileName
            audioNode.autoplayLooped = false
            
            self.uiSFXNode.addChild(audioNode)
        }
    }
    
    //MARK: GETTERS ////////////////////////////
    
    //MARK: GET AUDIO
    /**
     * Pega o áudio salvo na biblioteca de áudios
     */
    public func getAudio(_ audioName: String) -> SKNode {
        if let audioNode = self.scene.childNode(withName: String("//\(audioName)")) {
            return audioNode
        }
        
        else {
            return SKAudioNode()
        }
        
    }
    
    //MARK: GET MUSIC Group
    /**
     * Pega o node pai de todas as músicas
     */
    public func getMusicGroupNode() -> SKNode {
        return self.musicNode
    }
    
    //MARK: GET MUSIC Group
    /**
     * Pega o node pai de todas os sons
     */
    public func getSoundGroupNode() -> SKNode {
        return self.soundNode
    }
    
    //MARK: GET GAME Groups
    /**
     * Pega o node pai de todos os áudios de jogo
     */
    public func getGameGroupNode() -> [SKNode] {
        return [gameBGMNode, gameSFXNode]
    }
    
    //MARK: GET UI Group
    /**
     * Pega o node pai de todas os áudios de UI
     */
    public func getUIGroupNode() -> SKNode {
        return self.uiSFXNode
    }
    
    //MARK: ACTIONS ////////////////////////////
    
    //MARK: PLAY AUDIO
    /**
     * Toca um audio específico pelo nome
     */
    public func playAudio(_ audioName: String) {
        self.getAudio(audioName).run(.play())
    }
    
    //MARK: PLAY AUDIOS
    /**
     * Toca diferentes audios simultaneamente
     */
    public func playAudios(_ audioNames: [String]) {
        for audioName in audioNames {
            self.getAudio(audioName).run(.play())
        }
    }
    
    //MARK: PAUSE AUDIO
    /**
     * Pausa um audio específico pelo nome
     */
    public func pauseAudio(_ audioName: String) {
        self.getAudio(audioName).run(.pause())
    }
    
    //MARK: PAUSE AUDIOS
    /**
     * Pausa diferentes audios simultaneamente
     */
    public func pauseAudios(_ audioNames: [String]) {
        for audioName in audioNames {
            self.getAudio(audioName).run(.pause())
        }
    }
    
    //MARK: PAUSE ALL
    /**
     * Pausa todos os audios
     */
    public func pauseAll() {
        var audioNodes: [SKNode] = gameBGMNode.children
        audioNodes.append(contentsOf: gameSFXNode.children)
        audioNodes.append(contentsOf: uiSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.pause())
        }
    }
    
    //MARK: PAUSE ALL MUSICS
    /**
     * Pausa todas as musicas (BGM)
     */
    public func pauseAllMusics() {
        let audioNodes: [SKNode] = gameBGMNode.children
        
        for audioNode in audioNodes {
            audioNode.run(.pause())
        }
    }
    
    //MARK: PAUSE ALL SOUNDS
    /**
     * Pausa todos os sons (SFX)
     */
    public func pauseAllSounds() {
        var audioNodes: [SKNode] = gameSFXNode.children
        audioNodes.append(contentsOf: uiSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.pause())
        }
    }
    
    //MARK: PAUSE ALL GAME AUDIO
    /**
     * Pausa todas os audios do node de Game
     */
    public func pauseAllGameAudios() {
        var audioNodes: [SKNode] = gameBGMNode.children
        audioNodes.append(contentsOf: gameSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.pause())
        }
    }
    
    //MARK: PAUSE ALL NON GAME AUDIO
    /**
     * Pausa todas os audios do(s) Node(s) que não são do Node Game
     */
    public func pauseAllNonGameAudios() {
        let audioNodes: [SKNode] = uiSFXNode.children
        
        for audioNode in audioNodes {
            audioNode.run(.pause())
        }
    }
    
    //MARK: STOP AUDIO
    /**
     * Pausa um audio específico pelo nome
     */
    public func stopAudio(_ audioName: String) {
        self.getAudio(audioName).run(.stop())
    }
    
    //MARK: STOP AUDIOS
    /**
     * Pausa diferentes audios simultaneamente
     */
    public func stopAudios(_ audioNames: [String]) {
        for audioName in audioNames {
            self.getAudio(audioName).run(.stop())
        }
    }
    
    //MARK: STOP ALL
    /**
     * Pausa todos os audios
     */
    public func stopAll() {
        var audioNodes: [SKNode] = gameBGMNode.children
        audioNodes.append(contentsOf: gameSFXNode.children)
        audioNodes.append(contentsOf: uiSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.stop())
        }
    }
    
    //MARK: STOP ALL MUSICS
    /**
     * Pausa todas as musicas (BGM)
     */
    public func stopAllMusics() {
        let audioNodes: [SKNode] = gameBGMNode.children
        
        for audioNode in audioNodes {
            audioNode.run(.stop())
        }
    }
    
    //MARK: STOP ALL SOUNDS
    /**
     * Pausa todos os sons (SFX)
     */
    public func stopAllSounds() {
        var audioNodes: [SKNode] = gameSFXNode.children
        audioNodes.append(contentsOf: uiSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.stop())
        }
    }
    
    //MARK: STOP ALL GAME AUDIO
    /**
     * Pausa todas os audios do node de Game
     */
    public func stopAllGameAudios() {
        var audioNodes: [SKNode] = gameBGMNode.children
        audioNodes.append(contentsOf: gameSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.stop())
        }
    }
    
    //MARK: STOP ALL NON GAME AUDIO
    /**
     * Pausa todas os audios do(s) Node(s) que não são do Node Game
     */
    public func stopAllNonGameAudios() {
        let audioNodes: [SKNode] = uiSFXNode.children
        
        for audioNode in audioNodes {
            audioNode.run(.stop())
        }
    }
    
    //MARK: MUTE AUDIO
    /**
     * Deixa mudo um audio específico pelo nome
     */
    public func muteAudio(_ audioName: String) {
        self.getAudio(audioName).run(.changeVolume(to: 0, duration: 0))
    }
    
    //MARK: MUTE AUDIOS
    /**
     * Deixa mudo diferentes audios simultaneamente
     */
    public func muteAudios(_ audioNames: [String]) {
        for audioName in audioNames {
            self.getAudio(audioName).run(.changeVolume(to: 0, duration: 0))
        }
    }
    
    //MARK: MUTE ALL
    /**
     * Deixa em mudo todos os audios da cena
     */
    public func muteAll() {
        var audioNodes: [SKNode] = gameBGMNode.children
        audioNodes.append(contentsOf: gameSFXNode.children)
        audioNodes.append(contentsOf: uiSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.changeVolume(to: 0, duration: 0))
        }
    }
    
    //MARK: MUTE ALL GAME AUDIOS
    /**
     * Deixa em mudo todos os audios do node pai do Game
     */
    public func muteAllGameAudios() {
        var audioNodes: [SKNode] = gameBGMNode.children
        audioNodes.append(contentsOf: gameSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.changeVolume(to: 0, duration: 0))
        }
    }
    
    //MARK: MUTE ALL UI AUDIOS
    /**
     * Deixa em mudo todos os audios do node pai do UI
     */
    public func muteAllUiAudios() {
        let audioNodes: [SKNode] = uiSFXNode.children
        
        for audioNode in audioNodes {
            audioNode.run(.changeVolume(to: 0, duration: 0))
        }
    }
    
    //MARK: MUTE ALL MUSICS
    /**
     * Deixa em mudo todos as musicas (BGM) da cena
     */
    public func muteAllMusics() {
        let audioNodes: [SKNode] = gameBGMNode.children
        
        for audioNode in audioNodes {
            audioNode.run(.changeVolume(to: 0, duration: 0))
        }
    }
    
    //MARK: MUTE ALL SOUNDS
    /**
     * Deixa em mudo todos os sons (SFX) da cena
     */
    public func muteAllSounds() {
        var audioNodes: [SKNode] = gameSFXNode.children
        audioNodes.append(contentsOf: uiSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.changeVolume(to: 0, duration: 0))
        }
    }
    
    //MARK: UNMUTE AUDIO
    /**
     * Tira o mudo de um audio específico pelo nome
     */
    public func unMuteAudio(_ audioName: String) {
        self.getAudio(audioName).run(.changeVolume(to: 1, duration: 0))
    }
    
    //MARK: UNMUTE AUDIOS
    /**
     * Tira o mudo de diferentes audios simultaneamente
     */
    public func unMuteAudios(_ audioNames: [String]) {
        for audioName in audioNames {
            self.getAudio(audioName).run(.changeVolume(to: 1, duration: 0))
        }
    }
    
    //MARK: UNMUTE ALL
    /**
     * Tira o mudo de todos os audios da cena
     */
    public func unMuteAll() {
        var audioNodes: [SKNode] = gameBGMNode.children
        audioNodes.append(contentsOf: gameSFXNode.children)
        audioNodes.append(contentsOf: uiSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.changeVolume(to: 1, duration: 0))
        }
    }
    
    //MARK: UNMUTE ALL GAME AUDIOS
    /**
     * Tira o mudo de todos os audios do node pai do Game
     */
    public func unMuteAllGameAudios() {
        var audioNodes: [SKNode] = gameBGMNode.children
        audioNodes.append(contentsOf: gameSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.changeVolume(to: 1, duration: 0))
        }
    }
    
    //MARK: UNMUTE ALL UI AUDIOS
    /**
     * Tira o mudo de todos os audios do node pai do UI
     */
    public func unMuteAllUiAudios() {
        let audioNodes: [SKNode] = uiSFXNode.children
        
        for audioNode in audioNodes {
            audioNode.run(.changeVolume(to: 1, duration: 0))
        }
    }
    
    //MARK: UNMUTE ALL MUSICS
    /**
     * Tira o mudo de todos as musicas (BGM) da cena
     */
    public func unMuteAllMusics() {
        let audioNodes: [SKNode] = gameBGMNode.children
        
        for audioNode in audioNodes {
            audioNode.run(.changeVolume(to: 1, duration: 0))
        }
    }
    
    //MARK: UNMUTE ALL SOUNDS
    /**
     * Tira o mudo de todos os sons (SFX) da cena
     */
    public func unMuteAllSounds() {
        var audioNodes: [SKNode] = gameSFXNode.children
        audioNodes.append(contentsOf: uiSFXNode.children)
        
        for audioNode in audioNodes {
            audioNode.run(.changeVolume(to: 1, duration: 0))
        }
    }
    
    //MARK: SET VOLUME
    /**
     * Muda o volume de um áudio específico, dentro de um determinado tempo para completar a ação
     */
    public func setVolume(audioName: String, volume: Float, fadeDuration: TimeInterval) {
        self.getAudio(audioName).run(.changeVolume(to: volume, duration: fadeDuration))
    }
}
