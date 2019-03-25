//
//  URLManager.swift
//  XfinityViewers
//
//  Created by Khaleeq Abdul on 3/22/19.
//  Copyright © 2019 Xfinity. All rights reserved.
//

import Foundation

class URLManager {
    #if DEBUG
    static let URL = "https://api.duckduckgo.com/?q=simpsons+characters&format=json"
    #else
    static let URL = "https://api.duckduckgo.com/?q=the+wire+characters&format=json"
    #endif
}
