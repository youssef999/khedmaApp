import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'greeting': 'Hello',
          'image_ratio': 'Image resolution be 1920:1080',
          'login': 'Login',
          'logout': 'Log out',
          'register': 'Register',
          'create_an_account': 'Create an Account',
          'dont_have_an_account': 'Don\'t have an account?',
          'email': 'Email',
          'password': 'Password',
          'password_confirm': 'Password Confirm',
          'confirm': 'Confirm',
          'please_enter_a_valid_email': 'Please enter a valid email',
          'forget_pass': 'Forgot your password?',
          'remember': 'Remember me',
          'or_login_with': 'Or Login With',
          'personal_info': 'Personal Info',
          "next": "Next",
          "name": "Name",
          "first_name": "First Name",
          "last_name": "Last Name",
          "done": "Done",
          "religion": "Religion",
          "phone_number": "Phone Number",
          "message": "Message",
          "phone": "Phone",
          "choose": "Choose",
          "select": "Select",
          "nationality": "Nationality",
          "optional": "Optional",
          "job": "Job",
          "jobs": "Jobs",
          "address_info": "Address Info",
          "city": "City",
          "country": "Country",
          "region": "Region",
          "street": "Street",
          "building": "Building",
          "adn": "Automated address number",
          "piece_num": "Piece Number",
          "id_proof": "Identity proof",
          "id_number": "Id Number",
          "ref_number": "Refernce Number",
          "upload_id": "Upload an ID Photo or passport",
          "upload_docs": "Upload Documents",
          "upload_category_icon": "Upload Category Icon",
          "upload_job_icon": "Upload Job Icon",
          "upload_service_icon": "Upload Service Icon",
          "id_photo": "ID Photo",
          "id_photo_front": "Front side of ID",
          "id_photo_back": "Back side of ID",
          "upload_personal_photo": "Upload Personal Photo",
          "security": "Security",
          "otp_text_1": "Confirm Your Email",
          "otp_text_2": "Type the code that you received on the email",
          "otp_text_3": "Didn't get any code?",
          "otp_text_4": "Resend",
          "send": "Send",
          "hello": "Hello",
          "all": "All",
          "services": "Services",
          "rec_com": "Recruitment companies",
          "cl_com": "Cleaning companies",
          "cleaner": "Cleaner",
          "driver": "Driver",
          "chef": "Chef",
          "babysitter": "Babysitter",
          "nurse": "Nurse",
          "sewing": "Sewing",
          "washing": "Washing",
          "per_hour": "Per Hour",
          "per_year": "Per Year",
          "per_treatment": "Per Treatment",
          "user_type_text": "You are registering as",
          "company": "Company",
          "user": "User",
          "closest": "Closest",
          "close": "Close",
          "best": "Best",
          "cheapest": "Cheapest",
          "employee_filter_page": "Set filters for employees",
          "booking_filter_page": "Set filters for Bookings",
          "ads_filter_page": "Set filters for Advertisments",
          "age": "Age",
          "gender": "Gender",
          "male": "Male",
          "single": "Single",
          "female": "Female",
          "married": "Married",
          "marital_status": " Marital Status",
          "status": "Status",
          "employees": "Employees",
          "s_languages": "Spoken Languages",
          "apply": "Apply",
          "complete_data": "Complete this data",
          "office_warrently": "Office warranty",
          "offers": "Offers",
          "rate_view": "Rating and reviews",
          "payment": "Payment",
          "contracts": "Contracts",
          "agree": "I agree",
          "download": "Download",
          "share": "Share",
          "notifications": "Notifications",
          "invoice": "Invoice",
          "categories": "Categories",
          "create_category": "Create a new category",
          "create_job": "Create a new job",
          "create_service": "Create a new Service",
          "price": "Price",
          "total": "Total",
          "delivery": "Delivery",
          "filling_data": "Filling Data",
          "start_date": "Start Date",
          "date_of_birth": "Date of birth",
          "living_town": "Living town",
          "birth_place": "Birth place",
          "end_date": "End Date",
          "settings": "Settings",
          "owner_info": "Owner Info",
          "company_info": "Company Info",
          "company_name": "Company name",
          "company_type": "Company type",
          "type": "Type",
          "company_types": "Company types",
          "url": "Url",
          "docs": "Documents",
          "write_your_email": "Write Your Email",
          "write_your_ph_num": "Write Your Phone Number",
          "reset_password": "Reset Password",
          "try_ph_num": "Try with your Phone Number",
          "try_email": "Try with your Email",
          "add_advertisment": "Add Advertisment",
          "add_employee": "Add new employee",
          "new": "new",
          "upload": "Upload",
          "photo": "Photo",
          "duration": "Duration",
          "day": "Day",
          "promotion_url": "Promotion Url",
          "company_page": "Company page",
          "external_link": "External link",
          "add": "Add",
          "added": "Added",
          "total_balance": "Total balance",
          "booking_no": "Bookings No.",
          "bookings_payments": "Bookings payments",
          "bookings": "Bookings",
          "payments": "Payments",
          "ads_payment": "Payments of Ads.",
          "ads": "Advertisments",
          "users_no": "Users No.",
          "rec_com_no": "Recruitment companies No.",
          "clean_com_no": "Cleaning companies No.",
          "reports": "Reports",
          "user_profiles": "User Profiles",
          "company_profiles": "Company Profiles",
          "no_of_children": "Children No.",
          "weight": "Weight",
          "height": "Height",
          "complexion": "Complexion",
          "passport_data": "Passport data",
          "passport_number": "Passport number",
          "issue_date": "Issue date",
          "issue_place": "Issue place",
          "expiry_date": "Expiry date",
          "work_info": "Work info",
          "other_data": "Other data",
          "cancel": "Cancel",
          "canceled": "Canceled",
          "retrieved": "Retrieved",
          "ok": "Ok",
          "search": "Search",
          "no": "No",
          "yes": "Yes",
          "is_offer": "Is there offer",
          "monthly_salery": "Monthly salery",
          "hour_salery": "Hour salery",
          "previous_work_abroad": "Previous work abroad",
          "duration_of_employment": "Duration of employment",
          "educational_certificates": "Educational certificates",
          "knowledge_of_languages": "Knowledge of languages",
          "contract_duration": "Contract duration",
          "contract_amount": "Contract amount",
          "nothing_found": "Nothing Found!!",
          "commercial_info": "Commercial information",
          "commercial_reg_number": "Commercial registration number",
          "tax_number": "Tax number",
          "license_number": "license number",
          "upload_company_logo": "Upload Company Logo",
          "upload_admin_logo": "Upload Admin Logo",
          "recruitment": "Recruitment",
          "cleaning": "Cleaning",
          "general_info": "General Info",
          "upload_front_side_of_id": "Upload front side of ID",
          "upload_back_side_of_id": "Upload back side of ID",
          "upload_your_passport": "Upload passport",
          "identity_confirmation_by": "Identity confirmation by",
          "id": "ID",
          "passport": "Passport",
          "submit": "Submit",
          "successfully": "Successfully",
          "you_have_been_registered": "You have been registered",
          "your_advertisment_has_added": "Your advertisment has added",
          "your_data_have_been_completed": "Your data have been completed",
          "your_note_have_been_sent": "Your note have been sent",
          "code_has_been_sent": "code has been sent",
          "your_email_have_been_confirmed": "Your email have been confirmed",
          "the_documents_have_been_sent": "The documents have been sent",
          "add_your": "Add your",
          "edit_your": "Edit your",
          "ad": "Advertisment",
          "check_your_phone_messages": "Check Your phone messages",
          "check_your_email": "Check Your Email",
          "phone_c":
              "Messages will be sent to your phone please check the message",
          "email_c":
              "Messages will be sent to your email please check the message",
          "change_password": "Change Password",
          "password_changed": "Password changed",
          "current_password": "Current Password",
          "new_password": "New Password",
          "confirm_password": "Confirm Password",
          "save": "Save",
          "edit": "Edit",
          "delete": "Delete",
          "parent_type": "Parent type",
          "create": "Create",
          "name_ar": "Name in Arabic",
          "short_name": "Short name",
          "name_en": "Name in English",
          "unique_name": "Unique name",
          "my_ads": "My advertisments",
          "comment": "Comment",
          "refund": "Refund",
          "refund_requests": "Refund Requests",
          "today": "Today",
          "yesterday": "yesterday",
          "before": "before",
          "booking_date": "RecruuitmentBooking date",
          "specific_date": "Specific date",
          "from_to": "From - To",
          "requests": "Requests",
          "refunds": "Refunds",
          "history": "History",
          "accept": "Accept",
          "approve": "Approve",
          "refuse": "Refuse",
          "accepted": "Accepted",
          "refused": "Refused",
          "write_your_notes": "Write your notes",
          "account_statment": "Account Statment",
          "depositor": "Depositor",
          "beneficiary": "Beneficiary",
          "amount": "Amount",
          "payment_date": "Payment Date",
          "deposit_type": "Deposit type",
          "pending": "Pending",
          "booked": "Booked",
          "not_booked": "Not Booked",
          "language": "Language",
          "edit_profile": "Edit Profile",
          "about_app": "About Application",
          "work_time_per_day": "Work time per day",
          "employee_added": "Employee added",
          "amount_after_disccount": "Amount after disccount",
          "my_cart": "My cart",
          "quantity": "Quantity",
          "cities": "Cities",
          "countries": "Countries",
          "regions": "Regions",
          "addresses": "Addresses",
          "create_new": "Create new",
          "langs": "Languages",
          "contact": "Contact",
          "messages": "Messages",
          "profile_edited": "Profile edited",
          "my_bookings": "My bookings",
          "favourites": "Favourites",
          "years": "Years",
          "year": "Year",
          "did_not_work_abroad": "Did not work abroad!!",
          "overview": "Overview",
          "all_employees": "All Employees",
          "available": "Available",
          "more_details": "More details",
          "flag": "Flag",
          "code": "Code",
          "nationality_ar": "Nationality (AR)",
          "nationality_en": "Nationality (En)",
          "currency": "Currency",
          "short_currency": "Short Currency",
          "commissions": "Commissions",
          "commssion_recruitment_type": "Commssion recruitment type",
          "commssion_clean_type": "Commssion general type",
          "commssion_recruitment": "Commssion recruitment",
          "commssion_clean": "Commssion general",
          "rate": "Rate",
          "fixed": "Fixed",
          "advertisment_price": "Advertisment price",
          "end_date_pending_employee": "Days to reserve workers",
          "price_pending_employee": "ًorkers reservation price",
          "send_message": "Send a message",
          "block": "Block",
          "un_block": "Unblock",
          "book": "Book",
          "submit_docs": "Submit documents to the company",
          "finished_procedure_of": "Finished the procedure of",
          "view": "View",
          "active": "Active",
          "disable": "Disable",
          "drop_downs": "Personal status",
          "reservation_request": "Reservation extension request",
          "days_required": "Days required",
          "reason": "Reason",
          "employees_requests": "Booking",
          "reservation_requests": "Extend the booking",
          "show_files": "Show files",
          "medical_exam": "Medical examination request",
          "medical_exams": "Medical examination requests",
          "medical_exam_price": "Medical examination price",
          "missing_files": "Missing files",
          "choose_service": "Choose service",
          "date": "Date",
          "employee_name": "Employee name",
          "company_headquarters": "Company Headquarters",
          "representative_from_the_company": "Representative from the company",
          "representative_from_the_application":
              "Representative from the application",
          "address": "Address",
          "khedma_cleaning_price": "Khedma representative fees",
          "cleaning_price": "Service price",
          "bank_details": "Bank Details",
          "bank_name": "Bank name",
          "bank_account_name": "Bank account name",
          "account_number": "Account number",
          "iban": "Iban",
          "geust": "Guest",
          "login_first": "Login first",
          "pay": "Pay",
          "pay_method": "Payment Method",
          "contract": "Ministry of Interior contract",
          "final_contract": "Triple recruitment contract",
          "about": "About",
          "order": "Order",
          "rate_us": "Rate us",
          "applicant": "Applicant",
          "receipt_method": "Receipt method",
          "orders": "Orders",
          "upload_files": "Upload files",
          "add_doc": "Add document",
          "camera": "Camera",
          "gallery": "Gallery",
          "can't_edit_employee": "Can't edit employee",
          "can't_delete_employee": "Can't delete employee",
          "data": "Data",
          "kwd": "KWD",
          "fingerprint": "Fingerprint",
          "protect_with_fingerprint": "Protect with fingerprint",
          "localizedReason": "Please authenticate to enter the app",
          "whatsapp": "Whatsapp",
          "pending_employee": "Pending employee",
          "checkout_cleaning_company": "Checkout cleaning company",
          "advertisement": "Advertisement",
          "signiture": "Signiture",
          "draw": "Draw",
          "commercial_license": "Commercial License",
          "articles_of_association": "Articles of Association",
          "signiture_auth": "Signiture Authorization",
          "clear": "Clear",
          "busy": "Busy",
          "all_cities": "All Cities",
          "active_text":
              "In order to activate your account, you must agree to upload the necessary documents listed below",
          "review_text": "Your documents are currently being reviewed",
          "report": "Report",
          "open": "Open",
          "delete_account": "Delete Account",
          "are_you_sure": "Are you sure",
          "unified_number": "Unified number",
          "desc": "Description",
          "file": "File",
        },
        'ar_SYR': {
          "desc": "الوصف",
          "file": "الملف",
          "unified_number": "الرقم الموحد",
          "are_you_sure": "هل أنت متأكد",
          "delete_account": "حذف الحساب",
          "open": "فتح",
          "report": "إبلاغ",
          "review_text": "تتم مراجعة وثائقك حالياً",
          "all_cities": "كل المدن",
          "active_text":
              "من أجل تفعيل حسابك يتوجب عليك الموافقة على رفع الوثائق اللازمة المدرجة أدناه",
          "busy": "مشغول",
          "clear": "مسح",
          "commercial_license": "رخصة سارية",
          "articles_of_association": "عقد التأسيس",
          "signiture_auth": "اعتماد التوقيع",
          "draw": "رسم",
          "signiture": "التوقيع",
          "whatsapp": "واتساب",
          "localizedReason": "يرجى المصادقة للدخول إلى التطبيق",
          "protect_with_fingerprint": "الحماية باستخدام البصمة",
          "fingerprint": "البصمة",
          "kwd": "د.ك",
          "data": "بيانات",
          "can't_edit_employee": "الموظف غير قابل للتعديل",
          "can't_delete_employee": "الموظف غير قابل للحذف",
          "gallery": "المعرض",
          "camera": "كاميرا",
          "add_doc": "اضف وثيقة",
          "upload_files": "رفع الملفات",
          "orders": "الطلبات",
          "receipt_method": "طريقة الاستلام",
          "applicant": "صاحب الطلب",
          "rate_us": "أعطنا تقييمك",
          "order": "الطلب",
          "about": "حول",
          "contract": "عقد وزارة الداخلية",
          "final_contract": "عقد الاستقدام الثلاثي",
          "pay_method": "وسيلة الدفع",
          "pay": "إدفع",
          "login_first": "سجل أولاً",
          "offers": "عروض",
          "geust": "الدخول كضيف",
          "bank_name": "اسم البنك",
          "bank_account_name": "اسم الحساب البنكي",
          "account_number": "رقم الحساب",
          "iban": "ايبان",
          "bank_details": "تفاصيل البنك",
          "cleaning_price": "سعر الخدمة",
          "khedma_cleaning_price": "رسوم مندوب خدمة",
          "address": "العنوان",
          "company_headquarters": "المقر الرئيسي للشركة",
          "representative_from_the_company": "ممثل من الشركة",
          "representative_from_the_application": "ممثل من التطبيق",
          "employee_name": "اسم الموظف",
          "date": "التاريخ",
          "choose_service": "اختر خدمة",
          "missing_files": "ملفات ناقصة",
          "medical_exam": "طلب فحص طبي",
          "medical_exams": "طلبات الفحوص الطبية",
          "medical_exam_price": "سعر الكشف الطبي",
          "show_files": "عرض الملفات",
          "employees_requests": "طلبات الحجز",
          "reservation_requests": "طلبات تمديد الحجز",
          "reason": "السبب",
          "days_required": "عدد الأيام اللازمة",
          "reservation_request": "طلب تمديد الحجز",
          "active": "تفعيل",
          "disable": "تعطيل",
          "view": "عرض",
          "finished_procedure_of": "أنهى المعاملة الخاصة بـ",
          "submit_docs": "رفع الملفات إلى الشركة",
          "book": "حجز",
          "block": "حظر",
          "un_block": "فك الحظر",
          "send_message": "أرسل لنا رسالة",
          "advertisment_price": "سعر الإعلان",
          "end_date_pending_employee": "عدد ايام حجز العمالة",
          "price_pending_employee": "عمولة حجز العمالة",
          "rate": "نسبة",
          "fixed": "ثابت",
          "commssion_recruitment_type": "نوع عمولة شركات التوظيف",
          "commssion_clean_type": "نوع عمولة الشركات العامة",
          "commssion_recruitment": "عمولة شركات التوظيف",
          "commssion_clean": "عمولة الشركات العامة",
          "commissions": "العمولات",
          "code": "رمز البلد",
          "nationality_ar": "الجنسية بالعربية",
          "nationality_en": "الجنسية بالإنجليزي",
          "currency": "العملة",
          "short_currency": "العملة القصيرة",
          "flag": "العلم",
          "more_details": "المزيد من التفاصيل",
          "all_employees": "كل الموظفون",
          "available": "متاح",
          "overview": "نظرة عامة",
          "did_not_work_abroad": "لم يعمل/تعمل في الخارج سابقاً!!",
          "years": "سنوات",
          "year": "سنة",
          "my_bookings": "حجوزاتي",
          "favourites": "المفضلة",
          "profile_edited": "تم تعديل الملف الشخصي",
          "contact": "الاتصال",
          "messages": "الرسائل",
          "langs": "اللغات",
          "create_new": "أنشئ",
          "cities": "المدن",
          "countries": "البلدان",
          "regions": "المناطق",
          "addresses": "العناوين",
          "quantity": "الكمية",
          "my_cart": "السلة",
          "amount_after_disccount": "السعر بعد التخفيض",
          "employee_added": "تم إضافة الموظف",
          "work_time_per_day": "وقت العمل في اليوم",
          "edit_profile": "تعديل الملف الشخصي",
          "about_app": "حول التطبيق",
          "language": "اللغة",
          "pending": "في الإنتظار",
          "booked": "محجوز",
          "not_booked": "غير محجوز",
          "depositor": "المودع",
          "beneficiary": "المستفيد",
          "amount": "المبلغ",
          "payment_date": "تاريخ الدفع",
          "deposit_type": "نوع الإيداع",
          "account_statment": "كشف الحساب",
          "accepted": "مقبول",
          "refused": "مرفوض",
          "write_your_notes": "إكتب ملاحظاتك",
          "accept": "قبول",
          "approve": "قبول",
          "refuse": "رفض",
          "requests": "الطلبات",
          "refunds": "الاسترداد",
          "history": "السجل",
          "booking_date": "تاريخ الحجز",
          "special_date": "تاريخ محدد",
          "from_to": "من - إلى",
          "before": "مسبقاً",
          "today": "اليوم",
          "yesterday": "البارحة",
          "refund": "إسترداد",
          "refund_requests": "طلبات الاسترداد",
          "comment": "ملاحظات",
          "my_ads": "إعلاناتي",
          "name_ar": "الاسم بالعربية",
          "short_name": "الاسم القصير",
          "name_en": "الاسم بالإنجليزية",
          "unique_name": "الاسم الفريد",
          "create": "إنشاء",
          "edit": "تعديل",
          "delete": "حذف",
          "parent_type": "النوع الأب",
          "save": "حفظ",
          "try_email": "إعادة تعيين باستخدام البريد الالكتروني",
          "check_your_phone_messages": "تفقد الرسائل في هاتفك",
          "check_your_email": "تفقد بريدك الإلكتروني",
          "phone_c": "سيتم إرسال الرسائل إلى هاتفك ، يرجى التحقق من الرسالة",
          "email_c":
              "سيتم إرسال الرسائل إلى بريدك الإلكتروني ، يرجى التحقق من الرسالة",
          "change_password": "تغيير كلمة السر",
          "password_changed": "تم تغيير كلمة السر",
          "current_password": "كلمة السر الحالية",
          "new_password": "كلمة السر الجديدة",
          "confirm_password": "تأكيد كلمة السر",
          "confirm": "تأكيد",
          "add_your": "أضف",
          "edit_your": "عدّل",
          "ad": "إعلانك",
          "the_documents_have_been_sent": "تم إرسال الوثائق",
          "your_email_have_been_confirmed": "لقد تم تأكيد بريدك الإلكتروني",
          "code_has_been_sent": "تم إرسال الرمز",
          "your_note_have_been_sent": "لقد تم إرسال ملاحظتك",
          "your_data_have_been_completed": "لقد اكتملت بياناتك",
          "your_advertisment_has_added": "تم إضافة إعلانك",
          "you_have_been_registered": "لقد قمت بالتسجيل",
          "successfully": "بنجاح",
          "submit": "إرسال",
          "identity_confirmation_by": "تأكيد الهوية بواسطة",
          "passport": "جواز السفر",
          "id": "الهوية الشخصية",
          "upload_front_side_of_id": "تحميل الجانب الأمامي من بطاقة الهوية",
          "upload_back_side_of_id": "تحميل الجانب الخلفي من بطاقة الهوية",
          "upload_your_passport": "تحميل جواز السفر",
          "general_info": "معلومات عامة",
          "cleaning": "تنظيف",
          "recruitment": "توظيف",
          "upload_company_logo": "رفع شعار الشركة",
          "upload_admin_logo": "رفع شعار الأدمن",
          "commercial_info": "معلومات تجارية",
          "commercial_reg_number": "رقم السجل التجاري",
          "tax_number": "الرقم الضريبي",
          "license_number": "رقم الترخيص",
          "nothing_found": "لا يوجد أي شيء!!",
          "contract_duration": "مدة العقد",
          "contract_amount": "قيمة العقد",
          "no": "لا",
          "yes": "نعم",
          "is_offer": "هل يوجد عرض",
          "monthly_salery": "الراتب الشهري",
          "hour_salery": "الراتب في الساعة",
          "previous_work_abroad": "سبق وعمل بالخارج",
          "duration_of_employment": "مدة التوظيف",
          "educational_certificates": "الشهادات التعليمية",
          "knowledge_of_languages": "معرفة باللغات",
          "ok": "موافق",
          "search": "بحث",
          "cancel": "الغاء",
          "canceled": "ملغى",
          "retrieved": "معاد",
          "other_data": "معلومات اخرى",
          "work_info": "معلومات العمل",
          "passport_data": "بيانات جواز السفر",
          "passport_number": "رقم جواز السفر",
          "issue_date": "تاريخ اصدار الجواز",
          "issue_place": "مكان اصدار الجواز",
          "expiry_date": "تاريخ الانتهاء",
          "complexion": "البشرة",
          "weight": "الوزن",
          "height": "الطول",
          "no_of_children": "عدد الأولاد",
          "user_profiles": "ملفات المستخدمين الشخصية",
          "company_profiles": "ملفات الشركات الشخصية",
          "bookings_payments": "مدفوعات الحجوزات",
          "bookings": "الحجوزات",
          "reports": "التقارير",
          "booking_no": "عدد الحجوزات",
          "payments": "المدفوعات",
          "ads_payment": "دفعات الإعلانات",
          "ads": "الإعلانات",
          "users_no": "عدد المستخدم",
          "rec_com_no": "عدد شركات التوظيف",
          "clean_com_no": "عدد شركات التنظيف",
          "total_balance": "إجمالي الرصيد",
          "add": "إضافة",
          "added": "تمت الإضافة",
          "day": "يوم",
          "company_page": "صفحة الشركة",
          "external_link": "رابط خارجي",
          "promotion_url": "العنوان الترويجي",
          "duration": "المدة",
          "add_advertisment": "إضافة إعلان",
          "add_employee": "إضافة موظف جديد",
          "new": "جديد",
          "upload": "رفع",
          "photo": "صورة",
          "try_ph_num": "إعادة تعيين باستخدام رقم الهاتف",
          "reset_password": "إعادة تعيين كلمة المرور",
          "write_your_email": "اكتب بريدك الإلكتروني هنا",
          "write_your_ph_num": "اكتب رقم هاتفك هنا",
          "docs": "الوثائق",
          "company_info": "معلومات الشركة",
          "company_name": "اسم الشركة",
          "company_type": "نوع الشركة",
          "type": "النوع",
          "company_types": "انواع الشركات",
          "url": "الرابط",
          "owner_info": "معلومات المالك",
          "total": "المجمل",
          "delivery": "التوصيل",
          "filling_data": "تعبئة البيانات",
          "start_date": "تاريخ البدء",
          "date_of_birth": "تاريخ الولادة",
          "living_town": "دولة المعيشة",
          "birth_place": "مكان الولادة",
          "end_date": "تاريخ الانتهاء",
          "settings": "الإعدادات",
          "price": "السعر",
          "categories": "الفئات",
          "create_category": "أنشئ فئة جديدة",
          "create_job": " أنشئ عمل جديد",
          "create_service": "أنشئ خدمة جديدة",
          "download": "تحميل",
          "share": "مشاركة",
          "notifications": "الإشعارات",
          "invoice": "الفاتورة",
          "contracts": "العقود",
          "agree": "أوافق",
          "rate_view": "التقييم والمراجعات",
          "payment": "الدفع",
          "office_warrently": "ضمان المكتب",
          "العروض": "العروض",
          "complete_data": "أكمل هذه البيانات",
          "s_languages": "اللغات المتحدث بها",
          "apply": "تطبيق",
          "employees": "الموظفون",
          "marital_status": "الحالة الاجتماعية",
          "status": "الحالة",
          "gender": "الجنس",
          "male": "ذكر",
          "single": "عازب",
          "female": "أنثى",
          "married": "متزوج",
          "employee_filter_page": "تعيين الفلاتر للموظفين",
          "booking_filter_page": "تعيين الفلاتر للحجوزات",
          "ads_filter_page": "تعيين الفلاتر للإعلانات",
          "age": "العمر",
          "closest": "إغلاق",
          "close": "Close",
          "best": "الأفضل",
          "cheapest": "الأرخص",
          "user_type_text": "أنت تقوم بالتسجيل كـ",
          "cleaner": "منظف",
          "company": "شركة",
          "user": "مستخدم",
          "driver": "سواق",
          "chef": "شيف",
          "babysitter": "جليسة أطفال",
          "nurse": "تمريض",
          "sewing": "خياطة",
          "washing": "غسل",
          "per_hour": "في الساعة",
          "per_year": "في السنة",
          "per_treatment": "في العقد",
          "services": "الخدمات",
          "all": "الكل",
          "cl_com": "شركات التنظيف",
          "rec_com": "شركات التوظيف",
          "hello": "مرحباً",
          "otp_text_3": "لم أحصل على أي رمز؟",
          "otp_text_4": "إعادة الإرسال",
          "send": "إرسال",
          "otp_text_1": "تأكيد بريدك الإلكتروني",
          "otp_text_2": "اكتب الرمز الذي تلقيته على البريد الإلكتروني",
          "security": "الأمان",
          'password_confirm': 'تأكيد كلمة السر',
          "id_proof": "تأكيد الهوية",
          "id_number": "رقم الهوية",
          "ref_number": "رقم المرجع",
          "upload_id": "تحميل صورة الهوية أو جواز السفر",
          "upload_docs": "رفع الملفات",
          "upload_category_icon": "رفع صورة الفئة",
          "upload_job_icon": "رفع صورة العمل",
          "upload_service_icon": "رفع صورة الخدمة",
          "id_photo": "صورة الهوية الشخصية",
          "id_photo_front": "الوجه الأمامي للهوية الشخصية",
          "id_photo_back": "الوجه الخلفي للهوية الشخصية",
          "upload_personal_photo": "تحميل الصورة الشخصية",
          "street": "الشارع",
          "building": "البناء",
          "adn": "رقم العنوان الآلي",
          "piece_num": "رقم القطعة",
          "city": "المدينة",
          "country": "البلدة",
          "region": "المنطقة",
          "address_info": "تفاصيل العنوان",
          "job": "العمل",
          "jobs": "الأعمال",
          "nationality": "الجنسية",
          "optional": "إختياري",
          "choose": "إختر",
          "select": "إختر",
          "phone_number": "رقم الهاتف",
          "message": "الرسالة",
          "phone": "الهاتف",
          "name": "الاسم",
          "first_name": "الاسم الأول",
          "last_name": "الاسم الأخير",
          "done": "تم",
          "religion": "الدين",
          "next": "التالي",
          'personal_info': 'المعلومات الشخصية',
          'greeting': 'مرحباً',
          'image_ratio': 'يجب ان تكون أبعاد الصورة 1920:1080',
          'login': 'تسجيل الدخول',
          'logout': 'تسجيل الخروج',
          'register': 'التسجيل',
          'create_an_account': 'أنشئ حساباً',
          'dont_have_an_account': 'ليس لديك حساب؟',
          'email': 'البريد الإلكتروني',
          'password': 'كلمة السر',
          'please_enter_a_valid_email': 'أدخل بريداً إلكترونياً صالحاً',
          'forget_pass': 'هل نسيت كلمة السر؟',
          'remember': 'تذكر كلمة السر',
          'or_login_with': 'أو قم بالدخول بواسطة',
          "drop_downs": "الحالة الشخصية",
        },
      };
}
