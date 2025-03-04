////
////  moodLogged.swift
////  IDM362-vidhi
////
////  Created by Vidhi Shah  on 3/3/25.
////
//
//import SwiftUI
//
//struct moodLogged: View {
//    let moodName: String
//    let moodImage: String
//    let moodColor: Color
//    @State private var notes: String = ""
//    @Binding var selectedDate: Date // Binding for selected date
//
//    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject var navigationState: NavigationState
//
//    var body: some View {
//        VStack {
//            Text("You picked \(moodName)")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding()
//
//            Image(moodImage)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 250, height: 250)
//
//            Text("Add notes about your mood:")
//                .font(.headline)
//                .padding(.top)
//
//            // Increased height of input field
//            TextEditor(text: $notes)
//                .frame(height: 150) // Adjust height here
//                .cornerRadius(10)
//                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 2))
//                .padding()
//
//            Button("Done") {
//                // Create a new MoodEntry
//                let newMoodEntry = MoodEntry(date: dateString(from: selectedDate), mood: moodName, notes: notes)
//
//                // Save the entry
//                MoodDataManager.shared.saveMoodEntry(newMoodEntry)
//
//                // After saving, go back to CalendarView
//                navigationState.currentView = 0
//                presentationMode.wrappedValue.dismiss()
//            }
//            .font(.headline)
//            .foregroundColor(.black)
//            .padding()
//            .frame(width: 250)
//            .background(moodColor)
//            .cornerRadius(10)
//            .padding(.top)
//            
//            Spacer()
//        }
//        .background(moodColor.opacity(0.2).edgesIgnoringSafeArea(.all))
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                Text("MoodCloud")
//                    .font(.title)
//                    .multilineTextAlignment(.center)
//                    .fontWeight(.bold)
//                    .foregroundStyle(Color("Color"))
//            }
//
//            ToolbarItem(placement: .topBarLeading) {
//                Button(action: {}) {}.tint(Color("Color"))
//            }
//        }
//    }
//
//    // Function to format selectedDate into a string
//    func dateString(from date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter.string(from: date)
//    }
//}
//
//
//#Preview {
//    moodLogged()
//}
