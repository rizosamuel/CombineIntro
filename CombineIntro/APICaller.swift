//
//  APICaller.swift
//  CombineIntro
//
//  Created by Rijo Samuel on 02/02/22.
//

import Combine
import Foundation

final class APICaller {
	
	static let shared = APICaller()
	
	private init() {}
	
	private let array = ["Apple", "Goodle", "Microsoft", "Facebook"]
	
	func fetchData() -> Future<[String], Error> {
		
		return Future { promise in
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
				promise(.success(self.array))
			}
		}
	}
}
