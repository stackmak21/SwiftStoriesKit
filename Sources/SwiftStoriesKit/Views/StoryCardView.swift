//
//  StoryCardView.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 20/3/25.
//

import Foundation
import SwiftUI

struct StoryCardView: View {
    
    @Binding var selectedStoryBundleID: String
    @Binding var timerProgress: CGFloat
    @Binding var allow3DRotation: Bool
    
    @Binding var isInternalShown: Bool
    
    let storyBundle: StoryBundle
    let thumbnailNamespace: Namespace.ID
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                let index = min(Int(timerProgress), storyBundle.stories.count - 1)
                ImageLoaderRect(url: storyBundle.stories[index].imageURL)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .onAppear{ resetTimer() }
                ZStack{
                    VStack(spacing: 0){
                        StoryTimeProgressBar(timerProgress: $timerProgress, story: storyBundle)
                        thumbnailNameSection(story: storyBundle)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .rotation3DEffect(allow3DRotation ? getAngle(proxy: geo) : .zero , axis: (x:0, y:1, z:0), anchor: geo.frame(in: .global).minX > 0 ? .leading : .trailing, perspective: 0.5)
        }
    }
    
    @ViewBuilder
    func thumbnailNameSection(story: StoryBundle) -> some View{
        if isInternalShown{
            ImageLoaderCircle(url: story.previewUrl)
                .frame(width: 60, height: 60)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal)
        }
    }
    
    private func getAngle(proxy: GeometryProxy) -> Angle {
        let progress = proxy.frame(in: .global).minX / proxy.size.width
        let rotationAngle: CGFloat = 75
        let degrees = rotationAngle * progress
        return Angle(degrees: Double(degrees))
    }
    
    private func resetTimer(){
        timerProgress = 0
    }
}


#Preview {
    StoryCardView(
        selectedStoryBundleID: .constant("12345"),
        timerProgress: .constant(CGFloat(2)),
        allow3DRotation: .constant(true),
        isInternalShown: .constant(true),
        storyBundle: DeveloperPreview.story,
        thumbnailNamespace: Namespace().wrappedValue
    )
}
