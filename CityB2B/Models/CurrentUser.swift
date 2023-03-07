import Foundation

struct CurrentUser: Codable {
    
    var id : Int
    var name : String
    var password : String
    var avatar : String
    var pic : String
    var role : Int
    var nickname : String
    var person_first_name : String
    var person_last_name : String
    var displayName : String
    var contactPersonFirstname : String
    var contactPersonLastname : String
    var contactPersonNickName : String
    var tel : String
    var phone : String
    var phone_verified : Bool
    var email : String
    var email_verified : Bool
    var googleMap : String
    var is_main_store : Int
    var user_name : String
    var is_set_password : Int
    var account_type : Int
   
    var CountOfGroupMembers : Int
    var abn_info : AbnInfo
 }

struct AbnInfo: Codable {
    var untity_name: String
    var ABNorACN: String
}
