//
//  AddViewController.swift
//  GsTodo
//
//  Created by NaokiKameyama on 2020/05/6.
//  Copyright © 2020 NaokiKameyama. All rights reserved.
//

import UIKit
#warning("ここに PKHUD を import しよう！")
import PKHUD
import FirebaseFirestore

class AddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!

    // TaskListViewControllerからコピーしたtasks
    var tasks: [Task] = []
    //firestoreのインスタンスを作成
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMemoTextView()
        setupNavigationBar()
    }
    
    // MARK: - UISetup
    private func setupMemoTextView() {
        memoTextView.layer.borderWidth = 1
        memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        memoTextView.layer.cornerRadius = 3
    }
    
    private func setupNavigationBar() {
        title = "Add"
        let rightButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapSaveButton))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    //Firestoreに保存する関数
    func createTaskToFirestore(_ title:String){
        //taskに割り振るランダムな文字列を生成
        let taskId = db.collection("Tasks").document().documentID
        //taskIdを使って、Tasksのインスタンスを作成
        let task = Task(taskId: taskId, title: title, memo: memoTextView.text, createdAt: Timestamp(), updatedAt: Timestamp())
        do{
        
            let encodedTask:[String:Any] = try Firestore.Encoder().encode(task)
            db.collection("Tasks").document(taskId).setData(encodedTask)
            tasks.append(task)
            
        } catch let error as NSError {
            print("エラー\(error)")
        }
        
    }
    
    
    // MARK: - Other Method
    @objc func tapSaveButton() {
        print("Saveボタンを押したよ！")
        
        guard let title = titleTextField.text else {
            return
        }

        #warning("titleが空白のときのエラー処理")
        // titleが空白のときのエラー処理
        if title.isEmpty {
            print(title, "👿titleが空っぽだぞ〜")
            HUD.flash(.labeledError(title: nil, subtitle: "👿 タイトルが入力されていません！！！"), delay: 1)
            // showAlert("👿 タイトルが入力されていません！！！")
            return // return を実行すると、このメソッドの処理がここで終了する。
        }

        #warning("tasksにtaskを追加する処理")
        self.createTaskToFirestore(title)
            
        // tasksにAddする処理
//        let task = Task(title: title, memo: memoTextView.text)
        //let task = Task(taskId: <#T##String#>, title: title, memo: memoTextView.text, createdAt: <#T##Timestamp#>, updatedAt: <#T##Timestamp#>)
        //tasks.append(task)
//        UserDefaultsRepository.saveToUserDefaults(tasks)

        HUD.flash(.success, delay: 0.3)
        // 前の画面に戻る
        navigationController?.popViewController(animated: true)
    }

    #warning("アラートを表示するメソッド")
    // アラートを表示するメソッド
    func showAlert(_ text: String){
        let alertController = UIAlertController(title: "エラー", message: text , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}
