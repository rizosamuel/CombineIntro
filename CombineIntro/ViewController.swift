//
//  ViewController.swift
//  CombineIntro
//
//  Created by Rijo Samuel on 02/02/22.
//

import UIKit
import Combine

final class ViewController: UIViewController {
	
	private let tableView: UITableView = {
		
		let table = UITableView()
		table.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
		return table
	}()
	
	private var models: [String] = []
	private var observers: [AnyCancellable] = []
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		
		APICaller.shared.fetchData()
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { completion in
				
				switch completion {
					case .finished: print("finished")
					case .failure(let error): print(error.localizedDescription)
				}
			}, receiveValue: { value in
				
				self.models = value
				self.tableView.reloadData()
			})
			.store(in: &observers)
	}
	
	override func viewDidLayoutSubviews() {
		
		super.viewDidLayoutSubviews()
		tableView.frame = view.bounds
	}
}

// MARK: - Table View Delegate Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
		// cell.textLabel?.text = models[indexPath.row]
		cell.action.sink { string in
			print("string is", string)
		}
		.store(in: &observers)
		
		return cell
	}
}
