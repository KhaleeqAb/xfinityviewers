//
//  ViewersWorker.swift
//  XfinityViewers
//
//  Created by Khaleeq Abdul on 3/22/19.
//  Copyright © 2019 Xfinity. All rights reserved.
//

import Foundation

struct GetViewers: RequestType {
    typealias ResponseType = ResponseModel
    var data: RequestData {
        return RequestData(path: URLManager.URL)
    }
}

class ViewersWorker {
    func downloadCharactersData(callback: @escaping (Error?, ResponseModel?) -> Void) {
        GetViewers().execute(
            onSuccess: { (characters: ResponseModel) in
                callback(nil, characters)
        },
            onError: { (error: Error) in
                callback(error, nil)
        })
    }
}
