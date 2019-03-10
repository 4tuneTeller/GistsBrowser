//
//  GistListTableViewCell.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 23/02/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import UIKit

class GistListTableViewCell: UITableViewCell {
	
	static let reuseId = "GistListTableViewCell"
	static let nibName = GistListTableViewCell.reuseId

	@IBOutlet private weak var userAvatarImageView: UIImageView!
	@IBOutlet private weak var gistTitleLabel: UILabel!
	@IBOutlet private weak var userNameLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func set(avatarImage: UIImage?, gistTitle: String, userName: String) {
		userAvatarImageView.image = avatarImage
		gistTitleLabel.text = gistTitle
		userNameLabel.text = userName
	}
    
}
