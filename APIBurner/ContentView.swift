//
//  ContentView.swift
//  APIBurner
//
//  Created by Gourav Kumar on 25/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView(viewModel: MainViewModel()).ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
