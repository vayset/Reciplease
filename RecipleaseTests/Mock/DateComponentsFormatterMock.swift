//
//  DateComponentsFormatterMock.swift
//  RecipleaseTests
//
//  Created by Saddam Satouyev on 27/04/2021.
//

import Foundation

@testable import Reciplease

class DateComponentsFormatterMock: DateComponentsFormatterProtocol {
    var unitsStyle: DateComponentsFormatter.UnitsStyle = .abbreviated
    
    func string(for obj: Any?) -> String? {
        return nil
    }
    
}
