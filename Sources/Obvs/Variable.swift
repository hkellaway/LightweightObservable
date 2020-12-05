//
//
//  Variable.swift
//  Obvs
//
// Copyright (c) 2020 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//

import Foundation

/// Starts with an initial value and replays it or the latest element to new subscribers.
public final class Variable<T>: Observable<T> {

    // MARK: - Properties

    // MARK: Public properties

    /// The current (writable) value of the variable.
    override public var value: T {
        get { _value }
        set { _value = newValue }
    }

    // MARK: Private properties
    
    private var _value: T {
        didSet {
            notifyObserver(with: value, from: oldValue)
        }
    }

    // MARK: - Init/Deinit

    /// Initializes a new variable with the given value.
    ///
    /// - Note: We keep the initializer to the super class `Observable` fileprivate in order to verify always having a value.
    public init(_ value: T) {
        _value = value

        super.init()
    }

    // MARK: - Instance methods

    override public func subscribe(_ observer: @escaping Observer) -> Disposable {
        // A variable should inform the observer with the initial value.
        observer(_value, nil)

        return super.subscribe(observer)
    }

}
