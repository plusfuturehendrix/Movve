//
//  APIManager.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 17.04.2023.
//
import Foundation

func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
    let url = URL(string: "https://imdb-api.com/en/API/SearchTitle/\(API.network)/\(query)")!
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data, error == nil else {
            completion(.failure(error ?? URLError(.unknown)))
            return
        }
        
        do {
            let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
            let movies = searchResults.results.map { result in
                Movie(title: result.title,
                      description: result.description,
                      imageUrl: result.image, idMovie: result.id)
            }
            completion(.success(movies))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}



