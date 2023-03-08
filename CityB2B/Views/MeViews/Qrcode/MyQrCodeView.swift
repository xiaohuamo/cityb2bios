import SwiftUI
import Alamofire
import SwiftyJSON

struct MyQrCodeView: View {
    @EnvironmentObject var user: UserViewModel
    @State private var qrCodeImage: UIImage? = nil
    @State private var isLoading = false
    
   
    private let apiUrl = "https://m.marsfresh.com/api/userCode"
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else if let image = qrCodeImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding()
            } else {
                Text("QR Code Unavailable")
            }
        }
        .onAppear {
            fetchQRCode()
        }
    }
    
    private func fetchQRCode() {
        isLoading = true
        
        let url = "https://m.marsfresh.com/api/userCode"
//        let params = [:]
        let headers: HTTPHeaders = [
         "token": user.user_temp_tokens
                      ]
        
        AF.request(url,
                   method: .post,
                   parameters: [:],
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
       
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let codePath = json["result"]["code_path"].stringValue
                    downloadQRCode(from: codePath)
                case .failure(let error):
                    print(error.localizedDescription)
                    isLoading = false
                }
            }
    }
    
    private func downloadQRCode(from url: String) {
        AF.download(url)
            .validate(statusCode: 200..<300)
            .responseData { response in
                isLoading = false
                switch response.result {
                case .success(let data):
                    qrCodeImage = UIImage(data: data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
