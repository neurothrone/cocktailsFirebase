//
//  AppMain.swift
//  CocktailsFirebase
//
//  Created by Zaid Neurothrone on 2022-12-15.
//

import Firebase
import SwiftUI

@main
struct AppMain: App {
  init() {
    FirebaseApp.configure()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
