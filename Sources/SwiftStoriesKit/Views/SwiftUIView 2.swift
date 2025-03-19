//
//  SwiftUIView 2.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 18/3/25.
//

import SwiftUI

struct SwiftUIView_2: View {
    @Namespace private var thumbnailNamespace
    @Namespace private var storyNamespace
    
    @State private var selectedStory: String = ""
    @State private var showStory: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                // MARK: - Thumbnail Section
                HStack {
                    ForEach(DeveloperPreview.stories) { story in
                        if !showStory {
                            ZStack {
                                Rectangle()
                                    .stroke(lineWidth: 4)
                                    .frame(width: 64, height: 64)
                                ImageLoader(url: story.previewUrl)
                                    .matchedGeometryEffect(id: story.id, in: storyNamespace)
                                    .frame(width: 20, height: 20)
//                                    .clipShape(Circle())


                                ImageLoader(url: story.previewUrl)
                                    .matchedGeometryEffect(id: story.id, in: thumbnailNamespace)
                                    .frame(width: 60, height: 60)
//                                    .clipShape(Circle())
                            }
                            .transition(.scale(scale: 0.99))
                            .onTapGesture {
                                selectedStory = story.id
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                                    print("fsdfsdfd")
                                    showStory = true
                                }
                            }
                        }
                    }
                }
                Spacer()
            }

            // MARK: - Fullscreen Story Viewer
            if showStory {
                ZStack {
                    TabView(selection: $selectedStory) {
                        ForEach(DeveloperPreview.stories) { story in
                            GeometryReader { geo in
                                ZStack {
                                    ImageLoader(url: story.previewUrl)
                                        .frame(width: geo.size.width, height: geo.size.height)
                                        .clipped()

                                    if !showStory || story.id == selectedStory {
                                        ImageLoader(url: story.previewUrl)
                                            .matchedGeometryEffect(id: story.id, in: thumbnailNamespace)
                                            .frame(width: 60, height: 60)
//                                            .clipShape(Circle())
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                            .padding()
                                    }
                                }
                                .tag(story.id)
                            }
                        }
                    }
                    .matchedGeometryEffect(id: selectedStory, in: storyNamespace)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .transition(.scale(scale: 0.99))
                .onTapGesture {
                    showStory = false
                }
            }
        }
        .animation(.spring(duration: 1), value: showStory)
    }
}

#Preview {
    SwiftUIView_2()
}
