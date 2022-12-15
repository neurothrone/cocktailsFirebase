//
//  Firebase+Utility.swift
//  CocktailsFirebase
//
//  Created by Zaid Neurothrone on 2022-12-15.
//

import FirebaseCore
import FirebaseFirestore
import Foundation

class FirebaseManager: ObservableObject {
  @Published var cocktails: [Cocktail] = []
  
  func save(cocktail: Cocktail, for userId: String, to db: Firestore) {
    let collectionRef = db.collection("users").document(userId).collection("cocktails")
    
    do {
      let newCocktailRef = try collectionRef.addDocument(from: cocktail)
    } catch {
      print("Failed to add Cocktail to Firebase")
    }
  }
  
  private func saveCocktailToFavorites(cocktail: Cocktail, forUserId: String, in db: Firestore) {
    let collectionRef = db.collection("users").document(forUserId).collection("favorites")
    
    do {
      let newCocktailRef = try collectionRef.addDocument(from: cocktail)
    } catch {
      print("Failed to add Cocktail to Firebase")
    }
  }
  
  func getAllCocktails(for userId: String, in db: Firestore) {
    let collectionRef = db.collection("users").document(userId).collection("cocktails")
    
    collectionRef.getDocuments { snapshot, error in
      if let error {
        print("Error when getting documents. Error: \(error.localizedDescription)")
        return
      }
      
      if let documents = snapshot?.documents {
        
        // Short approach
        let fetchedCocktails = documents.compactMap { document in
          return try? document.data(as: Cocktail.self)
        }
        
        DispatchQueue.main.async {
          self.cocktails = fetchedCocktails
        }

        // Long approach
//        for document in documents {
//          let cocktail = try? document.data(as: Cocktail.self)
//          if let cocktail {
//            print(cocktail)
//            cocktails.append(cocktail)
//          }
//        }
      }
    }
  }
}
