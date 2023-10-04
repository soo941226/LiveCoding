//
//  MyView.swift
//  LiveCoding
//
//  Created by kjs on 04/10/23.
//

import SwiftUI

struct MyView: View {
    @ObservedObject var imageViewModel: RandomImageViewModel

    var body: some View {
        Image(uiImage: imageViewModel.result)
        Text("Hello, world!")
        Button(action: {
            imageViewModel.input(.buttonTouch)
        }, label: {
            Text("click")
        })
    }
}
