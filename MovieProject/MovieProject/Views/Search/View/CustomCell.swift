//
//  CustomCell.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 17.04.2023.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public properties
    let cycleImage = UIImageView()
    let label = UILabel()
}

//MARK: - Setup CustomCell for UITableViewCell
extension CustomCell {
    func initialize() {
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        cycleImage.clipsToBounds = true
        cycleImage.layer.cornerRadius = 15
        cycleImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cycleImage)
        
        cycleImage.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(200)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(200)
            make.height.equalTo(150)
            make.right.equalTo(cycleImage).inset(-205)
        }
    }
}
