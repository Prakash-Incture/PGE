//
//  UIView+Extension.swift
//  DORT
//
//  Created by Mahabaleshwar Hegde on 02/05/18.
//  Copyright © 2018 Murphy. All rights reserved.
//

import UIKit

extension UIView {
    enum BorderPosition: String {
        case none = "None"
        case left = "Left"
        case right = "Right"
        case top = "Top"
        case bottom = "Bottom"
        case fullBorder = "FullBorder"
    }

    /// Add borders to UIView based on position.
    func addBorder(at borderPositions: [BorderPosition] = [.fullBorder], borderColor: UIColor = .gray,
                   borderWidth: CGFloat = 1.0,
                   cornerRadius: CGFloat = 0.0,
                   opacity: Float = 1.0,
                   leftRightpadding: CGFloat = 0,
                   topBottomPadding: CGFloat = 0) {
        var muatableBorderPositions = borderPositions

        if borderPositions.contains(.none) { return }

        let borderName = "viewBorder"
        self.removeBorder()
        if borderPositions.contains(.fullBorder) {
            muatableBorderPositions = [.fullBorder]
        }

        for borderPosition in muatableBorderPositions {
            if borderPosition != .fullBorder {
                let border = CALayer()
                border.backgroundColor = borderColor.cgColor
                border.cornerRadius = cornerRadius
                border.masksToBounds = true
                border.name = borderName
                border.opacity = opacity
                border.masksToBounds = true
                border.drawsAsynchronously = true
                border.shouldRasterize = true
                border.rasterizationScale = UIScreen.main.scale

                switch borderPosition {
                case .top:
                    border.frame = CGRect(x: leftRightpadding, y: 0, width: self.bounds.size.width - (leftRightpadding * 2), height: borderWidth)
                case .bottom:
                    border.frame = CGRect(x: leftRightpadding, y: self.bounds.size.height - borderWidth, width: self.bounds.size.width - (leftRightpadding * 2), height: borderWidth)
                case .left:
                    border.frame = CGRect(x: 0, y: topBottomPadding, width: borderWidth, height: self.bounds.size.height - (topBottomPadding * 2))
                case .right:
                    border.frame = CGRect(x: self.bounds.size.width - borderWidth, y: 0, width: borderWidth, height: self.bounds.size.height)
                default:
                    break
                }
                self.layer.addSublayer(border)
            } else {
                self.layer.masksToBounds = true
                self.layer.shouldRasterize = true
                self.layer.rasterizationScale = UIScreen.main.scale
                self.layer.borderColor = borderColor.cgColor
                self.layer.borderWidth = borderWidth
                self.layer.cornerRadius = cornerRadius
            }
        }
    }

    func removeBorder(borderName: String = "viewBorder") {
        if let sublayers = self.layer.sublayers {
            let bottomLayer = sublayers.filter({ $0.name == borderName })
            bottomLayer.forEach({ $0.removeFromSuperlayer() })
        }
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func pushTransition(_ duration: CFTimeInterval) {
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }

    func addDashedBorder(name: String) {
        let color = UIColor.lightGray.cgColor

        let shapeLayer: CAShapeLayer = CAShapeLayer()
        shapeLayer.name = name

        // let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.frame = self.bounds
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6, 3]
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5).cgPath

        self.layer.addSublayer(shapeLayer)
    }
    
    convenience init(frame: CGRect, backgroundColor: UIColor) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
    }
    
    func addLabel(to view: UIView, message text: String, frame: CGRect? = nil) {
        let labelFrame = frame ?? CGRect(x: 16, y: 10, width: view.bounds.width * 0.65, height: 20)
        let descriptionLabel = UILabel(frame: labelFrame, backgroundColor: .clear)
        descriptionLabel.text = text
        self.addSubview(descriptionLabel)
    }
    
    func addSeparator(to view: UIView, at position: NSLayoutConstraint.Attribute = .top) {
        
        switch position {
        case .top:
            let topCustomSeperator = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1), backgroundColor: .lightGray)
            view.addSubview(topCustomSeperator)
        case .bottom:
            let bottomCustomSeperator = UIView(frame: CGRect(x: 0, y: view.bounds.maxY - 1, width: view.bounds.width, height: 1), backgroundColor: .lightGray)
            view.addSubview(bottomCustomSeperator)
        default:
            return
        }
    }
    
    func mask(withRect rect: CGRect, inverse: Bool = false) {
        let path = UIBezierPath(rect: rect)
        let maskLayer = CAShapeLayer()
        
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = .evenOdd
        }
        
        maskLayer.path = path.cgPath
        
        self.layer.mask = maskLayer
    }
    
    func mask(withPath path: UIBezierPath, inverse: Bool = false) {
        let path = path
        let maskLayer = CAShapeLayer()
        
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = .evenOdd
        }
        
        maskLayer.path = path.cgPath
        
        self.layer.mask = maskLayer
    }
}

protocol ShapeConverter {
    func circular()
}

extension ShapeConverter where Self: UIView {
    func circular() {
        self.layer.cornerRadius = self.frame.width / 2.0
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}

extension UIView: ShapeConverter {}

extension UIView {
    class func fromNib<T: NibInitializable>() -> T {
        return Bundle.main.loadNibNamed(T.nibName, owner: nil, options: nil)![0] as! T
    }
}

protocol NibInitializable: class {
    static var nib: UINib { get }
    static var nibName: String { get }
}

extension NibInitializable {
    static var nib: UINib {
        return UINib(nibName: Self.nibName, bundle: nil)
    }

    static var nibName: String {
        return String(describing: self)
    }
}

extension UIView: NibInitializable {}


extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

extension UIApplication { func makeSnapshot() -> UIImage? { return keyWindow?.layer.makeSnapshot() } }

extension CALayer {
    func makeSnapshot() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
}

extension UIView {
    func makeSnapshot() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: frame.size)
            return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
        } else {
            return layer.makeSnapshot()
        }
    }
}

extension UIImage {
    convenience init?(snapshotOf view: UIView) {
        guard let image = view.makeSnapshot(), let cgImage = image.cgImage else { return nil }
        self.init(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
}
