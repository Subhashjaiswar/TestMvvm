//
//  UserrCell.swift
//  TestMvvm
//
//  Created by Harsh on 18/04/24.
//

import UIKit

class UserrCell: UITableViewCell {
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblbody:UILabel!
    @IBOutlet weak var lblId:UILabel!
    var userModl:UserInfo!
    override func awakeFromNib() {
        super.awakeFromNib()
        //Hello Subhash
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        print("selected")
    }
    
    func userConfigure(){
        
        lblId.text = "\(String(describing: userModl?.userId!))"
        lblTitle.text = "\(String(describing: userModl?.title!))"
        lblbody.text = "\(String(describing: userModl?.completed!))"
        let status = userModl?.getStatusColor()
        lblbody.text = status?.0
        backgroundColor = status?.1
        
    }
}
