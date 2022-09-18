/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Vo Quoc Huy
    ID: s3823236
    Created  date: 10/09/2022
    Last modified: 15/09/2022
    Acknowledgement:
    - Canvas
*/

import Foundation

struct FormatDate{
    static func convertDateToString(formatDay:Date) -> String{
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd MMM yyyy"
        return formatter1.string(from: formatDay)
    }
}
