//
//  ContentView.swift
//  FitnessTracker
//
//  Created by Erik on 07.05.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView(){
            WorkoutPlanListView()
                .tabItem{
                    Label("Workouts", systemImage: "list.dash")
                }
            WorkoutHistoryView()
                .tabItem{
                    Label("Historie", systemImage: "clock")
                }
        }
    }
}

#Preview {
    ContentView()
}
