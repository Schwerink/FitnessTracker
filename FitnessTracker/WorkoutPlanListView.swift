//
//  WorkoutPlanListView.swift
//  FitnessTracker
//
//  Created by Erik on 08.05.25.
//

import SwiftUI
import SwiftData

struct WorkoutPlanListView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var plans: [WorkoutPlan]
    @State private var showAddPlan = false
    
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(plans) { plan in
                    NavigationLink(plan.name){
                        WorkoutTrackingView(plan: plan)
                    }
                }
            }
            .navigationTitle("Workout Pläne")
            .toolbar{
                Button("Hinzufügen"){
                    showAddPlan = true
                }
            }
            .sheet(isPresented: $showAddPlan){
                AddWorkoutPlanView()
            }
        }
        
    }
}

