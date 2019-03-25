//
//  ViewersViewModel.swift
//  XfinityViewers
//
//  Created by Khaleeq Abdul on 3/22/19.
//  Copyright © 2019 Xfinity. All rights reserved.
//

import Foundation

class ViewersViewModel {
    
    var worker: ViewersWorker!
    var charactersInfo: ResponseModel?
    
    // MARK: - Life cycle
    init() {
        worker = ViewersWorker()
    }
    
    // MARK: - Service Call
    func getCharacters(callback: @escaping (Error?, ResponseModel?) -> Void) {
        worker.downloadCharactersData (
            callback: {(err, characters) in
                guard let charactersData = characters else {
                    callback(err, nil )
                    return
                }
                self.charactersInfo = charactersData
                callback(nil, characters)
        })
    }
    
    func numberOfRowsInSection() -> Int {
        guard let relatedTopicsCount = charactersInfo?.relatedTopics.count else {
            return 0
        }
        return relatedTopicsCount
    }
    
    func getTitleForRow(row: Int) -> String {
        let relatedTopicText = getRelatedTopicForRow(row: row)?.text
        guard let title = relatedTopicText?.splitStringWithSeparator(separator: "-").first else {
            return ""
        }
        return String(title)
    }
    
    func getRelatedTopicForRow(row: Int) -> RelatedTopic? {
        guard let relatedTopic = charactersInfo?.relatedTopics[row] else {
            return nil
        }
        return relatedTopic
    }
    
    func getImageURLForRow(row: Int) -> String? {
        return getRelatedTopicForRow(row: row)?.icon.url
    }
}
