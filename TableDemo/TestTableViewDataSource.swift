//
//  TestTableViewDataSource.swift
//  TableDemo
//
//  Created by UTEAMTEC on 2018/10/19.
//  Copyright © 2018年 UTEAMTEC. All rights reserved.
//

import UIKit

protocol TestTableViewDataSourceDelegate {
    func onSubmit()
}
class TestTableViewDataSource: NSObject, UITableViewDataSource {
    var delegate:TestTableViewDataSourceDelegate?
    let content = [1,2]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCellId, for: indexPath) as? TestTableViewCell
        if cell == nil {
            cell = TestTableViewCell(style: .default, reuseIdentifier: TestTableViewCellId)
        }
        
        
        cell?.title.text = "hello"
     
        cell?.delegate = self
        
        cell?.selectionStyle = .none
        cell?.selectedBackgroundView = UIView(frame: (cell?.frame)!)
        cell?.selectedBackgroundView?.backgroundColor = UIColor.red
        return cell!
    }
}

extension TestTableViewDataSource:TestTableViewCellDelegate {
    func onSubmit() {
        if delegate != nil {
            delegate?.onSubmit()
        }
    }
}
