//
//  moodEntry.swift
//  IDM362-vidhi
//
//  Created by Vidhi Shah  on 3/3/25.
//

import Foundation

struct MoodEntry: Identifiable,Codable {
    var id = UUID()
    let date: String
    let mood: String
    let notes: String
}
