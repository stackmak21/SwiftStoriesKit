//
//  StoryFullScreenViewer.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 31/3/25.
//

import SwiftUI

public struct StoryFullScreenViewer: View {
    
    @Binding var storiesBundle: [StoryBundle]
    
    @State var animationDebounce: Bool = false
    
    @State private var offsetY: CGFloat = 0
    @State private var scale: CGFloat = 1
    @Binding var opacity: Double
    
    @State var isTimerPaused: Bool = false
    
    @State var isStoryTransitioning: Bool = false
    
    
    
    @Binding var showStory: Bool
    @Binding var isInternalThumbnailShown: Bool
    @Binding var selectedStory: String
    
    @Binding var timerProgress: CGFloat

    var thumbnailNamespace: Namespace.ID
    var storyNamespace: Namespace.ID
    
    private let deviceHeight: Double = UIScreen.self.main.bounds.height
    
    @State var timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    
    
    public var body: some View {
        ZStack {
            ZStack{
                TabView(selection: $selectedStory) {
                    ForEach(storiesBundle) { story in
                        GeometryReader { geo in
                            StoryContentView(
                                story: story,
                                geo: geo,
                                isInternalThumbnailShown: $isInternalThumbnailShown,
                                timerProgress: $timerProgress
                            )
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                    if let bundleIndex = storiesBundle.firstIndex(where: {$0.id == selectedStory}){
                                        if selectedStory == story.id{
                                                storiesBundle[bundleIndex].stories[story.currentStoryIndex].storyShowed()
                                        }
                                    }
                                    
                                }
                            }
                            .tag(story.id)
                            .onTapGesture(coordinateSpace: .global){ actionBasedOnTapLocation($0, geo, story)}
                            .onChange(of: geo.frame(in: .global).minX){ minX in
                                if minX != 0{
                                    isTimerPaused = true
                                }else{
                                    isTimerPaused = false
                                    
                                        if let bundleIndex = storiesBundle.firstIndex(where: {$0.id == selectedStory}){
                                            if bundleIndex < storiesBundle.count - 1 {
                                                storiesBundle[bundleIndex + 1].storyTimer = CGFloat(storiesBundle[bundleIndex + 1].currentStoryIndex)
                                            }
                                            if bundleIndex > 0 {
                                                storiesBundle[bundleIndex - 1].storyTimer = CGFloat(storiesBundle[bundleIndex - 1].currentStoryIndex)
                                            }
                                        }
                                    
                                }
                            }
                            .rotation3DEffect(isInternalThumbnailShown ? getAngle(proxy: geo) : .zero , axis: (x:0, y:1, z:0), anchor: geo.frame(in: .global).minX > 0 ? .leading : .trailing, perspective: 0.5)
                        }
                    }
                }
                .disabled(animationDebounce)
                .matchedGeometryEffect(id: isInternalThumbnailShown ? "" : selectedStory , in: storyNamespace)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle())
                .animation(.spring(duration: 0.1), value: selectedStory)
                .onChange(of: selectedStory) { storyID in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                        animationDebounce = false
                    }
                }
                
            }
            if showStory && !isInternalThumbnailShown{
                if let story = storiesBundle.first(where: { $0.id == selectedStory}){
                    ImageLoaderCircle(url: story.previewUrl)
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
        .onReceive(timer) { _ in
            
            if !animationDebounce{
                
                if !isTimerPaused{
                    if let bundleIndex = storiesBundle.firstIndex(where: {$0.id == selectedStory}){
                        let storyBundle = storiesBundle[bundleIndex]
                        if storiesBundle[bundleIndex].storyTimer < CGFloat(storyBundle.stories.count){
                            storiesBundle[bundleIndex].updateTimer()
                            let storyIndex = min(Int(storiesBundle[bundleIndex].storyTimer), storyBundle.stories.count)
                            if storyBundle.currentStoryIndex != storyIndex{
                                storiesBundle[bundleIndex].goToNextStory(with: storyIndex)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                        storiesBundle[bundleIndex].stories[storiesBundle[bundleIndex].currentStoryIndex].storyShowed()
                                }
                            }
                            
                        }
                        else{
                            if let index = storiesBundle.firstIndex(where: { $0.id == selectedStory }){
                                if !animationDebounce{
                                    if index < storiesBundle.count - 1{
                                        animationDebounce = true
                                        selectedStory = storiesBundle[index + 1].id
                                        storiesBundle[bundleIndex].storyTimer = CGFloat(storiesBundle[bundleIndex].currentStoryIndex)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                                storiesBundle[bundleIndex].stories[storiesBundle[bundleIndex].currentStoryIndex].storyShowed()
                                        }
                                    }else{
                                        closeStoryViewer()
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    private func actionBasedOnTapLocation(_ location: CGPoint, _ geo: GeometryProxy, _ story: StoryBundle){
        if !animationDebounce{
            if let index = storiesBundle.firstIndex(where: { $0.id == selectedStory }){
                let goForward = location.x >= geo.size.width / 2
                if goForward{
                    if story.currentStoryIndex < story.stories.count - 1 {
                        storiesBundle[index].goToNextStory()
                        storiesBundle[index].storyTimer = CGFloat(storiesBundle[index].currentStoryIndex)
                        storiesBundle[index].stories[story.currentStoryIndex].storyShowed()
                    }
                    else{
                        if index < storiesBundle.count - 1{
                            animationDebounce = true
                            selectedStory = storiesBundle[index + 1].id
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                storiesBundle[index].storyTimer = CGFloat(storiesBundle[index].currentStoryIndex)
                            }
                        }else{
                            closeStoryViewer()
                        }
                    }
                }
                if !goForward{
                    if story.currentStoryIndex > 0 {
                        storiesBundle[index].goToPreviousStory()
                        storiesBundle[index].storyTimer = CGFloat(storiesBundle[index].currentStoryIndex)
                    }else{
                        if index == 0 {
                            closeStoryViewer()
                        }else{
                            animationDebounce = true
                            selectedStory = storiesBundle[index - 1].id
                            storiesBundle[index].storyTimer = CGFloat(storiesBundle[index].currentStoryIndex)
                            
                        }
                    }
                }
            }
        }
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
        
        if dy < 0{
            isTimerPaused = false
        }
        if dy >= 0.0 {
            if dy <= deviceHeight / 10 {
                withAnimation {
                    offsetY = 0.0
                    scale = 1.0
                    opacity = 1.0
                }
            }else{
                closeStoryViewer()
            }
        }
    }
    
    private func closeStoryViewer(){
        if let bundleIndex = storiesBundle.firstIndex(where: {$0.id == selectedStory}){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                storiesBundle[bundleIndex].resetTimeToCurrentIndex()
            }
        }
        isInternalThumbnailShown = false
        DispatchQueue.main.async{
            withAnimation(.spring(duration: 0.16)){
                showStory = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            offsetY = 0.0
            scale = 1.0
            opacity = 1.0
        }
    }
    
    private func getAngle(proxy: GeometryProxy) -> Angle {
        let progress = proxy.frame(in: .global).minX / proxy.size.width
        let rotationAngle: CGFloat = 75
        let degrees = rotationAngle * progress
        return Angle(degrees: Double(degrees))
    }
}


#Preview {
    StoryFullScreenViewer(
        storiesBundle: .constant(DeveloperPreview.stories),
        opacity: .constant(1),
        showStory: .constant(true),
        isInternalThumbnailShown: .constant(true),
        selectedStory: .constant(""),
        timerProgress: .constant(2.5),
        thumbnailNamespace: Namespace().wrappedValue,
        storyNamespace: Namespace().wrappedValue
    )
}
