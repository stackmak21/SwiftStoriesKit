//
//  SwiftUIView.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 18/3/25.
//

import SwiftUI

struct SwiftUIView: View {
    @Namespace private var thumbnailNamespace
    @Namespace private var storyNamespace
    
    @State private var selectedStory: String = ""
    @State private var showStory: Bool = false
    
    @State private var isInternalShown: Bool = false
    @State private var isExternalShown: Bool = false
    
    @State private var offsetY: CGFloat = 0
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 1
    @State private var showInfo: Bool = false
    
    @State var allow3DRotation: Bool = false
    
    private let deviceHeight: Double = UIScreen.self.main.bounds.height
    
    var body: some View {
        ZStack {
            VStack {
                // MARK: - Thumbnail Section
                ScrollView(.horizontal){
                    VStack{
                        HStack {
                            ForEach(DeveloperPreview.stories) { story in
                                if !showStory{
                                    ZStack {
                                        
                                        ImageLoaderRect(url: story.previewUrl)
                                            .matchedGeometryEffect(id: story.id, in: storyNamespace)
                                            .frame(width: 20, height: 20)
                                        
                                        
                                        
                                        ImageLoader(url: story.previewUrl)
                                            .matchedGeometryEffect(id: story.id, in: thumbnailNamespace)
                                            .frame(width: 60, height: 60)
                                        
                                    }
                                    .transition(.scale(scale: 0.99))
                                    .onDisappear {
                                        print("isInternalShown: \(isInternalShown)")
                                        isInternalShown = true
                                    }
                                    .onTapGesture {
                                        selectedStory = story.id
                                        DispatchQueue.main.asyncAfter(deadline: .now()){
                                            showStory = true
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
            }

            // MARK: - Fullscreen Story Viewer
            if showStory {
                ZStack {
                    ZStack{
                        TabView(selection: $selectedStory) {
                            ForEach(DeveloperPreview.stories) { story in
                                GeometryReader { geo in
                                    ZStack {
                                        ImageLoaderRect(url: story.previewUrl)
                                            .frame(width: geo.size.width, height: geo.size.height)
                                            .clipped()
                                        
                                        if isInternalShown{
                                            ImageLoader(url: story.previewUrl)
                                                .frame(width: 60, height: 60)
                                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                                .padding()
                                                .onAppear {
                                                    print("thumbnail appeared")
                                                }
                                            
                                        }
                                    }
                                    .tag(story.id)
                                }
                            }
                        }
                        .matchedGeometryEffect(id: selectedStory, in: storyNamespace)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                    }
                   
                    .onAppear {
                        print("TabView Appeared")
                    }
                    .onDisappear {
                        print("TabView Disapeared")
                    }
                    
                    if showStory && !isInternalShown{
                        if let story = DeveloperPreview.stories.first(where: { $0.id == selectedStory}){
                            ImageLoader(url: story.previewUrl)
                                .matchedGeometryEffect(id: story.id, in: thumbnailNamespace)
                                .frame(width: 60, height: 60)
                            //                                            .clipShape(Circle())
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding()
//                                .opacity(showStory ? 0 : 1)
                               
                        }
                    }
                }
                .transition(.scale(scale: 0.99))
                .onTapGesture {
                    isInternalShown = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()){
                        print("show story = false")
                        showStory = false
                    }
                }
                .offset(y: offsetY)
                .scaleEffect(scale)
                .gesture(
                    DragGesture()
                        .onChanged(onDrag)
                        .onEnded(onDragEnded)
                )
            }
        }
        .animation(.spring(duration: 1), value: showStory)
    }
    
    private func onDrag(_ value: DragGesture.Value) {
        let dy = value.translation.height
        if dy >= 0.0 {
            offsetY = dy/2
            scale = 1 - ((dy/deviceHeight)/10)
            opacity = 1 - (dy/deviceHeight)
        }
    }
    
    private func onDragEnded(_ value: DragGesture.Value){
        let dy = value.translation.height
        
        if dy >= 0.0 {
            if dy <= deviceHeight / 10 {
                withAnimation {
                    offsetY = 0.0
                    scale = 1.0
                    opacity = 1.0
                }
            }else{
                allow3DRotation = false
                if !allow3DRotation{
                    isInternalShown = false
                    DispatchQueue.main.async{
                        withAnimation(.spring(duration: 0.2)){
                            showStory = false
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.4){
                    offsetY = 0.0
                    scale = 1.0
                    opacity = 1.0
                }
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
