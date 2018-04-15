//
//  SearchTableViewCell.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 11/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    override func awakeFromNib() {
        let bgView = UIView(frame:self.contentView.bounds)
        self.selectedBackgroundView = bgView
        self.artwork.kf.indicatorType = .activity
    }

}
