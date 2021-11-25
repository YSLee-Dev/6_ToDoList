//
//  ViewController.swift
//  6_TodoList
//
//  Created by 이윤수 on 2021/11/17.
//

import UIKit

class ViewController: UIViewController {

    var tableView : UITableView!
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapEditBtn(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddBtn(sender:)))
        
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),  
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func tapEditBtn(sender:UIBarButtonItem){
        
    }

    @objc func tapAddBtn(sender:UIBarButtonItem){
        let alert = UIAlertController(title: "할 일 추가", message: nil , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "등록", style: .default){ [weak self] _ in
            guard let title = alert.textFields?[0].text else {return}
            let task = Task(title: title, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData()
        })
        alert.addTextField(){ tf in
            tf.placeholder = "할 일 입력"
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        self.present(alert, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.tasks[indexPath.row].title
        print(self.tasks[indexPath.row].title)
        return cell
    }
}
