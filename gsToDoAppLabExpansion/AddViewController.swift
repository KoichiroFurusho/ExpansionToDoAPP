//
//  AddViewController.swift
//  gsToDoAppLabExpansion
//
//  Created by Kouichiro Furusho on 2021/07/17.
//

import UIKit
import PKHUD

class AddViewController: UIViewController {

    var tasks:[Task] = []
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBOutlet weak var memoTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //画面をロードした時に呼び出し
        setupMemoTextView()
        setupNavigationBar()
        
        // Do any additional setup after loading the view.
    }

    private func setupMemoTextView(){
        memoTextView.layer.borderWidth = 1
        memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        memoTextView.layer.cornerRadius = 3
    }
    
    private func setupNavigationBar(){
        title = "Add"
        let rightButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapSaveButton))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func tapSaveButton(){
        print("saveボタン押したよ！")
        guard let title = titleTextField.text else {
            return
        }
        if title.isEmpty{
            print("titleが空だぞ")
            HUD.flash(.labeledError(title: nil, subtitle: "タイトルが入力されていません！！"), delay: 1)
            return
        }
        let task = Task(title: title, memo: memoTextView.text)
        tasks.append(task)
        UserDefaultsRepository.saveToUserDefaults(tasks)
        HUD.flash(.success, delay: 0.3)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
