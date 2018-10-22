//
//  TestTableView.swift
//  TableDemo
//
//  Created by UTEAMTEC on 2018/10/19.
//  Copyright © 2018年 UTEAMTEC. All rights reserved.
//

import UIKit

let TestTableViewCellId = "TestCell"
class TestTableView: UITableView {
    
    var selectedIdx = -1
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.register(TestTableViewCell.self, forCellReuseIdentifier: TestTableViewCellId)
        self.separatorStyle = .none
        self.isScrollEnabled = false
        bounces = false
        delegate = self
    }
    
}

extension TestTableView:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        var cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCellId) as? TestTableViewCell
        
        if cell != nil {
            cell?.setSelected(false, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCellId) as? TestTableViewCell
        if cell != nil {
            if indexPath.row == selectedIdx {
                //deselect
                selectedIdx = -1
                cell?.setSelected(false, animated: true)
            }
            else {
                cell?.setSelected(true, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
