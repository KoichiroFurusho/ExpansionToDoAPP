//
//  Task.swift
//  GsTodo
//
//  Created by NaokiKameyama on 2020/05/6.
//  Copyright © 2020 NaokiKameyama. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// Task のクラス。
// プロパティに title と memo を持っている
class Task: Codable {
    //Task単位で一つのDocumentになるため、IDを持たせる
    var taskId: String
    var title: String
    var memo: String?
    
    var createdAt:Timestamp
    var updatedAt:Timestamp
    
    // init とは、Task を作るときに呼ばれるメソッド。(イニシャライザという)
    // 使い方： let task = Task(title: "プログラミング")
    init(taskId:String, title: String, memo: String = "", createdAt:Timestamp, updatedAt:Timestamp) {
        self.taskId = taskId
        self.title = title
        self.memo = memo
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
