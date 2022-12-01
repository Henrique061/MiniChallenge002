//
//  JunkData.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Assis on 01/12/22.
//

import Foundation
import SpriteKit

class JunkData {
    public static func getJunkList(_ type: TipoLixo) -> [String] {
        let organics: [String] = ["FlorOrganico", "FrangoOrganico", "MacaOrganico", "OvoOrganico", "PeixeOrganico"]
        let plastics: [String] = ["CanudoPlástico", "CopoPlástico", "CorotePlástico", "GarrafaPlástico", "SacolaPlástico"]
        let metals: [String] = ["LataMetal", "LataRefriMetal", "ParafusoMetal", "SprayMetal", "TesouraMetal"]
        let glasses: [String] = ["EspelhoVidro", "GarrafaVidro", "PoteVidro", "PratoVidro", "TacaVidro"]
        let papers: [String] = ["CaixaPapel", "CartaPapel", "FolhaPapel", "JornalPapel", "NotaPapel"]
        
        switch type {
        case .organico: return organics
        case .plastico: return plastics
        case .metal: return metals
        case .vidro: return glasses
        case .papel: return papers
        }
    }
    
    public static func getRandomJunkType() -> [String] {
        let recycleTypes: [TipoLixo] = [.papel, .vidro, .metal, .plastico, .organico]
        
        if let randomType: TipoLixo = recycleTypes.randomElement() {
            return JunkData.getJunkList(randomType)
        }
        
        return JunkData.getJunkList(.plastico)
    }
    
    public static func getRandomJunkTypeExcludingOrganic() -> [String] {
        let recycleTypes: [TipoLixo] = [.papel, .vidro, .metal, .plastico]
        
        if let randomType: TipoLixo = recycleTypes.randomElement() {
            return JunkData.getJunkList(randomType)
        }
        
        return JunkData.getJunkList(.plastico)
    }
    
    public static func getRandomJunkTypeWithExclusions(_ exclusions: [TipoLixo]) -> [TipoLixo] {
        var junksType: [TipoLixo] = []
        
        for lixoCase in TipoLixo.allCases {
            if !exclusions.contains(lixoCase) {
                junksType.append(lixoCase)
            }
        }
        
        return junksType
    }
}
