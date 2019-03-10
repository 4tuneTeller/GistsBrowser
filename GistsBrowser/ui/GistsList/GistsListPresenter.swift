//
//  GistsListPresenter.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 03/03/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import Foundation

typealias CellData = (title: String, userName: String, imageData: Data?)

protocol GistsListPresenter: class {
	func configView()
	func gistsCount() -> Int
	func cellSelectedAt(indexPath: IndexPath)
	func getCellDataBy(indexPath: IndexPath) -> CellData?
	func updateData(_ data: Data, for url: URL)
}


class GistsListPresenterImpl: GistsListPresenter {
	
	private weak var view: GistsListViewController?
	var interactor: GistsListInteractor!
	var router: GistsListRouter!
	
	private var gistsList: [Gist]?
	private var currentPage = 0
	
	init(view: GistsListViewController) {
		self.view = view
	}
	
	func configView() {
		getNextPage()
	}
	
	func cellSelectedAt(indexPath: IndexPath) {
		guard let selectedGist = gistsList?[indexPath.row] else { return }
		router.openDetailsOf(gist: selectedGist)
	}
	
	func getCellDataBy(indexPath: IndexPath) -> CellData? {
		guard let gist = gistsList?[indexPath.row] else { return nil }
		
		let avatarImageData: Data?
		if let avatarUrl = gist.authorAvatarUrl {
			avatarImageData = interactor.getImageDataBy(url: avatarUrl)
		} else {
			avatarImageData = nil
		}
		
		return (title: gist.title, userName: gist.authorName, imageData: avatarImageData)
	}
	
	func updateData(_ data: Data, for url: URL) {
		guard let gistsList = self.gistsList else { return }
		
		var indexPaths = [IndexPath]()
		for (i, gist) in gistsList.enumerated() {
			if gist.authorAvatarUrl == url {
				indexPaths.append(IndexPath(row: i, section: 0))
			}
		}
		
		view?.reloadCellsAt(indexPaths: indexPaths)
	}
	
	func gistsCount() -> Int {
		return gistsList?.count ?? 0
	}
	
	private func getNextPage() {
		GistsListService.shared.getGists(page: currentPage) { retrievedGists in
			guard let retrievedGists = retrievedGists else { return }
			
			if self.gistsList == nil {
				self.gistsList = retrievedGists
			} else {
				self.gistsList?.append(contentsOf: retrievedGists)
			}
			
			self.view?.reloadData()
			self.currentPage += 1
		}
	}
	
}