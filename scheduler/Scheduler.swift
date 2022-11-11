//
//  Schedule.swift
//  scheduler
// this structure generates the schedules
//  Created by Ricardo López  on 08/10/22.
//

import Foundation
@testable import AVLTree

struct Scheduler {
    // self-balanced tree to know witch hours of the week are already used
    private var activeTimeTree = AVLTree<ActiveTime>()
    //This set keep's track of the current group combination
    private var addedGroups = Set<Group>()
    private var subjects:[Subject] = []
    //Array of generated schedules
    private var generatedSchedules:[Set<Group>] = []
    
    
    
    public mutating func makeSchedules(subjects:[Subject]) -> [Set<Group>] {
        if subjects.count == 0 {
            return []
        }
        self.subjects = subjects
        dfsScheduler(depth: 0)
        
        for s in generatedSchedules {
            print("aqui")
            for g in s {
                print(g.groupID)
            }
        }

        return generatedSchedules
    }
    
    /*
        The  combinations of groups are generated with a brut force approuch. The current combination is
        stored in the set "addedGroups" . For every group in every subject, it check's if it is posible to
        add the current group to the current combination of groups and subjects. This is done with an AVL
        Tree so this can be done in O(log(n)) time, where n is the number of groups already in the set.
        
        The AVL Tree store's ActiveTime objects, witch represent time already used by added groups.
        If it is not posibble to add a group, its already added ActiveTimes are removed from the tree.
        If a group is successfully added to the set, the proccess y repeted for the groups of the next subject.
     
        At the end, the added Group and all its ActiveTimes are removed from the set and the AVL tree respectively,
        so the next group can be tried.
    */
    
    private mutating func dfsScheduler (depth: Int) {
        
        if depth >= subjects.count {
            generatedSchedules.append(addedGroups)
            return
        }

        let currentSubject = subjects[depth]
        
        groupsLoop: for subjectGroup in currentSubject.groups {
            var insertedActiveTimes:[ActiveTime] = []
            for activeTime in subjectGroup.getActiveHours() {
                if let _ = activeTimeTree.search(value: activeTime)?.value {
                    removeInsertedActiveTimes(insertedActiveTimes: insertedActiveTimes)
                    continue groupsLoop
                }
                activeTimeTree.insert(value: activeTime)
                insertedActiveTimes.append(activeTime)
            }
            addedGroups.insert(subjectGroup)
            dfsScheduler(depth: depth + 1)
            addedGroups.remove(subjectGroup)
            removeInsertedActiveTimes(insertedActiveTimes: insertedActiveTimes)
        }
    }
    

    
    private mutating func removeInsertedActiveTimes(insertedActiveTimes: [ActiveTime]) {
        for toRemove in insertedActiveTimes {
            activeTimeTree.delete(value: toRemove)
        }
    }

    
}
