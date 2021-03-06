//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Note that although this protocol is public, the `reset` method is intended only
/// for internal use, and should not be invoked by host applications.
public protocol Resettable {

    /// Called when the client calls `Amplify.reset()` during testing. When invoked,
    /// the plugin must release resources and reset shared state. Shortly after calling
    /// `reset()` on the plugin, the category and its associated plugins will be
    /// released. Plugins must invoke the `onComplete` handler when they complete their
    /// reset. Immediately after invoking `onComplete`, the plugin's underlying system
    /// must be ready to instantiate a new plugin and configure it.
    ///
    /// This method is intended only for use by the Amplify system, and should not be
    /// invoked by host applications.
    func reset(onComplete: @escaping BasicClosure)

}
