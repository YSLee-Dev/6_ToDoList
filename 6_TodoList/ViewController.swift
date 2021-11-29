//
//  ViewController.swift
//  6_TodoList
//
//  Created by 이윤수 on 2021/11/17.
//

import UIKit

class ViewController: UIViewController {

    var tableView : UITableView!
    var tasks = [Task](){
        didSet{
            dataSave()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        loadTasks()
        
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
        alert.addAction(UIAlertAction(title: "등록", style: .default){ [weak self] _ in // 클로저 캡쳐
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
    
    func dataSave(){
        let data = self.tasks.map{ // map 고차함수 : 데이터 변형 후 배열로 리턴
            [
                "title" : $0.title,
                "done" : $0.done
            ]
        }
        let ud = UserDefaults.standard
        ud.setValue(data, forKey: "tasks")
        print(data)
    }
    
    func loadTasks(){
        let ud = UserDefaults.standard
        guard let data = ud.value(forKey: "tasks") as? [[String:Any]] else {return}
        self.tasks = data.compactMap{ // compactMap : 데이터 변형 + nil 제거 + 옵셔널바인딩 + 1차원 배열로 변경
            guard let title = $0["title"] as? String else {return nil}
            guard let done = $0["done"] as? Bool else {return nil}
            
            return Task(title: title, done: done)
        }
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.tasks[indexPath.row].title
        return cell
    }
}
