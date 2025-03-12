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
        
        // First check if we already have an entry for this date and replace it
        if let index = currentEntries.firstIndex(where: { $0.date == entry.date }) {
            currentEntries[index] = entry
        } else {
            currentEntries.append(entry)
        }
        
        if let encoded = try? JSONEncoder().encode(currentEntries) {
            UserDefaults.standard.set(encoded, forKey: moodKey)
            // Force synchronize to save immediately
            UserDefaults.standard.synchronize()
            print("Mood saved: \(entry)")
        }
    }
}

