//
//  UserModel.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 23.05.22.
//

import Foundation
import RealmSwift

class UserModel: Object {
    
    @Persisted var firstName: String = ""
    @Persisted var secondName: String = ""
    @Persisted var height: Int = 0
    @Persisted var weight: Int = 0
    @Persisted var target: Int = 0
}
