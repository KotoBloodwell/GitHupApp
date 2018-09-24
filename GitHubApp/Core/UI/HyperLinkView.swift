//
//  HyperLinkVIew.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 23/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

import UIKit

class HyperLinkVIew: UIView {
    
    private var _hyperLink: String?
    
    @IBInspectable
    var hyperLink: String? {
        get {
            return _hyperLink
        }
        set {
            if let newLink = newValue {
                _hyperLink = newLink
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addHyperLinkTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addHyperLinkTapGesture()
    }
    
    private func addHyperLinkTapGesture(){
        let hyperLinkTapGesture = UITapGestureRecognizer(target: self, action: #selector(animateTapAndHold))
        self.addGestureRecognizer(hyperLinkTapGesture)
    }
    
    private func openHyperLink(){
        if let hyperLink = _hyperLink {
            let url = URL(string: hyperLink)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc private func animateTapAndHold(){
        let previousBackground = self.backgroundColor
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundColor = UIColor.lightGray
            self.changeInnerLabelColorText(in: self, with: UIColor.white)
        }) { _ in
            self.backgroundColor = previousBackground
            self.changeInnerLabelColorText(in: self, with: UIColor.lightGray)
            self.openHyperLink()
        }
    }
    
    private func changeInnerLabelColorText(in view: UIView, with uiColor: UIColor) {
        for subview in view.subviews {
            if let label = subview as? UILabel {
                label.textColor = uiColor
            }
        }
    }
}
