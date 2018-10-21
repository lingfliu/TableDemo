//
//  ViewController.swift
//  TableDemo
//
//  Created by UTEAMTEC on 2018/10/19.
//  Copyright © 2018年 UTEAMTEC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dialog: TestCustomDialog!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func show(_ sender: Any) {
        dialog = TestCustomDialog()
        dialog.showDialog(from: self, mode: CustomDialogPresenter.Mode.center)
    }
}

class TestCustomDialog:CustomDialog, TestTableViewDataSourceDelegate {
    var table:UITableView!
    var button:UIButton!
    var datasource:TestTableViewDataSource!
    
    override var dialogHeight: CGFloat {
        return 160
    }
    override var dialogWidth: CGFloat {
        return 240
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        datasource = TestTableViewDataSource()
        datasource.delegate = self
        table = TestTableView(frame: CGRect(x: 0, y: 0, width: dialogWidth, height: 120), style: .plain)
        table.dataSource = datasource
        table.reloadData()
        table.layoutIfNeeded()
        
        self.view.addSubview(table)
        
        button = UIButton(frame: CGRect(x: 0, y: dialogHeight-40, width: dialogWidth, height: 40))
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(onClose), for: .touchUpInside)
        button.backgroundColor = UIColor.green
        self.view.addSubview(button)
    }
    
    @objc func onClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onSubmit() {
        self.dismiss(animated: true, completion: nil)
    }
}
