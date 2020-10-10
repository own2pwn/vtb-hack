//
//  Tap.swift
//  vtb-hack
//
//  Created by Semyon on 09.10.2020.
//

infix operator ~>
@discardableResult public func ~> <U> (value: U, closure: ((inout U) -> Void)) -> U {
    var returnValue = value
    closure(&returnValue)
    return returnValue
}

// tap self
infix operator ~>?
@discardableResult public func ~>? <U> (value: U?, closure: ((inout U) -> Void)) -> U? {
    guard var returnValue = value else { return value }
    closure(&returnValue)
    return returnValue
}

// tap and possible transform self
infix operator ->?
public func ->? <U, T> (value: U?, closure: (U) -> T?) -> T? {
    guard let value = value else { return nil }
    return closure(value)
}

