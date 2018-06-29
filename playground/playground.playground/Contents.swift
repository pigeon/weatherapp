//: Playground - noun: a place where people can play

import Foundation

let date0 = Date(timeIntervalSince1970: 1_530_198_000)
let date1 = Date(timeIntervalSince1970: 1_530_241_200)

let day = Calendar.current.component(.day, from: date1)
let month = Calendar.current.component(.month, from: date1)
let year = Calendar.current.component(.year, from: date1)

var dateFormatterFlayingDate: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy" // 28/06/2018 9:00
    return dateFormatter
}()

var dateFormatterTo: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter
}()

dateFormatterFlayingDate.string(from: date0)
dateFormatterFlayingDate.string(from: date0)

dateFormatterTo.string(from: date0)
