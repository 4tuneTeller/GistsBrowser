//
//  GistsListRouter.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 04/03/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import UIKit

protocol GistsListRouter {
	func openDetailsOf(gist: Gist)
}

class GistsListRouterImpl: GistsListRouter {
	
	private weak var view: GistsListViewController!
	private weak var rootNavigationController: UINavigationController?
	private weak var storyboard: UIStoryboard?
	
	init (viewController: GistsListViewControllerImpl) {
		self.view = viewController
		self.rootNavigationController = viewController.navigationController
		self.storyboard = viewController.storyboard
	}
	
	func openDetailsOf(gist: Gist) {
		guard let vc = storyboard?.instantiateViewController(withIdentifier: GistDetailsViewControllerImpl.identifier) as? GistDetailsViewControllerImpl else { return }
		vc.configurator.configure(with: vc, gist: gist)
		rootNavigationController?.pushViewController(vc, animated: true)
	}
	
}
