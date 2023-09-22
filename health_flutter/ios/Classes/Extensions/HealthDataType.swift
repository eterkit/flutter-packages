//
//  HealthDataType.swift
//  health_flutter
//
//  Created by Marc Sanny HTD on 21/09/2023.
//

import Foundation
import HealthKit

@available(iOS 13.0, *)
extension HealthDataType {
    var toHealthKitType: HKSampleType {
        switch self {
        case .activeEnergyBurned: return HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!
        case .basalBodyTemperature: return HKSampleType.quantityType(forIdentifier: .basalBodyTemperature)!
        case .basalEnergyBurned: return HKSampleType.quantityType(forIdentifier: .basalEnergyBurned)!
        }
    }
    
    var healthKitUnit: HKUnit {
        switch self {
        case .activeEnergyBurned, .basalEnergyBurned: return HKUnit.kilocalorie()
        case .basalBodyTemperature: return HKUnit.degreeCelsius()
        }
    }
}

extension HKQuantitySample {
    func toJson(type: HealthDataType) -> [String : Any?] {
        return [
            "uuid": "\(self.uuid)",
            "type_index": type.rawValue,
            "value": self.quantity.doubleValue(for: type.healthKitUnit),
            "start_date_timestamp": self.startDate.millisecondsSince1970,
            "end_date_timestamp": self.startDate.millisecondsSince1970,
            "source": [
                "id": self.sourceRevision.source.bundleIdentifier,
                "name": self.sourceRevision.source.name,
            ],
            "device": [
                "name": self.device?.name,
                "mode": self.device?.model,
                "manufacturer": self.device?.manufacturer,
            ]
        ]
    }
}
