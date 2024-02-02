//
//  ContentView.swift
//  FoodApiPractice
//
//  Created by Joao Leal on 2/1/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var recipes: [Recipe] = []
    let recipeClient = RecipeClient()
    @State private var recipeName: String = ""
    var body: some View {
        VStack {
            TextField("Enter name", text: $recipeName)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    Task{
                        do{
                            recipes = try await recipeClient.searchRecipe(recipeName)
                        } catch {
                            print(error)
                        }}
                }.padding()
            List(recipes) { recipe in
                
                HStack {
                    AsyncImage(url: recipe.featuredImage) { image in
                        image.resizable()
                            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                            .frame(width: 100, height: 100)
                    } placeholder: {
                    ProgressView("Loading")}
                    
                    Text(recipe.title)
                }
                
                
            }
        }
        }    }


#Preview {
    ContentView()
}
