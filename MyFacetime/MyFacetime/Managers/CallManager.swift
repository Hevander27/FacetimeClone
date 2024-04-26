//
//  CallManager.swift
//  MyFacetime
//
//  Created by Hevander Da Costa on 4/24/24.
//

import Foundation
import StreamVideo
import StreamVideoUIKit
import StreamVideoSwiftUI

class CallManager {
    static let shared = CallManager()
    
    struct Constants {
        static let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiRGFydGhfTWF1bCIsImlzcyI6Imh0dHBzOi8vcHJvbnRvLmdldHN0cmVhbS5pbyIsInN1YiI6InVzZXIvRGFydGhfTWF1bCIsImlhdCI6MTcxMzk5NzE3OSwiZXhwIjoxNzE0NjAxOTg0fQ.sC_44ONP8Zjc-U38KJwDVrxYiu0Vg1JrbXFSNPbbl14"
    }
    
    private var video: StreamVideo?
    private var videoUI: StreamVideoUI?
    public private(set) var  callViewModel: CallViewModel?
    
    
    struct UserCredentials {
        let user: User
        let token: UserToken
    }
    
    func setUp(email: String) {
        setUpCallViewModel()
        
        // UserCredential
        let credential = UserCredentials(
            user: .guest(email),
            token: UserToken(rawValue: Constants.userToken)
        )
        // StreamVideo
        let video  = StreamVideo(
            apiKey: "96seceje6rtn" ,
            user: credential.user,
            token: credential.token) { result in
                // Refresh token via real backend
                result(.success(credential.token))
                
            }
        // StreamVideoUI
        let videoUI = StreamVideoUI(streamVideo: video)
        
        self.video = video
        self.videoUI = videoUI
    }
    
    private func setUpCallViewModel() {
        guard callViewModel == nil else { return }
        
        DispatchQueue.main.async {
            self.callViewModel = CallViewModel()
        }
    }
}
