//
//
//  Observable.swift
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

/// A simple implementation of an observable sequence that can be subscribed to.
public class Observable<T> {

    // MARK: - Types

    /// The type for the closure to executed on change of the observable.
    ///
    /// - Parameters:
    ///   - value: The current (new) value.
    ///   - oldValue: The previous (old) value.
    public typealias Observer = (_ value: T, _ oldValue: T?) -> Void

    // MARK: - Properties

    // MARK: Public properties

    /// The current (read-only) value of the observable.
    ///
    /// - Attention: Subscription should be preferred to accessing this value directly.
    public var value: T? {
        fatalError("Should be overridden by subclass.")
    }

    // MARK: Private properties

    /// The index of the last inserted observer.
    private var lastIndex: UInt = 0

    /// Map with all **active** observers.
    private var observers = [UInt: Observer]()

    // MARK: - Init/Deinit

    internal init() {}

    // MARK: - Instance methods

    // MARK: Public instance methods

    /// Informs the given observer on changes to `value`.
    ///
    /// - Parameter observer: The closure that is notified on changes.
    public func subscribe(_ observer: @escaping Observer) -> Disposable {
        let indexForNewObserver = lastIndex + 1
        observers[indexForNewObserver] = observer
        lastIndex = indexForNewObserver

        // Return a disposable that removes the entry for this observer on its deallocation.
        return Disposable { [weak self] in
            self?.observers[indexForNewObserver] = nil
        }
    }

    // MARK: Private instance methods

    internal func notifyObserver(with value: T, from oldValue: T?) {
        observers.values.forEach { observer in
            observer(value, oldValue)
        }
    }

}
