//
//  FavCell.swift
//  TestMvvm
//
//  Created by Harsh on 09/05/24.
//

import UIKit

class FavCell: UITableViewCell {
    @IBOutlet weak var lblName:UILabel!
    var favModell:FavraiteData!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dataConfigure(){
        lblName.text = favModell.business_name
    }

}
