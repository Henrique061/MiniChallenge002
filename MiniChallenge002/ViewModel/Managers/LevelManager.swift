//
//  LevelManager.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Assis on 30/11/22.
//

import Foundation
import SpriteKit

public struct JunkNamesByType {
    var type: TipoLixo
    var junkList: [String]
}

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
        self.gameLevel = 20
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
    public func generateJunksLevel() -> [Lixo] {
        // initialization
        var pickedTreadmill = false
        var treadmillChoosed: Int = 0
        var treadmillsLimit: [Int] = [0, 0, 0]
        var junkXPosition: CGFloat = 0
        
        var junksList: [JunkNamesByType] = []
        var choosedJunkList: JunkNamesByType
        var choosedJunkName: String = ""
        var lixos: [Lixo] = []
        let level = self.getActualLevelModel()
        
        //setup
        if (level.junkVariety == .recycleOrganic) { junksList = self.setupRecycleOrganic() }
        else { junksList = self.setupRecycleVariety() }
        
        // randomize max junk quantity in the scene
        self.randomJunkQuantity()
        
        for _ in 0 ..< self.junkQuantity {
            repeat {
                treadmillChoosed = Int.random(in: 0 ... 2)
                if treadmillsLimit[treadmillChoosed] < level.maxTreadmillJunk {
                    treadmillsLimit[treadmillChoosed] += 1
                    pickedTreadmill = true
                }
            } while pickedTreadmill == false
            
            junkXPosition = CGFloat.random(in: -1700 ... 1700)
            choosedJunkList = junksList.randomElement() ?? JunkNamesByType(type: .organico, junkList: JunkData.getJunkList(.organico))
            choosedJunkName = choosedJunkList.junkList.randomElement() ?? "FlorOrganico"
            
            lixos.append(Lixo(xPos: junkXPosition, tipoLixo: choosedJunkList.type, nomeImagem: choosedJunkName, esteiraIndex: treadmillChoosed))
            
            switch treadmillChoosed {
            case 0: lixos.last!.zPosition = 3; break
            case 1: lixos.last!.zPosition = 2; break
            case 2: lixos.last!.zPosition = 1; break
            default: lixos.last!.zPosition = 1; break
            }
            
            // se o jogo eh separado entre organico e reciclavel
            if level.junkVariety == .recycleOrganic {
                // se deve contar os organicos
                if self.collectOrganic {
                    if lixos.last!.isOrganic { self.correctJunkQuantity += 1 }
                }
                
                // se deve contar os reciclados
                else {
                    if !lixos.last!.isOrganic { self.correctJunkQuantity += 1 }
                }
            }
            
            // se o jogo eh separado entre tipos de reciclados
            else {
                if lixos.last!.tipoLixo == self.correctJunkType { self.correctJunkQuantity += 1 }
            }
        }
        
        return lixos
    }
    
    //MARK: SETUP ORGANIC
    private func setupRecycleOrganic() -> [JunkNamesByType] {
        var junksList: [JunkNamesByType] = []
        _ = self.getActualLevelModel()
        let chooseOrganic: Int = Int.random(in: 0...1)
        
        if chooseOrganic == 1 { self.collectOrganic = true }
        else { self.collectOrganic = false }
        
        let recycleTypes: [TipoLixo] = JunkData.getRandomJunkTypeWithExclusions([.organico])
        
        if let choosedRecycle: TipoLixo = recycleTypes.randomElement() {
            junksList.append(JunkNamesByType(type: .organico, junkList: JunkData.getJunkList(.organico)))
            junksList.append(JunkNamesByType(type: choosedRecycle, junkList: JunkData.getJunkList(choosedRecycle)))
        }
        
        return junksList
    }
    
    //MARK: SETUP RECYCLES
    private func setupRecycleVariety() -> [JunkNamesByType] {
        var junksList: [JunkNamesByType] = []
        let level = self.getActualLevelModel()
        
        self.correctJunkType = TipoLixo.allCases[Int.random(in: 0 ..< TipoLixo.allCases.count)]
        let incorrectJunkTypes: [TipoLixo] = randomJunkVariety(level)
        
        junksList.append(JunkNamesByType(type: self.correctJunkType, junkList: JunkData.getJunkList(self.correctJunkType)))
        for incorrectJunkType in incorrectJunkTypes {
            junksList.append(JunkNamesByType(type: incorrectJunkType, junkList: JunkData.getJunkList(incorrectJunkType)))
        }
        
        return junksList
    }
    
    private func randomJunkVariety(_ level: LevelModel) -> [TipoLixo] {
        var junkTypes: [TipoLixo] = []
        var choosedType: TipoLixo
        junkTypes.append(self.correctJunkType)
        print(level.numOfVariety)
        
        repeat {
            choosedType = TipoLixo.allCases.randomElement() ?? .organico
            
            if !junkTypes.contains(choosedType) {
                junkTypes.append(choosedType)
            }
        } while junkTypes.count < level.numOfVariety
        print("junkCOunt: \(junkTypes.count)")
        print("junk types: \(junkTypes)")
        
        return junkTypes
    }
}
