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
    
    @State private var selectedStory: String = ""
    @State var isShown: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    if !isShown {
                        ZStack {
                            ImageLoader(url: DeveloperPreview.story.url[2])
                                .matchedGeometryEffect(id: "box", in: namespace, isSource: true)
                                .frame(width: 20, height: 20)

                            ImageLoader(url: DeveloperPreview.story.previewUrl)
                                .matchedGeometryEffect(id: "storyThumbnail", in: namespace, isSource: true)
                                .frame(width: 120, height: 120)
                                
                        }
                        .transition(.scale(scale: 0.99))
                        .onTapGesture {
                            withAnimation {
                                isShown = true
                            }
                        }
                    }
                }
                Spacer()
            }

            if isShown {
                ZStack {
                    
                    TabView(selection: $selectedStory) {
                            GeometryReader { geo in
                                ZStack {

                                    ImageLoader(url: DeveloperPreview.story.previewUrl)
                                        .clipped()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                                    ImageLoader(url: DeveloperPreview.story.previewUrl)
                                        .matchedGeometryEffect(id: "storyThumbnail", in: namespace)
                                        .frame(width: 60, height: 60)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                        .padding()
                                }
                            }
                        
                    }
                    .matchedGeometryEffect(id: "box", in: storyNamespace)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    
                }
                .transition(.scale(scale: 0.99)) // Move transition here
                .onTapGesture {
                    withAnimation {
                        isShown = false
                    }
                }
            }
        }
        .animation(.interpolatingSpring(duration: 1), value: isShown)
    }
}

#Preview {
    SwiftUIView()
}
