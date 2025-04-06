//
//  StoryHeaderView.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 31/3/25.
//

import SwiftUI

struct StoryHeaderView: View {
    
    let story: StoryBundle
    
    @Binding var isInternalThumbnailShown: Bool
    @Binding var timerProgress: CGFloat
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                StoryTimeProgressBar(timerProgress: $timerProgress, story: story)
                HStack(spacing: 0){
                    ZStack{
                        Group{
                            Circle()
                                .opacity(0.01)
                                .frame(width: 30, height: 30)
                            if isInternalThumbnailShown{
                                ImageLoaderCircle(url: story.previewUrl)
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding(.leading)
                        .padding(.trailing, 8)
                    }
                    Text("Paraskevas Makris")
                        .font(.system(size: 20))
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    StoryHeaderView(
        story: StoriesDeveloperPreview.story,
        isInternalThumbnailShown: .constant(true),
        timerProgress: .constant(2.4)
    )
}

