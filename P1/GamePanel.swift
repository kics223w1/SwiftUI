//
//  GamePanel.swift
//  P1
//
//  Created by Cao Viet Huy on 21/12/2023.
//

import SwiftUI


struct Game: Identifiable {
    var id = UUID()
    var title: String
    var genre: String
    var imageName: String
}

struct EpicGameLibraryView: View {
    let games: [Game] = [
        Game(title: "Fortnite", genre: "Battle Royale", imageName: "fortnite"),
        Game(title: "Cyberpunk 2077", genre: "RPG", imageName: "cyberpunk2077"),
        Game(title: "Among Us", genre: "Party", imageName: "amongus"),
        // Add more games as needed
    ]

    var body: some View {
        VStack {
            
        
         
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200)),
                    GridItem(.flexible(minimum: 100, maximum: 200)),
                    GridItem(.flexible(minimum: 100, maximum: 200)),
                ], spacing: 16) {
                    ForEach(games) { game in
                        NavigationLink(destination: GameDetailView(game: game)) {
                            GameCardView(game: game)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            
        }
        
    }
}

struct GameCardView: View {
    var game: Game

    var body: some View {
        VStack(alignment: .leading) {
            Image(game.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(width: 260 ,height: 60)
            Text(game.title)
                .font(.headline)
                .padding(.top, 8)
            Text(game.genre)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct GameDetailView: View {
    var game: Game

    var body: some View {
        VStack {
            Image(game.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding(.bottom, 16)
            Text(game.title)
                .font(.title)
            Text(game.genre)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .navigationTitle(game.title)
    }
}
