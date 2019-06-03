//
//  GistsListInteractor.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 03/03/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import Foundation

protocol GistsListInteractor {
	func getImageDataBy(url: URL) -> Data?
	func getGists(at page: Int, callback: @escaping ([Gist]?)->())
}

class GistsListInteractorImpl: GistsListInteractor {
	
	private weak var presenter: GistsListPresenter?
	
	init(presenter: GistsListPresenter) {
		self.presenter = presenter
	}
	
	func getImageDataBy(url: URL) -> Data? {
		
		if let cachedData = NetworkService.shared.getLocalDataBy(url: url) {
			return cachedData
		}
		
		DispatchQueue.global(qos: .userInitiated).async {
			guard let data = NetworkService.shared.getDataFrom(url: url) else { return }
			
			DispatchQueue.main.async {
				self.presenter?.updateData(data, for: url)
			}
		}
		
		return nil
		
	}
	
	func getGists(at page: Int, callback: @escaping ([Gist]?)->()) {
		
		GistsListService.shared.getGists(page: page) { retrievedGists in
			callback(retrievedGists)
		}
		
	}
	
}
