//
//  TaskListViewController.swift
//  gsToDoAppLabExpansion
//
//  Created by Kouichiro Furusho on 2021/07/17.
//

import UIKit


class TaskListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    
    var tasks:[Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        
        self.tableView.register(nib, forCellReuseIdentifier:
            "CustomCell")
        
        setUpNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppearが呼ばれたよ")
        tasks = UserDefaultsRepository.loadFromUserDefaults()
        dump(tasks)
        reloadTableView()
    }
    
    func reloadTableView(){
        tableView.reloadData()
    }
    
    private func setUpNavigationBar(){
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:
            #selector(self.showAddScreen))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func showAddScreen(){
        let vc = AddViewController()
        vc.tasks = tasks
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection
                    section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
                    IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    "CustomCell", for: indexPath)as! CustomCell
        cell.titleLabel.text = self.tasks[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskDetailViewController()
        vc.selectIndex = indexPath.row
        vc.tasks = tasks
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tasks.remove(at: indexPath.row)
        UserDefaultsRepository.saveToUserDefaults(tasks)
        reloadTableView()
    }
    
    
    
}
