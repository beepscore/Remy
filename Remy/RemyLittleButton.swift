//
//  RemyLittleButton.swift
//  Remy
//
//  Created by Steve Baker on 9/22/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import UIKit

class RemyLittleButton: UIButton {

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
        layer.cornerRadius = CGFloat(8.0)
    }

}
