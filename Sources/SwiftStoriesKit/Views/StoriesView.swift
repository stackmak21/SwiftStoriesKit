//
//  StoriesView.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//

import SwiftUI

public struct StoriesView: View {
    
    //    @EnvironmentObject var videoManager: VideoPlayerManager
    
    @State private var offsetY: CGFloat = 0
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 1
    @State private var showInfo: Bool = false
    
    @Binding var showStory: Bool
    @Binding var allow3dRotation: Bool
    @Binding var selectedStory: String
    
    let storiesList: [StoryItemBundle]
    let storyNamespace: Namespace.ID
    let storyThumbnailNamespace: Namespace.ID
    
    private let deviceHeight: Double = UIScreen.self.main.bounds.height
    
    public var body: some View {
        ZStack{
            
            Color.black.opacity(opacity).ignoresSafeArea()
            TabView(selection: $selectedStory){
                ForEach(storiesList){ story in
                    GeometryReader{ geo in
                        ZStack{
                            ImageLoader(url: story.previewUrl)
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipped()
//                            if showStory && story.id == selectedStory{
                                ImageLoader(url: story.previewUrl)
                                .matchedGeometryEffect(id: selectedStory == story.id ? story.id : "", in: storyThumbnailNamespace)
                                    .frame(width: 60, height: 60)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    .padding()
                                
//                             }
                        }
                        .tag(story.id)
                        .rotation3DEffect(allow3dRotation ? getAngle(proxy: geo) : .zero , axis: (x:0, y:1, z:0), anchor: geo.frame(in: .global).minX > 0 ? .leading : .trailing, perspective: 0.5)
                    }
                    // 3D Rotation. Disabling for Test.
//                    .onAppear{
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//                            allow3dRotation = true
//                        }
//                    }
                }
                
            }
            .matchedGeometryEffect(id: selectedStory, in: storyNamespace)
//            .transition(.scale(scale: 0.99))
            .tabViewStyle(.page(indexDisplayMode: .never))
            .offset(y: offsetY)
            .scaleEffect(scale)
            .gesture(
                DragGesture()
                    .onChanged(onDrag)
                    .onEnded(onDragEnded)
            )
            
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
                allow3dRotation = false
                if !allow3dRotation{
                    withAnimation(.interactiveSpring(duration: 0.2)){
                        showStory = false
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
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


#Preview {
    StoriesView(
        showStory: .constant(true),
        allow3dRotation: .constant(true),
        selectedStory: .constant(""),
        storiesList: DeveloperPreview.stories,
        storyNamespace: Namespace().wrappedValue,
        storyThumbnailNamespace:  Namespace().wrappedValue
    )
}
