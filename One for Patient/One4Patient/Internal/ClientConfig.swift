//
//  MedicoDefaults.swift
//  Medico
//
//  Created by Praneeth Althuru on 21/03/18.
//  Copyright © 2018 a2aoptima. All rights reserved.
//

import Foundation



struct ClientConfig {

    static var BASE_URL = "http://api.one4patient.com/api"
    static var Image_Base_Url = "http://api.one4patient.com/api"
    static var server_Key  = "AAAAFj4TwBE:APA91bEDmrdhUpBRbKnJkDZNE4dXbnJ2TcOb8aUInlh93AtTdMTuvxnBmVKX9DF6C00BnS-VI0lWiZ2d4Br6O2ZaNLetxNM2xAGj-PMDERSewlkMLl8NzQIBPm4haK9XWAbudXmcpaPM"
}

struct ClientInterface {
    
//     MARK: LOGIN Url's
    static var patientRegisterUrl = ClientConfig.BASE_URL + "/Identity/Account/PatientRegister"
    static var patientLoginUrl = ClientConfig.BASE_URL + "/Identity/Account/Login"
    static var forgotPasswordUrl = ClientConfig.BASE_URL + "/Identity/Account/ResetPassword_RequestPasscode"
    static var validatePasscodeUrl = ClientConfig.BASE_URL + "/Identity/Account/ResetPassword_ValidatePasscode"
    static var resetPasswordUrl = ClientConfig.BASE_URL + "/Identity/Account/ResetPassword"
    static var changePasswordUrl = ClientConfig.BASE_URL + "/Identity/Account/Manage/ChangePassword"
    static var requestPassCodeUrl = ClientConfig.BASE_URL + "/Identity/Account/RequestPasscode"
    static var loginWithPassCodeUrl = ClientConfig.BASE_URL + "/Identity/Account/LoginWithPasscode"
    static var changePassUrl = ClientConfig.BASE_URL + "/Identity/Account/Manage/ChangePassword"
    static var requestResetPasswordUrl = ClientConfig.BASE_URL + "/Identity/Account/RequestResetPassword"
//   MARK: Add Member Url
    static var addMemberUrl = ClientConfig.BASE_URL + "/Patient/Subscriptions/AddMember"
    
// MARK: Image url's
    static var imageUrl = ClientConfig.BASE_URL + "/Profile/PersonalInfos/EditProfilePic?Id=" + "\(GlobalVariables.profileID)"

//    MARK: SPECIALIST Url's
    static var splRegisterUrl = ClientConfig.BASE_URL + "/Identity/Account/SpecialistRegister"

//    MARK: User's List Url
    static var getPatientsListUrl = ClientConfig.BASE_URL + "/Patients"
    static var getDoctorsListUrl  = ClientConfig.BASE_URL + "/Specialists"
    
//    MARK: Account Details Url's
    static var getAccountUrl = ClientConfig.BASE_URL + "/Identity/Account/Manage"
    static var updateAccountUrl = ClientInterface.getAccountUrl
    static var getProfileUrl = ClientConfig.BASE_URL + "/Profile/PersonalInfos"
    static var updateProfileUrl = ClientConfig.BASE_URL + "/Profile/PersonalInfos/EditBasicDetails?Id=" + "\(GlobalVariables.profileID)"
    static var updateAddressUrl = ClientConfig.BASE_URL + "/Profile/PersonalInfos/EditAddressDetails?Id=" + "\(GlobalVariables.profileID)"
   
    
    
//    MARK: Eduacation Url
    static var getEducationUrl = ClientConfig.BASE_URL + "/Profile/Educations/GetByProfileId?ProfileId=" + "\(GlobalVariables.profileID)"
    static var getSpecilazationUrl = ClientConfig.BASE_URL + "/Profile/Specializations/GetByProfileId?ProfileId=" + "\(GlobalVariables.profileID)"
    static var postSpecilizationUrl = ClientConfig.BASE_URL + "/Profile/Specializations"
    static var postEducationUrl = ClientConfig.BASE_URL + "/Profile/Educations"
    static var delEducationUrl = ClientConfig.BASE_URL + "/Profile/Educations/" + "\(GlobalVariables.educationID)"
    static var delSpecializationlUrl = ClientConfig.BASE_URL + "/Profile/Specializations/" + "\(GlobalVariables.educationID)"
    
//  MARK: Subsrciption Url
    static var masterSubscriptions = ClientConfig.BASE_URL + "/Admin/MasterSubscriptions"
    
//    MARK: Appointment Url's
    static var specialistListUrl = ClientConfig.BASE_URL + "/Profiles/GetSpecialists"
    static var symptomsListUrl = ClientConfig.BASE_URL + "/Admin/MasterSymptoms"
    static var appointmentListUrl = ClientConfig.BASE_URL + "/Appointments/GetAppointments"
    static var getAppbyIDUrl =  ClientConfig.BASE_URL + "/Appointments/"
    static var postAppoinmentUrl = ClientConfig.BASE_URL + "/Appointments"
    static var getSpecialityUrl = ClientConfig.BASE_URL + "/Admin/MasterMedicalSpecialities"
    static var getSplbySpltyUrl = ClientConfig.BASE_URL + "/Profile/SpecialistSpecialities/GetSpecialistsForSelectedSpeciality?MedicalSpecialityId=" + "\(GlobalVariables.specialityID)"
    static var getAllSplListUrl = ClientConfig.BASE_URL + "/Specialists"
    static var getTimeSlotsUrl = ClientConfig.BASE_URL + "/Profile/SpecialistWeeklySchedules/GetBySpecialistId?SpecialistId=" + GlobalVariables.specialistID
      
    static var EditAppStatusUrl = ClientConfig.BASE_URL + "/Appointments/" + GlobalVariables.appointmentID + "/EditStatus"
    
    
//    MARK: Encounter's Details
    static var getEncountersList = ClientConfig.BASE_URL + "/Appointment/Encounters/GetByAppointmentId?AppointmentId="
    
    
    
//    MARK: Get Family  Details Url
    static var GetFamilyUrl = ClientConfig.BASE_URL + "/Patient/Subscriptions/GetMemberSubscriptions"
//    GET My Subscription Details Url
    static var mySubscriptionUrl = ClientConfig.BASE_URL + "/Patient/Subscriptions/GetMySubscription"
    
// MARK: Health Summary Url's
    
//    MARK: Medication History
    static var medicationUrl = ClientConfig.BASE_URL + "/Patient/MedicalState/MedicationHistories"
    static var deleteMedicationUrl = ClientConfig.BASE_URL + "/Patient/MedicalState/MedicationHistories/Delete/" 
    
    
//    MARK: Allergy Url
    static var allergyUrl = ClientConfig.BASE_URL + "/Patient/MedicalState/AllergyHistories"
    static var deleteAllergyUrl = ClientConfig.BASE_URL + "/Patient/MedicalState/AllergyHistories/Delete/" 
    static var allergyListurl = ClientConfig.BASE_URL + "/Admin/Master/Allergies"

    //    MARK: Habits History
    static var habitsUrl = ClientConfig.BASE_URL + "/Patient/MedicalState/Habits"
    static var deleteHabitUrl = ClientConfig.BASE_URL + "/Patient/MedicalState/Habits/Delete/" 
    
    //    MARK: Medical Conditons
    static var MConditionUrl = ClientConfig.BASE_URL + "/Patient/MedicalState/MedicalConditions"
    static var deleteMConditionUrl = ClientConfig.BASE_URL + "/Patient/MedicalState/MedicalConditions/Delete/" 
    
    
}

//MARK: GLobal Variables

struct GlobalVariables {
    static var savedSymptoms = [String]()
    static var addedSymptoms:[String] = []
    static var specialityID = ""
    static var timeSlot = ""
    static var appointmentDate =  ""
    static var specialistID = ""
    static var profileID = ""
    static var appointmentID = ""
    static var accountID = ""
    static var viewAppointments:Bool = false
    static var firstName = ""
    static var lastName = ""
    static var userName = ""
    static var userEmail = ""
    static var token = ""
    static var educationID = ""
    static var isDoctor:Bool = false
    static var medicationID = ""
    static var habitID = ""
    static var allergyID = ""
    static var MConditionID = ""
    static var SPName = ""
    static var deviceID = ""
    static var fcmToken = ""
    static var appointmentStatus:Int?
    static var patientName = ""
}


struct ZoomDetails {
    static var ZoomID = ""
    static var ZoomUrl = ""
    static var ZoomTopic = ""
}


struct BookingFor {
    static var userId  = ""
    static var userName = ""
    static var userEmail = ""
    static var isUserSelected:Bool = false 
}







