//
//  ResponseModel.swift
//  XfinityViewers
//
//  Created by Khaleeq Abdul on 3/22/19.
//  Copyright © 2019 Xfinity. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    let redirect, image, abstractSource, definitionURL: String
    let imageIsLogo: Int
    let answerType, type, entity, heading: String
    let definition, answer, abstractText, definitionSource: String
    let abstractURL: String
    let relatedTopics: [RelatedTopic]
    let imageWidth: Int
    let meta: Meta
    let abstract, infobox: String
    let imageHeight: Int
    
    enum CodingKeys: String, CodingKey {
        case redirect = "Redirect"
        case image = "Image"
        case abstractSource = "AbstractSource"
        case definitionURL = "DefinitionURL"
        case imageIsLogo = "ImageIsLogo"
        case answerType = "AnswerType"
        case type = "Type"
        case entity = "Entity"
        case heading = "Heading"
        case definition = "Definition"
        case answer = "Answer"
        case abstractText = "AbstractText"
        case definitionSource = "DefinitionSource"
        case abstractURL = "AbstractURL"
        case relatedTopics = "RelatedTopics"
        case imageWidth = "ImageWidth"
        case meta
        case abstract = "Abstract"
        case infobox = "Infobox"
        case imageHeight = "ImageHeight"
    }
}

struct Meta: Codable {
    let maintainer: Maintainer
    let srcURL, createdDate: JSONNull?
    let unsafe: Int
    let attribution: JSONNull?
    let jsCallbackName, perlModule, name, srcDomain: String
    let developer: [Developer]
    let srcName, devMilestone, productionState, repo: String
    let producer, devDate, blockgroup, liveDate: JSONNull?
    let exampleQuery, id: String
    let isStackexchange: JSONNull?
    let signalFrom: String
    let srcID: Int
    let tab: String
    let topic: [String]
    let srcOptions: SrcOptions
    let status: String
    let designer: JSONNull?
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case maintainer
        case srcURL = "src_url"
        case createdDate = "created_date"
        case unsafe, attribution
        case jsCallbackName = "js_callback_name"
        case perlModule = "perl_module"
        case name
        case srcDomain = "src_domain"
        case developer
        case srcName = "src_name"
        case devMilestone = "dev_milestone"
        case productionState = "production_state"
        case repo, producer
        case devDate = "dev_date"
        case blockgroup
        case liveDate = "live_date"
        case exampleQuery = "example_query"
        case id
        case isStackexchange = "is_stackexchange"
        case signalFrom = "signal_from"
        case srcID = "src_id"
        case tab, topic
        case srcOptions = "src_options"
        case status, designer, description
    }
}

struct Developer: Codable {
    let name: String
    let url: String
    let type: String
}

struct Maintainer: Codable {
    let github: String
}

struct SrcOptions: Codable {
    let isWikipedia: Int
    let sourceSkip, directory: String
    let skipAbstractParen, skipImageName: Int
    let srcInfo: String
    let skipIcon: Int
    let skipEnd, language, skipQr: String
    let isMediawiki, isFanon, skipAbstract: Int
    let minAbstractLength: String
    
    enum CodingKeys: String, CodingKey {
        case isWikipedia = "is_wikipedia"
        case sourceSkip = "source_skip"
        case directory
        case skipAbstractParen = "skip_abstract_paren"
        case skipImageName = "skip_image_name"
        case srcInfo = "src_info"
        case skipIcon = "skip_icon"
        case skipEnd = "skip_end"
        case language
        case skipQr = "skip_qr"
        case isMediawiki = "is_mediawiki"
        case isFanon = "is_fanon"
        case skipAbstract = "skip_abstract"
        case minAbstractLength = "min_abstract_length"
    }
}

struct RelatedTopic: Codable {
    let text: String
    let firstURL: String
    let result: String
    let icon: Icon
    
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case firstURL = "FirstURL"
        case result = "Result"
        case icon = "Icon"
    }
}

struct Icon: Codable {
    let width: String
    let url: String
    let height: String
    
    enum CodingKeys: String, CodingKey {
        case width = "Width"
        case url = "URL"
        case height = "Height"
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}
