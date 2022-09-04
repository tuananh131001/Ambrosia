//
//  Ultility.swift
/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 2
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 05/08/2022
    Last modified: 07/08/2022
    Acknowledgement:
- Canvas, CodeWithChris Course
 */

import Foundation
import SwiftUI

// - MARK: drawing arrow shape in note
struct ArrowShape: Shape {

    func path(in rect: CGRect) -> Path {
        let xArrowPoint = CGFloat(rect.maxX + (rect.maxX - rect.midX) / 3)
        let downArrowPoint = CGPoint(x: rect.maxX, y: rect.minY)
        let upArrowPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        let middleArrowPoint = CGPoint(x: xArrowPoint, y: rect.midY)
        var path = Path()

        path.move(to: downArrowPoint)
        path.addLine(to: middleArrowPoint)
        path.addLine(to: upArrowPoint)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: downArrowPoint)

        return path
    }
}

