//
//  MyCollectionViewCell.swift
//  CollectionView+SecondVC
//
//  Created by Danil Bochkarev on 14.04.2023.
//

import UIKit
import SnapKit

class MyCollectionViewCell: UICollectionViewCell {
    //MARK: - Setting properties for cell
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setting Label for cell && constraints
private extension MyCollectionViewCell {
    func initialize() {
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        addSubview(titleLabel)
        
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        addSubview(subtitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(25)
            make.left.equalToSuperview().inset(8)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(8)
        }
    }
}



