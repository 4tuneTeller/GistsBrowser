//
//  Gist.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 23/02/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import Foundation

private struct GistFields {
	static let id = "id"
	static let description = "description"
	static let owner = "owner"
	static let files = "files"
	
	struct Owner {
		static let login = "login"
		static let avatarUrl = "avatar_url"
	}
}

struct Gist {
	
	let description: String
	let files: [String: Any]
	let authorName: String
	let authorAvatarUrl: URL?
	
	var title: String {
		if self.description.isEmpty {
			return files.first?.key ?? ""
		} else {
			return description
		}
	}
	
	init?(jsonData: [String: Any]) {
		
		guard
			let files = jsonData[GistFields.files] as? [String: Any],
			let author = jsonData[GistFields.owner] as? [String: Any]
		else {
			return nil
		}
		
		self.files = files
		self.authorName = author[GistFields.Owner.login] as? String ?? ""
		
		if let avatarUrlString = author[GistFields.Owner.avatarUrl] as? String {
			self.authorAvatarUrl = URL(string: avatarUrlString)
		} else {
			self.authorAvatarUrl = nil
		}
		
		self.description = jsonData[GistFields.description] as? String ?? ""
		
	}
	
}
