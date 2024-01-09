//
//  Shapes.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-06.
//

import Foundation
import UIKit

struct Shape{
    var name : String
    internal init(name: String) {
        self.name = name
    }
}

var favouriteArray:[Shape] = []
let squareArray = [Shape(name: "square"),Shape(name: "square2"),Shape(name: "square3"),Shape(name: "square")]
let circleArray = [Shape(name: "circle1"),Shape(name: "circle2"),Shape(name: "circle3"),Shape(name: "circle2"),Shape(name: "circle4"),Shape(name: "circle1")]
let triangleArray = [Shape(name: "triangle2"),Shape(name: "triangle1"),Shape(name: "triangle3"),Shape(name: "triangle1"),Shape(name: "triangle1"),Shape(name: "triangle2"),Shape(name: "triangle3"),Shape(name: "triangle1")]

public enum ShapeType : CaseIterable {
    case favourite
    case square
    case circle
    case triangle
    
    var shapeArray : [Shape] {
        switch self{
        case .favourite : return favouriteArray
        case .square : return squareArray
        case .circle : return circleArray
        case .triangle : return triangleArray
        }
    }
    
    var shapeTypeName : String {
        switch self{
        case .favourite : return "Favourite"
        case .square : return "Square"
        case .circle : return "Circle"
        case .triangle : return "Triangle"
        }
    }
}

