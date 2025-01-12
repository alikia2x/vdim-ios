//
//  Glow.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/12.
//

import SwiftUI

private struct GlowView<Content: View>: View {
    var content: Content
    var blurRadius: CGFloat = 8
    var opacity: Double = 0.5

    var body: some View {
        ZStack {
            content
                .blur(radius: blurRadius)
                .opacity(opacity)
            content
        }
    }
}

struct Glow<Content: View>: View {
    @ViewBuilder var content: () -> Content
    var blurRadius: CGFloat = 8
    var opacity: Double = 0.5

    var body: some View {
        GlowView(content: content(), blurRadius: blurRadius, opacity: opacity)
    }
}
