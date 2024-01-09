//
//  SideBar.swift
//  Practice1
//
//  Created by Ketheeswaran Kukesan  on 2023-05-16.
//

import Foundation

enum SideBarOptions :CaseIterable{
    case addButton
    case layerButton
    case lessonsButton
    case shapesButton
    case imagePickerButton
    case exportImageButton
    
    var buttonName : String{
        switch self {
        case .addButton:
            return "add"
        case .layerButton:
            return "layer-icon"
        case .lessonsButton:
            return "lesson"
        case .shapesButton:
            return "shapeIcon"
        case .imagePickerButton:
            return "image"
        case .exportImageButton:
            return "export"
        }
    }
}
