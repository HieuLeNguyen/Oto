//
//  ProfileTableViewCell.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 28/7/24.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var imgIconUser: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgIconUser.layer.cornerRadius = imgIconUser.frame.height / 2
        imgIconUser.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
