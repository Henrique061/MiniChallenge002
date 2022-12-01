//
//  LevelModel.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Batista de Assis on 25/11/22.
//

import Foundation
import SpriteKit

public enum JunkVariety: String, Codable {
    case recycleOrganic = "Reciclados e Orgânicos"
    case recycleVariety = "Variedade de reciclados"
}

public struct LevelModel : Codable {
    public var levelId: Int // id do level
    public var maxTotalJunk: Int // capacidade maxima de lixos na cena
    public var minTotalJunk: Int // capacidade minima de lixos na cena
    public var maxTreadmillJunk: Int // capacidade maxima de lixos numa esteira
    public var junkVariety: JunkVariety // o tipo de variacao de lixo
    public var numOfVariety: Int // quantidade de variacoes de lixo na cena
}
