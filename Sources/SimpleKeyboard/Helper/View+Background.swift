//
//  View+Background.swift
//  
//
//  Created by Henrik Storch on 23.04.22.
//

import SwiftUI

public enum KeyboardTheme {
    case system, floating
}

protocol ThemeableView {
    var theme: KeyboardTheme { get }
}

#if canImport(UIKit)
import UIKit
#endif

extension View where Self: ThemeableView {
    var keyboardBackground: some View {
        if #available(iOS 15.0, macOS 12.0, *) {
            return AnyView(EmptyView().background(.ultraThinMaterial))
        } else {
            return AnyView(Color(PlatformColor.systemGray3.withAlphaComponent(0.75)))
        }
    }
}

extension ColorScheme {
    var keyboardKeyColor: Color {
        self == .dark ? .gray : .white
    }
}

#if canImport(UIKit)
import UIKit
typealias RectCorner = UIRectCorner
private typealias PlatformColor = UIColor
#else

#if canImport(AppKit)
import AppKit
private typealias PlatformColor = NSColor
extension NSColor { static var systemGray3: NSColor { NSColor.systemGray } }
#endif

public struct RectCorner : OptionSet {
    public var rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }

    public static var topLeft: RectCorner { RectCorner(rawValue: 1 << 0) }

    public static var topRight: RectCorner { RectCorner(rawValue: 1 << 1) }

    public static var bottomLeft: RectCorner { RectCorner(rawValue: 1 << 2) }

    public static var bottomRight: RectCorner { RectCorner(rawValue: 1 << 3) }

    public static var allCorners: RectCorner { [.topRight, .topLeft, .bottomLeft, .bottomRight] }
}
#endif

extension View {
    func cornerRadius(_ radius: CGFloat, corners: RectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

// https://stackoverflow.com/a/56763282/9506784
struct RoundedCorner: Shape {
    internal init(tl: CGFloat = 0.0, tr: CGFloat = 0.0, bl: CGFloat = 0.0, br: CGFloat = 0.0) {
        self.tl = tl
        self.tr = tr
        self.bl = bl
        self.br = br
    }

    init(radius: CGFloat, corners: RectCorner) {
        if corners.contains(.bottomLeft) {
            bl = radius
        }
        if corners.contains(.bottomRight) {
            br = radius
        }
        if corners.contains(.topLeft) {
            tl = radius
        }
        if corners.contains(.topRight) {
            tr = radius
        }
    }

    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)

        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        path.closeSubpath()

        return path
    }
}
