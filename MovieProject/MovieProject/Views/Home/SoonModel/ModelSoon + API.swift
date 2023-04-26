//
//  ModelSoon + API.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 26.04.2023.
//

import Foundation

struct SoonMovie: Codable {
    let id: String
    let title: String
    let image: String
}

struct ComingSoonResponse: Codable {
    let items: [SoonMovie]
}

func getComingSoonMovies(completion: @escaping ([SoonMovie]?, Error?) -> Void) {
    if let url = URL(string: "https://imdb-api.com/en/API/ComingSoon/\(API.network)") {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(ComingSoonResponse.self, from: data)
                    let soon = Array(result.items.prefix(10)) // Получаем только первые 10 фильмов
                    completion(soon, nil)
                } catch let error {
                    completion(nil, error)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }.resume()
    }
}
