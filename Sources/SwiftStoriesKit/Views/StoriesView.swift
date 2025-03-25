//
//  StoriesView.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//

import SwiftUI

public struct StoriesView: View {
    
    @State private var offsetY: CGFloat = 0
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 1
    @State private var showInfo: Bool = false
    
    
    
    @Binding var showStory: Bool
    @Binding var allow3DRotation: Bool
    @Binding var selectedStoryBundleID: String
    
    @Binding var isInternalShown: Bool
    
    let storiesList: [StoryBundle]
    let storyNamespace: Namespace.ID
    let thumbnailNamespace: Namespace.ID
    
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var timerProgress: CGFloat = 0
    
    private let deviceHeight: Double = UIScreen.self.main.bounds.height
    
    public var body: some View {
        ZStack{
            Color.black.opacity(opacity).ignoresSafeArea()
            ZStack{
                ZStack{
                    TabView(selection: $selectedStoryBundleID){
                        ForEach(storiesList){ storyBundle in
                            StoryCardView(
                                selectedStoryBundleID: $selectedStoryBundleID,
                                timerProgress: $timerProgress,
                                allow3DRotation: $allow3DRotation,
                                isInternalShown: $isInternalShown,
                                storyBundle: storyBundle,
                                thumbnailNamespace: thumbnailNamespace
                            )
                            .tag(storyBundle.id)
                        }
                    }
                    .matchedGeometryEffect(id: selectedStoryBundleID, in: storyNamespace)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                            allow3DRotation = true
                        }
                    }
                }
                if showStory && !isInternalShown{
                    if let story = DeveloperPreview.stories.first(where: { $0.id == selectedStoryBundleID}){
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
        .onReceive(timer) { _ in
            guard let story =  storiesList.first(where: { $0.id == selectedStoryBundleID}) else { return }
            if timerProgress < CGFloat(story.stories.count) {
                withAnimation {
                    timerProgress += 0.1
                }
            }else{
                updateStory()
            }
        }
        .animation(.spring(duration: 1), value: showStory)
    }
    
    
    
    
    
    
    
    
    
    
    private func resetTimer(){
        timerProgress = 0
    }
    
    private func updateStory(forward: Bool = true){
        guard let storyBundle =  storiesList.first(where: { $0.id == selectedStoryBundleID}) else { return }
        let index = min(Int(timerProgress), storyBundle.stories.count - 1)
        let story = storyBundle.stories[index]
        if let last = storyBundle.stories.last, last.id == story.id{
            if let lastBundle = storiesList.last, lastBundle.id == storyBundle.id{
                withAnimation {
                    showStory = false
                }
                resetTimer()
            }
            else{
                let storyBundleIndex = storiesList.firstIndex(where: { $0.id == selectedStoryBundleID }) ?? 0
                
                
                selectedStoryBundleID = storiesList[storyBundleIndex + 1].id
                
                
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
                        withAnimation(.spring(duration: 1)){
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
    StoriesView(
        showStory: .constant(true),
        allow3DRotation: .constant(true),
        selectedStoryBundleID: .constant("12345"),
        isInternalShown: .constant(true),
        storiesList: DeveloperPreview.stories,
        storyNamespace: Namespace().wrappedValue,
        thumbnailNamespace:  Namespace().wrappedValue
    )
}
