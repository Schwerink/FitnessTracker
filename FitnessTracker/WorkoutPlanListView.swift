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
    @State private var showHistory = false
    @State private var selectedPlan: WorkoutPlan? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(plans) { plan in
                    NavigationLink(plan.name) {
                        WorkoutTrackingView(plan: plan)
                    }
                    .swipeActions(){
                        Button(role: .destructive){
                            withAnimation{
                                context.delete(plan)
                            }
                        }label:{
                            Label("Delete", systemImage:"trash")
                                .symbolVariant(.fill)
                        }
                        Button("Edit"){
                            selectedPlan = plan
                        }
                        .tint(.orange)
                    }

                }
            }
            .navigationTitle("Workout Pläne")
            .toolbar{
                Button(){
                    showAddPlan = true
                }label:{
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddPlan){
                AddWorkoutPlanView()
            }
            .sheet(item: $selectedPlan){ plan in
                WorkoutEditView(plan: plan)
            }
        }
    }
}
