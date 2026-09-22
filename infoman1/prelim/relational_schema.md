# Relational Schema — ToolShare Database

StorageLocation( <u>location_code</u>, description )

Member( <u>member_id</u>, name, phone_number, membership_start_date )

Tool( <u>tool_id</u>, name, category, purchase_date, location_code [FK -> StorageLocation.location_code] )

Certification( <u>cert_id</u>, cert_name )

Borrowing( <u>borrow_id</u>, member_id [FK -> Member.member_id], tool_id [FK -> Tool.tool_id], borrow_date, return_date )

ToolCertification( <u>tool_id [FK -> Tool.tool_id]</u>, <u>cert_id [FK -> Certification.cert_id]</u> )

MemberCertification( <u>member_id [FK -> Member.member_id]</u>, <u>cert_id [FK -> Certification.cert_id]</u>, completion_date )