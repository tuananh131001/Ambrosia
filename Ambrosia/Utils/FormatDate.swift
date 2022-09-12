//
//  FormatDate.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 10/09/2022.
//

import Foundation

struct FormatDate{
    static func convertDateToString(formatDay:Date) -> String{
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd MMM yyyy"
        return formatter1.string(from: formatDay)
    }
}
