//
//  CryptoViewCell.swift
//  CryptoApp
//
//  Created by Wiktor Witkowski on 04/03/2024.
//

import UIKit

class CryptoViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    
    
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public var item : Crypto! {
        didSet{
            self.nameLbl.text = item.currency
            self.priceLbl.text = item.price
        }
    }

}
