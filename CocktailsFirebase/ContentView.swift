//
//  ContentView.swift
//  CocktailsFirebase
//
//  Created by Zaid Neurothrone on 2022-12-15.
//

import FirebaseCore
import FirebaseFirestore
import SwiftUI

struct ContentView: View {
  @StateObject private var firebaseManager: FirebaseManager = .init()
  
  let db = Firestore.firestore()
  
  var body: some View {
    NavigationStack {
      List {
        if firebaseManager.cocktails.isEmpty {
          Text("No cocktails yet.")
        } else {
          ForEach(firebaseManager.cocktails) { cocktail in
            HStack {
              Text(cocktail.name)
              Spacer()
              Text(cocktail.color)
            }
          }
        }
      }
      .padding()
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            addCocktailToFirebaseOldApproach()
            getAllCocktailsModernApproach()
          } label: {
            Label("Add Cocktail to Firebase", systemImage: "plus")
          }
        }
      }
    .onAppear(perform: getAllCocktailsModernApproach)
    }
  }
}

extension ContentView {
  private func addCocktailToFirebaseOldApproach() {
    var ref: DocumentReference?
    
    let cocktail = Cocktail(name: "Ginger", color: "Blue")
    
    ref = db.collection("users").document("anna").collection("cocktails").addDocument(data: [
      "name": cocktail.name,
      "color": cocktail.color
    ], completion: { error in
      if let error {
        print("Failed to add document. Error: \(error)")
      } else {
        print("Successfully uploaded document.")
      }
    })
  }
  
  private func addCocktailToFirebaseModernApproach() {
    let cocktail = Cocktail(name: "Ginger", color: "Blue")
    firebaseManager.save(cocktail: cocktail, for: "anna", to: db)
  }
  
  private func getAllCocktailsOldApproach() {
    db.collection("users").document("anna").collection("cocktails").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
          print("\(document.documentID) => \(document.data())")
        }
      }
    }
  }
  
  private func getAllCocktailsModernApproach() {
    firebaseManager.getAllCocktails(for: "anna", in: db)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
