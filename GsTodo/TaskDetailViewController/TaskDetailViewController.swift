//
//  TaskDetailViewController.swift
//  GsTodo
//
//  Created by Naoki Kameyama on 2020/06/12.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import UIKit
#warning("ここに PKHUD を import しよう！")
import PKHUD

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!

    // TaskListViewControllerからコピーしたtasksとindexPath
    var tasks: [Task] = []
    var selectIndex: Int?

    // MARK: - UISetup
    private func setupMemoTextView() {
        memoTextView.layer.borderWidth = 1
        memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        memoTextView.layer.cornerRadius = 3
    }

    private func setupNavigationBar() {
        title = "Task"
        let rightButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapSaveButton))
        navigationItem.rightBarButtonItem = rightButtonItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMemoTextView()
        setupNavigationBar()

        // 編集のときTask内容を表示させる
        configureTask()
    }

    // MARK: - Other Method
    #warning("ここにEditかどうかの判定を入れる")
    private func configureTask() {
        if let index = selectIndex {
            titleTextField.text = tasks[index].title
            memoTextView.text = tasks[index].memo
        }
    }

    @objc func tapSaveButton() {
        print("Saveボタンを押したよ！")

        guard let title = titleTextField.text, let index = selectIndex else {
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

        #warning("ここにEditかどうかの判定を入れる")
        // Edit
        tasks[index] = Task(title: title, memo: memoTextView.text)
        UserDefaultsRepository.saveToUserDefaults(tasks)

        HUD.flash(.success, delay: 0.3)
        // 前の画面に戻る
        navigationController?.popViewController(animated: true)
    }

    // アラートを表示するメソッド
    func showAlert(_ text: String){
        let alertController = UIAlertController(title: "エラー", message: text , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
