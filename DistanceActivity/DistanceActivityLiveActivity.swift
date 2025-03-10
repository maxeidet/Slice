//
//  DistanceActivityLiveActivity.swift
//  DistanceActivity
//
//  Created by Max Eidet on 2025-01-30.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DistanceActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DistanceActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                HStack {
                    
                    Image("lkgk")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("Hole 1")
                        Text("Index 13 ")
                        Text("Par 4")
                    }
                    .font(.caption)
                    
                    
                    VStack {
                        HStack {
                            Image(systemName: "figure.golf")
                                .font(.title2)
                            Image(systemName: "arrow.right")
                                .font(.subheadline)
                        
                            Image(systemName: "flag.circle")
                                .font(.title2)
                           
                        }
                       
                        Text("Distance 234m")
                            .font(.subheadline)
                    }
                    .frame(width: 150)
                    
                    Spacer()
                }
                .padding()
            }
            .activityBackgroundTint(Color.white)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                }
                DynamicIslandExpandedRegion(.trailing) {
        
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        HStack {
                            Text("Hole \(context.state.holeNumber)")
                            Text("Par \(context.state.holeNumber)")
                            Text("HCP \(context.state.index)")
                               
                        }
                        HStack {
                            Image(systemName: "figure.golf")
                            Image(systemName: "arrow.right")
                            Image(systemName: "flag.circle")
                                .foregroundStyle(Color(.green))
                           
                        }
                        Text("Distance: \(context.state.distance) m")
                    }
                }
            } compactLeading: {
                Text("Distance")
            } compactTrailing: {
                Text("\(context.state.distance) m")
            } minimal: {
                /*
                Text("Slice")
                    .font(.footnote)
                 */
                Text("\(context.state.distance)")
            }
            //.widgetURL(URL(string: "http://www.apple.com"))
            //.keylineTint(Color.red)
        }
    }
}

// Preview Section
extension DistanceActivityAttributes {
    fileprivate static var preview: DistanceActivityAttributes {
        DistanceActivityAttributes(name: "Golf Game")
    }
}

extension DistanceActivityAttributes.ContentState {
    fileprivate static var exampleState: DistanceActivityAttributes.ContentState {
        DistanceActivityAttributes.ContentState(distance: 250, holeNumber: 3, par: 4, index: 7)
    }
}
/*
#Preview("Live Activity Preview", as: .content, using: DistanceActivityAttributes.preview) {
    DistanceActivityLiveActivity()
} contentStates: {
    DistanceActivityAttributes.ContentState.exampleState
}

struct LiveActivitiesPreviewProvider: PreviewProvider {
    static let activityAttributes = DistanceActivityAttributes(name: "Golf Game")
    
    static let state = DistanceActivityAttributes.ContentState(
        distance: 250,
        holeNumber: 3,
        par: 4,
        index: 7
    )
    
    static var previews: some View {
        Group {
            activityAttributes
                .previewContext(state, viewKind: .dynamicIsland(.compact))
                .previewDisplayName("Dynamic Island - Compact")
            
            activityAttributes
                .previewContext(state, viewKind: .dynamicIsland(.expanded))
                .previewDisplayName("Dynamic Island - Expanded")
            
            activityAttributes
                .previewContext(state, viewKind: .dynamicIsland(.minimal))
                .previewDisplayName("Dynamic Island - Minimal")
            
            activityAttributes
                .previewContext(state, viewKind: .content)
                .previewDisplayName("Lock Screen Notification")
        }
    }
}
 */
