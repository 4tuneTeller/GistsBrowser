//
//  GistDetailsInteractor.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 04/03/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import Foundation

protocol GistDetailsInteractor {
	
}

class GistDetailsInteractorImpl: GistDetailsInteractor {
	
	private weak var presenter: GistDetailsPresenter?
	
	init(presenter: GistDetailsPresenter) {
		self.presenter = presenter
	}
	
}
