//
//  ColorExtension.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/18.
//

import SwiftUI

extension Color {
    init(hex: String) {
        @Environment(\.colorScheme) var colorScheme
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }

        var r: Double = 0
        var g: Double = 0
        var b: Double = 0
        var a: Double = 1.0

        switch hexSanitized.count {
        case 3:
            if let rgb = UInt64(hexSanitized, radix: 16) {
                r = Double((rgb >> 8) & 0xF) / 15.0
                g = Double((rgb >> 4) & 0xF) / 15.0
                b = Double(rgb & 0xF) / 15.0
            }
        case 4:
            if let rgba = UInt64(hexSanitized, radix: 16) {
                r = Double((rgba >> 12) & 0xF) / 15.0
                g = Double((rgba >> 8) & 0xF) / 15.0
                b = Double((rgba >> 4) & 0xF) / 15.0
                a = Double(rgba & 0xF) / 15.0
            }
        case 6:
            if let rgb = UInt64(hexSanitized, radix: 16) {
                r = Double((rgb >> 16) & 0xFF) / 255.0
                g = Double((rgb >> 8) & 0xFF) / 255.0
                b = Double(rgb & 0xFF) / 255.0
            }
        case 8:
            if let rgba = UInt64(hexSanitized, radix: 16) {
                r = Double((rgba >> 24) & 0xFF) / 255.0
                g = Double((rgba >> 16) & 0xFF) / 255.0
                b = Double((rgba >> 8) & 0xFF) / 255.0
                a = Double(rgba & 0xFF) / 255.0
            }
        default:
            break
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }
}
