//
//  StoryThumbnail.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//

import SwiftUI

public struct StoryThumbnailView: View {
    
    let story: StoryItemBundle
    let namespace: Namespace.ID
    let onLongPress: () -> Void
    let onClick: () -> Void
    
    public var body: some View {
        Circle()
            .foregroundStyle(Color.white.opacity(0.001))
            .overlay{
                GeometryReader{ geo in
                    Button(
                        action: { onClick() },
                        label: {
                            
                            ZStack{
                                Circle()
                                    .fill(Color.white.opacity(0.001))
                                    .overlay(
                                        Circle()
                                            .stroke(LinearGradient(colors: [.pink, .red, .orange], startPoint: .topTrailing, endPoint: .bottomLeading), lineWidth: 3)
                                    )
                                ImageLoader(url: story.previewUrl)
                                    .matchedGeometryEffect(id: story.id, in: namespace)
                                    .frame(width: geo.size.width - 6, height: geo.size.height - 6)
                                    .clipShape(Circle())
                            }
                            
                        }
                    )
                    .buttonStyle(StoryThumbnailButtonStyle(onLongPress: onLongPress))
                    
                }
            }
    }
}


#Preview {
    let story = StoryItemBundle(
        id: "1234",
        url: [
            "https://picsum.photos/800/1006",
            "https://picsum.photos/800/1007",
            "https://picsum.photos/800/1008"
        ],
        previewUrl: "https://picsum.photos/800/1009"
    )
    StoryThumbnailView(
        story: story,
        namespace: Namespace().wrappedValue,
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
                minimumDuration: 0.16,
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


