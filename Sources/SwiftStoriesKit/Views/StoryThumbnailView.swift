//
//  StoryThumbnail.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//

import SwiftUI

public struct StoryThumbnailView: View {
    
    let story: StoryBundle
    let thumbnailNamespace: Namespace.ID
    let onLongPress: () -> Void
    let onClick: () -> Void
    
    public var body: some View {
        Button(
            action: { onClick() },
            label: {
                ZStack{
                    ImageLoaderCircle(url: story.previewUrl)
                        
                }
            }
        )
        .buttonStyle(StoryThumbnailButtonStyle(onLongPress: onLongPress))
    }
}


#Preview {
    
    StoryThumbnailView(
        story: DeveloperPreview.stories[0],
        thumbnailNamespace: Namespace().wrappedValue,
        onLongPress: {},
        onClick: {}
    )
    .frame(width: 100, height: 100)
}


struct StoryThumbnailButtonStyle: ButtonStyle{
    
    @State var isLongPressed: Bool = false
    let onLongPress: () -> Void
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .overlay {
                Circle()
                    .foregroundStyle(Color.gray.opacity(isLongPressed ? 0.2 : 0))
            }
            .onLongPressGesture(
                minimumDuration: 0.5,
                maximumDistance: 100,
                perform: {
                    isLongPressed = true
                    onLongPress()
                },
                onPressingChanged: {
                    if !$0 { isLongPressed = false }
                }
            )
            .scaleEffect(isLongPressed ? 0.94 : 1)
            .animation(.easeInOut(duration: 0.2), value: isLongPressed)
    }
}


