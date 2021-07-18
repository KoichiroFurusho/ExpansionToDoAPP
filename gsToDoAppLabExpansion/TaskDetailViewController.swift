//
//  TaskDatailViewController.swift
//  gsToDoAppLabExpansion
//
//  Created by Kouichiro Furusho on 2021/07/17.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var memoTextView: UITextView!
    
    var tasks:[Task] = []
    
    var selectIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMemoTextView()
        setupNavigationBar()
        
        configureTask()
        // Do any additional setup after loading the view.
    }

    private func setupMemoTextView(){
        memoTextView.layer.borderWidth = 1
        memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        memoTextView.layer.cornerRadius = 3
    }
    
    private func setupNavigationBar(){
        title = "Task"
        let rightButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapSaveButton))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func tapSaveButton(){
        print("Saveボタン押したよ")
        guard let title = titleTextField.text, let index = selectIndex else {
            return
        }
        if title.isEmpty {
            print("タイトルが空ですよ")
            return
        }
        
        tasks[index] = Task(title: title, memo: memoTextView.text)
        UserDefaultsRepository.saveToUserDefaults(tasks)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    private func configureTask(){
        if let index = selectIndex {
            titleTextField.text = tasks[index].title
            memoTextView.text = tasks[index].memo
        }
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
