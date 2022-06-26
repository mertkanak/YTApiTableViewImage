//
//  HeroStats.swift
//  YTApiTableViewImage
//
//  Created by mert Kanak on 27.06.2022.
//

import Foundation

struct HeroStats: Decodable {
    
    let localized_name : String
    let primary_attr : String
    let attack_type : String
    let legs: Int
    let img : String
}
