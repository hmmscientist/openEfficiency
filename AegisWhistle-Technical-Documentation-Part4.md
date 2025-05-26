# AegisWhistle Technical Documentation - Part 4: User Interfaces and Dashboards

## Mockup UI Diagrams

### Landing Page

```
┌──────────────────────────────────────────────────────────────┐
│                    www.aegiswhistle.com                     │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────┐                        ┌─────────┐ ┌─────────┐  │
│  │ AEGIS   │                        │ LOGIN   │ │ SIGN UP │  │
│  │ LOGO    │                        └─────────┘ └─────────┘  │
│  └─────────┘                                                  │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │                                                      │   │
│  │     Secure Whistleblower Platform for Organizations  │   │
│  │                                                      │   │
│  │     Powered by Blockchain. Protected by Design.      │   │
│  │                                                      │   │
│  │     [FOR ORGANIZATIONS]    [REPORT AN ISSUE]         │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
┌────────────────────────────────────────────────────────────────────┐
│                    REPORT SUBMISSION FLOW                          │
├────────────────────────────────────────────────────────────────────┤
│ 1. Choose Anonymity Level:                                         │
│    [●] Remain Anonymous (Default)                                  │
│    [ ] Identify Myself                                             │
│                                                                    │
│ 2. Report Details:                                                 │
│    ┌────────────────────────────────────────────────────────────┐  │
│    │ Type your concern or speak naturally...                    │  │
│    │                                                            │  │
│    │ [🎤] [Start Voice Recording]                                 │  │
│    └────────────────────────────────────────────────────────────┘  │
│                                                                    │
│ 3. Additional Information (Optional):                             │
│    ┌────────────────────────────────────────────────────────────┐  │
│    │ Upload supporting documents (max 5MB)                     │  │
│    │ [📎 Attach Files]                                          │  │
│    └────────────────────────────────────────────────────────────┘  │
│                                                                    │
│ 4. Contact Preference (if not anonymous):                         │
│    ┌────────────────────────────────────────────────────────────┐  │
│    │ [ ] Email  [ ] Phone  [ ] Secure Inbox                    │  │
│    └────────────────────────────────────────────────────────────┘  │
│                                                                    │
│ [SUBMIT REPORT]  [SAVE DRAFT]                                     │
└────────────────────────────────────────────────────────────────────┘

### Anonymity Implementation Details

1. **Anonymous Submissions**:
   - No personally identifiable information stored
   - Secure token generated for follow-up
   - End-to-end encrypted communication channel
   - IP addresses and metadata not logged

2. **Identified Submissions**:
   - Identity verification through secure methods
   - Information stored in private data collection on Hyperledger
   - Access restricted to authorized Ethics Officers only
   - Immutable record of consent for identification

3. **Blockchain Storage**:
   ```mermaid
   graph LR
       A[Report] -->|Anonymous| B{Anonymity Check}
       B -->|Yes| C[Store in Public Channel]
       B -->|No| D[Store in Private Data Collection]
       C --> E[No PII Stored]
       D --> F[Identity + Report Stored]
       F --> G[Encrypted with Org Keys]
   ```

4. **Smart Contract Logic**:
   ```javascript
   async function submitReport(reportData, isAnonymous) {
       const reportId = generateId();
       const timestamp = new Date().toISOString();
       
       if (isAnonymous) {
           // Store only non-PII data on-chain
           const publicReport = {
               reportId,
               timestamp,
               category: reportData.category,
               contentHash: hash(reportData.content),
               status: 'submitted',
               isAnonymous: true
           };
           await ctx.stub.putState(reportId, Buffer.from(JSON.stringify(publicReport)));
       } else {
           // Store in private data collection with PII
           const privateReport = {
               ...reportData,
               reportId,
               timestamp,
               isAnonymous: false,
               submittedById: ctx.clientIdentity.getID()
           };
           const collection = '_implicit_org_' + getMSPID() + '_private';
           await ctx.stub.putPrivateData(collection, reportId, Buffer.from(JSON.stringify(privateReport)));
       }
       
       return { reportId, timestamp };
   }
   ```
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │                                                      │   │
│  │  TRUSTED BY LEADING ORGANIZATIONS                    │   │
│  │                                                      │   │
│  │  [Uber Logo]  [Microsoft Logo]  [Tesla Logo]        │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │                                                      │   │
│  │  ENTER YOUR ORGANIZATION SUBDOMAIN:                  │   │
│  │  ┌────────────────────┐                              │   │
│  │  │ organization       │.aegiswhistle.com [GO]        │   │
│  │  └────────────────────┘                              │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### Whistleblower Interface

#### When Whistleblowers Access This Interface

The Whistleblower Interface is presented to users in the following scenarios:

1. **Initial Report Submission**: 
   - After a whistleblower enters their organization's subdomain (e.g., uber.aegiswhistle.com)
   - When they select the "Report a Concern" or "Speak Up" option
   - This is their primary entry point for submitting new reports

2. **Report Follow-up**: 
   - When returning to check on the status of a previously submitted report
   - After entering their unique report ID and verification code
   - No login credentials are required, preserving anonymity

3. **Post-Voice Interaction**: 
   - After completing a voice-based report using VAPI or Gemini Live AI
   - The system transitions from voice to this text interface for verification and submission
   - The AI-generated summary is presented for review before final submission

4. **Responding to Investigator Queries**: 
   - When an investigator has questions about the report
   - Whistleblowers receive a secure notification and can respond through this interface
   - All communication remains anonymous based on the configured anonymity level

5. **Reward Claim Process**: 
   - When a report has been validated and a reward approved
   - The interface provides secure instructions for claiming cryptocurrency rewards
   - Includes options to direct rewards to external wallets or the built-in wallet

This interface is designed to be accessible from any device with a web browser, requires no software installation, and operates through encrypted connections to protect the whistleblower's identity.

```
┌──────────────────────────────────────────────────────────────┐
│                      uber.aegiswhistle.com                   │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────┐                                    ┌─────────┐  │
│  │ AEGIS   │                                    │ TEAM    │  │
│  │ LOGO    │                                    │ LOGIN   │  │
│  └─────────┘                                    └─────────┘  │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │                                                      │   │
│  │                                                      │   │
│  │                                                      │   │
│  │                                                      │   │
│  │                SPEAK UP                              │   │
│  │                                                      │   │
│  │            [Start Conversation]                      │   │
│  │                                                      │   │
│  │                   - OR -                             │   │
│  │                                                      │   │
│  │               [Write Report]                         │   │
│  │                                                      │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐         │
│  │ OPEN    │  │ RESOLVED│  │ REWARDS │  │ BOUNTY  │         │
│  │ CASES   │  │ CASES   │  │ ISSUED  │  │ AVAILABLE│         │
│  │ 12      │  │ 45      │  │ $25,000 │  │ $100,000 │         │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘         │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │                                                      │   │
│  │               FOLLOW UP ON REPORT                    │   │
│  │                                                      │   │
│  │   Report ID: [          ]  [Check Status]            │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### Organization Dashboards

#### Ethics Admin Dashboard

**Access and Authentication:**

The Ethics Admin (Organization Owner) dashboard is accessed in the following scenarios:

1. **Initial Setup**: 
   - After completing the organization registration and payment process
   - The platform creates the first Ethics Admin account during organization onboarding
   - Login credentials are sent to the email provided during registration
   - A dedicated Hyperledger Fabric infrastructure is automatically provisioned and configured for the organization
   - The system creates a separate blockchain network with organization-specific peers, orderers, and certificate authorities
   - A dedicated AI agent (VAPI or Gemini Live AI based on selection) is allocated and configured with organization-specific parameters
   - All blockchain components are initialized with the organization's security policies and anonymity settings

2. **Regular Access**: 
   - Through the organization subdomain (e.g., uber.aegiswhistle.com/admin)
   - Using credentials created during the registration process
   - With optional two-factor authentication for enhanced security

3. **Account Recovery**: 
   - Through a secure password reset process with multi-factor verification
   - Requires verification through both email and phone for high-security operations

**Dashboard Features and Functionality:**

```
┌──────────────────────────────────────────────────────────────┐
│                 ETHICS ADMIN DASHBOARD                       │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────┐                                    ┌─────────┐  │
│  │ AEGIS   │                                    │ ADMIN   │  │
│  │ LOGO    │                                    │ PROFILE │  │
│  └─────────┘                                    └─────────┘  │
│                                                              │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌───────┐  │
│  │ USERS       │ │ REPORTS     │ │ SETTINGS    │ │ LOGS  │  │
│  └─────────────┘ └─────────────┘ └─────────────┘ └───────┘  │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ ORGANIZATION STATISTICS                           [↓] │   │
│  ├──────────────────────────────────────────────────────┤   │
│  │                                                      │   │
│  │  Total Reports: 57    Open: 12    Resolved: 45      │   │
│  │  Ethics Officers: 2   Investigators: 5              │   │
│  │  Rewards Issued: $25,000    Available: $100,000     │   │
│  │                                                      │   │
│  │  [View Detailed Analytics]                           │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ USER MANAGEMENT                                  [+] │   │
│  ├──────────────────────────────────────────────────────┤   │
│  │                                                      │   │
│  │  ┌─────────────────────────────────────────────┐    │   │
│  │  │ CREATE NEW USER                         [+] │    │   │
│  │  └─────────────────────────────────────────────┘    │   │
│  │                                                      │   │
│  │  ETHICS OFFICERS:                                    │   │
│  │  • Sarah Johnson (sarah.j@uber.com) [Edit] [Disable] │   │
│  │  • Michael Chen (michael.c@uber.com) [Edit] [Disable]│   │
│  │                                                      │   │
│  │  INVESTIGATORS:                                      │   │
│  │  • Priya Sharma (p.sharma@uber.com) [Edit] [Disable] │   │
│  │  • James Wilson (j.wilson@uber.com) [Edit] [Disable] │   │
│  │  • [View All Users]                                  │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ CONFIGURATION                                    [↓] │   │
│  ├──────────────────────────────────────────────────────┤   │
│  │                                                      │   │
│  │  ANONYMITY SETTINGS:                                 │   │
│  │  [•] Encrypted Identity (default)                    │   │
│  │  [ ] Complete Anonymity                              │   │
│  │  [ ] Pseudo-anonymity                                │   │
│  │                                                      │   │
│  │  REWARD SETTINGS:                                    │   │
│  │  Min Reward: $100    Max Reward: $5,000             │   │
│  │  Default Currency: USDC                              │   │
│  │  [Configure Reward Tiers]                            │   │
│  │                                                      │   │
│  │  [Save Configuration]                                │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────┘
```

**Key Responsibilities:**

1. **User Management**:
   - Create accounts for Ethics Officers and Investigators
   - Set permissions and access levels for each user
   - Disable accounts when employees leave the organization
   - Send email notifications with login credentials to new users

2. **System Configuration**:
   - Set anonymity levels for whistleblower reports
   - Configure reward policies and cryptocurrency options
   - Customize the organization's whistleblower portal branding
   - Set notification preferences and escalation paths

3. **Analytics and Reporting**:
   - View high-level statistics on whistleblower reports
   - Monitor case resolution metrics and timelines
   - Track reward distributions and budget allocation
   - Generate compliance reports for regulatory requirements

4. **Professional Services**:
   - Select and approve external service providers (legal, healthcare)
   - Set budget limits for professional service engagements
   - Review service provider performance metrics

#### Ethics Officer Dashboard

**Access and Authentication:**

The Ethics Officer dashboard is accessed in the following scenarios:

1. **Initial Access**: 
   - After the Ethics Admin creates their account and sends credentials
   - Ethics Officers receive an email with temporary login credentials
   - They must change their password on first login
   - The Ethics Officer cannot self-register; account creation is strictly controlled by the Ethics Admin

2. **Regular Access**: 
   - Through the organization subdomain (e.g., uber.aegiswhistle.com/ethics)
   - Using credentials provided by the Ethics Admin
   - With mandatory two-factor authentication for security

3. **Notification-Based Access**: 
   - When receiving alerts about new whistleblower reports
   - When case updates require their attention
   - Through secure deep links in notification emails

**Dashboard Features and Functionality:**

```
┌──────────────────────────────────────────────────────────────┐
│                ETHICS OFFICER DASHBOARD                     │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐         │
│  │ NEW     │  │ UNDER   │  │ ASSIGNED│  │ RESOLVED│         │
│  │ REPORTS │  │ REVIEW  │  │ CASES   │  │ CASES   │         │
│  │ 3       │  │ 5       │  │ 8       │  │ 45      │         │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘         │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ RECENT REPORTS                                    [+] │   │
│  ├──────────────────────────────────────────────────────┤   │
│  │                                                      │   │
│  │  AG7X9M2K4P | Harassment | 2025-05-24 | New         │   │
│  │  ───────────────────────────────────────────────    │   │
│  │  Employee reports harassment by supervisor...        │   │
│  │  [Assign] [Review] [Resolve]                         │   │
│  │                                                      │   │
│  │  BH8Y0N3L5Q | Fraud | 2025-05-23 | Under Review     │   │
│  │  ───────────────────────────────────────────────    │   │
│  │  Suspicious financial transactions in accounting...  │   │
│  │  [Assign] [Review] [Resolve]                         │   │
│  │                                                      │   │
│  │  CJ9Z1P4M6R | Safety | 2025-05-22 | Assigned        │   │
│  │  ───────────────────────────────────────────────    │   │
│  │  Unsafe working conditions in warehouse...           │   │
│  │  [View Details] [Message Investigator]               │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────┐  ┌──────────────────────────┐ │
│  │ REWARD POOL              │  │ PROFESSIONAL SERVICES    │ │
│  ├──────────────────────────┤  ├──────────────────────────┤ │
│  │                          │  │                          │ │
│  │  Available: $100,000     │  │  Legal Services    [+]   │ │
│  │  Issued: $25,000         │  │  Medical Services  [+]   │ │
│  │  Pending: $5,000         │  │  Investigators     [+]   │ │
│  │                          │  │  Specialists       [+]   │ │
│  │  [Add Funds] [History]   │  │                          │ │
│  │                          │  │  [Browse Marketplace]    │ │
│  └──────────────────────────┘  └──────────────────────────┘ │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

**Key Responsibilities:**

1. **Case Management**:
   - Review new whistleblower reports as they arrive
   - Assign cases to appropriate investigators based on expertise
   - Track investigation progress and ensure timely resolution
   - Communicate anonymously with whistleblowers for clarification

2. **Reward Administration**:
   - Evaluate the validity and value of whistleblower reports
   - Approve appropriate rewards within configured policy limits
   - Monitor reward distribution and claim status
   - Ensure fair and consistent reward allocation

3. **Professional Service Engagement**:
   - Engage external legal or healthcare professionals when needed
   - Approve service requests within budget constraints
   - Coordinate between investigators and professional service providers
   - Evaluate service quality and maintain preferred provider lists

4. **Compliance Oversight**:
   - Ensure all investigations follow proper protocols
   - Generate reports for regulatory compliance
   - Maintain documentation of all actions taken
   - Implement remediation measures based on findings

### Investigator Dashboard

**Access and Authentication:**

The Investigator dashboard is accessed in the following scenarios:

1. **Initial Access**: 
   - After the Ethics Admin creates their account and sends credentials
   - Investigators receive an email with temporary login credentials
   - They must change their password on first login
   - Like Ethics Officers, Investigators cannot self-register; account creation is controlled by the Ethics Admin

2. **Regular Access**: 
   - Through the organization subdomain (e.g., uber.aegiswhistle.com/investigator)
   - Using credentials provided by the Ethics Admin
   - With mandatory two-factor authentication for security

3. **Case Assignment Notifications**: 
   - When receiving alerts about newly assigned cases
   - When whistleblowers respond to their queries
   - Through secure deep links in notification emails

**Dashboard Features and Functionality:**

```
┌──────────────────────────────────────────────────────────────┐
│                      INVESTIGATOR DASHBOARD                  │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐         │
│  │ ASSIGNED│  │ IN      │  │ PENDING │  │ COMPLETED│         │
│  │ CASES   │  │ PROGRESS│  │ RESPONSE│  │ CASES   │         │
│  │ 3       │  │ 5       │  │ 2       │  │ 12      │         │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘         │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ CASE DETAILS: AG7X9M2K4P                         [↓] │   │
│  ├──────────────────────────────────────────────────────┤   │
│  │                                                      │   │
│  │  Category: Harassment                                │   │
│  │  Reported: 2025-05-24                                │   │
│  │  Status: In Progress                                 │   │
│  │                                                      │   │
│  │  Summary:                                            │   │
│  │  Employee reports harassment by supervisor in        │   │
│  │  marketing department. Incidents occurred during     │   │
│  │  team meetings over the past month. Witnesses        │   │
│  │  present but not identified.                         │   │
│  │                                                      │   │
│  │  [View Full Transcript]                              │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────┐  ┌──────────────────────────┐ │
│  │ INVESTIGATION ACTIONS    │  │ CASE TIMELINE            │ │
│  ├──────────────────────────┤  ├──────────────────────────┤ │
│  │                          │  │                          │ │
│  │  [Query Whistleblower]   │  │  2025-05-24 10:30        │ │
│  │                          │  │  Case created             │ │
│  │  [Add Evidence]          │  │                          │ │
│  │                          │  │  2025-05-24 11:15        │ │
│  │  [Request Professional   │  │  Assigned to investigator │ │
│  │   Services]              │  │                          │ │
│  │                          │  │  2025-05-24 14:20        │ │
│  │  [Update Status]         │  │  Status changed to       │ │
│  │                          │  │  "In Progress"           │ │
│  │  [Complete Investigation]│  │                          │ │
│  │                          │  │  [View All Activity]     │ │
│  └──────────────────────────┘  └──────────────────────────┘ │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```
**Investigator Dashboard Key Responsibilities:**

1. **Investigation Management**:
   - Conduct thorough investigations of assigned whistleblower reports
   - Gather evidence and document findings securely
   - Maintain detailed investigation logs and timelines
   - Communicate with whistleblowers through anonymous channels

2. **Case Documentation**:
   - Document all investigative actions in the blockchain
   - Upload evidence with proper chain of custody tracking
   - Prepare investigation reports for Ethics Officers
   - Ensure all documentation meets compliance requirements

3. **Professional Collaboration**:
   - Request assistance from legal or healthcare professionals when needed
   - Coordinate with external specialists through secure channels
   - Incorporate expert findings into investigation reports
   - Maintain confidentiality of all shared case information

4. **Remediation Recommendations**:
   - Develop actionable recommendations based on findings
   - Propose corrective measures to prevent future incidents
   - Identify systemic issues requiring organizational attention
   - Track implementation of approved recommendations


### Professional Marketplace

```
┌──────────────────────────────────────────────────────────────┐
│                      PROFESSIONAL MARKETPLACE                │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ CATEGORIES                      [Search Professionals]│   │
│  ├──────────────────────────────────────────────────────┤   │
│  │                                                      │   │
│  │  [✓] Legal Services                                  │   │
│  │  [ ] Medical Services                                │   │
│  │  [ ] Alternative Medicine                            │   │
│  │  [ ] Specialized Services                            │   │
│  │                                                      │   │
│  │  SPECIALIZATIONS                                     │   │
│  │  [✓] Employment Law                                  │   │
│  │  [ ] Corporate Compliance                            │   │
│  │  [ ] Workplace Harassment                            │   │
│  │  [ ] Fraud Investigation                             │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ SEARCH RESULTS                                   [↓] │   │
│  ├──────────────────────────────────────────────────────┤   │
│  │                                                      │   │
│  │  Smith Legal Services                                │   │
│  │  ───────────────────────────────────────────────    │   │
│  │  Employment Law | San Francisco, CA | ★★★★★ (28)     │   │
│  │  $300/hour | Available within 4 hours                │   │
│  │  [View Profile] [Request Service]                    │   │
│  │                                                      │   │
│  │  Johnson Employment Law Group                        │   │
│  │  ───────────────────────────────────────────────    │   │
│  │  Employment Law | Remote | ★★★★☆ (42)                │   │
│  │  $275/hour | Available within 24 hours               │   │
│  │  [View Profile] [Request Service]                    │   │
│  │                                                      │   │
│  │  Workplace Rights Advocates                          │   │
│  │  ───────────────────────────────────────────────    │   │
│  │  Employment Law | Chicago, IL | ★★★★★ (15)           │   │
│  │  $325/hour | Available within 8 hours                │   │
│  │  [View Profile] [Request Service]                    │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

## Conclusion

The AegisWhistle platform provides a comprehensive, secure, and user-friendly solution for organizations to implement effective whistleblowing systems. By leveraging Hyperledger Fabric for blockchain security, voice AI for intuitive reporting, and a professional marketplace for support services, the platform offers a complete ecosystem for ethical reporting and investigation.

The implementation plan outlined in this document provides a structured approach to building the platform, with clear phases and milestones. The technical architecture ensures scalability, security, and compliance with regulatory requirements.

Organizations using AegisWhistle will benefit from:
1. Increased reporting of ethical concerns
2. Enhanced protection for whistleblowers
3. Streamlined investigation processes
4. Improved compliance with regulatory requirements
5. Reduced legal and reputational risks

The platform's multi-tenant design allows for complete isolation between organizations while providing optional cross-network communication for collaborative investigations when needed.
