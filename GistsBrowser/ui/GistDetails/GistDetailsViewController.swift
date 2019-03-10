//
//  GistDetailsViewController.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 22/02/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import UIKit

protocol GistDetailsViewController: class {
	var configurator: GistDetailsConfigurator { get }
}

class GistDetailsViewControllerImpl: UIViewController, GistDetailsViewController {
	
	static let identifier = "GistDetailsViewControllerImpl"
	
	private let _configurator = GistDetailsConfiguratorImpl()

	@IBOutlet var authorNameLabel: UILabel!
	@IBOutlet var gistDescriptionTextView: UITextView!
	@IBOutlet var gistDescriptionHeightConstraint: NSLayoutConstraint!
	
	var presenter: GistDetailsPresenter!
	
	var configurator: GistDetailsConfigurator { return _configurator }
	
	override func viewDidLoad() {
        super.viewDidLoad()

        authorNameLabel.text = presenter.getAuthorName()
		gistDescriptionTextView.text = presenter.getDescription()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		gistDescriptionHeightConstraint.constant = gistDescriptionTextView.sizeThatFits(CGSize(width: gistDescriptionTextView.frame.width, height: CGFloat.greatestFiniteMagnitude)).height
	}

}
