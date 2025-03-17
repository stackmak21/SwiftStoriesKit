//
//  SwiftUIView.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 17/3/25.
//

import SwiftUI

struct SwiftUIView: View {
    @Namespace private var namespace
    @Namespace private var storyNamespace
    
    @State var isShown: Bool = false
    
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                VStack{
                    Spacer()
                    HStack{
                        if !isShown{
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .matchedGeometryEffect(id: "123", in: namespace)
                                    .foregroundStyle(Color.white.opacity(0.001))
                                    .frame(width: 100, height: 100)
                                    .onTapGesture {
                                        isShown = true
                                    }
                                ImageLoader(url: DeveloperPreview.story.previewUrl)
                                    .matchedGeometryEffect(id: "123", in: storyNamespace)
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(Color.red)
                                    .onTapGesture {
                                        isShown = true
                                    }
                            }
                        }
                        Spacer()
                    }
                    
                }
                
                if isShown{
                    ZStack{
                        ImageLoader(url: DeveloperPreview.story.url[2])
                            .matchedGeometryEffect(id: "123", in: namespace)
                            .frame(width: geo.size.width)
                            .clipped()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .onTapGesture {
                                isShown = false
                            }
                        ImageLoader(url: DeveloperPreview.story.previewUrl)
                            .matchedGeometryEffect(id: "123", in: storyNamespace)
                            .foregroundStyle(Color.red)
                            .frame(width: 40, height: 40)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                    }
                    
                }
            }
        }
        .animation(.interpolatingSpring(duration: 0.12), value: isShown)
    }
}

#Preview {
    SwiftUIView()
}
