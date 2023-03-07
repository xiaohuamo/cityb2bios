import Foundation

struct MyNewSupplier: Identifiable, Decodable, Hashable {
    let id: Int
    let user_id: Int
    let logo: URL?
    let displayName: String
    let phone: String
    let pic: URL?
    let type: Int
    let status: Int
    
    
}

extension MyNewSupplier {
    static var sampleData: [MyNewSupplier] {
        return [
            MyNewSupplier(
                id: 321484,
                user_id: 2188130,
                logo: URL(string: "https://www.marsfresh.com/data/upload/2022-08/20220818070954101549.png")!,
                displayName: "NiceGoMe Food",
                phone: "0413712628",
                pic: URL(string: "https://m.marsfresh.com/")!,
                type: 1,
                status: 0
            ),
            MyNewSupplier(
                id: 319188,
                user_id: 2188209,
                logo: URL(string: "https://www.marsfresh.com/data/upload/2022-03/20220316131516206759.png")!,
                displayName: "DNL TRADING PTY LTD",
                phone: "0451288666",
                pic: URL(string: "https://www.marsfresh.com/data/upload/2022-12/20221202000950138495.png")!,
                type: 1,
                status: 0
            )
        ]
    }
    static var sampleMyNewSupplier: MyNewSupplier {
        return MyNewSupplier(
            id: 319188,
            user_id: 2188209,
            logo: URL(string: "https://www.marsfresh.com/data/upload/2022-03/20220316131516206759.png")!,
            displayName: "DNL TRADING PTY LTD",
            phone: "0451288666",
            pic: URL(string: "https://www.marsfresh.com/data/upload/2022-12/20221202000950138495.png")!,
            type: 1,
            status: 0
        )
    }
}
