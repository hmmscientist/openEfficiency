# AegisWhistle Mockup Diagrams

*This document provides visual representations of key user interfaces in the AegisWhistle platform. Each diagram is accompanied by detailed explanations of the user flows and interface elements.*

## Table of Contents
1. [Whistleblower Interface](#whistleblower-interface)
2. [Ethics Officer Dashboard](#ethics-officer-dashboard)
3. [Investigator Workspace](#investigator-workspace)
4. [Professional Marketplace](#professional-marketplace)
5. [Organization Admin Dashboard](#organization-admin-dashboard)
6. [System Flows](#system-flows)

## Legend
- `[●]` Selected option
- `[ ]` Unselected option
- `[Button]` Clickable element
- `[Input Field]` Text input area
- `[↓]` Dropdown menu

## Whistleblower Interface

*The main interface for individuals to submit reports while maintaining their anonymity if desired.*

**Key Features:**
- Anonymous or identified reporting options
- Multiple reporting methods (voice/written)
- Secure submission process
- Anonymous ID for follow-up
- Real-time case statistics

**Security Notes:**
- All communications are end-to-end encrypted
- IP addresses and metadata are not logged for anonymous reports
- Voice data is processed in-memory and not stored unless explicitly saved
- Anonymous IDs are generated client-side for maximum privacy
- All file uploads are scanned for malware
- Data is stored on Hyperledger Fabric with appropriate access controls
- Private data collections protect sensitive information
- Regular security audits are conducted

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
│  │  ┌──────────────────────────────────────────────┐   │   │
│  │  │ 1. Choose Anonymity:                        │   │   │
│  │  │    [●] Remain Anonymous (Recommended)         │   │   │
│  │  │    [ ] Identify Myself                       │   │   │
│  │  │                                              │   │   │
│  │  │ 2. Report Method:                            │   │   │
│  │  │    [●] Voice Conversation                    │   │   │
│  │  │    [ ] Written Report                        │   │   │
│  │  │                                              │   │   │
│  │  │ 3. Report Details:                           │   │   │
│  │  │    ┌──────────────────────────────────────┐  │   │   │
│  │  │    │ Type your concern or speak naturally │  │   │   │
│  │  │    │                                      │  │   │   │
│  │  │    │ [🎤] [Start Voice Recording]          │  │   │   │
│  │  │    └──────────────────────────────────────┘  │   │   │
│  │  │                                              │   │   │
│  │  │ 4. Additional Information:                   │   │   │
│  │  │    [📎 Upload Files (max 5MB)]               │   │   │
│  │  │                                              │   │   │
│  │  │ 5. Contact Preference (if identified):       │   │   │
│  │  │    [ ] Email  [ ] Phone  [ ] Secure Inbox  │   │   │
│  │  └──────────────────────────────────────────────┘   │   │
│  │                                                      │   │
│  │  [SUBMIT REPORT]  [SAVE DRAFT]                         │   │
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
│  │               FOLLOW UP ON REPORT                    │   │
│  │                                                      │   │
│  │  Report ID: [          ]  [Check Status]             │   │
│  │                                                      │   │
│  │  ┌──────────────────────────────────────────────┐   │   │
│  │  │  Your Anonymous ID:  XK7F9P2Q1R              │   │   │
│  │  │  Save this ID to check status or add more info  │   │   │
│  │  │                                              │   │   │
│  │  │  Blockchain Transaction: 0x1a2b3c...4d5e6f    │   │   │
│  │  │  [View on Explorer]                          │   │   │
│  │  └──────────────────────────────────────────────┘   │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

## Ethics Officer Dashboard

*Central hub for managing and overseeing reported cases within an organization.*

**Key Features:**
- Case overview with status tracking
- Quick action buttons for common tasks
- Reward pool management
- Professional services marketplace access
- Real-time notifications

**Workflow:**
1. Review new reports
2. Assign cases to investigators
3. Monitor investigation progress
4. Approve resolutions
5. Manage reward distributions

**Data Protection:**
- Role-based access control
- Audit logging of all actions
- Secure communication channels
- Data encryption at rest and in transit

```
┌──────────────────────────────────────────────────────────────┐
│                      ETHICS OFFICER DASHBOARD                │
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

## Investigator Workspace

*Dedicated environment for managing and conducting investigations.*

**Key Features:**
- Case details and evidence repository
- Communication tools
- Timeline tracking
- Professional service requests
- Report generation

**Investigation Process:**
1. Receive case assignment
2. Review initial report
3. Gather and analyze evidence
4. Consult with professionals if needed
5. Document findings
6. Submit final report

```
┌──────────────────────────────────────────────────────────────┐
│                      INVESTIGATOR WORKSPACE                  │
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

## Professional Marketplace

*Platform for engaging external experts to assist with investigations.*

**Service Categories:**
- Legal Services
- Medical Services
- Forensic Accounting
- Cybersecurity
- HR Consulting

**Provider Information:**
- Verified credentials
- Ratings and reviews
- Availability status
- Pricing information
- Response time

**Booking Process:**
1. Search for required service
2. Review provider profiles
3. Submit service request
4. Receive confirmation
5. Collaborate through secure channels

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

## Organization Admin Dashboard

*Administrative console for managing organization settings and users.*

**Management Areas:**
- User management
- Role assignments
- System configuration
- Billing and subscriptions
- Compliance settings

**Key Metrics:**
- Active cases
- Team performance
- System usage
- Compliance status
- Financial overview

```
┌──────────────────────────────────────────────────────────────┐
│                      ORGANIZATION ADMIN DASHBOARD            │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐         │
│  │ ACTIVE  │  │ TOTAL   │  │ REWARD  │  │ TEAM    │         │
│  │ CASES   │  │ REPORTS │  │ BUDGET  │  │ MEMBERS │         │
│  │ 16      │  │ 57      │  │ $100,000│  │ 8       │         │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘         │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ ORGANIZATION SETTINGS                             [↓] │   │
│  ├──────────────────────────────────────────────────────┤   │
│  │                                                      │   │
│  │  Organization: Uber Technologies                     │   │
│  │  Subdomain: uber.aegiswhistle.com                    │   │
│  │  Anonymity Level: Encrypted                          │   │
│  │  Reward Range: $100 - $5,000                         │   │
│  │  Crypto Options: USDC, ETH                           │   │
│  │                                                      │   │
│  │  [Edit Settings] [Generate QR Code] [Marketing Kit]  │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────────────┐  ┌──────────────────────────┐ │
│  │ TEAM MANAGEMENT          │  │ ANALYTICS                │ │
│  ├──────────────────────────┤  ├──────────────────────────┤ │
│  │                          │  │                          │ │
│  │  Ethics Officers (3)     │  │  Reports by Category     │ │
│  │  [+] [Manage]            │  │  ┌───┐ ┌───┐ ┌───┐ ┌───┐ │ │
│  │                          │  │  │   │ │   │ │   │ │   │ │ │
│  │  Investigators (5)       │  │  │   │ │   │ │   │ │   │ │ │
│  │  [+] [Manage]            │  │  └───┘ └───┘ └───┘ └───┘ │ │
│  │                          │  │   30%   25%   20%   25%  │ │
│  │  [Invite Team Member]    │  │                          │ │
│  │                          │  │  [View Full Analytics]   │ │
│  └──────────────────────────┘  └──────────────────────────┘ │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ PROFESSIONAL SERVICES                             [↓] │   │
│  ├──────────────────────────────────────────────────────┤   │
│  │                                                      │   │
│  │  Active Providers:                                   │   │
│  │  • Smith Legal Services (Legal)                      │   │
│  │  • Bay Area Workplace Counseling (Medical)           │   │
│  │  • Digital Forensics Group (Specialized)             │   │
│  │                                                      │   │
│  │  [Add Provider] [Browse Marketplace]                 │   │
│  │                                                      │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

## Voice Reporting Flow

```
┌─────────────────────────────────────────────────────────────┐
│                   VOICE REPORTING FLOW                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌───────────────┐                                          │
│  │ Whistleblower │                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐                                          │
│  │ Access Website│                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐                                          │
│  │ Click "Speak  │                                          │
│  │ Up" Button    │                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐     ┌───────────────┐                   │
│  │ VAPI Voice    │     │ Gemini Live   │                   │
│  │ Agent         │◄────┤ (Fallback)    │                   │
│  └───────┬───────┘     └───────────────┘                   │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐                                          │
│  │ Conversation  │                                          │
│  │ & Transcription│                                         │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐                                          │
│  │ AI Summary &  │                                          │
│  │ Categorization│                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐     ┌───────────────┐                   │
│  │ Generate      │     │ Store in      │                   │
│  │ Report ID     │────►│ Hyperledger   │                   │
│  └───────┬───────┘     └───────┬───────┘                   │
│          │                     │                           │
│          ▼                     ▼                           │
│  ┌───────────────┐     ┌───────────────┐                   │
│  │ Display ID to │     │ Notify Ethics │                   │
│  │ Whistleblower │     │ Officer       │                   │
│  └───────────────┘     └───────────────┘                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Reward Processing Flow

```
┌─────────────────────────────────────────────────────────────┐
│                   REWARD PROCESSING FLOW                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌───────────────┐                                          │
│  │ Ethics Officer│                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐                                          │
│  │ Approve Reward│                                          │
│  │ ($500 USDC)   │                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐     ┌───────────────┐                   │
│  │ Check Org     │     │ Organization  │                   │
│  │ Wallet Balance│◄────┤ Wallet        │                   │
│  └───────┬───────┘     └───────────────┘                   │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐                                          │
│  │ Generate      │                                          │
│  │ Anonymous     │                                          │
│  │ Wallet        │                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐     ┌───────────────┐                   │
│  │ Transfer USDC │     │ Record in     │                   │
│  │ to Anonymous  │────►│ Hyperledger   │                   │
│  │ Wallet        │     └───────────────┘                   │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐     ┌───────────────┐                   │
│  │ Send Claim    │     │ Whistleblower │                   │
│  │ Instructions  │────►│ Claims Reward │                   │
│  │ to Whistleblower│    │ (Optional)    │                   │
│  └───────────────┘     └───────────────┘                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Organization Onboarding Flow

```
┌─────────────────────────────────────────────────────────────┐
│                ORGANIZATION ONBOARDING FLOW                 │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌───────────────┐                                          │
│  │ Ethics Admin  │                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐                                          │
│  │ Register      │                                          │
│  │ Organization  │                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐     ┌───────────────┐                   │
│  │ Platform Admin│     │ Approve       │                   │
│  │ Review        │────►│ Organization  │                   │
│  └───────────────┘     └───────┬───────┘                   │
│                                │                           │
│                                ▼                           │
│  ┌───────────────┐     ┌───────────────┐                   │
│  │ Initialize    │     │ Generate      │                   │
│  │ Hyperledger   │────►│ Certificate   │                   │
│  │ Network       │     │ Authority     │                   │
│  └───────┬───────┘     └───────┬───────┘                   │
│          │                     │                           │
│          ▼                     ▼                           │
│  ┌───────────────┐     ┌───────────────┐                   │
│  │ Organization  │     │ Ethics Admin  │                   │
│  │ Activated     │────►│ Configures    │                   │
│  └───────────────┘     │ Settings      │                   │
│                        └───────┬───────┘                   │
│                                │                           │
│                                ▼                           │
│                        ┌───────────────┐                   │
│                        │ Invite Team   │                   │
│                        │ Members       │                   │
│                        └───────────────┘                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Professional Service Request Flow

```
┌─────────────────────────────────────────────────────────────┐
│              PROFESSIONAL SERVICE REQUEST FLOW              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌───────────────┐                                          │
│  │ Ethics Officer│                                          │
│  │ or Investigator│                                         │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐                                          │
│  │ Browse        │                                          │
│  │ Marketplace   │                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐                                          │
│  │ Select        │                                          │
│  │ Provider      │                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐                                          │
│  │ Submit Service│                                          │
│  │ Request       │                                          │
│  └───────┬───────┘                                          │
│          │                                                  │
│          ▼                                                  │
│  ┌───────────────┐     ┌───────────────┐                   │
│  │ Provider      │     │ Provider      │                   │
│  │ Notification  │────►│ Accepts/Declines│                 │
│  └───────────────┘     └───────┬───────┘                   │
│                                │                           │
│                                ▼                           │
│                        ┌───────────────┐                   │
│                        │ Link Provider │                   │
│                        │ to Case       │                   │
│                        └───────┬───────┘                   │
│                                │                           │
│                                ▼                           │
│                        ┌───────────────┐                   │
│                        │ Service       │                   │
│                        │ Delivery      │                   │
│                        └───────┬───────┘                   │
│                                │                           │
│                                ▼                           │
│                        ┌───────────────┐                   │
│                        │ Payment &     │                   │
│                        │ Review        │                   │
│                        └───────────────┘                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```
