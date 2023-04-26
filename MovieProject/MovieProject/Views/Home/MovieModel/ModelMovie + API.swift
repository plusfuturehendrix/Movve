//
//  ffdsf.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 26.04.2023.
//

import Foundation

struct MovieModel: Codable {
    let id: String
    let title: String
    let image: String
    let imDbRating: String
}

struct TopMoviesResponse: Codable {
    let items: [MovieModel]
}

func getTopMovies(completion: @escaping ([MovieModel]?, Error?) -> Void) {
    if let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/\(API.network)") {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(TopMoviesResponse.self, from: data)
                    let movies = Array(result.items.prefix(10)) // Получаем только первые 10 фильмов
                    completion(movies, nil)
                } catch let error {
                    completion(nil, error)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }.resume()
    }
}


