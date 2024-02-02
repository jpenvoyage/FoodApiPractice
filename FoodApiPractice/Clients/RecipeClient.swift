//
//  RecipeClient.swift
//  FoodApiPractice
//
//  Created by Joao Leal on 2/1/24.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidResponse
    case decodingError
}

struct RecipeClient {
    func searchRecipe(_ name: String) async throws -> [Recipe] {
        guard let url = URL(string: "https://food2fork.ca/api/recipe/search/?page=2&query=\(name)") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.addValue("Token 9c8b06d329136da358c2d00e76946b0111ce2c48", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
       guard let recipeResponse = try? JSONDecoder().decode(RecipeResponse.self, from: data) else  { throw NetworkError.decodingError }
       
        return recipeResponse.results
    }
}
