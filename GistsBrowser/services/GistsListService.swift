//
//  GistsListService.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 23/02/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import Foundation
import Alamofire

class GistsListService {
	
	static let shared = GistsListService()
	
	private let endpoint = "https://api.github.com/"
	
	private init() { }

	private func makeUrlFor(request: String) -> URL {
		let fixedRequest = request.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
		return URL(string: endpoint + fixedRequest)!
	}
	
	func getGists(page: Int, callback: @escaping ([Gist]?)->()) {
		let getGistsRequest = makeUrlFor(request: "gists/public")
		let parameters: Parameters = [
			"page": String(page)
		]
		Alamofire.request(getGistsRequest,
						  method: .get,
						  parameters: parameters)
		.validate()
		.responseJSON() { response in
			guard response.result.isSuccess else {
				print("Error while fetching public gists: \(String(describing: response.result.error))")
				callback(nil)
				return
			}
			
			guard
				let gistsList = response.result.value as? [[String: Any]]
			else {
				print("Malformed data received from gists service")
				callback(nil)
				return
			}
			
			let gists = gistsList.compactMap { Gist(jsonData: $0) }
			callback(gists)
			
		}
	}
	
}
