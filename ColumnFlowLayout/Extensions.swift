//
//  Created by Pierluigi Cifani on 20/09/2018.
//  Copyright © 2018 The Left Bit. All rights reserved.
//

import UIKit

extension UILabel {
    
    public static func unlimitedLinesLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
}

extension UIView {
    public func addAutolayoutSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    public func roundCorners(radius: CGFloat = 10) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    @discardableResult
    public func pinToSuperview(withEdges edges: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        guard let superView = superview else { return [] }
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: edges.left),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -edges.right),
            topAnchor.constraint(equalTo: superView.topAnchor, constant: edges.top),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -edges.bottom)
        ]
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}

extension UIEdgeInsets {
    public init(uniform: CGFloat) {
        self.init()
        top = uniform
        left = uniform
        bottom = uniform
        right = uniform
    }
}

open class TextStyler {
    
    // https://gist.github.com/zacwest/916d31da5d03405809c4
    
    public static let styler = TextStyler()
    public init() {}
    open var preferredFontName: String?
    
    open func attributedString(_ string: String, color: UIColor? = nil, forStyle style: UIFont.TextStyle = .body) -> NSAttributedString {
        
        var attributes: [NSAttributedString.Key : Any] = [
            .font: fontForStyle(style)
        ]
        
        if let color = color {
            attributes[.foregroundColor] = color
        }
        
        return NSMutableAttributedString(string: string, attributes: attributes)
    }
    
    open func fontForStyle(_ style: UIFont.TextStyle) -> UIFont {
        
        let systemFont = UIFont.preferredFont(forTextStyle: style)
        guard
            let preferredFontName = preferredFontName,
            let font = UIFont(name: preferredFontName, size: systemFont.pointSize) else {
                return systemFont
        }
        
        if #available(iOS 11.0, *) {
            let metrics = UIFontMetrics(forTextStyle: style)
            return metrics.scaledFont(for: font)
        } else {
            return font
        }
    }
}

public extension UIFont {
    
    var bolded: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: pointSize)
    }
}

public extension NSAttributedString {
    func modifyingFont(_ newFont: UIFont) -> NSAttributedString {
        let string = self.mutableCopy() as! NSMutableAttributedString
        let range = NSRange(location: 0, length: string.length)
        string.removeAttribute(.font, range: range)
        string.addAttribute(.font, value: newFont, range: range)
        return string
    }
    
    var bolded: NSAttributedString {
        let range = NSRange(location: 0, length: self.length)
        let font = self.attributes(at: 0, longestEffectiveRange: nil, in: range)[.font] as! UIFont
        return modifyingFont(font.bolded)
    }
}
