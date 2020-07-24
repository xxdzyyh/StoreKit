//
//  ImagePicker.swift
//  iOSAppNext
//
//  Created by Alex on 2020/1/1.
//  Copyright © 2020 -. All rights reserved.
//

import UIKit
import RxSwift
import TZImagePickerController

final class ImagePicker {
    enum Crop {
        case none, square, circle
    }
    
    static func pickOnePhoto(crop: Crop = .none) -> Observable<UIImage> {
        return Observable.create { (observer) -> Disposable in
            
            pickOnePhoto(crop: crop, done: { (photo) in
                observer.onNext(photo)
                observer.onCompleted()
            }) {
                observer.onCompleted()
            }
            
            return Disposables.create {
                observer.onCompleted()
            }
        }
    }
    
    static func pickOnePhoto(crop: Crop = .none, done: @escaping (UIImage)->Void, cancelled: (()->Void)? = nil) {
        guard let picker = TZImagePickerController(maxImagesCount: 1, delegate: nil) else {
            return
        }
        picker.allowCrop = true
        switch crop {
        case .none:
            picker.allowCrop = false
        case .circle:
            picker.needCircleCrop = true
        default: break
        }
        picker.scaleAspectFillCrop = true
        picker.allowPickingOriginalPhoto = false
        
        picker.allowPickingGif = false
        picker.allowPickingVideo = false
        picker.allowTakeVideo = false

        // 最新的照片会显示在最前面，内部的拍照按钮会排在第一个
        picker.sortAscendingByModificationDate = false
        
        picker.didFinishPickingPhotosWithInfosHandle =
            { (photos: [UIImage]?, assets: [Any]?, original: Bool, infos: [[AnyHashable:Any]]?) in
                guard let photo = photos?.first else { return }
                done(photo)
        }
        picker.imagePickerControllerDidCancelHandle =
            { cancelled?() }
        
        Router.present(picker)
    }
    
    func pickPhotos(min: Int = 0, max: Int = 9) {
        guard let picker = TZImagePickerController(maxImagesCount: max, delegate: nil) else {
            return
        }
        
        picker.minImagesCount = min
        picker.maxImagesCount = max
        
        Router.present(picker)
    }
}
