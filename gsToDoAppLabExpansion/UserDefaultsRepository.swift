//
//  UserDafaultsRepository.swift
//  gsToDoAppLabExpansion
//
//  Created by Kouichiro Furusho on 2021/07/17.
//

import Foundation

 class UserDefaultsRepository {
    
    static let userDefaultsTasksKey = "user_tasks"
    
    static func saveToUserDefaults(_ tasks:[Task]){
       let encoder = JSONEncoder()
        do{
       let data = try encoder.encode(tasks)
          UserDefaults.standard.setValue(data, forKey: userDefaultsTasksKey)
        } catch {
        print(error)
    }
}

    static func loadFromUserDefaults() -> [Task]{
        let decoder = JSONDecoder()
        do {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsTasksKey)else {return []}
        let tasks = try decoder.decode([Task].self, from: data)
            return tasks
        } catch {
            print(error)
            return[]
        }
    }

 }
