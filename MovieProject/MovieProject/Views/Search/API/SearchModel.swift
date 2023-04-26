//
//  SearchModel.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 17.04.2023.
//

import Foundation

struct Movie {
    let title: String
    let description: String?
    let imageUrl: String?
    let idMovie: String
}

struct SearchResults: Decodable {
    let results: [SearchResult]
}

struct SearchResult: Decodable {
    let id: String
    let title: String
    let description: String?
    let image: String?
}

