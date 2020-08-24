//
//  NavigationBarExtension.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/22/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import UIKit

extension UINavigationController {
    func addBackgroundImage() {
        let imageContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        let imageView = UIImageView(image: R.image.finchStation())
        imageView.contentMode = .scaleAspectFit
        imageContainer.addSubview(imageView)
        navigationItem.titleView = imageView
    }
}
