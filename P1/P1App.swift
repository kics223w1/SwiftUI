//
//  P1App.swift
//  P1
//
//  Created by Cao Viet Huy on 19/12/2023.
//

import SwiftUI

@main
struct P1App: App {
    var body: some Scene {
        WindowGroup("Main Window") {
           ContentGames()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .handlesExternalEvents(matching: ["main"])
        
        WindowGroup("P1 Games") {
           ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .handlesExternalEvents(matching: ["p1"])
    }
}
