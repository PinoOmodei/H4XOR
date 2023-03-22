//
//  ContentView.swift
//  H4XOR
//
//  Created by Pino Omodei on 22/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()

    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {                    
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
            }
            .navigationTitle("H4X0R NEWS")
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                networkManager.fetchData()
            }
        }
        .onAppear() {
            networkManager.fetchData()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
