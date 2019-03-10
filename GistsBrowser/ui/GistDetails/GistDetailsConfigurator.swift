//
//  GistDetailsConfigurator.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 04/03/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import Foundation

protocol GistDetailsConfigurator {
	func configure(with viewController: GistDetailsViewControllerImpl, gist: Gist)
}

class GistDetailsConfiguratorImpl: GistDetailsConfigurator {
	
	func configure(with viewController: GistDetailsViewControllerImpl, gist: Gist) {
		let presenter = GistDetailsPresenterImpl(view: viewController, gist: gist)
		let interactor = GistDetailsInteractorImpl(presenter: presenter)
		
		viewController.presenter = presenter
		presenter.interactor = interactor
	}
	
}
