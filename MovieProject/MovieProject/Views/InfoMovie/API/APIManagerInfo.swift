//
//  APIManager.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 18.04.2023.
//

import Foundation

//MARK: - API Cell for info about movie
func fetchMovieDetails(url: URL, completion: @escaping (String, String, String, String, String, String, String) -> Void) {
    let session = URLSession.shared

    let task = session.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
            return
        }

        guard let data = data else {
            print("No data")
            return
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

            if let fullTitle = json?["fullTitle"] as? String,
               let type = json?["type"] as? String,
               let image = json?["image"] as? String,
               let releaseDate = json?["releaseDate"] as? String,
               let runtimeStr = json?["runtimeStr"] as? String,
               let plot = json?["plot"] as? String,
               let directors = json?["directors"] as? String {
                completion(fullTitle, type, image, releaseDate, runtimeStr, plot, directors)
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }

    task.resume()
}
