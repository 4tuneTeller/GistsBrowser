//
//  GistsListConfigurator.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 04/03/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import Foundation

protocol GistsListConfigurator {
	func configure(with viewController: GistsListViewControllerImpl)
}

class GistsListConfiguratorImpl: GistsListConfigurator {
	
	func configure(with viewController: GistsListViewControllerImpl) {
		let presenter = GistsListPresenterImpl(view: viewController)
		let interactor = GistsListInteractorImpl(presenter: presenter)
		let router = GistsListRouterImpl(viewController: viewController)
		
		viewController.presenter = presenter
		presenter.interactor = interactor
		presenter.router = router
	}
	
}
