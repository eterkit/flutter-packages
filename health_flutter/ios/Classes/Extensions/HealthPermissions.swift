//
//  PermissionType.swift
//  health_flutter
//
//  Created by Marc Sanny HTD on 21/09/2023.
//

import Foundation
import HealthKit

extension [HealthPermission] {
    var toRead: Set<HKSampleType> {
        return Set(self.compactMap {
            return $0.permissionType.isRead ? $0.dataType.toHealthKitType : nil
        })
    }
    
    var toShare: Set<HKSampleType> {
        return Set(self.compactMap {
            return $0.permissionType.isShare ? $0.dataType.toHealthKitType : nil
        })
    }
}

private extension PermissionType {
    /// Whether permission request is to read data only.
    var isRead: Bool {
        return self == PermissionType.read
    }
    
    /// Whether permission request is to share data.
    var isShare: Bool {
        return self == PermissionType.write || self == PermissionType.readWrite
    }
}
