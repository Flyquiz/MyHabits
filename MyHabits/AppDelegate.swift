//
//  AppDelegate.swift
//  MyHabits
//
//  Created by Иван Захаров on 08.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//TODO: TODOLIST
/*
 1. Добавить возможность снятия трека с привычки
 2. Прикрутить счетчик треков к ячейке
 3. Добавить экран редактирования и удаления
 4. Докрасить и адаптировать для темной темы
 5. Ячейки в tableView без реюза. Нужно что-то сделать
 6. При скролле коллекции в HabitsVC идет дерганье вниз
 */
