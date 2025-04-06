//
//  StoryTimeProgressBar.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 31/3/25.
//

import SwiftUI

public struct StoryTimeProgressBar: View {
    
    @Binding var timerProgress: CGFloat
    let story: StoryBundle
    
    public var body: some View {
        HStack(spacing: 0){
            ForEach(Array(story.stories.enumerated()), id: \.offset){ index, item in
                GeometryReader{ geo in
                    let width = geo.size.width
                    let progress = story.storyTimer - CGFloat(index)
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


#Preview {
    StoryTimeProgressBar(
        timerProgress: .constant(2.4),
        story: StoriesDeveloperPreview.story
    )
}
