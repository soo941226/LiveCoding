//
//  ContentView.swift
//  LiveCoding
//
//  Created by kjs on 04/10/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var imageViewModel = RandomImageViewModel()

    var body: some View {
        VStack {
            MyView(imageViewModel: imageViewModel)
            if let error = imageViewModel.error {
                Text(error.localizedDescription)
            }
        }
        .padding()
        .onAppear {
            imageViewModel.input(.onAppear)
        }
    }
}

#Preview {
    ContentView()
}
