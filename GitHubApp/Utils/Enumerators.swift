//
//  Enumerators.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 20/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

import Foundation

enum URLsOperationServices : CustomStringConvertible {
    case getUserInfo
    
    
    var description: String {
        switch self {
        case .getUserInfo:
            return "\(BASE_URI)/"
        }
        
    }
    
}
