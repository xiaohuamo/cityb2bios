//
//  DeliveryDateTextViewModel.swift
//  CityB2B
//
//  Created by Fei Wang on 8/2/2023.
//

import Foundation
class DeliveryDateTextViewModel: ObservableObject {
        
    @Published var deliveryDateText: [DeliveryDateText]?
    
    @Published var user_temp_tokens: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjaXR5YjJiX21lbWJlcl9zeXN0ZW1faXNzIiwiYXVkIjoiY2l0eWIyYl9tZW1iZXJfc3lzdGVtX2F1ZCIsImlhdCI6MTY3NTA1OTk5MiwibmJmIjoxNjc1MDU5OTkyLCJleHAiOjE2Nzc2NTE5OTIsImRhdGEiOnsidWlkIjoyMTg4MTcxLCJidXNpbmVzc0lkIjowfX0.zcshlfh8pKVecMEHlUw3RA3ybkld5tZRdCPZVH5rjkA"
   

    //ALERTS
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    
    
    
}
