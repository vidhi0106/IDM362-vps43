import SwiftUI

struct ContentView: View {
    let moods = [
        ("sparkly", "Excited", Color(red: 1.0, green: 0.7137254901960784, blue: 0.592156862745098)),
        ("sunny", "Happy", Color(red: 1.0, green: 0.8117647058823529, blue: 0.592156862745098)),
        ("pleasant", "Calm", Color(red: 1.0, green: 0.9176470588235294, blue: 0.7019607843137254)),
        ("cloudy", "Anxious", Color(red: 0.8352941176470589, green: 0.9411764705882353, blue: 1.0)),
        ("rainy", "Sad", Color(red: 0.9333333333333333, green: 0.8235294117647058, blue: 1.0)),
        ("stormy", "Angry", Color(red: 1.0, green: 0.7372549019607844, blue: 0.9098039215686274))
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
                
                Text("Pick the cloud that matches your mood!")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .foregroundStyle(Color("Color"))
                
                // Grid of mood buttons
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(moods, id: \.1) { mood in
                        NavigationLink(destination: MoodDetailView(moodName: mood.1, moodImage: mood.0, moodColor: mood.2)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(mood.2)
                                    .frame(width: 160, height: 90)
                                
                                VStack(spacing: -30) {
                                    Image(mood.0)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 90)
                                        .offset(y: -40)

                                    Text(mood.1)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding(.top, -10)
                                }
                                .padding(30)
                            }
                            
                        }
                    }
                }
                .padding()
            }
            Spacer()
        }
        .accentColor(Color("Color"))
    }
}

import SwiftUI

struct MoodDetailView: View {
    let moodName: String
    let moodImage: String
    let moodColor: Color
    @State private var notes: String = ""
    
    @Environment(\.presentationMode) var presentationMode
       @EnvironmentObject var navigationState: NavigationState
    
    var body: some View {
        VStack {
            
            Text("You picked \(moodName)")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Image(moodImage)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            
            
            Text("Add notes about your mood:")
                .font(.headline)
                .padding(.top)

            // Increased height of input field
            TextEditor(text: $notes)
                .frame(height: 150) // Adjust height here
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 2))
                .padding()
    
                

            Button("Done") {
                            // Handle saving the mood and notes
                            print("Mood: \(moodName), Notes: \(notes)")
                            
                            // Set the current view to CalendarView
                            navigationState.currentView = 0
                            
                            // Dismiss the current view
                            presentationMode.wrappedValue.dismiss()
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 250)
                        .background(moodColor)
                        .cornerRadius(10)
                        .padding(.top)
            Spacer()
        }
        .background(moodColor.opacity(0.2).edgesIgnoringSafeArea(.all))
//        .navigationTitle("MoodLog")
                .navigationBarTitleDisplayMode(.inline) // Keeps the title inline
                .toolbar {
                    ToolbarItem(placement: .principal) {
                                    Text("MoodCloud")
                                    .font(.title)
                                    .multilineTextAlignment(.center)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("Color"))
                                }
                    
                    ToolbarItem(placement:.topBarLeading) {
                        Button(action: {}) {}.tint(Color("Color"))
                    }
                }
    }
    
}


#Preview {
    ContentView()
}
