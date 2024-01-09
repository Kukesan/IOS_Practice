//
//  Export.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-20.
//

import Foundation


public enum ExportTypes: CaseIterable {
    case saveToDevice
    case exportToPSD
    case exportToPNG
    case googleClassRoom
    case messanger
    case facebook
    case email
    case twitter
    case print
    case continues
    
    var descriptions : String {
        switch self{
            case .saveToDevice: return "Save to Device"
            case .exportToPSD: return "Export as PSD"
            case .exportToPNG: return "Export as PNG"
            case .googleClassRoom: return "Google Class Room"
            case .messanger: return "Messanger"
            case .facebook: return "Facebook"
            case .email: return "Email"
            case .twitter: return "Twitter"
            case .print: return "Print"
            case .continues: return "Continue"
        }
    }
}
