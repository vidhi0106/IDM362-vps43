import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 30) {
            // App Title
            Text("MoodCloud")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Color"))
                .padding(10)
            
            // Tagline
            Text("Track your mood, understand yourself! ")
                .font(.title3)
            
            // Features Section
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    Image(systemName: "pencil")
                        .font(.title2)
                        .foregroundColor(Color("Color"))
                        .frame(width: 30)
                    Text("Log your mood daily with just a tap!")
                        .font(.body)
                    Spacer()
                }
                .frame(width: 320, height: 50)
                .padding()
                .background(Color("Excited").opacity(0.5))
                .cornerRadius(12)
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(Color("Color"))
                        .font(.title2)
                        .frame(width: 30)
                    Text("View past mood entries directly from the calendar.")
                        .font(.body)
                    Spacer()
                }
                .frame(width: 320, height: 50)
                .padding()
                .background(Color("Happy").opacity(0.5))
                .cornerRadius(12)

                HStack {
                    Image(systemName: "clock.arrow.circlepath")
                        .foregroundColor(Color("Color"))
                        .font(.title2)
                        .frame(width: 30)
                    Text("Add moods for the past days through the calendar.")
                        .font(.body)
                    Spacer()
                }
                .frame(width: 320, height: 50)
                .padding()
                .background(Color("Calm").opacity(0.5))
                .cornerRadius(12)
                
                HStack {
                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(Color("Color"))
                        .font(.title2)
                        .frame(width: 30)
                    Text("Track your mood trends over time for better insights.")
                        .font(.body)
                    Spacer()
                }
                .frame(width: 320, height: 50)
                .padding()
                .background(Color("Anxious").opacity(0.5))
                .cornerRadius(12)
                
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(Color("Color"))
                        .font(.title2)
                        .frame(width: 30)
                    Text("Once logged, your mood for the day is final—no edits allowed!")
                        .font(.body)
                    Spacer()
                }
                .frame(width: 320, height: 50)
                .padding()
                .background(Color("Sad").opacity(0.5))
                .cornerRadius(12)
            }
            
            Spacer()
        }
    }
}

#Preview {
    AboutView()
}

