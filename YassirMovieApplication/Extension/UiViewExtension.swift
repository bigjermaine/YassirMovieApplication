//
//  UiViewExtension.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 23/06/2024.
//

import Foundation
import UIKit

struct constants {
    static let corneRadius:CGFloat = 10.0
}


extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
        
    }
    public var height: CGFloat {
        return frame.size.height
        
    }
    public var top: CGFloat {
        return frame.origin.y
        
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
        
    }
    
    
    public var left: CGFloat {
        return frame.origin.x
        
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
        
    }
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
}
