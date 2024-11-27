import SwiftUI

struct PickCourse: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchQuery: String = ""
    @State private var courseDistances: [String: Double] = [:]
    //@State private var courses: [Course] = [linkopingGK, leksandsGK, rattviksGK] // Example courses
    @State private var courses: [Course] = CourseRepository.allCourses
    @ObservedObject var locationManager = LocationManager() // Inject your LocationManager

    var filteredCourses: [String] {
        if searchQuery.isEmpty {
            return Array(courseDistances.keys)
        }
        return courseDistances.keys.filter { $0.localizedCaseInsensitiveContains(searchQuery) }
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Back Button
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(Color(.black))
                    })
                    Spacer()
                }
                .padding(.horizontal)
                
                // Header
                VStack {
                    Text("Pick your course")
                        .font(.title2)
                        .bold()
                }
                .padding()
                
                // Search Bar
                HStack {
                    TextField("Search for a course", text: $searchQuery)
                        .padding()
                    if !searchQuery.isEmpty {
                        Image(systemName: "xmark")
                            .padding()
                            .onTapGesture {
                                searchQuery = ""
                            }
                    }
                }
                .frame(width: 250, height: 40)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 3)
                        .opacity(0.4)
                )
                
                // Courses List
                VStack() {
                    HStack {
                        Text("Nearby Courses")
                            .font(.subheadline)
                        Spacer()
                    }
                  
                    // Dynamic Course List
                    ScrollView {
                        ForEach(
                            filteredCourses.sorted { courseDistances[$0, default: .infinity] < courseDistances[$1, default: .infinity] },
                            id: \.self
                        ) { courseName in
                            if let course = courses.first(where: { $0.name == courseName }),
                               let distance = courseDistances[courseName] {
                                NavigationLink(
                                    destination: GolfingScreen(course: course))
                                    {
                                        CourseRow(courseName: course.name, distance: distance, courseImage: course.image)
                                    }
                                    .foregroundStyle(Color.black)
                                Divider()
                            }
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .onAppear {
                updateDistances()
            }
        }
    }
    
    func updateDistances() {
        // Access the current location from the LocationManager instance
        guard let currentLocation = locationManager.locationManager.location else {
            print("User's location is unavailable.")
            return
        }
        
        let userCoordinate = currentLocation.coordinate

        // Use the calculateDistances method to compute distances
        let distances = locationManager.calculateDistances(to: courses, from: userCoordinate)
        // Sort distances by value and store in courseDistances
        courseDistances = distances.sorted(by: { $0.value < $1.value }).reduce(into: [:]) { result, pair in
            result[pair.key] = pair.value
        }
    }
}

// Reusable Course Row
struct CourseRow: View {
    var courseName: String
    var distance: Double
    var courseImage: String
    
    var body: some View {
        HStack {
            Image(courseImage)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(.horizontal)
            VStack(alignment: .leading) {
                Text(courseName)
                    .font(.headline)
                Text("\(String(format: "%.1f", distance / 1000)) km away") // Distance in km
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(height: 60)
        .background(Color(.white))
        .padding(.vertical, 4)
        
    }
}

#Preview {
    PickCourse()
}
