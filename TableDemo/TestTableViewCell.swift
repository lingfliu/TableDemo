//
//  TestTableViewCell.swift
//  TableDemo
//
//  Created by UTEAMTEC on 2018/10/19.
//  Copyright © 2018年 UTEAMTEC. All rights reserved.
//

import UIKit

protocol TestTableViewCellDelegate {
    func onSubmit()
}

class TestTableViewCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var delegate:TestTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let nib = UINib(nibName: "TestTableViewCell", bundle: Bundle.main)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.frame
        self.addSubview(view)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {

        if selected {
            // Configure the view for the selected state
            title.backgroundColor = UIColor.red
            title.textColor = UIColor.white
        }
        else {
            title.backgroundColor = UIColor.white
            title.textColor = UIColor.black
        }
        
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        if delegate != nil {
            delegate?.onSubmit()
        }
    }
    
}
