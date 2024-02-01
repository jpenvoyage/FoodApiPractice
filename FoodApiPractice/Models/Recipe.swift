//
//  Recipe.swift
//  FoodApiPractice
//
//  Created by Joao Leal on 2/1/24.
//

import Foundation

struct RecipeResponse: Decodable {
    let results: [Recipe]
}

struct Recipe: Decodable {
    let title: String
    let featuredImage: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case featuredImage = "featured_image"
    }
}
