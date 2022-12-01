//
//  LevelManager.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Assis on 30/11/22.
//

import Foundation
import SpriteKit

class LevelManager {
    //MARK: VAR
    private var gameLevel: Int
    private var timeLeft: TimeInterval
    private var junkQuantity: Int
    private var correctJunkQuantity: Int
    private var levelsModel: [LevelModel]
    private var correctJunkType: TipoLixo
    private var collectOrganic: Bool
    
    //MARK: GETTERS AND SETTERS
    public var GameLevel: Int {
        get { return self.gameLevel }
        set(value) { self.gameLevel = value }
    }
    
    public var TimeLeft: TimeInterval {
        get { return self.timeLeft }
        set(value) { self.timeLeft = value }
    }
    
    public var JunkQuantity: Int {
        get { return self.junkQuantity }
        set(value) { self.junkQuantity = value }
    }
    
    public var CorrectJunkQuantity: Int {
        get { return self.correctJunkQuantity }
        set(value) { self.correctJunkQuantity = value }
    }
    
    public var LevelsModel: [LevelModel] {
        get { return self.levelsModel }
    }
    
    public var CorrectJunkType: TipoLixo {
        get { return self.correctJunkType }
    }
    
    //MARK: INIT
    init() {
        self.gameLevel = 1
        self.timeLeft = 90
        self.junkQuantity = 0
        self.correctJunkQuantity = 0
        self.levelsModel = JsonUtils.getLevelsFromBundle()
        self.levelsModel.sort(by: { $0.levelId < $1.levelId }) // sort em ordem crescente de levelId
        self.correctJunkType = .organico
        self.collectOrganic = false
    }
    
    //MARK: METHODS
    public func addOneLevel() {
        self.gameLevel += 1
    }
    
    public func timeCountdown(_ countdown: TimeInterval) {
        self.timeLeft -= countdown
    }
    
    public func getActualLevelModel() -> LevelModel {
        let levelIndex = self.gameLevel - 1
        if self.gameLevel >= 10 {
            return levelsModel[9]
        }
        
        return levelsModel[levelIndex]
    }
    
    public func randomJunkQuantity() {
        let level = getActualLevelModel()
        self.junkQuantity = Int.random(in: level.minTotalJunk ... level.maxTotalJunk)
    }
    
    //MARK: GENERATE JUNK
    public func generateLevel() -> [Lixo] {
        // initialization
        var lixos: [Lixo] = []
        let level = self.getActualLevelModel()
        
        //setup
        if (level.junkVariety == .recycleOrganic) { self.setupRecycleOrganic() }
        else { self.setupRecycleVariety() }
    }
    
    //MARK: SETUP ORGANIC
    private func setupRecycleOrganic() {
        let level = self.getActualLevelModel()
        let chooseOrganic: Int = Int.random(in: 0...1)
        
        if chooseOrganic == 1 { self.collectOrganic = true }
        else { self.collectOrganic = false }
        
        
    }
    
    //MARK: SETUP RECYCLES
    private func setupRecycleVariety() {
        let level = self.getActualLevelModel()
        self.correctJunkType = TipoLixo.allCases[Int.random(in: 0 ..< TipoLixo.allCases.count)]
        var junkTypes: [TipoLixo] = randomJunkVariety(level)
        
        
    }
    
    private func randomJunkVariety(_ level: LevelModel) -> [TipoLixo] {
        var junkTypes: [TipoLixo] = []
        var choosedType: TipoLixo
        junkTypes.append(self.correctJunkType)
        
        repeat {
            choosedType = TipoLixo.allCases[Int.random(in: 0 ..< TipoLixo.allCases.count)]
            
            if !junkTypes.contains(choosedType) {
                junkTypes.append(choosedType)
            }
        } while junkTypes.count == level.numOfVariety
        
        return junkTypes
    }
}
