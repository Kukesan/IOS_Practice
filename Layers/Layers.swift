//
//  Layers.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-27.
//

import Foundation

enum LayerOptions{
    case layer1
    case layer2
    case layer3
    case layer4
    case layer5
    case layer6
    case layer7
    
    var imageName:String{
        switch self{
        case .layer1:
            return "layer1"
        case .layer2:
            return "layer2"
        case .layer3:
            return "layer3"
        case .layer4:
            return "layer4"
        case .layer5:
            return "layer5"
        case .layer6:
            return "layer6"
        case .layer7:
            return "layer7"
        }
    }
}
