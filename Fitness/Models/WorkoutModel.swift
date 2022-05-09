//
//  WorkoutModel.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 9.05.22.
//

import Foundation
import RealmSwift

class WorkoutModel: Object {
    
    @Persisted var workoutDate: Date
    @Persisted var workoutNumberOfDay: Int = 0
    @Persisted var workoutName: String = "Unknown"
    @Persisted var workoutRepeat: Bool = true
    @Persisted var workoutSets: Int = 0
    @Persisted var workoutReps: Int = 0
    @Persisted var workoutTimer: Int = 0
    @Persisted var workoutImage: Data?
}
