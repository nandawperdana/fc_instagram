//
//  ModelInitTest.swift
//  InstagramCloneTests
//
//  Created by nandawperdana on 04/08/24.
//

import XCTest
import FirebaseFirestore
@testable import InstagramClone

final class ModelInitTest: XCTestCase {
    func testUserInit() throws {
        // Given
        let dictionary: [String: Any] = [
            "email": "test@example.com",
            "fullname": "Test User",
            "profileImage": "http://google.com",
            "username": "testuser",
            "uid": "12345",
        ]
        
        // When
        let user = User(dictionary: dictionary)
        
        // Then
        XCTAssertEqual(user.email, dictionary["email"] as! String)
        XCTAssertEqual(user.fullname, dictionary["fullname"] as! String)
        XCTAssertEqual(user.profileImage, dictionary["profileImage"] as! String)
        XCTAssertEqual(user.username, dictionary["username"] as! String)
        XCTAssertEqual(user.uid, dictionary["uid"] as! String)
        XCTAssertNotNil(user.stats)
        XCTAssertEqual(user.stats.followers, 0)
        XCTAssertEqual(user.stats.following, 0)
        XCTAssertFalse(user.isFollowed)
    }
    
    func testNotificationInit() throws {
        // Given
        let dictionary: [String: Any] = [
            "timestamp": Timestamp(date: Date(timeIntervalSince1970: 1609459200)),
            "id": "12345",
            "uid": "54321",
            "type": 1,
        ]
        
        // When
        let notification = Notification(dictionary: dictionary)
        
        // Then
        XCTAssertEqual(notification.timestamp, Timestamp(date: Date(timeIntervalSince1970: 1609459200)))
        XCTAssertEqual(notification.type, NotificationType.follow)
    }
}
