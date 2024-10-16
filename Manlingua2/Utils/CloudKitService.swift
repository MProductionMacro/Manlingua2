//
//  CloudKitService.swift
//  Manlingua2
//
//  Created by Paulus Michael on 13/10/24.
//

import CloudKit

class CloudKitService: ObservableObject {
   @Published var isSignedIntoCloud: Bool = false
   @Published var error: String = ""
   
   init() {
      getCloudKitStatus()
   }
   
   func getCloudKitStatus(){
      CKContainer.default().accountStatus { [weak self] status, error in
         DispatchQueue.main.async {
            switch status {
            case .available:
               self?.isSignedIntoCloud = true
            case .noAccount:
               self?.error = CloudKitError.iCloudAccountNotFound.rawValue

            case .restricted:
               self?.error = CloudKitError.iCloudAccountRestricted.rawValue

            case .couldNotDetermine:
               self?.error = CloudKitError.iCloudAccountUnknown.rawValue

            case .temporarilyUnavailable:
               self?.error = CloudKitError.iCloudAccountUnknown.rawValue
               
            @unknown default:
               break
            }
         }
      }
   }
   
   enum CloudKitError: String, LocalizedError {
      case iCloudAccountNotFound
      case iCloudAccountNotDetermined
      case iCloudAccountRestricted
      case iCloudAccountUnknown
   }
}
