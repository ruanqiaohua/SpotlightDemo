//
//  MovieListTableViewCell.swift
//  SpotlightDemo
//
//  Created by 阮巧华 on 2017/3/6.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mDetailTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
