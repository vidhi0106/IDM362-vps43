//
//  CalendarView.swift
//  IDM362-vidhi
//
//  Created by Vidhi Shah  on 2/10/25.
//

//  CalendarView.swift
//  IDM362-vidhi
//
//  Created by Vidhi Shah  on 2/10/25.
//

import SwiftUI

struct CalendarView: View {
    let calendar = Calendar.current
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    
    @State private var selectedMonth = Date() // Stores the currently displayed month
    
    // Fake emotion log (Maps a date to an emoji/image name)
    let fakeEmotionLog: [String: String] = [
        "2025-02-02": "sparkly",
        "2025-02-03": "sunny",// Happy
        "2025-02-05": "cloudy", // Sad
        "2025-02-10": "pleasant", // Angry
        "2025-02-15": "stormy", // Tired
        "2025-02-20": "rainy" // Excited
    ]
    
    let emotionColors: [String: Color] = [
        "sparkly": Color("customRed"), // Happy
        "sunny": Color("customOrange"),
        "cloudy": Color("customBlue"), // Sad
        "pleasant": Color("customYellow"), // Angry
        "stormy": Color("customPink"), // Tired
        "rainy": Color("customPurple") // Excited
    ]

    var body: some View {
        NavigationStack {
            VStack {
                Text("MoodCloud")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .padding(10)
                    .foregroundStyle(Color("Color"))
                
                // Month Navigation
                HStack {
                    Button(action: { changeMonth(by: -1) }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.title)
                            .padding(10)
                            .tint(Color("Color"))
                            .imageScale(.large)
                    }
                    
                    Text(monthYearString(from: selectedMonth))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Color"))
                        .frame(width: 200)
                    
                    Button(action: { changeMonth(by: 1) }) {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.title)
                            .tint(Color("Color"))
                            .padding(10)
                            .imageScale(.large)
                    }
                }
                .padding()
                
                // Weekday Labels
                HStack {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color("Color"))
                    }
                }
                .padding(.bottom, 5)
                
                // Calendar Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                    ForEach(daysInMonth(), id: \.self) { day in
                        if let day = day {
                            let dateKey = dateString(from: day)
                            let emotion = fakeEmotionLog[dateKey]
                            let backgroundColor = emotion != nil ? emotionColors[emotion!] : Color("customGrey")
                            
                            VStack {
                                Text("\(calendar.component(.day, from: day))")
                                    .font(.caption)
                                    .foregroundStyle(Color.black)
                                
                                // Fixed space for mood emoji (empty if no mood is logged)
                                if let emotion = emotion {
                                    
                                    Image(emotion)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                    
                                } else {
                                    Text(" ") // Keeps layout intact
                                        .font(.title2)
                                        .frame(width: 50, height: 50)
                                }
                            }
                            .frame(width: 50, height: 80)
                            .background(backgroundColor)
                            .cornerRadius(10)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: 50, height: 80)
                        }
                    }
                }
                .frame(height: 500)
                .padding()
            }
            
            Spacer()
        }
    }
    
    // Function to generate an array of dates for the month
    func daysInMonth() -> [Date?] {
        let range = calendar.range(of: .day, in: .month, for: selectedMonth)!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedMonth))!
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth) - 1 // Adjust for 0-based index
        
        return Array(repeating: nil, count: firstWeekday) +
               range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: firstDayOfMonth) }
    }

    // Function to change months
    func changeMonth(by value: Int) {
        selectedMonth = calendar.date(byAdding: .month, value: value, to: selectedMonth)!
    }

    // Function to format month and year
    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    // Function to format a date into "YYYY-MM-DD"
    func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarView()
}
