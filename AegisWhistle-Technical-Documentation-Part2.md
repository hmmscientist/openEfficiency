# AegisWhistle Technical Documentation - Part 2

## Data Structures and Smart Contracts

### Core Chaincode Components

Chaincode (smart contracts) in Hyperledger Fabric are programs that implement the business logic of the AegisWhistle platform. They run in isolated containers and have controlled access to the ledger data. Below are the three primary chaincode components used in our platform, each serving a specific purpose in the whistleblower reporting and investigation process:

1. **Complaint Management Chaincode**

```javascript
// Complaint Asset Structure
const complaintAsset = {
  reportId: "AG7X9M2K4P", // Unique 10-digit alphanumeric ID
  timestamp: "2025-05-24T10:30:00Z",
  organizationId: "uber",
  summary: "Employee reports harassment by supervisor...",
  transcriptHash: "0x4a5b6c7d8e9f...", // Hash of the full transcript
  category: "harassment",
  status: "new", // new, under_review, assigned, resolved, escalated
  anonymityLevel: "encrypted", // complete, encrypted, pseudo
  whistleblowerIdentity: {
    type: "encrypted",
    data: "encrypted_data_blob", // Only decryptable with court order if level=encrypted
    publicKey: "whistleblower_public_key" // For anonymous communication
  },
  attachments: [
    {
      fileHash: "0x1a2b3c4d...",
      fileType: "application/pdf",
      encryptionKey: "encrypted_key_blob"
    }
  ],
  metadata: {
    source: "voice", // voice or text
    processingAgent: "vapi", // vapi or gemini
    ipAddress: "anonymized_ip", // Anonymized or encrypted
    browserFingerprint: "anonymized_fingerprint" // Anonymized or encrypted
  }
};

// Complaint Management Functions
async function createComplaint(ctx, complaintData) {
  // Validate input
  // Generate unique reportId
  // Store complaint with appropriate access controls
  // Emit event for notification service
  return reportId;
}

async function updateComplaintStatus(ctx, reportId, newStatus, updatedBy) {
  // Verify caller has permission
  // Update status
  // Log audit trail
  // Emit event
  return success;
}

async function assignInvestigator(ctx, reportId, investigatorId) {
  // Verify caller is Ethics Officer
  // Update complaint record
  // Grant investigator access to complaint
  // Log audit trail
  // Emit event
  return success;
}

async function queryWhistleblower(ctx, reportId, question) {
  // Verify caller has permission
  // Create secure communication channel
  // Store question in blockchain
  // Emit event for notification
  return questionId;
}
```

#### Complaint Management Chaincode Explained

The Complaint Management Chaincode is the core smart contract that handles all whistleblower reports in the AegisWhistle platform. It's responsible for the entire lifecycle of a complaint, from initial submission to final resolution.

**Key Features and Functions:**

1. **Secure Complaint Storage**: When a whistleblower submits a report (via voice or text), this chaincode creates a new complaint asset on the blockchain with a unique 10-digit alphanumeric ID (e.g., "AG7X9M2K4P"). This ID is provided to the whistleblower for future reference.

2. **Identity Protection**: Based on the organization's anonymity settings, the whistleblower's identity can be:
   - Completely anonymous (no identity stored)
   - Encrypted (stored but only decryptable with proper authorization)
   - Pseudo-anonymous (internal tracking only)

3. **Workflow Management**: The chaincode tracks the status of each complaint through its lifecycle:
   - `new`: Just submitted, not yet reviewed
   - `under_review`: Being reviewed by Ethics Officer
   - `assigned`: Assigned to an Investigator
   - `resolved`: Investigation complete, case closed
   - `escalated`: Requires higher-level attention

4. **Secure Communication**: Enables anonymous communication between investigators and whistleblowers through the `queryWhistleblower` function, which creates a secure channel without revealing the whistleblower's identity.

5. **Evidence Management**: Handles attachments and evidence securely, storing only cryptographic hashes on the blockchain while the actual files are stored in encrypted form in off-chain storage.

**Real-World Example:**

When an employee at Uber uses the voice interface to report harassment, the system:
1. Generates a unique report ID ("AG7X9M2K4P")
2. Creates a new complaint asset with status "new"
3. Stores it on Uber's private Hyperledger Fabric network
4. Notifies Uber's Ethics Officers
5. Provides the report ID to the whistleblower for follow-up

2. **Reward System Chaincode**

```javascript
// Reward Asset Structure
const rewardAsset = {
  rewardId: "RW12345678",
  reportId: "AG7X9M2K4P", // Associated complaint
  amount: "500",
  currency: "USDC",
  status: "pending", // pending, approved, processed, claimed
  approvedBy: "ethics_officer_id",
  approvedAt: "2025-06-01T14:22:00Z",
  anonymousWallet: {
    address: "0x...", // One-time use wallet
    privateKey: "encrypted_private_key", // Encrypted, only accessible to whistleblower
    expiryDate: "2025-12-01T00:00:00Z" // 6-month claim window
  },
  transactionHash: null, // Filled when processed
  claimedAt: null // Timestamp when claimed
};

// Reward System Functions
async function approveReward(ctx, reportId, amount, currency, approvedBy) {
  // Verify caller is Ethics Officer
  // Check organization reward policy compliance
  // Create reward record
  // Log audit trail
  // Emit event
  return rewardId;
}

async function processReward(ctx, rewardId) {
  // Verify reward is approved
  // Generate anonymous wallet
  // Transfer funds from organization wallet
  // Update reward status
  // Log audit trail
  // Emit event for notification
  return {
    walletAddress: "0x...",
    encryptedPrivateKey: "encrypted_key_blob"
  };
}

async function claimReward(ctx, rewardId, targetWallet) {
  // Verify claim is valid
  // Transfer from anonymous wallet to target wallet
  // Update reward status
  // Log audit trail
  // Emit event
  return transactionHash;
}
```

#### Reward System Chaincode Explained

The Reward System Chaincode manages the incentive mechanism for whistleblowers who provide valid and valuable reports. This chaincode enables organizations to reward whistleblowers while maintaining their anonymity.

**Key Features and Functions:**

1. **Reward Approval**: Ethics Officers can approve rewards for valuable whistleblower reports. The chaincode enforces the organization's reward policies, ensuring rewards are within the configured minimum and maximum amounts (e.g., $100-$5,000 for Uber).

2. **Anonymous Rewards**: The chaincode creates one-time use anonymous wallets to transfer cryptocurrency rewards without revealing the whistleblower's identity. This is crucial for maintaining whistleblower protection.

3. **Multi-Currency Support**: Supports various cryptocurrencies (USDC, ETH, etc.) based on the organization's configuration and the whistleblower's preference.

4. **Secure Claim Process**: Whistleblowers can claim rewards using their report ID, without revealing their identity. They can transfer funds to their personal wallet or use the anonymous wallet directly.

5. **Audit Trail**: All reward transactions are recorded on the blockchain with timestamps, creating an immutable audit trail for compliance purposes.

**Real-World Example:**

When Uber's Ethics Officer approves a $500 USDC reward for a valid harassment report:

1. The Reward System Chaincode creates a reward asset linked to the complaint
2. It generates a one-time use anonymous wallet
3. It transfers $500 USDC from Uber's organization wallet to this anonymous wallet
4. The whistleblower receives secure claim instructions
5. The whistleblower can claim the reward to their personal crypto wallet without revealing their identity

3. **Audit Trail Chaincode**

```javascript
// Audit Record Structure
const auditRecord = {
  auditId: "AU98765432",
  timestamp: "2025-05-24T15:45:00Z",
  actor: {
    role: "ethics_officer",
    id: "user123", // Anonymized for whistleblower
    organization: "uber"
  },
  action: "update_status", // create, view, update, assign, approve_reward, etc.
  resource: {
    type: "complaint",
    id: "AG7X9M2K4P"
  },
  details: {
    previousValue: "new",
    newValue: "under_review"
  },
  ipAddress: "anonymized_ip",
  systemVersion: "1.2.3"
};

// Audit Trail Functions
async function recordAudit(ctx, auditData) {
  // Automatically called by other chaincodes
  // Store immutable audit record
  // No update/delete operations allowed
  return auditId;
}

async function queryAuditsByResource(ctx, resourceType, resourceId) {
  // Verify caller has permission
  // Return all audit records for the resource
  return auditRecords;
}

async function generateComplianceReport(ctx, startDate, endDate, filters) {
  // Verify caller has admin permission
  // Generate comprehensive audit report
  // Apply filters (user, action, resource)
  return reportData;
}
```

#### Audit Trail Chaincode Explained

The Audit Trail Chaincode is a critical component for compliance, security, and transparency in the AegisWhistle platform. It creates an immutable record of all actions taken within the system, ensuring accountability and providing evidence for regulatory compliance.

**Key Features and Functions:**

1. **Comprehensive Logging**: Automatically records every significant action in the system, including:
   - Complaint creation and status changes
   - User access to sensitive information
   - Assignment of investigators
   - Approval and processing of rewards
   - Communication between parties

2. **Tamper-Proof Records**: All audit records are stored on the blockchain, making them immutable and tamper-proof. This is essential for maintaining the integrity of whistleblower investigations.

3. **Privacy-Preserving**: While recording all actions, the chaincode anonymizes sensitive information to protect whistleblower identities and comply with privacy regulations.

4. **Compliance Reporting**: Generates comprehensive reports for regulatory compliance (SOX, GDPR, etc.) with filtering capabilities by date range, action type, user role, and resource.

5. **Evidence Preservation**: In case of legal proceedings, provides cryptographically verifiable evidence of all actions taken during the whistleblower reporting and investigation process.

**Real-World Example:**

When an Ethics Officer at Uber changes the status of a whistleblower complaint from "new" to "under_review":

1. The Audit Trail Chaincode automatically creates an audit record with:
   - Timestamp of the action
   - Ethics Officer's role (but with anonymized ID for privacy)
   - The specific action ("update_status")
   - The affected resource (the complaint ID)
   - The before and after values ("new" to "under_review")

2. This record becomes part of the immutable blockchain ledger

3. Later, if Uber needs to demonstrate compliance with whistleblower protection regulations, they can generate a comprehensive audit report showing the proper handling of all complaints

### Private Data Collections

For sensitive data that should not be shared across the entire network:

```yaml
# Private Data Collection Definition
collections:
  - name: whistleblowerIdentityCollection
    policy: "OR('OrgMSP.member')"
    requiredPeerCount: 1
    maxPeerCount: 1
    blockToLive: 0
    memberOnlyRead: true
    memberOnlyWrite: true
    endorsementPolicy:
      signaturePolicy: "OR('OrgMSP.member')"
  
  - name: rewardDetailsCollection
    policy: "OR('OrgMSP.member')"
    requiredPeerCount: 1
    maxPeerCount: 2
    blockToLive: 0
    memberOnlyRead: true
    memberOnlyWrite: true
    endorsementPolicy:
      signaturePolicy: "OR('OrgMSP.member')"
```

## API Specifications

### Organization Management API

```javascript
// Create Organization
POST /api/v1/organizations
{
  "organizationName": "Uber Technologies",
  "subdomain": "uber",
  "adminEmail": "ethics@uber.com",
  "domain": "uber.com",
  "bountyConfig": {
    "minReward": 100,
    "maxReward": 5000,
    "currency": "USD",
    "cryptoOptions": ["USDC", "ETH"]
  },
  "anonymityLevel": "encrypted", // "complete", "encrypted", "pseudo"
  "businessType": "Technology",
  "employeeCount": "10000+",
  "complianceRequirements": ["SOX", "GDPR"]
}

// Get Organization Details
GET /api/v1/organizations/{orgId}

// Update Organization Settings
PUT /api/v1/organizations/{orgId}

// Invite Team Member
POST /api/v1/organizations/{orgId}/invitations
{
  "email": "investigator@uber.com",
  "role": "investigator",
  "permissions": ["view_complaints", "update_status", "query_whistleblower"]
}
```

### Complaint Management API

```javascript
// Get Complaints (Ethics Officer/Investigator)
GET /api/v1/organizations/{orgId}/complaints?status=new&page=1&limit=20

// Get Complaint Details
GET /api/v1/organizations/{orgId}/complaints/{reportId}

// Update Complaint Status
PUT /api/v1/organizations/{orgId}/complaints/{reportId}/status
{
  "status": "under_review",
  "notes": "Initial review in progress"
}

// Assign Investigator
POST /api/v1/organizations/{orgId}/complaints/{reportId}/assignments
{
  "investigatorId": "user456",
  "instructions": "Please focus on gathering evidence",
  "priority": "high",
  "deadline": "2025-06-15T00:00:00Z"
}

// Query Whistleblower
POST /api/v1/organizations/{orgId}/complaints/{reportId}/queries
{
  "question": "Could you provide more details about the location?",
  "responseDeadline": "2025-06-10T00:00:00Z"
}
```

### Whistleblower API

```javascript
// Submit Text Complaint
POST /api/v1/whistleblower/complaints
{
  "organizationId": "uber",
  "incidentType": "Harassment",
  "description": "I witnessed inappropriate behavior...",
  "incidentDate": "2025-05-15",
  "location": "10th floor meeting room",
  "witnesses": "Two other team members were present",
  "evidence": null,
  "impact": "This has created a hostile work environment"
}

// Check Complaint Status
GET /api/v1/whistleblower/complaints/{reportId}

// Respond to Query
POST /api/v1/whistleblower/complaints/{reportId}/responses
{
  "queryId": "Q12345",
  "response": "The incident occurred around 2pm in the main conference room"
}

// Claim Reward
POST /api/v1/whistleblower/rewards/{rewardId}/claim
{
  "targetWallet": "0x..." // Optional, can use anonymous wallet
}
```

### Voice Processing API

```javascript
// VAPI Integration
POST /api/v1/voice/process
{
  "conversationId": "vapi_conversation_id",
  "summary": "Employee reports harassment by supervisor...",
  "transcript": "Full conversation transcript...",
  "metadata": {
    "duration": 420, // seconds
    "language": "en-US",
    "confidence": 0.95
  }
}

// Gemini Live Integration
POST /api/v1/voice/gemini/process
{
  "sessionId": "gemini_session_id",
  "transcript": "Full conversation transcript...",
  "summary": "Employee reports harassment by supervisor...",
  "analysis": {
    "sentiment": "concerned",
    "urgency": "high",
    "categories": ["harassment", "workplace safety"]
  }
}
```

### Professional Marketplace API

```javascript
// Register Professional Service
POST /api/v1/marketplace/providers
{
  "basicInfo": {
    "businessName": "Smith Legal Services",
    "contactPerson": "John Smith, Esq.",
    "businessType": "Legal Services",
    "specialization": ["Employment Law", "Corporate Compliance"],
    "yearsOfExperience": 15,
    "location": {
      "city": "San Francisco",
      "state": "CA",
      "serviceRadius": "Bay Area + Remote"
    }
  },
  "credentials": {
    "businessLicense": {
      "number": "BL123456",
      "state": "CA",
      "expirationDate": "2026-12-31"
    },
    "professionalLicense": {
      "barNumber": "12345",
      "state": "CA", 
      "status": "active"
    },
    "certifications": [
      "Employment Law Specialist",
      "Corporate Compliance Expert"
    ],
    "insurance": {
      "provider": "LawPro Insurance",
      "coverage": "$2M Professional Liability"
    }
  },
  "serviceOffering": {
    "servicesProvided": [
      "Legal consultation on workplace issues",
      "Compliance review and recommendations", 
      "Investigation support",
      "Documentation review"
    ],
    "pricing": {
      "consultationFee": "$300/hour",
      "retainerOptions": true,
      "emergencyRate": "$450/hour"
    },
    "availability": {
      "businessHours": "Mon-Fri 9AM-6PM PST",
      "emergencyAvailable": true,
      "responseTime": "Within 4 hours"
    }
  }
}

// Search Professionals
GET /api/v1/marketplace/providers?category=legal&specialization=employment_law

// Request Service
POST /api/v1/organizations/{orgId}/service-requests
{
  "providerId": "provider123",
  "caseId": "AG7X9M2K4P",
  "serviceType": "legal_consultation",
  "urgency": "high",
  "budget": 2000,
  "details": "Need consultation on a sexual harassment case"
}
```
