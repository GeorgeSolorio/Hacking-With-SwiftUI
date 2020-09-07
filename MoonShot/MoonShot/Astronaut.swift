//
//  Astronauts.swift
//  MoonShot
//
//  Created by George Solorio on 9/6/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
