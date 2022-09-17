//
//  LoginUtils.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 11/09/2022.
//

import Foundation
import CryptoKit
import AuthenticationServices

func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}


func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}


//
//func startSignInWithAppleFlow() {
//    let provider = ASAuthorizationAppleIDProvider()
//        let request = provider.createRequest()
//        // request full name and email from the user's Apple ID
//    request.requestedScopes = [.fullName, .email]
//
//    let authController = ASAuthorizationController(authorizationRequests: [request])
//    authController.delegate = self.ASAuthController
////        authController.presentationContextProvider = ASAuthController.ASAuthorizationControllerPresentationContextProviding {
////            func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
////                // return the current view window
////                return self.view.window!
////            }
////        }
//    authController.performRequests()
//}
//
//func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//        // create an account in your system.
//        let userIdentifier = appleIDCredential.user
//        let userFirstName = appleIDCredential.fullName?.givenName
//        let userLastName = appleIDCredential.fullName?.familyName
//        let userEmail = appleIDCredential.email
//
//        // navigate to other view controller
//    }
//}
//



//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            // use the user credential / data to do stuff here ...
//        }
//    }



//                                SignInWithAppleButton(.signIn,
//                                       onRequest: { (request) in
//                                            request.requestedScopes = [.fullName, .email]
//                                       },
//                                       onCompletion: { (result) in
//                                         switch result {
//                                         case .success(let authorization):
//                                             if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//                                                        let userId = appleIDCredential.user
//                                                        let identityToken = appleIDCredential.identityToken
//                                                        let authCode = appleIDCredential.authorizationCode
//                                                        let email = appleIDCredential.email
//                                                        let givenName = appleIDCredential.fullName?.givenName
//                                                        let familyName = appleIDCredential.fullName?.familyName
//                                                        let state = appleIDCredential.state
//                                             }
//                                             break
//                                         case .failure(let error):
//                                             print("ERROR")
//                                             print(error)
//                                             print("END")
//                                             break
//                                         }
//                                       })
//                                    .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH, maxHeight: Constants.FIELD_HEIGHT)


//final class LoginViewController: UIViewController {
////    let loginView = LaunchContentView()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    @IBSegueAction func segueToHostingController(_ coder: NSCoder) -> UIViewController? {
//        return UIHostingController(coder: coder, rootView: LaunchContentView())
//    }
//
//}
//
//final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//    var window: UIWindow?
//    private lazy var flowController = FlowCoordinator(window: window!)
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//    guard let windowScene = scene as? UIWindowScene else { return }
//        window = UIWindow(windowScene: windowScene)
//        flowController.showRootView()
//        window?.makeKeyAndVisible()
//    }
//}
//
//final class FlowCoordinator {
//    private let window: UIWindow
//    init(window: UIWindow) {
//        self.window = window
//    }
//    func showRootView() {
//        let swiftUIView = LaunchContentView()
//        let hostingView = UIHostingController(rootView: swiftUIView)
//                window.rootViewController = UINavigationController(rootViewController: hostingView)
//    }
//}
//
//final class SignInWithAppleBtn: UIViewRepresentable {
//
//  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
////      let appleBtn = ASAuthorizationAppleIDButton()
////      appleBtn.cornerRadius = Constants.CONRNER_RADIUS
////      appleBtn.backgroundColor = Constants.LIGH_PRIMARY_COLOR_UI
//    return ASAuthorizationAppleIDButton()
//  }
//
//
//  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
//  }
//}
