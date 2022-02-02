//
//  CustomCellTableViewCell.swift
//  CombineIntro
//
//  Created by Rijo Samuel on 02/02/22.
//

import UIKit
import Combine

class CustomCell: UITableViewCell {
	
	static let identifier = "CustomCell"
	
	private let button: UIButton = {
		
		let button = UIButton()
		button.backgroundColor = .systemPink
		button.setTitle("Button", for: .normal)
		button.setTitleColor(.white, for: .normal)
		return button
	}()
	
	let action = PassthroughSubject<String, Never>()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(button)
		button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc private func didTapButton() {
		
		action.send("Cool!, Button was tapped")
	}
	
	override func layoutSubviews() {
		
		super.layoutSubviews()
		button.frame = CGRect(x: 10, y: 3, width: contentView.frame.size.width - 20, height: contentView.frame.size.height - 6)
	}
}
