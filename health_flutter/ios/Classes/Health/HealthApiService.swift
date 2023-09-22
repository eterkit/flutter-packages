//
//  Health.swift
//  health_flutter
//
//  Created by Marc Sanny HTD on 21/09/2023.
//

import Foundation
import HealthKit

@available(iOS 13, *)
class HealthApiService: HealthApi {
    let healthStore = HKHealthStore()
    
    func checkAvailability() -> Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    
    func canRequestPermissions(permissions: [HealthPermission], completion: @escaping (Result<Bool, Error>) -> Void) {
        healthStore.getRequestStatusForAuthorization(toShare: permissions.toShare, read: permissions.toRead, completion: {
            (status, error) in DispatchQueue.main.async {
                let canRequestPermissions = status == HKAuthorizationRequestStatus.shouldRequest && error == nil;
                completion(.success(canRequestPermissions))
            }
        })
    }
    
    func requestPermissions(permissions: [HealthPermission], completion: @escaping (Result<Bool, Error>) -> Void) {
        healthStore.requestAuthorization(toShare: permissions.toShare, read: permissions.toRead, completion: {
            (didOpenedSettings, error) in DispatchQueue.main.async {
                completion(error == nil ? .success(didOpenedSettings) : .failure(error!))
            }
        })
    }
    
    func getDataForType(type: HealthDataType, startDateMillisecondsSinceEpoch: Int64, endDateMillisecondsSinceEpoch: Int64, completion: @escaping (Result<[[AnyHashable: Any?]], Error>) -> Void) {
        let startDate = Date(milliseconds: startDateMillisecondsSinceEpoch)
        let endDate = Date(milliseconds: endDateMillisecondsSinceEpoch)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: type.toHealthKitType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) {
            query, results, error in
            
            guard let samples = results as? [HKQuantitySample] else {
                if error != nil { completion(.failure(error!)) }
                return
            }
            
            for sample in samples {
                print(sample.toJson(type: type))
            }
            
            DispatchQueue.main.async {
                completion(.success(samples.map { $0.toJson(type: type) }))
            }
        }
        healthStore.execute(query)
    }
}
