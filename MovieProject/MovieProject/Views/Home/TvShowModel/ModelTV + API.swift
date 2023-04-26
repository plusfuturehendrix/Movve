//
//  ModelTV + API.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 26.04.2023.
//

import Foundation

struct TopTVShowsResponse: Codable {
    let items: [TVShow]
}

struct TVShow: Codable {
    let id: String
    let title: String
    let image: String
    let imDbRating: String
}

func getTopTVShows(completion: @escaping ([TVShow]?, Error?) -> Void) {
    if let url = URL(string: "https://imdb-api.com/en/API/Top250TVs/\(API.network)") {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(TopTVShowsResponse.self, from: data)
                    let tvShows = Array(result.items.prefix(10)) // Получаем только первые 10 сериалов
                    completion(tvShows, nil)
                } catch let error {
                    completion(nil, error)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }.resume()
    }
}
