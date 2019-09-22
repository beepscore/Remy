//
//  RemyBigButton.swift
//  
//
//  Created by Steve Baker on 9/22/19.
//

import UIKit

class RemyBigButton: UIButton {

    /// initializes programmatically
    override init (frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    /// initialize from storyboard or nib
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }

    func configure() {
        backgroundColor = .lightGray
        layer.cornerRadius = CGFloat(16.0)
    }
}
