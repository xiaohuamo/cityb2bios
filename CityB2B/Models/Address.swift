import Foundation

struct Address: Codable,Identifiable {
    var id: Int
    var user_id: Int
    var first_name: String
    var last_name: String
    var address: String
    var phone: String
    var email: String
    var id_number: String
    var create_time: Int
    var message_to_business: String?
    var country: String
    var addr_post: String?
    var is_default_address: Int
    var Street_number: String?
    var display_name: String
    var business_hours: String
    var arrive_mode: String
    var pic: String
}

extension Address {
    static var sampleAddress: Address {
        return Address(id: 18915,
                       user_id: 2188208,
                       first_name: "harry",
                       last_name: "tang",
                       address: "15 Gum Tree Cl Croydon VIC,3136,AU",
                       phone: "0866312444",
                       email: "ubonuse0m@gmail.com",
                       id_number: "",
                       create_time: 1678141207,
                       message_to_business: nil,
                       country: "",
                       addr_post: nil,
                       is_default_address: 0,
                       Street_number: nil,
                       display_name: "dorset croydon shop",
                       business_hours: "",
                       arrive_mode: "",
                       pic: "")
    }
    
    static var sampleAddresses: [Address] {
        return [
            Address(id: 18915,
                    user_id: 2188208,
                    first_name: "harry",
                    last_name: "tang",
                    address: "15 Gum Tree Cl Croydon VIC,3136,AU",
                    phone: "0866312444",
                    email: "ubonuse0m@gmail.com",
                    id_number: "",
                    create_time: 1678141207,
                    message_to_business: nil,
                    country: "",
                    addr_post: nil,
                    is_default_address: 0,
                    Street_number: nil,
                    display_name: "dorset croydon shop",
                    business_hours: "",
                    arrive_mode: "",
                    pic: ""),
            Address(id: 18916,
                    user_id: 2188208,
                    first_name: "jane",
                    last_name: "doe",
                    address: "123 Main St",
                    phone: "123-456-7890",
                    email: "jane.doe@example.com",
                    id_number: "",
                    create_time: 1678141210,
                    message_to_business: nil,
                    country: "",
                    addr_post: nil,
                    is_default_address: 0,
                    Street_number: nil,
                    display_name: "",
                    business_hours: "",
                    arrive_mode: "",
                    pic: "")
        ]
    }
}
