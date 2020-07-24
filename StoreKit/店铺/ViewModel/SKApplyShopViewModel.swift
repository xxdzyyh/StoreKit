//
//  SKApplyShopViewModel.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/24.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SKApplyShopValidationService : DefaultValidationService {
    
    func validateUsername(_ username: String) -> ValidationResult {
        let charCount = username.count
        if charCount == 0 {
            return .empty(msg: "请填写您的真实姓名")
        }
        return .ok(msg: "")
    }
    
    func validateShopName(_ shopName: String) -> ValidationResult {
        let charCount = shopName.count
        if charCount == 0 {
            return .empty(msg: "请填写门店名称")
        }
        return .ok(msg: "")
    }
    
    func validateShopNum(_ shopNum: String) -> ValidationResult {
        let charCount = shopNum.count
        if charCount == 0 {
            return .empty(msg: "请输入填写户口号码")
        }
        return .ok(msg: "")
    }

    func validateShopImage(_ shopImage: UIImage?) -> ValidationResult {
        if shopImage == nil {
           return .empty(msg: "请上传门店图片")
        }
        return .ok(msg: "")
    }
    
    func validateShopCerImage(_ shopImage: UIImage?) -> ValidationResult {
        if shopImage == nil {
           return .empty(msg: "请上传门店图片")
        }
        return .ok(msg: "")
    }
}

class SKApplyShopViewModel: NSObject {

    var validatedPhone: Driver<ValidationResult>
    var validatedName: Driver<ValidationResult>
    var validatedShopName: Driver<ValidationResult>
    var validatedShopNum: Driver<ValidationResult>
    var validatedShopImage: Driver<ValidationResult>
    var validatedShopCerImage: Driver<ValidationResult>
    
    var validatedAll: Driver<ValidationResult>
    let validatedOnSubmit: Driver<ValidationResult>
    
    let submitting: Driver<Bool>
    let submitSuccess: Driver<Bool>
    
    init(phone:Driver<String>,name:Driver<String>,shopName:Driver<String>,shopNum:Driver<String>,
         shopImage:Driver<UIImage?>, shopCerImage:Driver<UIImage?>, submitTaps: Signal<()>) {
        
        let validationService = SKApplyShopValidationService()
        
        validatedPhone = phone.map { validationService.validateMobilePhone($0) }
        validatedName = name.map { validationService.validateUsername($0) }
        validatedShopName = shopName.map { validationService.validateShopName($0) }
        validatedShopNum = shopNum.map { validationService.validateShopName($0) }
        validatedShopImage = shopImage.map { validationService.validateShopImage($0) }
        validatedShopCerImage = shopImage.map { validationService.validateShopCerImage($0) }
        
        validatedAll = Driver.combineLatest(validatedPhone,validatedName,validatedShopName,validatedShopNum,validatedShopImage,validatedShopCerImage) {
            if false == $0.isValid { return $0 }
            if false == $1.isValid { return $1 }
            if false == $2.isValid { return $2 }
            if false == $3.isValid { return $3 }
            if false == $4.isValid { return $4 }
            return $5
        }
        
        validatedOnSubmit = submitTaps
                .asDriver(onErrorJustReturn: ())
                .withLatestFrom(validatedAll)
        
        let inputs = Driver.combineLatest(phone, name, shopName, shopNum, shopImage, shopCerImage) {
            (phone: $0, name: $1, shopName: $2, shopNum: $3, shopImage: $4, shopCerImage: $5)
        }
        
        let submitting = ActivityIndicator()
        self.submitting = submitting.asDriver()
        
        let shouldSubmit = Driver.combineLatest(
            validatedAll,
            submitting
        ) { (result, submitting) in
            return result.isValid && false == submitting
        }
        .distinctUntilChanged()
        
        submitSuccess = submitTaps
            .withLatestFrom(shouldSubmit)
            .filter({ $0 })
            .withLatestFrom(inputs)
            .flatMapLatest({ pair in
                
                let api = StoreApi.selectGoodsList
                
                let result = Network.request(api, dataType: ResponseModel<JSON>.self).map { (res) in
                    return res.code == 0
                }
                return result.trackActivity(submitting).asDriver(onErrorJustReturn: false)
            })
        
        super.init()
    }
}
