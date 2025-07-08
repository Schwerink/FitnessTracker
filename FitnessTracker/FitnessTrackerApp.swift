//
//  FitnessTrackerApp.swift
//  FitnessTracker
//
//  Created by Erik on 07.05.25.
//

import SwiftUI

@main
struct FitnessTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [WorkoutPlan.self, Exercise.self, WorkoutSession.self, TrackedExercise.self])
    }
}
