//
//  Lessons.swift
//  Practice1
//
//  Created by Ketheeswaran Kukesan on 2023-04-26.
//

import Foundation

public enum LessonCategories : CaseIterable {
    case horizontalLine
    case verticalLine
    case curvedLine
    case circularSpiral
    case rectangularSpiral
    case freehandDrawing
    case drawingExercise
    case drawLighthouse
    
    var name : String {
        switch self{
        case .horizontalLine : return "Horizontal Line"
        case .verticalLine : return "Vertical Line"
        case .curvedLine : return "Curved Line"
        case .circularSpiral : return "Circular Spiral"
        case .rectangularSpiral : return "Rectangle Spiral"
        case .freehandDrawing : return "Free Hand Drawing"
        case .drawingExercise : return "Drawing Exercise"
        case .drawLighthouse : return "Draw Light House"
        }
    }
}
