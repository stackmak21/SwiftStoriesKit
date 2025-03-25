//
//  SwiftUIView.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 18/3/25.
//

import SwiftUI

struct SwiftUIView: View {
    let stories: [StoryBundle] = DeveloperPreview.stories
    
    @Namespace private var thumbnailNamespace
    @Namespace private var storyNamespace
    
    @State private var selectedStory: String = ""
    @State private var showStory: Bool = false
    
    @State private var isInternalThumbnailShown: Bool = false

    @State private var offsetY: CGFloat = 0
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 1
    @State private var showInfo: Bool = false
    
    @State var allow3DRotation: Bool = false
    
    @State var timerProgress: CGFloat = 0
    
    private let deviceHeight: Double = UIScreen.self.main.bounds.height
    
    var body: some View {
        ZStack {
            
            StoryCarousel(
                storyBundles: stories,
                showStory: $showStory,
                isInternalThumbnailShown: $isInternalThumbnailShown,
                selectedStory: $selectedStory,
                thumbnailNamespace: thumbnailNamespace,
                storyNamespace: storyNamespace
            )
            
            // MARK: - Fullscreen Story Viewer
            Color.black.opacity(showStory ? opacity : 0).ignoresSafeArea()
            
            if showStory {
                
                    
                    StoryFullScreenViewer(
                        storyBundles: stories,
                        opacity: $opacity,
                        showStory: $showStory,
                        isInternalThumbnailShown: $isInternalThumbnailShown,
                        selectedStory: $selectedStory,
                        allow3DRotation: $allow3DRotation,
                        timerProgress: $timerProgress,
                        thumbnailNamespace: thumbnailNamespace,
                        storyNamespace: storyNamespace
                    )
                
            }
        }
        .animation(.spring(duration: 1.4), value: showStory)
    }
    

}

#Preview {
    SwiftUIView()
}








public struct StoryCarousel: View {
    
    let storyBundles: [StoryBundle]
    
    @Binding var showStory: Bool
    @Binding var isInternalThumbnailShown: Bool
    @Binding var selectedStory: String
    
    var thumbnailNamespace: Namespace.ID
    var storyNamespace: Namespace.ID
    
    public var body: some View {
        
            // MARK: - Thumbnail Section
            ScrollView(.horizontal, showsIndicators: false){
                VStack{
                    HStack {
                        ForEach(DeveloperPreview.stories) { story in
                            
                            ZStack{
                                Circle()
                                    .frame(width: 60, height: 60)
                                if !showStory  || selectedStory != story.id{
                                    StoryThumbnailItem(
                                        story: story,
                                        showStory: $showStory,
                                        isInternalThumbnailShown: $isInternalThumbnailShown,
                                        selectedStory: $selectedStory,
                                        thumbnailNamespace: thumbnailNamespace,
                                        storyNamespace: storyNamespace
                                    )
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
         
    }
}

struct StoryThumbnailItem: View {
    
    let story: StoryBundle
    
    @Binding var showStory: Bool
    @Binding var isInternalThumbnailShown: Bool
    @Binding var selectedStory: String
    
    var thumbnailNamespace: Namespace.ID
    var storyNamespace: Namespace.ID
    
    var body: some View {
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
            isInternalThumbnailShown = true
        }
        .onTapGesture {
            selectedStory = story.id
            DispatchQueue.main.asyncAfter(deadline: .now()){
                showStory = true
            }
        }
    }
}


struct StoryFullScreenViewer: View {
    
    let storyBundles: [StoryBundle]
    
    @State private var offsetY: CGFloat = 0
    @State private var scale: CGFloat = 1
    @Binding var opacity: Double
    
    
    
    @Binding var showStory: Bool
    @Binding var isInternalThumbnailShown: Bool
    @Binding var selectedStory: String
    @Binding var allow3DRotation: Bool
    
    @Binding var timerProgress: CGFloat

    var thumbnailNamespace: Namespace.ID
    var storyNamespace: Namespace.ID
    
    private let deviceHeight: Double = UIScreen.self.main.bounds.height
    
    var body: some View {
        ZStack {
            ZStack{
                TabView(selection: $selectedStory) {
                    ForEach(storyBundles) { story in
                        GeometryReader { geo in
                            StoryContentView(
                                story: story,
                                geo: geo,
                                isInternalThumbnailShown: $isInternalThumbnailShown,
                                timerProgress: $timerProgress
                            )
                            .rotation3DEffect(isInternalThumbnailShown ? getAngle(proxy: geo) : .zero , axis: (x:0, y:1, z:0), anchor: geo.frame(in: .global).minX > 0 ? .leading : .trailing, perspective: 0.5)
                            .tag(story.id)
                        }
                    }
                }
                .matchedGeometryEffect(id: selectedStory, in: storyNamespace)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            if showStory && !isInternalThumbnailShown{
                if let story = storyBundles.first(where: { $0.id == selectedStory}){
                    ImageLoader(url: story.previewUrl)
                        .matchedGeometryEffect(id: story.id, in: thumbnailNamespace)
                        .frame(width: 30, height: 30)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding()
                        .padding(.top, 6)
                }
            }
        }
        .transition(.scale(scale: 0.99))
        .offset(y: offsetY)
        .scaleEffect(scale)
        .gesture(
            DragGesture()
                .onChanged(onDrag)
                .onEnded(onDragEnded)
        )
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
                isInternalThumbnailShown = false
                DispatchQueue.main.async{
                    showStory = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    offsetY = 0.0
                    scale = 1.0
                    opacity = 1.0
                }
            }
        }
    }
    
    private func getAngle(proxy: GeometryProxy) -> Angle {
        let progress = proxy.frame(in: .global).minX / proxy.size.width
        let rotationAngle: CGFloat = 75
        let degrees = rotationAngle * progress
        return Angle(degrees: Double(degrees))
    }
}

struct StoryHeaderView: View {
    
    let story: StoryBundle
    
    @Binding var isInternalThumbnailShown: Bool
    @Binding var timerProgress: CGFloat
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                StoryTimeProgressBar(timerProgress: $timerProgress, story: story)
                if isInternalThumbnailShown{
                    ImageLoader(url: story.previewUrl)
                        .frame(width: 30, height: 30)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.horizontal)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}


struct StoryContentView: View {
    
    let story: StoryBundle
    
    let geo: GeometryProxy
    
    @Binding var isInternalThumbnailShown: Bool
    @Binding var timerProgress: CGFloat
    
    var body: some View {
        ZStack {
            ImageLoaderRect(url: story.previewUrl)
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
            StoryHeaderView(
                story: story,
                isInternalThumbnailShown: $isInternalThumbnailShown,
                timerProgress: $timerProgress
            )
        }
    }
}


public struct StoryTimeProgressBar: View {
    
    @Binding var timerProgress: CGFloat
    let story: StoryBundle
    
    public var body: some View {
        HStack(spacing: 0){
            ForEach(Array(story.stories.enumerated()), id: \.offset){ index, item in
                GeometryReader{ geo in
                    let width = geo.size.width
                    let progress = timerProgress - CGFloat(index)
                    let perfectProgress = min(max(progress, 0), 1)
                    Capsule()
                        .foregroundColor(Color.white.opacity(0.4))
                    
                    Capsule()
                        .foregroundColor(Color.white.opacity(1))
                        .frame(width: width * perfectProgress, alignment: .leading)
                }
                .padding(.trailing, story.stories.count - 1 != index ? 4 : 0 )
                .frame(height: 2)
            }
        }
        .padding(10)
    }
}
