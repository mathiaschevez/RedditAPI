//
//  ErrorActionSheetExtension.swift
//  Reddit
//
//  Created by Mathias on 6/17/20.
//  Copyright © 2020 Mathias Chevez. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
        
        let alertController = UIAlertController(title: "Error!", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
}
