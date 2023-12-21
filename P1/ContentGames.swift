//
//  ContentGames.swift
//  P1
//
//  Created by Cao Viet Huy on 21/12/2023.
//

import SwiftUI

struct ContentGames: View {
    @Environment(\.openURL) var openURL
    
    let data = Array(1...1000).map {"\($0)"}
   
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 200))
    ]
    
    
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 50) {
                ForEach(data, id: \.self) {
                    item in
                    ZStack {
                        Rectangle()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.green)
                            .cornerRadius(20)
                        
                        Text("\(item)")
                            .foregroundColor(.white)
                            .font(.system(size: 60, weight: .medium , design: .rounded))
                    }.onTapGesture {
                        guard let url = URL(string: "myapp://p1") else {return}
                        openURL(url)
                    }
                }
            }.padding(.horizontal)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        
    }
}

struct ContentGames_Previews: PreviewProvider {
    static var previews: some View {
        ContentGames()
    }
}
