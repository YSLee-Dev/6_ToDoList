//
//  ViewController.swift
//  6_TodoList
//
//  Created by 이윤수 on 2021/11/17.
//

import UIKit

class ViewController: UIViewController {

    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapEditBtn(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddBtn(sender:)))
        
        self.tableView = UITableView()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
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
        alert.addAction(UIAlertAction(title: "등록", style: .default){ _ in
            print(alert.textFields?[0].text)
        })
        alert.addTextField(){ tf in
            tf.placeholder = "할 일 입력"
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        self.present(alert, animated: true)
    }
    
}

