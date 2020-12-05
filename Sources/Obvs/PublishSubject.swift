//
//
//  PublishSubject.swift
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

/// Starts empty and only emits new elements to subscribers.
public final class PublishSubject<T>: Observable<T> {

    // MARK: - Properties

    // MARK: Public properties

    /// The current (read-only) value of the observable.
    override public var value: T? {
        _value
    }

    // MARK: Private properties

    /// The storage for our computed property.
    ///
    /// - Note: Workaround for compiler error `Cannot override with a stored property 'value'`.
    private var _value: T?

    // MARK: - Init/Deinit

    /// Initializes a new publish subject.
    ///
    /// - Note: As we've made the initializer to the super class `Observable` fileprivate, we must override it here to allow public access.
    override public init() {
        super.init()
    }

    // MARK: - Instance methods

    // MARK: - methods instance methods

    /// Updates the publish subject using the given value.
    public func update(_ value: T) {
        let oldValue = _value
        _value = value

        // We inform the observer here instead of using `didSet` on `_value` to prevent unwrapping an optional (`_value` is nullable, as we're starting empty).
        notifyObserver(with: value, from: oldValue)
    }

}
