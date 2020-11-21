//
//  ViewController.swift
//  samplePagedHeader
//
//  Created by Landon Boles on 11/21/20.
//

import UIKit
struct customData {
	// Defines elements for customData
	var screenName: String
	var textColor: UIColor
}
class ViewController: UIViewController {
	let data = [
		// Uses elements from our customData struct
		customData(screenName: "First", textColor: .blue),
		customData(screenName: "Second", textColor: .gray),
		customData(screenName: "Third", textColor: .gray),
		customData(screenName: "Fourth", textColor: .gray)
	]
	override func viewDidLoad() {
		super.viewDidLoad()
		makePagedHeader()
	}
	func makePagedHeader() {
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 225, height: 200) // Decides the size for each element
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 5
		layout.minimumInteritemSpacing = 0
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.isPagingEnabled = false
		collectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.0)
		collectionView.layer.cornerRadius = 30
		collectionView.layer.cornerCurve = .continuous
		collectionView.register(customCell.self, forCellWithReuseIdentifier: "collectionViewCell")
		collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 176).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.dataSource = self
	}
}
extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.width / 2.5)
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return data.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! customCell
		cell.backgroundColor = .clear
		cell.data = self.data[indexPath.row]
		return cell
	}
}
class customCell: UICollectionViewCell {
	var data: customData? {
		didSet { // did click basically
			guard let data = data else {return}
			tabBar.titleLabel?.text = data.screenName
			tabBar.setTitle(data.screenName, for: .normal)
			tabBar.setTitleColor(data.textColor, for: .normal)
			if data.screenName == "Second" {
				tabBar.titleLabel?.alpha = 1
				tabBar.titleLabel?.textAlignment = .center
				tabBar.addTarget(self, action: #selector(doSecond), for: .touchUpInside)
			}
			if data.screenName == "Upcoming" {
				tabBar.titleLabel?.alpha = 0.45
				tabBar.titleLabel?.textAlignment = .center
			}
			if data.screenName == "Requested" {
				tabBar.titleLabel?.alpha = 0.45
				tabBar.titleLabel?.textAlignment = .center
				tabBar.addTarget(self, action: #selector(segueToOrders), for: .touchUpInside)
			}
		}
	}
	@objc func doSecond() {
		print("i aint doin shit lOL")
	}
	@objc func segueToSearch() {
		print("going to search view")
	}
	@objc func segueToOrders() {
		print("going to orders")
	}
	@objc func segueToProfile() {
		print("going to profile")
	}
	fileprivate let tabBar: UIButton = {
		let segueButton = UIButton()
		segueButton.backgroundColor = .clear
		segueButton.layer.cornerRadius = 15
		segueButton.layer.cornerCurve = .continuous
		segueButton.titleLabel?.font = FontKit.roundedFont(ofSize: 40, weight: .semibold)
		segueButton.titleLabel?.adjustsFontSizeToFitWidth = true
		return segueButton
	}()
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(tabBar)
		tabBar.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		tabBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		tabBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		tabBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		tabBar.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class FontKit {
	// Just adds a nice rounded Font
	static func roundedFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
	let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
	let font: UIFont

	if #available(iOS 13.0, *) {
		if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
			font = UIFont(descriptor: descriptor, size: fontSize)
		} else {
			font = systemFont
		}
	} else {
		font = systemFont
	}

	return font
		}
	}
