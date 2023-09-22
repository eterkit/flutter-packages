//
//  DateConverter.swift
//  health_flutter
//
//  Created by Marc Sanny HTD on 22/09/2023.
//

extension Date {
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
