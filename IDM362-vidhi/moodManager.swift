//
//  moodManager.swift
//  IDM362-vidhi
//
//  Created by Vidhi Shah  on 3/3/25.
//

import Foundation
import SwiftUI

class MoodDataManager {
    static let shared = MoodDataManager()
    private let moodKey = "moodEntries"
    
    // Retrieve saved moods
    func loadMoodEntries() -> [MoodEntry] {
        if let data = UserDefaults.standard.data(forKey: moodKey),
           let moodEntries = try? JSONDecoder().decode([MoodEntry].self, from: data) {
            return moodEntries
        }
        return []
    }
    
    // Save mood entry
    func saveMoodEntry(_ entry: MoodEntry) {
        var currentEntries = loadMoodEntries()
        currentEntries.append(entry)
        
        if let encoded = try? JSONEncoder().encode(currentEntries) {
            UserDefaults.standard.set(encoded, forKey: moodKey)
            print("Mood saved: \(entry)")  // Debugging print
        }
    }
}

