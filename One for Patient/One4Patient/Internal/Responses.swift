//
//  LoginResponse.swift
//  qbounceTask
//
//  Created by Praneeth Althuru on 11/10/18.
//  Copyright © 2018 qbounce. All rights reserved.
//

import Foundation


struct SelectorContent {
    var title: String!
    var subTitle: String!
    var id: String!
    var code: String!
    var prefix: String!
    var index: Int!
    
}



struct CommonResponse:Decodable {
    let StatusCode:Int?
    let Message:String?
    let Result:JSONNull?
}

struct PostProfileResponse:Decodable {
    let StatusCode:Int?
    let Message:String?
    let Result:Int?
}

struct PostEduResponse:Decodable {
    let StatusCode:Int?
    let Message:String?
    let Result:String?
}

// UserInfo Response
struct UserInfoResponse:Decodable {
    let StatusCode:Int?
    let Result:Users
    let Message:String?
}

//ProfileInfoResponse

struct ProfileInfoResponse:Decodable {
    let Result: Profiles
    let StatusCode:Int?
    let Message:String?
}

// EducationInfo Reaponse
struct GetEduResponse:Decodable {
    let StatusCode:Int?
    let Message:String?
    let Result:[EduResult]
}

struct EduResult:Decodable {
    let id, profileID: Int
    let profile: JSONNull?
    let title, institute, college, dtFrom: String
    let dtFromFormatted, dtTo, dtToFormatted: String
    let stillStudying: Bool
    let grade: JSONNull?
    let status: Int
}

// MARK: Delete  Edcation Respoonse
struct Deleteresponse:Decodable {
       let statusCode: Int
       let message: String
}

// MARK: - EducationResponse
struct EducationResponse: Codable {
    let result: [EducationResult]
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

// MARK: - EducationResult
struct EducationResult: Codable {
    let id, profileID: Int
    let profile: JSONNull?
    let title, institute, college, dtFrom: String
    let dtFromFormatted, dtTo, dtToFormatted: String
    let stillStudying: Bool
    let grade: String?
    let status: Int

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case profileID = "ProfileId"
       case profile = "Profile"
        case title = "Title"
        case institute = "Institute"
        case college = "College"
        case dtFrom = "DtFrom"
        case dtFromFormatted = "DtFromFormatted"
        case dtTo = "DtTo"
        case dtToFormatted = "DtToFormatted"
        case stillStudying = "StillStudying"
        case grade = "Grade"
        case status = "Status"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK:- Signup Response
struct SignupDetails : Decodable {
    let title: String?
    let StatusCode: Int?
    let traceId:String?
    let Result:String?
    let Message:String?
}
struct RegisterResponse:Decodable {
    let Message:String?
    let StatusCode:Int?
    let Result:String?
}
struct Errors:Decodable {
    let Email:String?
    let Password:String?
    let UserName:String?
    let ConfirmPassword:String?
    
}
struct LoginPasscodeDetials:Decodable {
    let StatusCode:Int?
    let Message:String?
    let Result:PassCodeResults
}
struct PassCodeResults:Decodable {
    let User:Users
    let Token:String?
    let RequestFromIp:String?
    let UserAgent:String?
}
// MARK: Login Repsonse
struct LoginResponse:Decodable {
    let StatusCode:Int?
    let Message:String?
    let Result:LoginResult
}

struct LoginResult:Decodable {
//   let User:Users
   let Token:String?
   let RequestFromIp:String?
   let UserAgent:String?
   let Id:Int?
   let UserName:String?
   let Email:String?
   let PhoneNumber:String?
   let Profile:LoginProfile
   let Role:String?
   let Enums:EnumKeys
   let ProfilePic:String?
    
}

struct EnumKeys:Decodable {
    let EnumRowStatus:EnumRowStatusKey
    let EnumWeekDay:EnumWeekDayKeys
    let EnumSubscriptionPaymentStatus:EnumSubscriptionPaymentStatusKey
    let EnumCurrency:EnumCurrencyKey
    let EnumPlanType:EnumPlanTypeKey
    let EnumProfileType:EnumProfileTypeKey
    let EnumProfileMaritalStatus:EnumProfileMaritalStatusKey
    let EnumAppointmentStatus:EnumAppointmentStatusKey
}
struct EnumRowStatusKey:Decodable {
    let InActive:Int?
    let Active:Int?
    let Deleted:Int?
}

struct EnumAppointmentStatusKey:Decodable {
    let Queued:Int?
    let Accepted:Int?
    let Declined:Int?
    let Cancelled:Int?
    let Closed:Int?
    let FollowUp:Int?
    let Pooled:Int?
    let PopFromPool:Int?
    let PushToPool:Int?

}
struct EnumProfileMaritalStatusKey:Decodable {
    let Single:Int?
    let Married:Int?
}

struct EnumProfileTypeKey:Decodable {
    let SysAdmin:Int?
    let Specialist:Int?
    let Patient:Int?
}

struct EnumPlanTypeKey:Decodable {
    let Individual:Int?
    let Family:Int?
}

struct EnumCurrencyKey:Decodable {
    let Dollar:Int?
    let Rupee:Int?
}

struct EnumWeekDayKeys:Decodable {
    let Sun:Int?
    let Mon:Int?
       let Tue:Int?
       let Wed:Int?
       let Thu:Int?
       let Fri:Int?
       let Sat:Int?
      
}
struct EnumSubscriptionPaymentStatusKey:Decodable {
    let NotPaid:Int?
    let Paid:Int?
}

// MARK: Commom Response
struct Users:Decodable {
    let Id:Int?
    let UserName:String?
    let Email:String?
    let PhoneNumber:String?
    let Profile:Profiles?
    let Role:String?
}
struct Profiles:Decodable {
    let Id:Int?
    let FName:String?
    let LName:String?
    let DOB:String?
    let GenderId:Int?
    let Gender:UserGender
    let StreetAdd1:String?
    let StreetAdd2:String?
    let CityId:String?
    let City:String?
    let State:String?
    let StateId:String?
    let CountryId:String?
    let Country:String?
    let Zip:Int?
    let Fax:String?
    let ProfilePic:String?
//    let Educations:String?
//    let Specializations:String?
    let WorkContact:String?
    let SSN:String?
    let MName:String?
    let HomeContact:String?
}

struct LoginProfile:Decodable {
    let Id:Int?
    let FName:String?
    let LName:String?
    let DOB:String?
    let GenderId:Int?
    let Gender:UserGender
}

struct UserGender:Decodable {
    let Name:String?
}

// MARK: My Subscription Details

struct MySubscriptionResponse: Decodable {
    let result: MemberResult
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

//MARK: Family Members Reasponse
struct MembersResponse: Decodable {
    let result: [MemberResult]
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

// MARK: - MemberResult
struct MemberResult: Decodable {
    let id: Int
    let uniqueID: String
    let amount, discount, paymentStatus, type: Int
    let relationWithParentUser, userID: Int
    let user: MemberUser
    let ageGroup: AgeGroup
    let plan: Plan

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case uniqueID = "UniqueId"
        case amount = "Amount"
        case discount = "Discount"
        case paymentStatus = "PaymentStatus"
        case type = "Type"
        case relationWithParentUser = "RelationWithParentUser"
        case userID = "UserId"
        case user = "User"
        case ageGroup = "AgeGroup"
        case plan = "Plan"
    }
}

// MARK: - AgeGroup
struct AgeGroup: Decodable {
    let id: Int
    let title, ageGroupDescription: String
    let baseAmount, ageFrom, ageTo: Int

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case ageGroupDescription = "Description"
        case baseAmount = "BaseAmount"
        case ageFrom = "AgeFrom"
        case ageTo = "AgeTo"
    }
}

// MARK: - Plan
struct Plan: Decodable {
    let id: Int
    let title: String
    let planDescription: JSONNull?
    let discount, expiryPeriod: Int

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case planDescription = "Description"
        case discount = "Discount"
        case expiryPeriod = "ExpiryPeriod"
    }
}

// MARK: - MemberUser
struct MemberUser: Decodable {
    let id: Int
    let userName, email, phoneNumber: String
    let emailConfirmed: Bool

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case userName = "UserName"
        case email = "Email"
        case phoneNumber = "PhoneNumber"
        case emailConfirmed = "EmailConfirmed"
    }
}

// MARK: GetTimeSlotResponse

struct getTimeslotResponse:Decodable {
    let StatusCode:Int?
    let Message:String?
    let Result:[TimeResult]
}
struct TimeResult:Decodable {
    let Id: Int?
    let SpecialistId: Int?
    let  Specialist: String?
    let  WeekDay:Int?
    let  Available: Bool
    let ExtraInfo: String?
    let WeeklyScheduleTimeSlotMaps:[WeekTimeMap]
}
struct WeekTimeMap:Decodable {
    let Id:Int?
    let WeeklyScheduleId:Int?
    let WeeklySchedule:String?
    let TimeFrom:String?
    let TimeTo:String?
    let Checked:Bool?
    let TimeFromFormatted:String?
    let TimeToFormatted:String?
    let Available:Bool?
    let ExtraInfo:String?
    
    
}

// MARK: - MedicationResponse
struct MedicationResponse: Decodable {
    let result: [MedicationResult]
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

// MARK: - MedicationResult
struct MedicationResult: Decodable {
    let id, patientUserID: Int
//    let patient: JSONNull?
    let name: String
    let schedule, medicineNature: Int
    let strengthUnit, strengthValue: String
    let extraInfo: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case patientUserID = "PatientUserId"
//        case patient = "Patient"
        case name = "Name"
        case schedule = "Schedule"
        case medicineNature = "MedicineNature"
        case strengthUnit = "StrengthUnit"
        case strengthValue = "StrengthValue"
        case extraInfo = "ExtraInfo"
    }
}

// MARK: - HabitsResponse
struct HabitsResponse: Decodable {
    let result: [HabitsResult]
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

// MARK: - HabitsResult
struct HabitsResult: Decodable {
    let id, patientUserID: Int
//    let patient: JSONNull?
    let userID: Int
    let name: String
    let type, periodValue: Int
    let periodUnit, extraInfo: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case patientUserID = "PatientUserId"
//        case patient = "Patient"
        case userID = "UserId"
        case name = "Name"
        case type = "Type"
        case periodValue = "PeriodValue"
        case periodUnit = "PeriodUnit"
//        case resultDescription = "Description"
        case extraInfo = "ExtraInfo"
        case status = "Status"
    }
}


// MARK: - MConditionResponse
struct MConditionResponse: Decodable {
    let result: [MConditionResult]
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

// MARK: - MConditionResult
struct MConditionResult: Codable {
    let id, patientUserID: Int
//    let patient: JSONNull?
    let userID: Int
    let condition: String
    let type, periodValue: Int
    let periodUnit, Description: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case patientUserID = "PatientUserId"
//        case patient = "Patient"
        case userID = "UserId"
        case condition = "Condition"
        case type = "Type"
        case periodValue = "PeriodValue"
        case periodUnit = "PeriodUnit"
        case Description = "Description"
        case status = "Status"
    }
}


// MARK: - AllergyResponse
struct AllergyResponse: Decodable {
    let result: [AllergyResult]
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}


// MARK: - AllergyListResponse
struct AllergyListResponse: Decodable {
    let result: [AllegyListResult]
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

// MARK: - Result
struct AllegyListResult: Decodable {
    let id: Int
    let name: String
    let type: Int
    let resultDescription, extraInfo: String
    let status: Int
//    let patientAllergyHistories: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case type = "Type"
        case resultDescription = "Description"
        case extraInfo = "ExtraInfo"
        case status = "Status"
//        case patientAllergyHistories = "PatientAllergyHistories"
    }
}

// MARK: - AllergyResult
struct AllergyResult: Decodable {
    let id, userID, patientUserID: Int
//    let patient: JSONNull?
    let masterAllergyID: Int
    let masterAllergy: MasterAllergy
    let masterAllergyNameAddForApproval: JSONNull?
    let masterAllergyTypeAddForApproval, severity, periodValue: Int
    let periodUnit, resultDescription, comment: String
    let status: Int
//    let patientAllergyReactionMaps: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case userID = "UserId"
        case patientUserID = "PatientUserId"
//        case patient = "Patient"
        case masterAllergyID = "MasterAllergyId"
        case masterAllergy = "MasterAllergy"
        case masterAllergyNameAddForApproval = "MasterAllergyNameAddForApproval"
        case masterAllergyTypeAddForApproval = "MasterAllergyTypeAddForApproval"
        case severity = "Severity"
        case periodValue = "PeriodValue"
        case periodUnit = "PeriodUnit"
        case resultDescription = "Description"
        case comment = "Comment"
        case status = "Status"
//        case patientAllergyReactionMaps = "PatientAllergyReactionMaps"
    }
}

// MARK: - MasterAllergy
struct MasterAllergy: Decodable {
    let id: Int
    let name: String
    let type: Int
    let masterAllergyDescription, extraInfo: String
    let status: Int
//    let patientAllergyHistories: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case type = "Type"
        case masterAllergyDescription = "Description"
        case extraInfo = "ExtraInfo"
        case status = "Status"
//        case patientAllergyHistories = "PatientAllergyHistories"
    }
}


// MARK: - DoctorsListResponse
struct DoctorsListResponse: Decodable {
    let result: [DoctorsListResult]
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

// MARK: - DoctorsListResult
struct DoctorsListResult: Decodable {
    let id: Int
    let userName, email: String
    let phoneNumber: String?
    let emailConfirmed: Bool
    let profile: DoctorProfile

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case userName = "UserName"
        case email = "Email"
        case phoneNumber = "PhoneNumber"
        case emailConfirmed = "EmailConfirmed"
        case profile = "Profile"
    }
}

// MARK: - DoctorProfile
struct DoctorProfile: Decodable {
    let id: Int
    let fName: String
    let mName: String?
    let lName: String
//    let genderID: JSONNull?
    let dob: String
    let gender: UserGender
    let ssn, workContactCountryCode, workContact, homeContactCountryCode: String?
    let homeContact, streetAdd1, streetAdd2: String?
    let cityID, city, stateID, state: JSONNull?
    let countryID, country: JSONNull?
    let zip: Int
    let fax: String?
//    let profilePic, profileDescription: JSONNull?
    let educations, specializations: [Ation]

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case fName = "FName"
        case mName = "MName"
        case lName = "LName"
//        case genderID = "GenderId"
        case dob = "DOB"
        case gender = "Gender"
        case ssn = "SSN"
        case workContactCountryCode = "WorkContactCountryCode"
        case workContact = "WorkContact"
        case homeContactCountryCode = "HomeContactCountryCode"
        case homeContact = "HomeContact"
        case streetAdd1 = "StreetAdd1"
        case streetAdd2 = "StreetAdd2"
        case cityID = "CityId"
        case city = "City"
        case stateID = "StateId"
        case state = "State"
        case countryID = "CountryId"
        case country = "Country"
        case zip = "Zip"
        case fax = "Fax"
//        case profilePic = "ProfilePic"
//        case profileDescription = "Description"
        case educations = "Educations"
        case specializations = "Specializations"
    }
}

// MARK: - Ation
struct Ation: Codable {
    let title, college, institute: String
    let stillStudying: Bool
    let status: Int

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case college = "College"
        case institute = "Institute"
        case stillStudying = "StillStudying"
        case status = "Status"
    }
}





//MARK: ForgotPassword Response
struct ForgotPasswordDetails:Decodable {
    let StatusCode:Int?
    let Message:String?
    let Result:PasswordResults
}
struct PasswordResults:Decodable {
    let Message:String?
    let RequestFromIp:String?
    let UserAgent:String?
    let Token:String?
    let User:Users?
}

struct ResetPasswordResponse:Decodable {
    let StatusCode:Int?
    let Message:String?
    let Result:String?
    let status:Int?
    let traceId:String?
    let title:String?
    let errors:Errors
}

struct ValidatePasscodeRes:Decodable {
       let StatusCode:Int?
       let Message:String?
       let Result:ValidateResult
}
struct ValidateResult:Decodable {
    let PasswordResetToken:String?
    
}

struct PasscodeResponse:Decodable {
      let StatusCode:Int?
      let Message:String?
}


struct CommomDetails: Decodable {
    let StatusCode:Int?
    let Message:String?
    let Result:[Results]?
}

struct Results: Decodable {
    
    let Id:Int?
    let UniqueId:String?
    let Title:String?
    let Description:String?
    let BaseAmount:Float?
    let AgeFrom:Int?
    let AgeTo:Int?
    let ProfileSubscriptions:[String]?
    let Status:Int?
    let DtCreated:String?
    
    
}

struct loginRequest : Decodable {
    let Result: ResultPasscode?
    let StatusCode: Int?
}

struct ResultPasscode: Decodable {
    let Message: String?
    let RequestFromIp: String?
    let UserAgent: String?
    let Token: String?
}
struct SpecialistResult: Decodable {
    let Result: [SpecialistList]?
    let StatusCode: Int?
}
struct SpecialistList: Decodable {
    let User: SpecialistListUser?
    let ProfileType: String?
    let IsSpecialist: Bool?
    let FName: String?
    let DOB: String?
    let EnableNotification: Bool?
}

struct SpecialistListUser: Decodable {
    let Id: String?
    let UserName: String?
    let Email: Bool?
    let PhoneNumber: String?
}

struct SymptomsResult: Decodable {
    let Result: [Symptoms]?
    let StatusCode: Int?
}
struct GetSpecilaityResponse:Decodable {
       let StatusCode:Int?
       let Message:String?
       let Result:[SpecialtyResult]
}

struct SpecialtyResult:Decodable {
    let Id:Int?
    let Name:String?
    let Description:String?
    let Status:Int?
}
struct Symptoms: Decodable {
    let Id: Int?
    let SymptomCategoryId: Int?
    let SymptomCategory: SymptomsCategory?
    let Name: String?
    let Description: Int?
    let Checked: Bool?
//    let AppointmentSymptomMaps: ?
}

struct SymptomsCategory: Decodable {
    let Id: Int?
    let Name: String?
    let Description: Int?
    
}

struct AppointmentDayList: Decodable {
    let Result: [AppointmentDayListResult]?
    let StatusCode: Int?
    let Message: String?

}

struct AppointmentDayListResult: Decodable {
    let Id: Int?
    let QueueNumber: Int?
    let DateOfAppointment: String?
    let Description: Int?
    let Checked: Bool?
    let Specialist: SpecialistName?
    
    
}

struct SpecialistName: Decodable {
    let FName: String?
    let Id: Int?
    let IsSpecialist: Bool?
}



// MARK: User's LIST Response

struct PatientListResponse: Decodable {
    let result: [PatientListResult]
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

// MARK: - PatientListResult
struct PatientListResult: Decodable {
    let id: Int
    let userName: String
    let email, phoneNumber: String?
    let emailConfirmed: Bool
//    let profile: Profile

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case userName = "UserName"
        case email = "Email"
        case phoneNumber = "PhoneNumber"
        case emailConfirmed = "EmailConfirmed"
//        case profile = "Profile"
    }
}

// MARK: GetAppoinmentList Response
struct AppointmentListResponse: Decodable {
    let result: [AppointmentListResult]
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

struct Encounter: Decodable {
    let Id: Int?
    let Zoom_id:Int?
    let Zoom_topic:String?
    let Zoom_join_url:String?
    let UniqueId, DisplayId: String?
    let EncounterStatus:Int?
}

//// MARK: - Encounter
//struct Encounter: Decodable {
//    let id: Int
//    let uniqueID, displayID: String
////    let featureType: JSONNull?
//    let featureReferenceID, encounterStatus, appointmentID: Int
////    let appointment: JSONNull?
//    let specialistUserID: Int
////    let specialist, specialistIDEnc: JSONNull?
//    let patientUserID: Int
////    let patient, patientIDEnc, encounterDescription, dtFormatted: JSONNull?
////    let subject: JSONNull?
//    let priority: Int
//    let dtEncounter, dtEncounterFormatted: String
////    let extraInfo: JSONNull?
////    let connectChatsOneToOne, progressNotes: [JSONAny]
//    let zoomUUID: String
//    let zoomID: Int
////    let zoomHostID: JSONNull?
////    let zoomTopic, zoomAgenda: String
//    let zoomType: Int
////    let zoomStartTime: Date
////    let zoomDuration: Int
////    let zoomTimezone: String
////    let zoomCreatedAt: JSONNull?
////    let zoomJoinURL: String
////    let zoomH323Password: String
//
//    enum CodingKeys: String, CodingKey {
//        case id = "Id"
//        case uniqueID = "UniqueId"
//        case displayID = "DisplayId"
////        case featureType = "FeatureType"
//        case featureReferenceID = "FeatureReferenceId"
//        case encounterStatus = "EncounterStatus"
//        case appointmentID = "AppointmentId"
////        case appointment = "Appointment"
//        case specialistUserID = "SpecialistUserId"
////        case specialist = "Specialist"
////        case specialistIDEnc = "SpecialistIdEnc"
//        case patientUserID = "PatientUserId"
////        case patient = "Patient"
////        case patientIDEnc = "PatientIdEnc"
////        case encounterDescription = "Description"
////        case dtFormatted = "DtFormatted"
////        case subject = "Subject"
//        case priority = "Priority"
//        case dtEncounter = "DtEncounter"
//        case dtEncounterFormatted = "DtEncounterFormatted"
////        case extraInfo = "ExtraInfo"
////        case connectChatsOneToOne = "ConnectChatsOneToOne"
////        case progressNotes = "ProgressNotes"
//        case zoomUUID = "Zoom_uuid"
//        case zoomID = "Zoom_id"
////        case zoomHostID = "Zoom_host_id"
////        case zoomTopic = "Zoom_topic"
////        case zoomAgenda = "Zoom_agenda"
//        case zoomType = "Zoom_type"
////        case zoomStartTime = "Zoom_start_time"
////        case zoomDuration = "Zoom_duration"
////        case zoomTimezone = "Zoom_timezone"
////        case zoomCreatedAt = "Zoom_created_at"
////        case zoomJoinURL = "Zoom_join_url"
////        case zoomH323Password = "Zoom_h323_password"
//    }
//}

// MARK: - AppointmentResponse
struct AppointmentResponse: Decodable {
    let result: AppResultResponse
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

struct AppResultResponse:Decodable {
    let AppointmentId:Int?
}


// MARK: - Appointment Result
struct AppointmentListResult: Decodable {
    
    let id, PatientUserId: Int
    let patient: Patient
    let uniqueID, displayID: String

//    let specialistUserID: Int
    let specialist: SpecialistProfile
    let dateOfAppointment, startTimeOfAppointment, endTimeOfAppointment, reasonForAppointment: String
    let currentStatus: Int
    let isPooled, isConsultingAppointment, isEmergency, isAllDayAppointment: Bool
//  let closureNote: JSONNull?
//    let reasonForCancellation: String
//    let encounters: [Encounter]

    let priority: Int
    let followUpNeeded: Bool
//    let followUpReferenceAppointmentID, followUpNoteBySpecialist, followUpSchedule: JSONNull?
    let followUpScheduleBetweenFrom, followUpScheduleBetweenTo, preferredModeOfContact: String
    let appointmentTimeSlotMaps: [AppointmentTimeSlotMap]

    enum CodingKeys: String, CodingKey {
        case uniqueID = "UniqueId"
        case displayID = "DisplayId"
        case id = "Id"
        case PatientUserId = "PatientUserId"
        case patient = "Patient"
//        case specialistUserID = "SpecialistUserId"
        case specialist = "Specialist"
        case dateOfAppointment = "DateOfAppointment"
        case startTimeOfAppointment = "StartTimeOfAppointment"
        case endTimeOfAppointment = "EndTimeOfAppointment"
        case reasonForAppointment = "ReasonForAppointment"
        case currentStatus = "CurrentStatus"
        case isPooled = "IsPooled"
        case isConsultingAppointment = "IsConsultingAppointment"
        case isEmergency = "IsEmergency"
        case isAllDayAppointment = "IsAllDayAppointment"
//        case closureNote = "ClosureNote"
//        case reasonForCancellation = "ReasonForCancellation"
//        case encounters = "Encounters"

        case priority = "Priority"
        case followUpNeeded = "FollowUpNeeded"
//        case followUpReferenceAppointmentID = "FollowUpReferenceAppointmentId"
//        case followUpNoteBySpecialist = "FollowUpNoteBySpecialist"
//        case followUpSchedule = "FollowUpSchedule"
        case followUpScheduleBetweenFrom = "FollowUpScheduleBetweenFrom"
      case followUpScheduleBetweenTo = "FollowUpScheduleBetweenTo"
        case preferredModeOfContact = "PreferredModeOfContact"
        case appointmentTimeSlotMaps = "AppointmentTimeSlotMaps"
    }
}

// MARK: - AppointmentTimeSlotMap
struct AppointmentTimeSlotMap: Decodable {
    let id, appointmentID: Int
    let appointment: JSONNull?
    let specialistWeeklyScheduleTimeSlotMapID: Int
    let specialistWeeklyScheduleTimeSlotMap: SpecialistWeeklyScheduleTimeSlotMap
    let checked: Bool

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case appointmentID = "AppointmentId"
        case appointment = "Appointment"
        case specialistWeeklyScheduleTimeSlotMapID = "SpecialistWeeklyScheduleTimeSlotMapId"
        case specialistWeeklyScheduleTimeSlotMap = "SpecialistWeeklyScheduleTimeSlotMap"
        case checked = "Checked"
    }
}


// MARK: - SpecialistWeeklyScheduleTimeSlotMap
struct SpecialistWeeklyScheduleTimeSlotMap: Decodable {
    let id, weeklyScheduleID: Int
    let weeklySchedule: WeeklySchedule
    let timeFrom, timeTo: String
    let checked: Bool
    let timeFromFormatted, timeToFormatted: JSONNull?
    let available: Bool
    let extraInfo: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case weeklyScheduleID = "WeeklyScheduleId"
        case weeklySchedule = "WeeklySchedule"
        case timeFrom = "TimeFrom"
        case timeTo = "TimeTo"
        case checked = "Checked"
        case timeFromFormatted = "TimeFromFormatted"
        case timeToFormatted = "TimeToFormatted"
        case available = "Available"
        case extraInfo = "ExtraInfo"
    }
}

// MARK: - WeeklySchedule
struct WeeklySchedule: Decodable {
    let id, specialistProfileID: Int
    let specialist: JSONNull?
    let weekDay: Int
    let available: Bool
    let extraInfo: JSONNull?
    let weeklyScheduleTimeSlotMaps: [String]

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case specialistProfileID = "SpecialistProfileId"
        case specialist = "Specialist"
        case weekDay = "WeekDay"
        case available = "Available"
        case extraInfo = "ExtraInfo"
        case weeklyScheduleTimeSlotMaps = "WeeklyScheduleTimeSlotMaps"
    }
}

// MARK: - Patient
struct Patient: Decodable {
    let id: Int?
    let userName: String?
    let profile: AppointmentProfile

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case userName = "UserName"
        case profile = "Profile"
    }
}

// MARK: Specialist Profile
struct SpecialistProfile: Decodable {
    let id: Int?
    let userName: String?
    let profile: AppointmentProfile

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case userName = "UserName"
        case profile = "Profile"
    }
}

// MARK: - Profile
struct AppointmentProfile: Decodable {
    let id: Int?
    let fName, lName: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case fName = "FName"
        case lName = "LName"
    }
}

//struct SendSymptoms {
//    let id:String
//    let checked : Bool
//    init(id:String,checked:Bool) {
//        self.id = id
//        self.checked = checked
//    }
//
//}


// MARK: - EncountersListResponse
struct EncountersListResponse: Decodable {
    let result: [EncounterResult]
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

// MARK: - Result
struct EncounterResult: Decodable {
    let id: Int
    let uniqueID, displayID: String
    let encounterStatus, appointmentID, specialistID, patientID: Int
    let zoomID: Int
    let zoomUUID: String
//    let zoomH323Password: JSONNull?
//    let zoomType: Int
//    let zoomStartTime, zoomTimezone: JSONNull?
//    let zoomDuration: Int
//    let zoomJoinURL, zoomTopic, zoomAgenda: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case uniqueID = "UniqueId"
        case displayID = "DisplayId"
        case encounterStatus = "EncounterStatus"
        case appointmentID = "AppointmentId"
        case specialistID = "SpecialistId"
        case patientID = "PatientId"
        case zoomID = "Zoom_id"
        case zoomUUID = "Zoom_uuid"
//        case zoomH323Password = "Zoom_h323_password"
//        case zoomType = "Zoom_type"
//        case zoomStartTime = "Zoom_start_time"
//        case zoomTimezone = "Zoom_timezone"
//        case zoomDuration = "Zoom_duration"
//        case zoomJoinURL = "Zoom_join_url"
//        case zoomTopic = "Zoom_topic"
//        case zoomAgenda = "Zoom_agenda"
    }
}

// MARK: Edit AppointmentStatus Response
struct EditAppStatusResponse:Decodable {
    let Message:String?
    let StatusCode:Int?
    let Result:String?
}
// MARK: - SingleAppoinmentResponse
struct SingleAppoinmentResponse: Decodable {
    
    let result: SingleResult
    let statusCode: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case statusCode = "StatusCode"
        case message = "Message"
    }
}

// MARK: - Result
struct SingleResult: Decodable {
    let uniqueID, displayID: String

    let id, patientID: Int
    let patient: Patient
    let specialistUserID: Int
    let specialist: Patient
    let dateOfAppointment, startTimeOfAppointment, endTimeOfAppointment, reasonForAppointment: String
    let currentStatus: Int
    let isPooled, isConsultingAppointment, isEmergency, isAllDayAppointment: Bool
//    let closureNote: JSONNull?
//    let reasonForCancellation: String
    let priority: Int
    let followUpNeeded: Bool
//    let followUpReferenceAppointmentID, followUpNoteBySpecialist, followUpSchedule: JSONNull?
    let followUpScheduleBetweenFrom, followUpScheduleBetweenTo, preferredModeOfContact: String
    let appointmentSymptomMaps: [AppointmentSymptomMap]
    let encounters: [Encounter]
    let appointmentTimeSlotMaps: [AppointmentTimeSlotMap]

    enum CodingKeys: String, CodingKey {
        case uniqueID = "UniqueId"
        case displayID = "DisplayId"
        case id = "Id"
        case patientID = "PatientId"
        case patient = "Patient"
        case specialistUserID = "SpecialistUserId"
        case specialist = "Specialist"
        case dateOfAppointment = "DateOfAppointment"
        case startTimeOfAppointment = "StartTimeOfAppointment"
        case endTimeOfAppointment = "EndTimeOfAppointment"
        case reasonForAppointment = "ReasonForAppointment"
        case currentStatus = "CurrentStatus"
        case isPooled = "IsPooled"
        case isConsultingAppointment = "IsConsultingAppointment"
        case isEmergency = "IsEmergency"
        case isAllDayAppointment = "IsAllDayAppointment"
//        case closureNote = "ClosureNote"
//        case reasonForCancellation = "ReasonForCancellation"
        case priority = "Priority"
        case followUpNeeded = "FollowUpNeeded"
//        case followUpReferenceAppointmentID = "FollowUpReferenceAppointmentId"
//        case followUpNoteBySpecialist = "FollowUpNoteBySpecialist"
//        case followUpSchedule = "FollowUpSchedule"
        case followUpScheduleBetweenFrom = "FollowUpScheduleBetweenFrom"
        case followUpScheduleBetweenTo = "FollowUpScheduleBetweenTo"
        case preferredModeOfContact = "PreferredModeOfContact"
        case appointmentSymptomMaps = "AppointmentSymptomMaps"
        case encounters = "Encounters"
        case appointmentTimeSlotMaps = "AppointmentTimeSlotMaps"
    }
}

// MARK: - AppointmentSymptomMap
struct AppointmentSymptomMap: Decodable {
    let id, appointmentID: Int
    let appointment: JSONNull?
    let symptomID: Int
    let symptom: Symptom
    let userID: Int
    let userIDEnc, userRoles: JSONNull?
    let dtCreated: String
    let dtCreatedFormatted: JSONNull?
    let createdBy: Int
    let createdByProfile: JSONNull?
    let dtUpdated: String
    let dtUpdatedFormatted: JSONNull?
    let updatedBy: Int
    let updatedByProfile: JSONNull?
    let status: Int
    let deleted: Bool
    let deletedBy: Int

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case appointmentID = "AppointmentId"
        case appointment = "Appointment"
        case symptomID = "SymptomId"
        case symptom = "Symptom"
        case userID = "UserId"
        case userIDEnc = "UserIdEnc"
        case userRoles = "UserRoles"
        case dtCreated = "DtCreated"
        case dtCreatedFormatted = "DtCreatedFormatted"
        case createdBy = "CreatedBy"
        case createdByProfile = "CreatedByProfile"
        case dtUpdated = "DtUpdated"
        case dtUpdatedFormatted = "DtUpdatedFormatted"
        case updatedBy = "UpdatedBy"
        case updatedByProfile = "UpdatedByProfile"
        case status = "Status"
        case deleted = "Deleted"
        case deletedBy = "DeletedBy"
    }
}

// MARK: - Symptom
struct Symptom: Decodable {
    let id, symptomCategoryID: Int
    let symptomCategory: SymptomCategory
    let name: String
    let symptomDescription: JSONNull?
    let appointmentSymptomMaps: [AppointmentSymptomMap]
    let checked: Bool

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case symptomCategoryID = "SymptomCategoryId"
        case symptomCategory = "SymptomCategory"
        case name = "Name"
        case symptomDescription = "Description"
        case appointmentSymptomMaps = "AppointmentSymptomMaps"
        case checked = "Checked"
    }
}

// MARK: - SymptomCategory
struct SymptomCategory: Decodable {
    let id: Int
    let name: String
    let symptomCategoryDescription: JSONNull?
//    let symptoms: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case symptomCategoryDescription = "Description"
//        case symptoms = "Symptoms"
    }
}

