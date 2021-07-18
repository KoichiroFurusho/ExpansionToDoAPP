//
//  Task.swift
//  gsToDoAppLabExpansion
//
//  Created by Kouichiro Furusho on 2021/07/17.
//

import Foundation

class Task: Codable{
    var title: String
    var memo:String?

    init(title: String, memo:String = ""){
        self.title = title
        self.memo = memo
    }
}
