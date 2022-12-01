//
//  JsonUtils.swift
//  MiniChallenge002 iOS
//
//  Created by Henrique Assis on 30/11/22.
//

import Foundation

class JsonUtils {
    private static let STANDARD_PATH = "JSON"
    
    public static func getFilesURLFromBundle(folder name: String) -> [URL] {
        let folderPath = "\(STANDARD_PATH)/\(name)"
        guard let filesURL = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: folderPath) else { return [] }
        return filesURL
    }
    
    public static func getLevelsFromBundle() -> [LevelModel] {
        let urls = getFilesURLFromBundle(folder: "Level")
        var items: [LevelModel] = []
        for url in urls {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(LevelModel.self, from: data)
                items.append(decodedData)
            } catch {
                print("Error on path: \(url)")
            }
        }
        return items
    }
}
