//
//  ViewController.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 17.04.2023.
//

import UIKit
import SnapKit
import Kingfisher

class HomeView: UIViewController {
    let scrollView = UIScrollView()
    var collection1: UICollectionView!
    var collection2: UICollectionView!
    var collection3: UICollectionView!
    
    let popularMovie = UILabel()
    let tvShowLabel = UILabel()
    let commingSoon = UILabel()
    
    var movieTitle = [String]()
    var movieImage = [String]()
    var movieRait = [String]()
    var movieID = [String]()
    
    var tvShowTitle = [String]()
    var tvShowImage = [String]()
    var tvShowRait = [String]()
    var tvShowID = [String]()
    
    var soonTitle = [String]()
    var soonImage = [String]()
    var soonID = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTopMovies { [weak self] movies, error in
            if let movies = movies {
                for movie in movies {
                    self?.movieTitle.append(movie.title)
                    self?.movieImage.append(movie.image)
                    self?.movieRait.append(movie.imDbRating)
                    self?.movieID.append(movie.id)
                }
                DispatchQueue.main.async {
                    self?.setUpCollection()
                    self?.collection1.reloadData()
                }
            } else if let error = error {
                print(error)
            }
        }
        
        getTopTVShows { [weak self] tvShows, error in
            if let tvShows = tvShows {
                for show in tvShows {
                    self?.tvShowID.append(show.id)
                    self?.tvShowTitle.append(show.title)
                    self?.tvShowImage.append(show.image)
                    self?.tvShowRait.append(show.imDbRating)
                }
                DispatchQueue.main.async {
                    self?.setUpCollection()
                    self?.collection2.reloadData()
                }
            } else if let error = error {
                print(error)
            }
        }
        
        getComingSoonMovies { [weak self] SoonMovie, error in
            if let soon = SoonMovie {
                for soon in soon {
                    self?.soonID.append(soon.id)
                    self?.soonTitle.append(soon.title)
                    self?.soonImage.append(soon.image)
                }
            } else if let error = error {
                print(error)
            }
        }
        
        view.backgroundColor = Color.thremeColor
        
        // Создание UIScrollView
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        // Добавление коллекций в UIScrollView
        collection1 = createCollection()
        collection2 = createCollection()
        collection3 = createCollection()
        scrollView.addSubview(collection1)
        scrollView.addSubview(collection2)
        scrollView.addSubview(collection3)
        
        // Настройка layout
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setUpCollection()
        
        // Настройка контента UIScrollView
        let contentHeight = collection1.frame.height + collection2.frame.height + collection3.frame.height + 90
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight)
        nameBanner()
    }
}

extension HomeView {
    func setUpCollection() {
        scrollView.addSubview(popularMovie)
        popularMovie.text = "Popular Movie"
        popularMovie.font = .systemFont(ofSize: 24, weight: .bold)
        popularMovie.textColor = .white
        popularMovie.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.equalToSuperview().inset(10)
        }
        collection1.snp.makeConstraints { make in
            make.top.equalTo(popularMovie).inset(30)
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(260)
        }
        
        scrollView.addSubview(tvShowLabel)
        tvShowLabel.text = "TV Show"
        tvShowLabel.font = .systemFont(ofSize: 24, weight: .bold)
        tvShowLabel.textColor = .white
        tvShowLabel.snp.makeConstraints { make in
            make.top.equalTo(collection1.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(10)
        }
        collection2.snp.makeConstraints { make in
            make.top.equalTo(tvShowLabel).inset(30) // Установка отступа между коллекциями
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(260)
        }
        
        scrollView.addSubview(commingSoon)
        commingSoon.text = "Coming Soon"
        commingSoon.font = .systemFont(ofSize: 24, weight: .bold)
        commingSoon.textColor = .white
        commingSoon.snp.makeConstraints { make in
            make.top.equalTo(collection2.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(10)
        }
        collection3.snp.makeConstraints { make in
            make.top.equalTo(commingSoon).inset(30)
            make.left.right.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(260)
        }
    }
}

extension HomeView {
    func createCollection() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 210) // Установка размеров ячеек
        layout.sectionInset = UIEdgeInsets(top: -40, left: 10, bottom: 0, right: 10) // Установка отступа
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = Color.thremeColor
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collection.dataSource = self
        return collection
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell

        if (!movieTitle.isEmpty) && (collectionView == collection1) {
            cell.labelMovie.text = movieTitle[indexPath.row]
            cell.viewImage.kf.setImage(with: URL(string: "\(movieImage[indexPath.row])"))
            cell.labelMovieReit.text = "Rating: \(movieRait[indexPath.row])"
            cell.id = movieID[indexPath.row]
            cell.labelMovie.numberOfLines = 1
        }
        
        if (!movieTitle.isEmpty) && (collectionView == collection2) {
            cell.labelMovie.text = tvShowTitle[indexPath.row]
            cell.viewImage.kf.setImage(with: URL(string: "\(tvShowImage[indexPath.row])"))
            cell.labelMovieReit.text = "Rating: \(tvShowRait[indexPath.row])"
            cell.id = tvShowID[indexPath.row]
            cell.labelMovie.numberOfLines = 1
        }
        
        if (!movieTitle.isEmpty) && (collectionView == collection3) {
            cell.labelMovie.text = soonTitle[indexPath.row]
            cell.viewImage.kf.setImage(with: URL(string: "\(soonImage[indexPath.row])"))
            cell.labelMovieReit.text = ""
            cell.id = soonID[indexPath.row]
            cell.labelMovie.numberOfLines = 1
        }
        
        return cell
    }
}

//MARK: - Setup Header Banner
private extension HomeView {
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
