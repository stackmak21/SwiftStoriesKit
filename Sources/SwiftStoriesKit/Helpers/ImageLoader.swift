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
        ZStack {
            if let urlValue = URL(string: url) {
                GeometryReader { proxy in
                    KFImage(urlValue)
                        .resizable()
                        .placeholder {
                            Rectangle()
                                .frame(width: proxy.size.width, height: proxy.size.height)
                        }
                        .loadDiskFileSynchronously() // ✅ Ensures smooth loading
                        .fade(duration: 0) // ✅ Prevents sudden fade-in effects
                        .scaledToFill()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .clipShape(Circle())
                        /*.animation(.easeInOut(duration: 0.2), value: url)*/ // ✅ Ensures smooth updates
                }
                .frame(width: width, height: height)
            }
        }
    }
}

struct ImageLoaderRect: View {
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
        ZStack {
            if let urlValue = URL(string: url) {
                GeometryReader { proxy in
                    KFImage(urlValue)
                        .resizable()
                        .placeholder {
                            Rectangle()
                                .frame(width: proxy.size.width, height: proxy.size.height)
                        }
                        .loadDiskFileSynchronously() // ✅ Ensures smooth loading
                        .fade(duration: 0) // ✅ Prevents sudden fade-in effects
                        .scaledToFill()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .clipped()
                        /*.animation(.easeInOut(duration: 0.2), value: url)*/ // ✅ Ensures smooth updates
                }
                .frame(width: width, height: height)
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
