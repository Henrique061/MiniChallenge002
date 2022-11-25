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
    public var levelId: Int
    public var maxTotalJunk: Int
    public var minTotalJunk: Int
    public var maxTreadmillJunk: Int
    public var junkVariety: JunkVariety
    public var numOfVariety: Int
    public var maxJunkVariety: Int
}
