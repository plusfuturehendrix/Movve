//
//  MainScreen.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 14.04.2023.
//

import UIKit
import SnapKit

class HomeView: UIViewController {
    //MARK: - Setting properties
    private let cellIdentifier = "MyCell"
    private let numberOfCells = 10
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Color.thremeColor
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = Color.thremeColor
        return contentView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private let nameView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.thremeColor
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mov"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let nameLabel1: UILabel = {
        let label = UILabel()
        label.text = "ve"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = Color.tabbarBackgroundColor
        return label
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 80)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.thremeColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        setupView()
        nameBanner()
    }
}

//MARK: - Setup Header Banner
private extension HomeView {
    func nameBanner() {
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

//MARK: - Setup Views
private extension HomeView {
    private func setupView() {
        let popularMovie: UICollectionView = {
            let collectionViewLayout = UICollectionViewFlowLayout()
            collectionViewLayout.scrollDirection = .horizontal
            collectionViewLayout.itemSize = CGSize(width: 150, height: 220)
            collectionViewLayout.minimumInteritemSpacing = 10
            collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.backgroundColor = Color.thremeColor
            collectionView.showsHorizontalScrollIndicator = false
            return collectionView
        }()
        
        let popularMoview: UILabel = {
            let label = UILabel()
            label.text = "Popular Movie"
            label.font = .systemFont(ofSize: 26, weight: .semibold)
            label.textColor = .white
            return label
        }()
        
        let tvShow: UICollectionView = {
            let collectionViewLayout = UICollectionViewFlowLayout()
            collectionViewLayout.scrollDirection = .horizontal
            collectionViewLayout.itemSize = CGSize(width: 130, height: 190)
            collectionViewLayout.minimumInteritemSpacing = 20
            collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 18, right: 0)
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.backgroundColor = Color.thremeColor
            collectionView.showsHorizontalScrollIndicator = false
            return collectionView
        }()
        
        let tvShowLabel: UILabel = {
            let label = UILabel()
            label.text = "TV Show"
            label.font = .systemFont(ofSize: 26, weight: .semibold)
            label.textColor = .white
            return label
        }()
        
        let comingSoon: UICollectionView = {
            let collectionViewLayout = UICollectionViewFlowLayout()
            collectionViewLayout.scrollDirection = .horizontal
            collectionViewLayout.itemSize = CGSize(width: 120, height: 180)
            collectionViewLayout.minimumInteritemSpacing = 15
            collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.backgroundColor = Color.thremeColor
            collectionView.showsHorizontalScrollIndicator = false
            return collectionView
        }()
        
        let comingSoonLabel: UILabel = {
            let label = UILabel()
            label.text = "Coming Soon"
            label.font = .systemFont(ofSize: 26, weight: .semibold)
            label.textColor = .white
            return label
        }()
        
        popularMovie.tag = 0
        tvShow.tag = 1
        comingSoon.tag = 2
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(contentSize.height)
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        //MARK: - Popular Movie
        stackView.addArrangedSubview(popularMovie)
        popularMovie.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(270)
        }
        
        view.addSubview(popularMoview)
        popularMoview.snp.makeConstraints { make in
            make.top.equalTo(popularMovie).inset(-25)
            make.left.equalToSuperview().inset(20)
        }

        //MARK: - TV Show
        stackView.addArrangedSubview(tvShow)
        tvShow.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(270)
        }
        
        view.addSubview(tvShowLabel)
        tvShowLabel.snp.makeConstraints { make in
            make.top.equalTo(tvShow).inset(-6)
            make.left.equalToSuperview().inset(20)
        }
        
        //MARK: - Coming soon
        stackView.addArrangedSubview(comingSoon)
        comingSoon.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(270)
        }
        
        view.addSubview(comingSoonLabel)
        comingSoonLabel.snp.makeConstraints { make in
            make.top.equalTo(comingSoon).inset(-7)
            make.left.equalToSuperview().inset(20)
        }
    }
}

//MARK: - Setup UICollectionViewDataSource, UICollectionViewDelegate
extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colors: [UIColor] = [.yellow, .blue, .systemPink]
        let title: [String] = ["One", "Two", "Three"]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCollectionViewCell
        
        cell.backgroundColor = colors[collectionView.tag]
        cell.layer.cornerRadius = 20
        
        cell.titleLabel.text = "\(title[collectionView.tag])"
        cell.subtitleLabel.text = "\(title[collectionView.tag])"
        
        return cell
    }
}
