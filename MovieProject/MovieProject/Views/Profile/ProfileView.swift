//
//  UserView.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 14.04.2023.
//

import UIKit
import SnapKit
import Kingfisher

class ProfileView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.thremeColor
        nameBanner()
        initialize()
    }
}

//MARK: - Setup Header Banner
private extension ProfileView {
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

//MARK: - Setup ProfileView
private extension ProfileView {
    func initialize() {
        let imageProfile: UIImageView = {
            let imageProfile = UIImageView()
            imageProfile.kf.setImage(with: URL(string: "https://m.buro247.ru/images/senina/aiony-haust-3TLl_97HNJo-unspl.jpg.webp"))
            imageProfile.clipsToBounds = true
            imageProfile.layer.cornerRadius = 50
            imageProfile.translatesAutoresizingMaskIntoConstraints = false
            imageProfile.contentMode = .scaleAspectFill
            imageProfile.backgroundColor = .white
            return imageProfile
        }()
        
        let nameLabel: UILabel = {
            let name = UILabel()
            name.text = "Hello! Katty"
            name.font = .systemFont(ofSize: 34, weight: .heavy)
            name.textColor = .white
            return name
        }()
        
        let numberLabel: UILabel = {
            let name = UILabel()
            name.text = "Number: +7923.....10"
            name.font = .systemFont(ofSize: 16, weight: .semibold)
            name.textColor = .gray
            return name
        }()
        
        let dateLabel: UILabel = {
            let name = UILabel()
            name.text = "Date of registration: \(convertDate())"
            name.font = .systemFont(ofSize: 16, weight: .semibold)
            name.textColor = .gray
            return name
        }()
        
        let buttonLogOut: UIButton = {
            let name = UIButton()
            name.setTitle("Sing Out", for: .normal)
            name.tintColor = Color.selectItemsTabbar
            name.backgroundColor = Color.tabbarBackgroundColor
            name.layer.cornerRadius = 15
            return name
        }()
        
        view.addSubview(imageProfile)
        imageProfile.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(180)
            make.width.height.equalTo(200)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(imageProfile).inset(-70)
        }
        
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nameLabel).inset(-60)
        }
        
        view.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(dateLabel).inset(-25)
        }
        
        buttonLogOut.addTarget(self, action: #selector(testButton), for: .touchUpInside)
        view.addSubview(buttonLogOut)
        buttonLogOut.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(numberLabel).inset(-100)
        }
    }
    
    @objc func testButton() {
        print(123)
    }
}





