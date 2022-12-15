//
//  Cocktail.swift
//  CocktailsFirebase
//
//  Created by Zaid Neurothrone on 2022-12-15.
//

import FirebaseFirestoreSwift
import Foundation

struct Cocktail: Identifiable, Codable {
  @DocumentID var id: String?
  
  var name: String
  var color: String
//  var ingredients: [Ingredient]
}

struct Ingredient: Codable {
  var ingredient: String
  var amount: Int
  var unit: Unit
}

enum Unit: String, Codable {
  case ml = "ml"
  case p = "p"
}

