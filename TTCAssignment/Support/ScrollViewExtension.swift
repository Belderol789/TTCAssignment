//
//  ScrollViewExtension.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/23/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(self.contentOffset.x + self.frame.width)
        self.moveToFrame(contentOffset: contentOffset)
    }
    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.frame.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    fileprivate func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x: contentOffset, y: self.contentOffset.y , width: self.frame.width, height: self.frame.height)
        self.scrollRectToVisible(frame, animated: true)
    }
}
