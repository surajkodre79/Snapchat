//
//  AnimationView.swift
//  RaySnapchat
//
//  Created by Suraj Kodre on 26/11/18.
//  Copyright © 2018 Suraj Kodre. All rights reserved.
//

import UIKit

class AnimationView: UIView {
    @IBOutlet weak var cameraButtonViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraButtonViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraButtonViewBottomSpaceConstraint: NSLayoutConstraint!

    @IBOutlet weak var chatLeadingSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var discoverTrailingSpaceConstraint: NSLayoutConstraint!
    
    lazy var cameraButtonWidthConstraintConstant: CGFloat = {
        return self.cameraButtonViewWidthConstraint.constant
    }()
    
    lazy var cameraButtonHeightConstraintConstant: CGFloat = {
        return self.cameraButtonViewHeightConstraint.constant
    }()

    lazy var cameraButtonBottomConstraintConstant: CGFloat = {
        return self.cameraButtonViewBottomSpaceConstraint.constant
    }()
    
    lazy var chatSpaceConstraintConstant : CGFloat = {
        return self.chatLeadingSpaceConstraint.constant
    }()
    
    lazy var discoverSpaceConstraintConstant : CGFloat = {
        return self.discoverTrailingSpaceConstraint.constant
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(cameraButtonViewWidthConstraint)
    }
    
    func animation(to present: CGFloat) {
        let offset = abs(present)
        let finalWidthScale : CGFloat = cameraButtonWidthConstraintConstant * 0.2
        cameraButtonViewWidthConstraint.constant = cameraButtonWidthConstraintConstant - (finalWidthScale * offset)
        let finalHeightScale : CGFloat = cameraButtonHeightConstraintConstant * 0.2
        cameraButtonViewHeightConstraint.constant = cameraButtonHeightConstraintConstant - (finalWidthScale * offset)
        
        let finalDis : CGFloat = 30
        let dis = cameraButtonBottomConstraintConstant - finalDis
        cameraButtonViewBottomSpaceConstraint.constant = cameraButtonBottomConstraintConstant - (dis * offset)
        
        let Dis : CGFloat = 10
        let chatAndDiscoverDistance = chatSpaceConstraintConstant - Dis
        chatLeadingSpaceConstraint.constant = chatSpaceConstraintConstant + (chatAndDiscoverDistance * offset)
        discoverTrailingSpaceConstraint.constant = discoverSpaceConstraintConstant + (chatAndDiscoverDistance * offset)
        
        layoutIfNeeded()
    }
    
}
