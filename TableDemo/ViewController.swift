//
//  ViewController.swift
//  TableDemo
//
//  Created by UTEAMTEC on 2018/10/19.
//  Copyright © 2018年 UTEAMTEC. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

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
    @IBOutlet weak var table: TestTableView!
    
    @IBOutlet weak var progressIndicator: NVActivityIndicatorView!
    
    var datasource:TestTableViewDataSource!
    
    override var dialogHeight: CGFloat {
        return 280
    }
    override var dialogWidth: CGFloat {
        return 240
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        datasource = TestTableViewDataSource()
        
        let nib = UINib(nibName: "TestCustomDiagnosDialog", bundle: Bundle.main)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        v.frame = self.view.frame
        datasource.delegate = self
        table.dataSource = datasource
        table.reloadData()
        table.layoutIfNeeded()
        self.view.addSubview(v)
        
        progressIndicator.color = UIColor.red
        progressIndicator.startAnimating()
    }

    func onSubmit() {
        self.dismiss(animated: true, completion: nil)
    }
}
