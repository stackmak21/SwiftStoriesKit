//
//  ImageLoader.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//

import SwiftUI
import Kingfisher

struct ImageLoader: View {
    let url: String
    let width: CGFloat?
    let height: CGFloat?
    
    init(
        url: String,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        self.url = url
        self.width = width
        self.height = height
    }
    
    var body: some View {
        ZStack{
            if let urlValue = URL(string: url) {
                KFImage(urlValue)
                    .resizable()
                    .placeholder{
                        Rectangle()
                    }
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                }
        }
    }
}

#Preview {
    ImageLoader(
        url: "https://picsum.photos/800/1006",
        width: 200,
        height: 200
    )
}
