//
//  ViewModel.swift
//  IDM362-vidhi
//
//  Created by Vidhi Shah  on 3/4/25.
//

import Foundation

class CalendarViewModel: ObservableObject {
    @Published var moodEntries: [MoodEntry] = []

    func loadMoodEntries() {
        // Your existing load logic for mood entries
        print("Loaded mood entries in ViewModel")
    }
}
