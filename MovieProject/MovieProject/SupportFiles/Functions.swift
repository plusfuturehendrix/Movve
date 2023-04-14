//
//  Functions.swift
//  MovieProject
//
//  Created by Danil Bochkarev on 14.04.2023.
//

import Foundation

func convertDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    let date = Date()
    let formattedDate = dateFormatter.string(from: date)
    return formattedDate
}
