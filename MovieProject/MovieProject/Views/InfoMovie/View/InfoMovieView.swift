//
//  InfoMovieView.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 17.04.2023.
//

import UIKit
import SnapKit

class InfoMovieView: UIViewController {
    //MARK: - Selected info
    var id: String
    
    init(id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var fullTitleMovie: String?
    var typeMovie: String?
    var imageMovi: String?
    var releaseDateMovie: String?
    var runtimeStrMovie: String?
    var plotDateMovie: String?
    var directorsMovie: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialize()
        
        fetchMovieDetails(url: URL(string: "https://imdb-api.com/en/API/Title/\(API.network)/\(id)")!) { [weak self] (fullTitle, type, image, releaseDate, runtimeStr, plot, directors) in
            self?.fullTitleMovie = fullTitle
            self?.typeMovie = type
            self?.imageMovi = image
            self?.releaseDateMovie = releaseDate
            self?.runtimeStrMovie = runtimeStr
            self?.plotDateMovie = plot
            self?.directorsMovie = directors
            
            DispatchQueue.main.async {
                self?.initialize()
            }
        }
    }
    
    //MARK: - Setting view properties
    private let fullTitle = UILabel()
    private let type = UILabel()
    private let year = UILabel()
    private let imageMovie = UIImageView()
    private let releaseDate = UILabel()
    private let runtimeStr = UILabel()
    private let plot = UILabel()
    private let directors = UILabel()
    private var gradientView = UIView()
    private let seeTrailer = UIButton()
}

//MARK: - Setup View
private extension InfoMovieView {
    func initialize() {
        let screen = UIScreen.main.bounds
        
        imageMovie.kf.setImage(with: URL(string: "\(imageMovi ?? "https://avatars.mds.yandex.net/get-pdb/2800861/2b8a5ef7-141f-4f96-a398-c116a575bdc3/s1200")"))
        imageMovie.clipsToBounds = true
        imageMovie.contentMode = .scaleAspectFill
        imageMovie.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageMovie)
        imageMovie.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(0)
            make.height.equalTo(UIScreen.main.bounds.height / 1.5)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        gradientView = UIView(frame: CGRect(x: 0, y: 0, width: screen.width, height: screen.height + 50))
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, Color.thremeColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.1, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 0.5)
        gradientView.layer.addSublayer(gradientLayer)
        view.addSubview(gradientView)
        
        fullTitle.text = fullTitleMovie
        fullTitle.font = .systemFont(ofSize: 30, weight: .heavy)
        fullTitle.textColor = .white
        fullTitle.numberOfLines = 3
        fullTitle.textAlignment = .center
        view.addSubview(fullTitle)
        fullTitle.snp.makeConstraints { make in
            make.width.equalTo(screen.width - 50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(imageMovie).inset(80)
        }
        
        type.text = "\(typeMovie ?? "") •"
        type.font = .systemFont(ofSize: 18, weight: .semibold)
        type.textColor = .gray
        view.addSubview(type)
        type.snp.makeConstraints { make in
            make.bottom.equalTo(fullTitle).inset(-35)
            make.right.equalToSuperview().inset((screen.width / 2) - 15)
        }
        
        year.text = "1953 •"
        year.font = .systemFont(ofSize: 18, weight: .semibold)
        year.textColor = .gray
        view.addSubview(year)
        year.snp.makeConstraints { make in
            make.bottom.equalTo(fullTitle).inset(-35)
            make.left.equalTo(type).inset(-60)
        }
        
        runtimeStr.text = "\(runtimeStrMovie ?? "")"
        runtimeStr.font = .systemFont(ofSize: 18, weight: .semibold)
        runtimeStr.textColor = .gray
        view.addSubview(runtimeStr)
        runtimeStr.snp.makeConstraints { make in
            make.bottom.equalTo(fullTitle).inset(-35)
            make.right.equalTo(type).inset(-80)
        }
        
        releaseDate.text = "\(releaseDateMovie ?? "")"
        releaseDate.font = .systemFont(ofSize: 18, weight: .semibold)
        releaseDate.textColor = .gray
        view.addSubview(releaseDate)
        releaseDate.snp.makeConstraints { make in
            make.bottom.equalTo(runtimeStr).inset(-35)
            make.centerX.equalToSuperview()
        }
        
        plot.text = "\(plotDateMovie ?? "")"
        plot.font = .systemFont(ofSize: 18, weight: .semibold)
        plot.textColor = .gray
        plot.textAlignment = .center
        plot.numberOfLines = 4
        view.addSubview(plot)
        plot.snp.makeConstraints { make in
            make.width.equalTo(screen.width - 80)
            make.bottom.equalTo(releaseDate).inset(-100)
            make.centerX.equalToSuperview()
        }
        
        directors.text = "\(directorsMovie ?? "")"
        directors.font = .systemFont(ofSize: 18, weight: .semibold)
        directors.textColor = .gray
        directors.textAlignment = .center
        directors.numberOfLines = 4
        view.addSubview(directors)
        directors.snp.makeConstraints { make in
            make.width.equalTo(screen.width - 80)
            make.bottom.equalTo(plot).inset(-40)
            make.centerX.equalToSuperview()
        }
        
        seeTrailer.setTitle("Watch Now", for: .normal)
        seeTrailer.backgroundColor = Color.tabbarBackgroundColor
        seeTrailer.tintColor = .white
        seeTrailer.layer.cornerRadius = 12
        seeTrailer.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        view.addSubview(seeTrailer)
        seeTrailer.snp.makeConstraints { make in
            make.width.equalTo(screen.width / 2)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(directors).inset(-70)
        }
         
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func playVideo() {
        print("123")
    }
    
    @objc private func backAction() {
        dismiss(animated: true, completion: nil)
    }
}
