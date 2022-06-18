//
//  PushNotification.swift
//  instagram
//
//  Created by 서원지 on 2022/06/18.
//

import UIKit

struct PushNotification {
    //MARK: - 좋아요를 눌렀을때 알림 처리
    static func likePushNotification() {
        let content = UNMutableNotificationContent()
        content.body = "누군가 계시물에 좋아요를 눌렀어요!!!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: CellIdentifier.pushNotificationCellIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - 좋아요를 눌렀을때 알림 처리
    static func unlikePushNotification() {
        let content = UNMutableNotificationContent()
        content.body = "누군가 계시물에 좋아요를 취소했어요!!!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: CellIdentifier.pushNotificationCellIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - 댓글를 달았때 알림 처리
    static func commentPushNotification() {
        let content = UNMutableNotificationContent()
        content.body = "누군가 계시물에 댓글를 달았어요!!!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: CellIdentifier.pushNotificationCellIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - 팔로우를 했을때 알림 처리
    static func followPushNotification()  {
        let content = UNMutableNotificationContent()
        content.body = "누군가 팔로우를 했어요!!!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: CellIdentifier.pushNotificationCellIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - 언팔로우했을때 알림 처리
    static func unfollowPushNotification()  {
        let content = UNMutableNotificationContent()
        content.body = "누군가 언팔로우를 했어요!!!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: CellIdentifier.pushNotificationCellIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - 누군가 계시글을 올렸을때  알림 처리
    static func postPushNotification()  {
        let content = UNMutableNotificationContent()
        content.body = "누군가 계시글를 올렸어요!!!"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: CellIdentifier.pushNotificationCellIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
