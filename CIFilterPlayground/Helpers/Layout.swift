//
//  Layout.swift
//  CIFilterPlayground
//
//  Created by Egor Butyrin on 06.04.2022.
//

import UIKit

final class VSpacer: UIView {
  init(height: CGFloat) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension UIView {
  func pinSubview(_ subview: UIView, edges: UIRectEdge = .all, insets: UIEdgeInsets = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    subview.translatesAutoresizingMaskIntoConstraints = false
    if !subviews.contains(subview) {
      addSubview(subview)
    }
    var constraints: [NSLayoutConstraint] = []
    if edges.contains(.top) {
      constraints.append(subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top))
    }
    if edges.contains(.left) {
      constraints.append(subview.leftAnchor.constraint(equalTo: leftAnchor, constant: insets.left))
    }
    if edges.contains(.bottom) {
      constraints.append(subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom))
    }
    if edges.contains(.right) {
      constraints.append(subview.rightAnchor.constraint(equalTo: rightAnchor, constant: -insets.right))
    }
    NSLayoutConstraint.activate(constraints)
  }

  func centerHorizontallyInContainer(offset: CGFloat = 0) {
    guard let superview = superview else { return }

    translatesAutoresizingMaskIntoConstraints = false
    superview.translatesAutoresizingMaskIntoConstraints = false

    centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset).isActive = true
  }

  func centerVerticallyInContainer(offset: CGFloat = 0) {
    guard let superview = superview else { return }

    translatesAutoresizingMaskIntoConstraints = false
    superview.translatesAutoresizingMaskIntoConstraints = false

    centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset).isActive = true
  }

  func constrainWidth(_ toWidth: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: toWidth).isActive = true
  }

  func constrainHeight(_ toHeight: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: toHeight).isActive = true
  }

  func constrainSize(_ toSize: CGSize) {
    constrainWidth(toSize.width)
    constrainHeight(toSize.height)
  }
}

extension UILayoutGuide {
  func pinSubview(_ subview: UIView) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subview.topAnchor.constraint(equalTo: topAnchor),
      subview.leftAnchor.constraint(equalTo: leftAnchor),
      subview.bottomAnchor.constraint(equalTo: bottomAnchor),
      subview.rightAnchor.constraint(equalTo: rightAnchor),
    ])
  }
}

extension CGSize {
    static func square(_ dimensions: CGFloat) -> CGSize {
        CGSize(width: dimensions, height: dimensions)
    }
}
