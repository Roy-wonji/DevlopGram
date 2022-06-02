//
//  UploadPostControllerDelegate.swift
//  instagram
//
//  Created by 서원지 on 2022/05/26.
//

import Foundation

protocol UploadPostControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}
