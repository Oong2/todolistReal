//
//  InstaView.swift
//  todolistreal1
//
//  Created by t2023-m0088 on 2023/09/18.
//

import UIKit
import SwiftUI
import UIKit

class InstaView: UIView {
    
    var imageName: String = "" {
        willSet {
            imageView.image = UIImage(named: newValue)
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()


}
