//
//  SceneDelegate.swift
//  SepiaTask
//
//  Created by Kiran Jadhav on 29/11/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var timer: Timer?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(eventWith(timer:)),
                                             userInfo: [:],
                                             repeats: true)

        
        
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    
    
    func checkIfCurrentTimeIsBetween(startTime: String, endTime: String) -> Bool {
        guard let start = Formatter.today.date(from: startTime),
              let end = Formatter.today.date(from: endTime) else {
            return false
        }
        return DateInterval(start: start, end: end).contains(Date())
    }

    
    // Timer expects @objc selector
    @objc func eventWith(timer: Timer!) {
        
        let response = fetchWorkingHours()
        let pattern = String.validHoursRegex
        let regex = try! NSRegularExpression(pattern: pattern)
        if let match = regex.matches(in: response, range: .init(response.startIndex..., in: response)).first,
            match.numberOfRanges == 3 {
            let start = match.range(at: 1)
            print(response[Range(start, in: response)!])
            let end = match.range(at: 2)
            print(response[Range(end, in: response)!])
            if !checkIfCurrentTimeIsBetween(startTime: "\(response[Range(start, in: response)!])", endTime: "\(response[Range(end, in: response)!])") {
                timer.invalidate()
                window!.rootViewController?.popupAlert(title: String.alertTitle, message: String.invalidHours, actionTitles: ["OK"], actions:[{action1 in
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                },{action2 in

                }, nil])
            }
            
        }


    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

