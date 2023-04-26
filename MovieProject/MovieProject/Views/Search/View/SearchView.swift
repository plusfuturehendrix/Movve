//
//  SearchView.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 14.04.2023.
//
import UIKit
import SnapKit
import Kingfisher

class SearchView: UIViewController {
    //MARK: - Network propeties
    var titleMovie = [String]()
    var imageMovie = [String]()
    var idMoview = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.thremeColor
        
        nameBanner()
        initialize()
        initTableView()
    }
    
    //MARK: - Private propeties
    private var tableView = UITableView()
    private var textInput = UITextField()
    private let activityIndicator = UIActivityIndicatorView()
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

//MARK: - Setup Search View
private extension SearchView {
    func initialize() {
        let screen = UIScreen.main.bounds
        
        textInput.textColor = .black
        textInput.backgroundColor = .white
        textInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textInput.leftViewMode = .always
        textInput.layer.cornerRadius = 10
        textInput.autocorrectionType = .no
        textInput.attributedPlaceholder = NSAttributedString(
            string: "Example Titanic...",
            attributes: [NSAttributedString.Key.foregroundColor: Color.thremeColor.withAlphaComponent(0.5)]
        )
        
        let buttonSearch: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "checkmark"), for: .normal)
            button.backgroundColor = Color.tabbarBackgroundColor
            button.tintColor = .white
            button.layer.cornerRadius = 12
            return button
        }()
        
        let searchLabel: UILabel = {
            let text = UILabel()
            text.text = "Enter the movie you want to find"
            text.textAlignment = .center
            text.font = .systemFont(ofSize: 20, weight: .medium)
            text.textColor = .white
            return text
        }()
        
        view.addSubview(searchLabel)
        searchLabel.snp.makeConstraints { make in
            make.width.equalTo(screen.width - 80)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(150)
        }
        
        view.addSubview(textInput)
        textInput.snp.makeConstraints { make in
            make.width.equalTo(screen.width - 120)
            make.height.equalTo(50)
            make.bottom.equalTo(searchLabel).offset(60)
            make.left.equalToSuperview().inset(30)
        }
        
        view.addSubview(buttonSearch)
        buttonSearch.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.right.equalTo(textInput).inset(-60)
            make.bottom.equalTo(searchLabel).offset(60)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        buttonSearch.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Network request (closures)
    @objc private func searchButtonTapped() {
        guard let query = textInput.text else { return }
        idMoview = [String]()
        
        titleMovie = [String]()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset((UIScreen.main.bounds.height / 2) + 50)
        }
        activityIndicator.startAnimating()
        
        searchMovies(query: query) { [weak self] result in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
            }
            
            switch result {
            case .success(let movies):
                self?.titleMovie.removeAll()
                self?.imageMovie.removeAll()
                for movie in movies {
                    self?.titleMovie.append(movie.title)
                    self?.imageMovie.append(movie.imageUrl ?? "")
                    self?.idMoview.append(movie.idMovie)
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

//MARK: - Setup TableView
private extension SearchView {
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 230
        tableView.backgroundColor = Color.thremeColor
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textInput.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        cell.backgroundColor = Color.thremeColor
        cell.cycleImage.kf.setImage(with: URL(string: imageMovie[indexPath.item] == "" ? "https://avatars.mds.yandex.net/get-pdb/2800861/2b8a5ef7-141f-4f96-a398-c116a575bdc3/s1200" : imageMovie[indexPath.item]))
        cell.label.text = titleMovie[indexPath.item]
        cell.label.textColor = .white
        cell.label.numberOfLines = 3
        cell.label.textAlignment = .center
        cell.label.font = .systemFont(ofSize: 16, weight: .semibold)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InfoMovieView(id: idMoview[indexPath.item])
        let nav = UINavigationController(rootViewController: vc)
        print(idMoview[indexPath.item])
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}



