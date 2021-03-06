//
//  ViewController.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 22/02/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import UIKit

protocol GistsListViewController: class {
	func reloadData()
	func reloadCellsAt(indexPaths: [IndexPath])
}


class GistsListViewControllerImpl: UITableViewController, GistsListViewController {
	
	private let configurator: GistsListConfigurator = GistsListConfiguratorImpl()
	
	var presenter: GistsListPresenter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configurator.configure(with: self)
		
		self.tableView.rowHeight = 70
		self.tableView.estimatedRowHeight = 70
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		self.tableView.register(UINib(nibName: GistListTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: GistListTableViewCell.reuseId)
		self.tableView.register(UINib(nibName: HasMoreTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: HasMoreTableViewCell.reuseId)
		
		self.presenter.configView()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter.gistsCount() + 1
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard self.presenter.hasGist(at: indexPath) else {
			let cell = tableView.dequeueReusableCell(withIdentifier: HasMoreTableViewCell.reuseId)
			return cell ?? UITableViewCell()
		}
		
		guard
			let cell = tableView.dequeueReusableCell(withIdentifier: GistListTableViewCell.reuseId) as? GistListTableViewCell,
			let cellData = presenter.getCellDataBy(indexPath: indexPath)
		else {
			return UITableViewCell()
		}
		
		var avatarImage: UIImage?
		if let imageData = cellData.imageData {
			avatarImage = UIImage(data: imageData)
		}
		
		cell.set(avatarImage: avatarImage, gistTitle: cellData.title, userName: cellData.userName)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		presenter.cellSelectedAt(indexPath: indexPath)
	}
	
	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		return self.presenter.hasGist(at: indexPath)
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		self.presenter.willDisplayRow(at: indexPath)
	}
	
	func reloadData() {
		tableView.reloadData()
	}
	
	func reloadCellsAt(indexPaths: [IndexPath]) {
		UIView.performWithoutAnimation {
			tableView.reloadRows(at: indexPaths, with: .none)
		}
	}
	
}

