//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify

public class AWSAuthUpdateUserAttributeOperation: AmplifyOperation<
    AuthUpdateUserAttributeRequest,
    AuthUpdateAttributeResult,
    AuthError
>, AuthUpdateUserAttributeOperation {

    let userService: AuthUserServiceBehavior

    init(_ request: AuthUpdateUserAttributeRequest,
         userService: AuthUserServiceBehavior,
         resultListener: ResultListener?) {

        self.userService = userService
        super.init(categoryType: .auth,
                   eventName: HubPayload.EventName.Auth.updateUserAttributeAPI,
                   request: request,
                   resultListener: resultListener)
    }

    override public func main() {
         if isCancelled {
             finish()
             return
         }

        userService.updateAttribute(request: request) { [weak self] result in
            guard let self = self else { return }
            defer {
                self.finish()
            }
            if self.isCancelled {
                return
            }
            switch result {
            case .failure(let error):
                self.dispatch(error)
            case .success(let result):
                self.dispatch(result)
            }
        }
     }

     private func dispatch(_ result: AuthUpdateAttributeResult) {
         let result = OperationResult.success(result)
         dispatch(result: result)
     }

     private func dispatch(_ error: AuthError) {
         let result = OperationResult.failure(error)
         dispatch(result: result)
     }
}
