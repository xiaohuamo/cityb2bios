//
//  AboutAppView.swift
//  CityB2B
//
//  Created by Fei Wang on 25/2/2023.
//

import SwiftUI



struct TermAndConditionsView: View {
   
    @State private var TermAndConditionsContent = ""
    @EnvironmentObject var user: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
           ScrollView {
               VStack(alignment: .leading, spacing: 40) {
                   if !TermAndConditionsContent.isEmpty {
                       Text(TermAndConditionsContent)
                           .font(.system(size: 16))
                           .foregroundColor(Color("fontColorMain"))
                           .multilineTextAlignment(.leading)
                           .padding(.horizontal, 20)
                           .padding(.top,40)
                   } else {
                       ProgressView()
                           .progressViewStyle(CircularProgressViewStyle())
                           .padding()
                   }
               }
          
           }
           .onAppear {
               fetchTermAndConditionsContent()
           }
          
           .navigationBarTitle("用户协议", displayMode: .inline)
           .navigationBarBackButtonHidden()
           .navigationBarItems(leading: Button(action: {
                               self.presentationMode.wrappedValue.dismiss()
                           }) {
                               HStack {
                                   Image(systemName: "chevron.left") .foregroundColor(Color("fontColorMain"))
                                   Text("")
                               }
                           })
       }

    private func fetchTermAndConditionsContent() {
        // 通过 API 获取关于我们的内容
        // 这里仅为示例，未实际获取内容
        TermAndConditionsContent = """
            1. I/We hereby apply to the company for a trading account as indicated in this application and certify that the information contained herein is true and complete in every particular.

            TERMS AND CONDITIONS

            2. The company collect, hold and use, information related to my/our commercial and consumer creditworthiness from EQUIFAX (www.equifax.com.au), a credit reporting body, for all purposes permitted by law. The company also discloses information to them. This activity is conducted for the purpose of assessing my/our credit capacity, eligibility or history in connection with an application or an obligation as a guarantor, collecting payments from the company, and managing our credit relationship. Creditworthiness information includes information that is both positive (like payment information) and negative (like defaults or serious credit infringements that the company may disclose to credit reporting bodies if me/us fail to pay the company). The company’s privacy policy and the credit reporting body’s privacy policy (see the I/Websites) have more information on how the company, and the credit reporting body, manages personal information, including creditworthiness information. The policies also include how the company can access, correct, and make complaints about personal information, request that my/our information is not used for credit pre-screening, and request a ban on use of credit information where the company have been a victim of fraud.

            3. The customer must ensure that its customer account issued is available only to those of its employees authorized to use it. The customer acknowledges that it will be liable for all orders requested with the quotation of the account.

            4. The company may withdraw credit facilities from the customer at any time without notice. Without limiting the company’s rights to withdraw credit, the company reserves the right to stop supply and place the account on hold.

            5. Should it be considered necessary by the company to incur legal and/or other expenses (including commercial agent and private inquiry agent fees) in enforcement of the its rights or in obtaining or attempting to obtain payment of any amount due by me/us in consideration of the granting of credit to me/us, I/We expressly undertake to be liable for and reimburse the company on an indemnity basis the whole amount of such expenses and fees.

            6. a. I/We acknowledge that property and all title in the goods and services supplied will remain wholly vested in the company until all monies owing by the Applicant to the company together with all collection and repossession and legal costs incurred and applicable taxes have been paid in full.

            b. Until payment is made in full, the Applicant will hold the goods supplied as a bailee for and on behalf of the company.

            c. All payments the Applicant may receive for a goods supplied will be held in trust for the company pending payment thereof to the company.

            d. In the event that the Applicant fails to pay any monies owing to the company when due and payable, the company will be entitled forthwith and without notice to repossess all goods supplied by the company in the possession of the Applicant and for these purposes the Applicant or any other premises and retake possession of the goods held by the Applicant as aforesaid. The Applicant must forthwith account and make payments to the company of all and any monies held by it in respect to the proceeds of the sales of the goods.

            e. Any claims arising from outstanding payments must be made within seven (7) days. The company shall have the right to charge a monthly interest of 1.0% on any outstanding payments.

            f. The remedies available to the company in this clause are without prejudice to any other remedies available to it at law or in equity.

            7. Supplier terms: If I/We done the registration and become a supplier of the company platform . I acknowledge that

            a. I/We am/are a supplier who opened an account on the website of the company. For any customer who places an order with I/WE on the company, I/We firstly confirm that he/she is a customer who I have approved, and the company does not undertake any Direct or indirect economic losses due to order errors.

            b.I acknowledge that the network system may be interrupted and stop the service, and may even fail to return to normal for a long time; and I understand that network or server data may be attacked and leaked in some cases. the company itself will take measures to prevent network interruption and recovery , and provide necessary means to prevent illegal attacks. If the company cannot serve me/us normally due to network interruption or illegal attack, etc., I/We acknowledge will not make any claim to the company . the company is also not responsible for any suspension or long-term suspension of services, and direct and indirect economic losses caused by accidental leakage of customer data.

            c.According to the contract signed by the two parties, the company will regularly charge relevant service fees from me. If the company suspends the service for more than 6 hours due to any problem, the company will not charge the service fee for the same day. If the normal service cannot be provided for more than 24 hours, the services fees or charge from the company during the specific interruption time (the number of days plus 1 day) will be waived.

            d.The supplier's customer data, such as which customers I have, are strictly confidential, and other suppliers are strictly prohibited from accessing. I understand that I also cannot see any other supplier's customer data based on this provision. the company will not show other suppliers when my customers order on the company's site unless the customer who is ordering is also an account with another supplier.

            e. If I/We is/are play a role on website of the company , I/We acknowledge that I need sign another contract before the service can be supplied by the company. 8 If I am an ordering customer: I know that I will fulfill the following terms: a.I need to sign a contract with the supplier, which involves ordering and payment, and I need to perform the agreement signed with the supplier, and the company does not participate in related matters. b. the company general not charge any fee from me except I use the fault information and place the orders and refuse to recvied the goods that the supplier deliveried. c. the company will secure my/our information and not disclose and pass to third party not related the services provided by the company. A. DEFINITIONS: “I” and “Me” means the director who signs this document.

            “I/We” and “Us” means each of the directors jointly and severally.

            “The company” means CITYB2B PTY LTD (ABN: 87 655 992 966).

            “The supplier” means a suupler who open an wholsaler account on the company (CITYB2B PTY LTD (ABN: 87 655 992 966)).

            ‘I/WE HAVE READ AND UNDERSTOOD THE TERMS AND CONDITIONS AND HAVE BEEN ADVISED, AND GIVEN OPPORTUNITY, TO SEEK INDEPENDENT LEGAL ADVICE.’

            GUARANTEE AND ,

            THIS IS A LEGAL DOCUMENT. PLEASE SEEK LEGAL ADVICE BEFORE TICK THE TERM & CONDITIONS (WHICH MEAS YOU SIGNING THIS DOCUMENT )IF THE CUSTOMER IS IN ANY DOUBT AS TO ITS EFFECT AND MEANING.

            TO: CITYB2B PTY LTD (ABN: 87 655 992 966) (hereinafter referred to as “the company”)

            TO: THE SUPPLIER WHICH YOU INTENT TO PLACE AN ORDER (hereinafter referred to as “the SUPPLIER”)

            1. I/We guarantee payment to the company or the supplier of all monies and performance of all obligations including any past, present and future indebtedness or obligation by the customer (as named in the “Credit Application” and which forms a part of this document) or any of us arising from any past, present or future dealing with the company.

            2. I/We indemnify the company or the supplier against all loss or damage arising from any past, present or future dealing with the customer or any of us.

            3. I/We agree:

            a. That this is a continuing guarantee and that our liability under this guarantee is joint and several and will not be affected, waived or discharged by the reason of any time or indulgences granted by the company or the supplier and,

            b. That our liability under this guarantee shall not be affected, waived or discharged by the customer entering into a Deed of Company Arrangement (DOCA) or by the company or the supplier voting in favor of or against, or abstaining from voting, in relation to any proposal by the customer to enter a DOCA and,

            c. That this guarantee becomes binding on such of us that sign this guarantee irrespective of whether or not all intended signatories execute this guarantee and,

            d. That the company or the supplier is entitled to recover against a Guarantor without having first taken steps to recover against the customer or any other Guarantor and,

            e. That this guarantee may only be revoked as to future trading with the Applicant and any notice of revocation may only be given by pre-paid registered mail delivered to 500 Dorset RD ,Croydon south ,vic ,3136 until the expiration of 14 days from the date of posting.

            f. That any payment which is subsequently avoided by any law relating to insolvency shall be deemed not to have been paid and,

            g. That I/We sign in both our personal capacity and as Trustee of every Trust of which I/We are Trustee and/or a beneficiary and,

            h. To notify the company or the supplier of any change in the customer’s structure or management including any sale or disposition of any part of the business of the Customer, any change in directorships, shareholders or management or change in partnership or trusteeship within 7 days of the date of any such change.

            4. I/We further agree that this agreement and any claim or dispute with the company, the customer or any of us shall be governed by the law applicable in the State of Australian Victoria and submit to the jurisdiction of the Court in Victoria.

            A. DEFINITIONS:

            “I/We” and “Us” means each of the Guarantors jointly and severally.

            “The company” means CITYB2B PTY LTD (ABN: 87 655 992 966).

            “The supplier” means a suupler who open an wholsaler account on the company (CITYB2B PTY LTD (ABN: 87 655 992 966)).

            ‘I/WE HAVE READ AND UNDERSTOOD THE GUARANTEE AND INDEMNITY AND HAVE BEEN ADVISED, AND GIVEN OPPORTUNITY, TO SEEK INDEPENDENT LEGAL ADVICE.’
        """
    }
}

struct TermAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermAndConditionsView()
    }
}



