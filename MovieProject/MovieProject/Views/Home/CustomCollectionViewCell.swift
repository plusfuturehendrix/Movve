//
//  dfff.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 26.04.2023.
//

import UIKit
import SnapKit
import Kingfisher

class CustomCollectionViewCell: UICollectionViewCell {
    let idMovie = UIButton()
    var viewImage = UIImageView()
    var labelMovie = UILabel()
    var labelMovieReit = UILabel()
    
    var id = "0"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        idMovie.addTarget(self, action: #selector(movieID), for: .touchUpInside)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(viewImage)
        viewImage.kf.setImage(with: URL(string: "https://avatars.mds.yandex.net/get-pdb/2800861/2b8a5ef7-141f-4f96-a398-c116a575bdc3/s1200"))
        viewImage.clipsToBounds = true
        viewImage.layer.cornerRadius = 15
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        viewImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(labelMovie)
        labelMovie.text = "NoN"
        labelMovie.font = .systemFont(ofSize: 18, weight: .medium)
        labelMovie.textColor = .white
        labelMovie.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.bottom.equalTo(viewImage).inset(-25)
        }
        
        contentView.addSubview(labelMovieReit)
        labelMovieReit.text = "NoN"
        labelMovieReit.textColor = .gray
        labelMovieReit.font = .systemFont(ofSize: 14, weight: .light)
        labelMovieReit.snp.makeConstraints { make in
            make.bottom.equalTo(viewImage).inset(-45)
        }
        
        contentView.addSubview(idMovie)
        idMovie.backgroundColor = .clear
        idMovie.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func movieID() {
        print(id)
    }
}
