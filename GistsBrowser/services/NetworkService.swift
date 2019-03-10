//
//  NetworkService.swift
//  GistsBrowser
//
//  Created by Тимур Насыров on 03/03/2019.
//  Copyright © 2019 Timur Nasyrov. All rights reserved.
//

import Foundation

class NetworkService: NSObject {
	
	static let shared = NetworkService()
	
	private var networkCache = NSCache<NSURL, NSData>()
	private var requestedUrls = Set<NSURL>()
	
	private override init() {
		super.init()
		networkCache.delegate = self
	}
	
	func getLocalDataBy(url: URL) -> Data? {
		let nsUrl = url as NSURL
		return networkCache.object(forKey: nsUrl) as Data?
	}
	
	func getDataFrom(url: URL, forcedReload: Bool = false) -> Data? {
		if !forcedReload, let cachedData = getLocalDataBy(url: url) {
			return cachedData
		}
		
		let nsUrl = url as NSURL
		guard requestedUrls.insert(nsUrl).inserted else { return nil }
		guard let nsData = NSData(contentsOf: url) else { return nil }
		
		networkCache.setObject(nsData, forKey: nsUrl)
		return nsData as Data
	}
}

extension NetworkService: NSCacheDelegate {
	
	func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
		guard let object = obj as? NSURL, cache == networkCache else { return }
		for requestedUrl in requestedUrls {
			if networkCache.object(forKey: requestedUrl) == object {
				requestedUrls.remove(requestedUrl)
				return
			}
		}
	}
	
}
