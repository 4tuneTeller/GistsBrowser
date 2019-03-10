//
//  GistDetailsPresenter.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 04/03/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import Foundation

protocol GistDetailsPresenter: class {
	func getAuthorName() -> String
	func getDescription() -> String
}

class GistDetailsPresenterImpl: GistDetailsPresenter {
	
	private let gist: Gist
	
	private weak var view: GistDetailsViewController?
	var interactor: GistDetailsInteractor!
	
	init(view: GistDetailsViewController, gist: Gist) {
		self.view = view
		self.gist = gist
	}
	
	func getAuthorName() -> String {
		return gist.authorName
	}
	
	func getDescription() -> String {
		return gist.description
	}
	
}
