//
//  branchDataModel.swift
//  BanhaRestaurant
//
//  Created by Shimaa Elcc on 4/24/18.
//  Copyright © 2018 Shimaa Elcc. All rights reserved.
//

import Foundation
class branchDataModel {
    var name: String?
    var details: String?
    var phone : Int?
    var lang : Float?
    var lat : Float?

    init( name: String? , details : String? , phone : Int? ){
        self.name = name
        self.details = details
        self.phone = phone
    }
}
