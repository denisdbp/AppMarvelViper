//
//  ListCharactersModel.swift
//  AppMarvelViper
//
//  Created by Admin on 12/10/22.
//

import Foundation

struct ListData:Decodable {
    let data:ListComics
}

struct ListComics:Decodable {
    let results:[ListModel]
}

struct ListModel:Decodable {
    let id:Int
    let name, description:String
    let thumbnail:Thumbnails
}

struct Thumbnails:Decodable {
    let path, extensionThumbnail:String
    
    enum CodingKeys:String, CodingKey {
        case path
        case extensionThumbnail = "extension"
    }
}
