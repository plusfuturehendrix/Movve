//
//  SearchView.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 14.04.2023.
//

import UIKit

class SearchView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.thremeColor
        
        nameBanner()
    }
}

//MARK: - Setup Header Banner
private extension SearchView {
    func nameBanner() {
        let nameView: UIView = {
            let view = UIView()
            view.backgroundColor = Color.thremeColor
            return view
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "Mov"
            label.font = .systemFont(ofSize: 32, weight: .bold)
            label.textColor = .white
            return label
        }()
        
        let nameLabel1: UILabel = {
            let label = UILabel()
            label.text = "ve"
            label.font = .systemFont(ofSize: 32, weight: .bold)
            label.textColor = Color.tabbarBackgroundColor
            return label
        }()
        
        view.addSubview(nameView)
        nameView.addSubview(nameLabel)
        nameView.addSubview(nameLabel1)
        
        nameView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(85)
            make.top.equalToSuperview().inset(0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(5)
        }
        
        nameLabel1.snp.makeConstraints { make in
            make.right.equalTo(nameLabel).inset(-36)
            make.bottom.equalToSuperview().inset(5)
        }
    }
}
