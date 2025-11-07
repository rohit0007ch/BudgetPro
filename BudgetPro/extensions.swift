//
//  extensions.swift
//  BudgetPro
//
//  Created by ROHIT on 06/10/25.
//

import UIKit
import ObjectiveC
@IBDesignable
extension UITextField {
    
    @IBInspectable var placeholderColor: UIColor? {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
        }
        set {
            guard let color = newValue, let placeholderText = placeholder else { return }
            attributedPlaceholder = NSAttributedString(
                string: placeholderText,
                attributes: [.foregroundColor: color]
            )
        }
    }
}


@IBDesignable
extension UIButton {

    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }

    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
}



@IBDesignable
class DesignableView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}


@IBDesignable
class DesignableTableViewCell: UITableViewCell {
    
    @IBInspectable var topSpacing: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable var bottomSpacing: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable var leftSpacing: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable var rightSpacing: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            contentView.layer.cornerRadius = cornerRadius
            contentView.layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffsetY: CGFloat = 0 {
        didSet {
            layer.shadowOffset = CGSize(width: 0, height: shadowOffsetY)
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Apply custom insets (spacing between cells)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: topSpacing, left: leftSpacing, bottom: bottomSpacing, right: rightSpacing))
    }
}


@IBDesignable
extension UITextField {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}



@IBDesignable
extension UISegmentedControl {
    
    // MARK: - Associated Object Keys
    private struct AssociatedKeys {
        static var fontName = "fontName"
        static var fontSize = "fontSize"
        static var fontWeightValue = "fontWeightValue"
        static var normalTextColor = "normalTextColor"
        static var selectedTextColor = "selectedTextColor"
        static var selectedBackgroundColor = "selectedBackgroundColor"
        static var cornerRadius = "cornerRadius"
    }

    // MARK: - Inspectable Properties (Computed)
    
    @IBInspectable var fontName: String {
        get { objc_getAssociatedObject(self, &AssociatedKeys.fontName) as? String ?? "System" }
        set { objc_setAssociatedObject(self, &AssociatedKeys.fontName, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC); updateFont() }
    }

    @IBInspectable var fontSize: CGFloat {
        get { objc_getAssociatedObject(self, &AssociatedKeys.fontSize) as? CGFloat ?? 14 }
        set { objc_setAssociatedObject(self, &AssociatedKeys.fontSize, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC); updateFont() }
    }

    @IBInspectable var fontWeightValue: CGFloat {
        get { objc_getAssociatedObject(self, &AssociatedKeys.fontWeightValue) as? CGFloat ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedKeys.fontWeightValue, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC); updateFont() }
    }

    @IBInspectable var normalTextColor: UIColor {
        get { objc_getAssociatedObject(self, &AssociatedKeys.normalTextColor) as? UIColor ?? .darkGray }
        set { objc_setAssociatedObject(self, &AssociatedKeys.normalTextColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC); updateColors() }
    }

    @IBInspectable var selectedTextColor: UIColor {
        get { objc_getAssociatedObject(self, &AssociatedKeys.selectedTextColor) as? UIColor ?? .white }
        set { objc_setAssociatedObject(self, &AssociatedKeys.selectedTextColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC); updateColors() }
    }

    @IBInspectable var selectedBackgroundColor: UIColor {
        get { objc_getAssociatedObject(self, &AssociatedKeys.selectedBackgroundColor) as? UIColor ?? .systemBlue }
        set { objc_setAssociatedObject(self, &AssociatedKeys.selectedBackgroundColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC); updateColors() }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get { objc_getAssociatedObject(self, &AssociatedKeys.cornerRadius) as? CGFloat ?? 8 }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.cornerRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }

    // MARK: - Update Functions
    
    private func updateFont() {
        let weight = UIFont.Weight(rawValue: fontWeightValue)
        
        var font: UIFont
        if fontName == "System" {
            font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        } else {
            font = UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: weight)
        }

        let normalAttrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: normalTextColor]
        let selectedAttrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: selectedTextColor]

        setTitleTextAttributes(normalAttrs, for: .normal)
        setTitleTextAttributes(selectedAttrs, for: .selected)
    }

    private func updateColors() {
        setTitleTextAttributes([.foregroundColor: normalTextColor], for: .normal)
        setTitleTextAttributes([.foregroundColor: selectedTextColor], for: .selected)
        selectedSegmentTintColor = selectedBackgroundColor
    }

    // MARK: - Live Interface Builder Preview
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateFont()
        updateColors()
    }
}
