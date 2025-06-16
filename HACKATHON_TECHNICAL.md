# AegisWhistle Hackathon Technical Specification
## 10-Day Implementation Guide & Technical Architecture

### 📋 **Document Overview**
This document provides comprehensive technical specifications for implementing AegisWhistle during the 10-day hackathon, combining architectural guidelines from the main technical specification with practical implementation details from the hackathon plan.

**Scope:** Free, Audio, Video, and Rewards tiers only (Professional and Enterprise tiers excluded from hackathon scope)

**Platform:** Docker-based development with consistent port allocation and Python deployment scripts

---

## 🎯 **Technical Objectives**

### **Primary Goals:**
- **Multi-Modal Reporting Platform**: Text (Free), Voice (Audio $99), Video (Video $149)
- **Crypto Reward System**: USDC/ETH processing with anonymous claiming
- **Role-Based Platform**: Admin, Ethics Officer, Investigator, Whistleblower roles
- **Production-Ready Architecture**: Scalable, secure, containerized deployment
- **Frontend-Testable Daily**: Working UI components every day at fixed URLs

### **Technology Stack:**
- **Frontend**: Next.js 15.2.4 + React 19 + TypeScript
- **Backend**: Next.js API Routes + PostgreSQL + Redis
- **Voice Integration**: VAPI (Audio tier)
- **Video Integration**: Tavus (Video tier)
- **Crypto**: USDC/ETH on Polygon network
- **Deployment**: Docker containers with Python management scripts
- **UI**: Tailwind CSS + Radix UI + Lucide Icons

---

## 🏗️ **System Architecture**

### **Container Architecture**
```
Docker Environment (Fixed Ports):
├── Frontend Container (Port 3000)    - Next.js React application
├── Backend Container (Port 3001)     - API routes and business logic  
├── PostgreSQL (Port 5432)            - Primary database
└── Redis (Port 6379)                 - Caching and sessions
```

### **Application Structure**
```
aegisv11/
├── frontend/                     # Frontend Next.js application
│   ├── app/                     # Next.js 13+ App Router
│   │   ├── (auth)/
│   │   │   ├── login/page.tsx   # Multi-role authentication
│   │   │   └── register/page.tsx # Organization registration
│   │   ├── dashboard/
│   │   │   ├── admin/page.tsx   # Organization admin panel
│   │   │   ├── ethics-officer/page.tsx # Case management dashboard
│   │   │   ├── investigator/page.tsx # Investigation workspace
│   │   │   └── components/      # Dashboard-specific components
│   │   ├── report/
│   │   │   ├── page.tsx        # Report type selection
│   │   │   ├── text/page.tsx   # Free tier text reporting
│   │   │   ├── voice/page.tsx  # Audio tier voice reporting
│   │   │   ├── video/page.tsx  # Video tier video reporting
│   │   │   └── components/     # Reporting components
│   │   ├── track/page.tsx      # Anonymous report tracking
│   │   ├── claim/page.tsx      # Crypto reward claiming
│   │   └── globals.css         # Global styles
│   ├── components/             # Reusable UI components
│   │   ├── ui/                # Radix UI components
│   │   ├── forms/             # Form components
│   │   ├── dashboard/         # Dashboard layouts
│   │   ├── vapi-voice-widget.tsx # VAPI integration
│   │   └── video-recorder.tsx # Tavus integration
│   └── lib/                   # Frontend utilities
│       ├── auth.ts            # Authentication logic
│       ├── api.ts             # API client functions
│       └── utils.ts           # General utilities
│
├── backend/                    # Backend Node.js/Express application
│   ├── src/
│   │   ├── config/            # Essential configuration
│   │   │   ├── database.ts    # PostgreSQL + Redis configuration
│   │   │   ├── auth.ts        # JWT and session config
│   │   │   └── modules.ts     # Tier-based module loading
│   │   │
│   │   ├── core/              # Core infrastructure (hackathon essentials)
│   │   │   ├── auth/          # Authentication system
│   │   │   │   ├── auth.service.ts     # JWT token management
│   │   │   │   ├── auth.controller.ts  # Login/register endpoints
│   │   │   │   ├── auth.middleware.ts  # Route protection
│   │   │   │   └── auth.types.ts       # Auth interfaces
│   │   │   │
│   │   │   ├── database/      # Database layer
│   │   │   │   ├── database.service.ts # PostgreSQL connection
│   │   │   │   ├── database.factory.ts # Connection factory
│   │   │   │   ├── migrations/         # Database schema setup
│   │   │   │   └── adapters/
│   │   │   │       └── postgresql.adapter.ts # Primary database adapter
│   │   │   │
│   │   │   ├── api-gateway/   # Request handling
│   │   │   │   ├── gateway.service.ts  # Route management
│   │   │   │   ├── validator.ts        # Input validation
│   │   │   │   └── tenant-router.ts    # Organization routing
│   │   │   │
│   │   │   ├── cache/         # Caching layer
│   │   │   │   ├── cache.service.ts    # Cache management
│   │   │   │   └── redis.client.ts     # Redis integration
│   │   │   │
│   │   │   └── notifications/ # Basic notifications
│   │   │       ├── notification.service.ts # Notification system
│   │   │       └── email.provider.ts       # Email notifications
│   │   │
│   │   ├── modules/           # Hackathon-specific modules
│   │   │   ├── voice-agent/   # Audio tier ($99/month)
│   │   │   │   ├── voice.module.ts      # Voice module setup
│   │   │   │   ├── voice.service.ts     # VAPI integration logic
│   │   │   │   ├── voice.controller.ts  # Voice API endpoints
│   │   │   │   ├── vapi.client.ts       # VAPI client wrapper
│   │   │   │   └── voice.types.ts       # Voice interfaces
│   │   │   │
│   │   │   ├── video-agent/   # Video tier ($149/month)
│   │   │   │   ├── video.module.ts      # Video module setup
│   │   │   │   ├── video.service.ts     # Tavus integration logic
│   │   │   │   ├── video.controller.ts  # Video API endpoints
│   │   │   │   ├── tavus.client.ts      # Tavus client wrapper
│   │   │   │   └── video.types.ts       # Video interfaces
│   │   │   │
│   │   │   ├── rewards/       # Crypto reward system
│   │   │   │   ├── rewards.module.ts    # Rewards module setup
│   │   │   │   ├── rewards.service.ts   # Reward processing logic
│   │   │   │   ├── rewards.controller.ts # Rewards API endpoints
│   │   │   │   ├── crypto.wallet.ts     # Crypto wallet management
│   │   │   │   └── payment.processor.ts # USDC/ETH processing
│   │   │   │
│   │   │   └── reports/       # Core reporting system
│   │   │       ├── reports.module.ts    # Reports module setup
│   │   │       ├── reports.service.ts   # Report management logic
│   │   │       ├── reports.controller.ts # Reports API endpoints
│   │   │       ├── cases.service.ts     # Case management
│   │   │       └── tracking.service.ts  # Anonymous tracking
│   │   │
│   │   ├── shared/            # Shared utilities (hackathon essentials)
│   │   │   ├── types/         # TypeScript interfaces
│   │   │   │   ├── common.types.ts      # Common interfaces
│   │   │   │   ├── user.types.ts        # User-related types
│   │   │   │   ├── organization.types.ts # Organization types
│   │   │   │   └── tier.types.ts        # Subscription tier types
│   │   │   │
│   │   │   ├── utils/         # Utility functions
│   │   │   │   ├── logger.ts            # Logging system
│   │   │   │   ├── encryption.ts        # Data encryption
│   │   │   │   ├── validation.ts        # Input validation
│   │   │   │   └── helpers.ts           # Helper functions
│   │   │   │
│   │   │   ├── middleware/    # Express middleware
│   │   │   │   ├── error-handler.ts     # Global error handling
│   │   │   │   ├── request-logger.ts    # Request logging
│   │   │   │   ├── cors.ts              # CORS configuration
│   │   │   │   └── tier-validator.ts    # Subscription tier validation
│   │   │   │
│   │   │   └── decorators/    # Decorators for clean code
│   │   │       ├── auth.decorator.ts    # Authentication decorator
│   │   │       ├── cache.decorator.ts   # Caching decorator
│   │   │       └── tier.decorator.ts    # Tier validation decorator
│   │   │
│   │   ├── routes/            # API route definitions
│   │   │   ├── index.ts       # Main router setup
│   │   │   ├── auth.routes.ts # Authentication routes
│   │   │   ├── organization.routes.ts   # Organization management
│   │   │   ├── user.routes.ts # User management
│   │   │   ├── reports.routes.ts        # Report submission & tracking
│   │   │   ├── cases.routes.ts          # Case management
│   │   │   └── modules/       # Module-specific routes
│   │   │       ├── voice.routes.ts      # Voice processing routes
│   │   │       ├── video.routes.ts      # Video processing routes
│   │   │       └── rewards.routes.ts    # Crypto rewards routes
│   │   │
│   │   └── models/            # Data models (hackathon scope)
│   │       ├── user.model.ts            # User data model
│   │       ├── organization.model.ts    # Organization model
│   │       ├── subscription.model.ts    # Subscription tier model
│   │       ├── report.model.ts          # Report data model
│   │       ├── case.model.ts            # Case management model
│   │       └── reward.model.ts          # Reward transaction model
│   │
│   └── tests/                 # Testing (essential for production)
│       ├── unit/              # Unit tests
│       │   ├── auth.test.ts
│       │   ├── reports.test.ts
│       │   ├── voice.test.ts
│       │   ├── video.test.ts
│       │   └── rewards.test.ts
│       └── integration/       # Integration tests
│           ├── api.test.ts
│           ├── database.test.ts
│           └── modules.test.ts
│
└── deployment/                # Docker deployment (as specified)
    ├── docker/
    │   ├── frontend.Dockerfile
    │   └── backend.Dockerfile
    └── scripts/
        ├── deploy.py          # Python deployment script
        └── health_check.py    # Health monitoring
```

### **Hackathon Backend Architecture Rationale**

#### **What We're INCLUDING from Technical Specification:**

1. **Core Infrastructure (Essential):**
   - `core/auth/` - Complete authentication system with JWT
   - `core/database/` - PostgreSQL adapter and connection management
   - `core/api-gateway/` - Request routing and validation
   - `core/cache/` - Redis caching for performance
   - `core/notifications/` - Basic email notifications

2. **Tier-Specific Modules (Hackathon Scope):**
   - `modules/voice-agent/` - VAPI integration for Audio tier ($99/month)
   - `modules/video-agent/` - Tavus integration for Video tier ($149/month)
   - `modules/rewards/` - Crypto reward processing (USDC/ETH)
   - `modules/reports/` - Core reporting system (Free tier + enhanced)

3. **Shared Infrastructure (Production-Ready):**
   - `shared/types/` - TypeScript interfaces for type safety
   - `shared/utils/` - Logging, encryption, validation utilities
   - `shared/middleware/` - Error handling, CORS, tier validation
   - `shared/decorators/` - Clean code patterns

4. **Essential Models (Hackathon Data):**
   - User, Organization, Subscription, Report, Case, Reward models

#### **What We're EXCLUDING from Technical Specification:**

1. **Professional/Enterprise Features (Out of Scope):**
   - `modules/blockchain/` - Hyperledger Fabric integration
   - `modules/marketplace/` - Professional services marketplace
   - `modules/analytics/` - Advanced analytics (basic only)

2. **Multiple Database Adapters (Simplified):**
   - Only PostgreSQL adapter (not MySQL, MongoDB, Hyperledger)
   - Simplified database factory

3. **Advanced Infrastructure (Over-Engineering):**
   - Complex rate limiting (basic only)
   - Advanced security features (basic only)
   - Swagger documentation (minimal for hackathon)

#### **Hackathon Development Strategy:**

**Days 1-2: Core Infrastructure**
```typescript
// Implement essential core modules
- core/auth/ - Authentication system
- core/database/ - PostgreSQL connection
- core/api-gateway/ - Basic routing
- shared/middleware/ - Essential middleware
```

**Days 3-4: Free + Audio Tier**
```typescript
// Implement reporting and voice modules
- modules/reports/ - Text reporting (Free tier)
- modules/voice-agent/ - VAPI integration (Audio tier)
- routes/reports.routes.ts - Report API endpoints
- routes/voice.routes.ts - Voice processing API
```

**Days 5-6: Video + Rewards**
```typescript
// Implement video and crypto modules
- modules/video-agent/ - Tavus integration (Video tier)
- modules/rewards/ - Crypto reward system
- routes/video.routes.ts - Video processing API
- routes/rewards.routes.ts - Crypto rewards API
```

**Days 7-8: Integration + Testing**
```typescript
// Complete integration and testing
- tests/unit/ - Unit tests for all modules
- tests/integration/ - API integration tests
- shared/utils/logger.ts - Production logging
- shared/middleware/error-handler.ts - Error handling
```

This streamlined architecture maintains the modular, production-ready approach from the technical specification while focusing only on the components needed for the hackathon scope.

---

## 📊 **Database Schema**

### **Core Tables**

#### **Organizations Table**
```sql
CREATE TABLE organizations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  subdomain VARCHAR(100) UNIQUE NOT NULL,
  subscription_tier VARCHAR(50) DEFAULT 'free', -- 'free', 'audio', 'video'
  department_count INTEGER DEFAULT 1,
  max_departments INTEGER DEFAULT 1,
  crypto_wallet_address VARCHAR(100),
  wallet_balance DECIMAL(20,8) DEFAULT 0.00,
  eth_wallet_balance DECIMAL(20,8) DEFAULT 0.00,
  wallet_private_key_encrypted TEXT,
  billing_email VARCHAR(255),
  tier_upgraded_at TIMESTAMP,
  settings JSONB DEFAULT '{}',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

#### **Users Table**
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL, -- 'admin', 'ethics_officer', 'investigator'
  organization_id UUID REFERENCES organizations(id),
  department_id UUID REFERENCES departments(id),
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  crypto_wallet_address VARCHAR(100),
  email_verified BOOLEAN DEFAULT false,
  last_login TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

#### **Reports Table**
```sql
CREATE TABLE reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  anonymous_id VARCHAR(20) UNIQUE NOT NULL,
  organization_id UUID REFERENCES organizations(id),
  department_id UUID REFERENCES departments(id),
  title VARCHAR(255),
  description TEXT,
  report_type VARCHAR(50), -- 'text', 'voice', 'video'
  status VARCHAR(50) DEFAULT 'new',
  voice_transcript TEXT,
  voice_confidence_score DECIMAL(3,2),
  voice_duration_seconds INTEGER,
  video_url VARCHAR(500),
  video_processing_status VARCHAR(50),
  video_duration_seconds INTEGER,
  file_attachments JSONB,
  assigned_to UUID REFERENCES users(id),
  reward_eligible BOOLEAN DEFAULT false,
  reward_amount DECIMAL(10,2),
  reward_currency VARCHAR(10) DEFAULT 'USDC',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

#### **Cases Table**
```sql
CREATE TABLE cases (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  case_number VARCHAR(50) UNIQUE NOT NULL,
  report_id UUID REFERENCES reports(id),
  assigned_ethics_officer UUID REFERENCES users(id),
  assigned_investigator UUID REFERENCES users(id),
  status VARCHAR(50) DEFAULT 'open',
  priority VARCHAR(20) DEFAULT 'medium',
  notes TEXT,
  resolution_notes TEXT,
  reward_approved BOOLEAN DEFAULT false,
  reward_approved_by UUID REFERENCES users(id),
  reward_approved_at TIMESTAMP,
  reward_processed BOOLEAN DEFAULT false,
  reward_transaction_hash VARCHAR(100),
  reward_processed_at TIMESTAMP,
  estimated_resolution_date DATE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

#### **Reward Transactions Table**
```sql
CREATE TABLE reward_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  case_id UUID REFERENCES cases(id),
  report_id UUID REFERENCES reports(id),
  organization_id UUID REFERENCES organizations(id),
  amount DECIMAL(20,8) NOT NULL,
  currency VARCHAR(10) DEFAULT 'USDC',
  from_wallet VARCHAR(100) NOT NULL,
  to_wallet VARCHAR(100),
  transaction_hash VARCHAR(100),
  network VARCHAR(50) DEFAULT 'polygon',
  status VARCHAR(50) DEFAULT 'pending',
  claim_code VARCHAR(50) UNIQUE,
  claimed_at TIMESTAMP,
  expires_at TIMESTAMP,
  approved_by UUID REFERENCES users(id),
  gas_fee DECIMAL(20,8),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

#### **Usage Metrics Table**
```sql
CREATE TABLE usage_metrics (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID REFERENCES organizations(id),
  metric_type VARCHAR(50) NOT NULL,
  current_value INTEGER DEFAULT 0,
  limit_value INTEGER NOT NULL,
  period_start DATE,
  period_end DATE,
  overage_warning_sent BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

---

## 🔌 **API Specifications**

### **Authentication Endpoints**
```typescript
// Authentication & User Management
POST   /api/auth/login          // Multi-role login with tier validation
POST   /api/auth/register       // Organization registration + tier setup
POST   /api/auth/logout         // Secure session termination
GET    /api/auth/me             // Current user info with tier details
POST   /api/auth/verify-email   // Email verification
POST   /api/auth/reset-password // Password reset workflow

// Request/Response Examples:
POST /api/auth/login
{
  "email": "admin@company.com",
  "password": "securePassword123",
  "organization": "company"
}

Response:
{
  "user": {
    "id": "uuid",
    "email": "admin@company.com", 
    "role": "admin",
    "organization": {
      "name": "Company",
      "tier": "video",
      "subdomain": "company"
    }
  },
  "token": "jwt_token"
}
```

### **Organization & Department Endpoints**
```typescript
// Organization Management
GET    /api/organizations       // Get org details + tier info
PUT    /api/organizations       // Update org settings
POST   /api/organizations/upgrade // Subscription tier upgrade
GET    /api/organizations/usage // Current usage vs tier limits

// Department Management  
GET    /api/departments         // List departments (tier limited)
POST   /api/departments         // Create department (tier validation)
PUT    /api/departments/:id     // Update department
DELETE /api/departments/:id     // Archive department

// Example: Create Department
POST /api/departments
{
  "name": "Human Resources",
  "description": "HR related reports and cases",
  "ethics_officer_id": "uuid",
  "max_investigators": 2
}
```

### **Reporting Endpoints**
```typescript
// Report Submission (Tier-Based)
POST   /api/reports             // Submit report (tier determines features)
GET    /api/reports/:id         // Get report details
PUT    /api/reports/:id         // Update report
GET    /api/reports/track/:anonymousId // Anonymous tracking

// Voice Processing (Audio Tier)
POST   /api/voice/process       // Process VAPI transcript
GET    /api/voice/status/:id    // Check processing status
POST   /api/voice/upload        // Upload voice file

// Video Processing (Video Tier)  
POST   /api/video/process       // Process Tavus video
GET    /api/video/status/:id    // Check processing status
POST   /api/video/upload        // Upload video file

// Example: Submit Text Report (Free Tier)
POST /api/reports
{
  "type": "text",
  "title": "Workplace harassment incident",
  "description": "Detailed description...",
  "department_id": "uuid",
  "anonymous": true,
  "attachments": ["file1.pdf", "file2.jpg"]
}

Response:
{
  "report_id": "uuid",
  "anonymous_id": "XK7F9P2Q1R",
  "status": "submitted",
  "tracking_url": "/track/XK7F9P2Q1R"
}
```

### **Case Management Endpoints**
```typescript
// Case Workflow
POST   /api/cases               // Create case from report
GET    /api/cases               // List cases (role-filtered)
GET    /api/cases/:id           // Case details
PUT    /api/cases/:id           // Update case
POST   /api/cases/:id/assign    // Assign to investigator
POST   /api/cases/:id/resolve   // Mark resolved
POST   /api/cases/:id/close     // Close case

// Case Communication
POST   /api/cases/:id/notes     // Add investigation notes
GET    /api/cases/:id/timeline  // Case activity timeline
POST   /api/cases/:id/evidence  // Add evidence
```

### **Crypto Reward Endpoints**
```typescript
// Reward Management
POST   /api/rewards/approve     // Approve reward (ethics officer)
POST   /api/rewards/process     // Process crypto payment
GET    /api/rewards/claim/:code // Claim reward anonymously
GET    /api/rewards/status/:id  // Check reward status

// Wallet Management
POST   /api/wallet/setup        // Setup company wallet
GET    /api/wallet/balance      // Current USDC/ETH balance
POST   /api/wallet/fund         // Fund via fiat payment
GET    /api/wallet/transactions // Transaction history

// Example: Approve Reward
POST /api/rewards/approve
{
  "case_id": "uuid",
  "amount": 500.00,
  "currency": "USDC",
  "approved_by": "ethics_officer_uuid"
}

Response:
{
  "reward_id": "uuid",
  "claim_code": "CLAIM-ABC123XYZ",
  "expires_at": "2024-02-15T10:00:00Z",
  "claim_url": "/claim/CLAIM-ABC123XYZ"
}
```

---

## 🛠️ **Integration Specifications**

### **VAPI Voice Integration (Audio Tier)**
```typescript
// components/VoiceReporter.tsx
interface VAPIConfig {
  assistantId: string;
  apiKey: string;
  onTranscriptComplete: (transcript: string, confidence: number) => void;
  onError: (error: Error) => void;
  onStateChange: (state: 'idle' | 'listening' | 'processing') => void;
}

export function VoiceReporter({ onComplete }: { onComplete: (data: VoiceData) => void }) {
  const [isRecording, setIsRecording] = useState(false);
  const [transcript, setTranscript] = useState('');
  const [confidence, setConfidence] = useState(0);

  // VAPI integration logic
  const startRecording = async () => {
    // Initialize VAPI session
    // Handle real-time transcription
    // Process voice data
  };

  return (
    <div className="voice-reporter">
      <Button 
        onClick={startRecording}
        disabled={isRecording}
        className="record-btn"
      >
        {isRecording ? 'Recording...' : 'Start Voice Report'}
      </Button>
      
      {transcript && (
        <div className="transcript-preview">
          <p>Transcript (Confidence: {confidence}%)</p>
          <div className="transcript-text">{transcript}</div>
        </div>
      )}
    </div>
  );
}
```

### **Tavus Video Integration (Video Tier)**
```typescript
// components/VideoReporter.tsx
interface TavusConfig {
  apiKey: string;
  avatarId: string;
  onVideoComplete: (videoUrl: string, transcript: string, duration: number) => void;
  onProcessingUpdate: (status: string, progress: number) => void;
}

export function VideoReporter({ onComplete }: { onComplete: (data: VideoData) => void }) {
  const [isRecording, setIsRecording] = useState(false);
  const [processingStatus, setProcessingStatus] = useState('');
  const [progress, setProgress] = useState(0);

  // Tavus integration logic
  const startVideoSession = async () => {
    // Initialize Tavus video session
    // Handle video recording
    // Process video and extract transcript
  };

  return (
    <div className="video-reporter">
      <div className="video-container">
        {/* Tavus video interface */}
      </div>
      
      <Button 
        onClick={startVideoSession}
        disabled={isRecording}
        className="record-btn"
      >
        {isRecording ? 'Recording Video...' : 'Start Video Report'}
      </Button>
      
      {processingStatus && (
        <div className="processing-status">
          <p>Status: {processingStatus}</p>
          <div className="progress-bar">
            <div style={{ width: `${progress}%` }} />
          </div>
        </div>
      )}
    </div>
  );
}
```

### **Crypto Wallet Integration**
```typescript
// lib/crypto.ts
import { ethers } from 'ethers';

interface WalletManager {
  setupWallet: (organizationId: string) => Promise<WalletInfo>;
  getBalance: (walletAddress: string) => Promise<BalanceInfo>;
  processReward: (amount: number, claimCode: string) => Promise<TransactionInfo>;
  fundWallet: (amount: number, paymentMethod: string) => Promise<FundingInfo>;
}

export class CryptoWalletManager implements WalletManager {
  private provider: ethers.Provider;
  private network: string = 'polygon';

  constructor() {
    this.provider = new ethers.JsonRpcProvider(process.env.POLYGON_RPC_URL);
  }

  async setupWallet(organizationId: string): Promise<WalletInfo> {
    // Generate new wallet for organization
    const wallet = ethers.Wallet.createRandom();
    
    // Encrypt and store private key
    const encryptedKey = await this.encryptPrivateKey(wallet.privateKey);
    
    // Store in database
    await this.saveWalletToDatabase(organizationId, {
      address: wallet.address,
      encryptedPrivateKey: encryptedKey
    });

    return {
      address: wallet.address,
      network: this.network,
      balance: { usdc: 0, eth: 0 }
    };
  }

  async processReward(amount: number, claimCode: string): Promise<TransactionInfo> {
    // Process anonymous crypto reward
    // Generate transaction on Polygon network
    // Return transaction hash and status
  }

  // Additional crypto functions...
}
```

---

## 📅 **10-Day Implementation Roadmap**

### **Day 1: Foundation + Authentication**
**Backend Implementation:**
```typescript
// app/api/auth/login/route.ts
export async function POST(request: Request) {
  const { email, password, organization } = await request.json();
  
  // Validate credentials
  const user = await authenticateUser(email, password, organization);
  
  // Generate JWT with tier info
  const token = generateJWT({
    userId: user.id,
    role: user.role,
    organizationId: user.organization_id,
    tier: user.organization.subscription_tier
  });

  return Response.json({ user, token });
}

// app/api/auth/register/route.ts  
export async function POST(request: Request) {
  const { organizationName, adminEmail, password, tier } = await request.json();
  
  // Create organization
  const organization = await createOrganization({
    name: organizationName,
    subdomain: generateSubdomain(organizationName),
    subscription_tier: tier || 'free'
  });

  // Create admin user
  const admin = await createUser({
    email: adminEmail,
    password: hashPassword(password),
    role: 'admin',
    organization_id: organization.id
  });

  return Response.json({ organization, admin });
}
```

**Frontend Implementation:**
```typescript
// app/(auth)/login/page.tsx
export default function LoginPage() {
  const [formData, setFormData] = useState({
    email: '',
    password: '',
    organization: ''
  });

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    
    const response = await fetch('/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(formData)
    });

    if (response.ok) {
      const { user, token } = await response.json();
      // Store token and redirect based on role
      localStorage.setItem('token', token);
      router.push(`/dashboard/${user.role}`);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="login-form">
      <Input 
        placeholder="Email"
        value={formData.email}
        onChange={(e) => setFormData({...formData, email: e.target.value})}
      />
      <Input 
        type="password"
        placeholder="Password"
        value={formData.password}
        onChange={(e) => setFormData({...formData, password: e.target.value})}
      />
      <Input 
        placeholder="Organization"
        value={formData.organization}
        onChange={(e) => setFormData({...formData, organization: e.target.value})}
      />
      <Button type="submit">Login</Button>
    </form>
  );
}
```

**🧪 Day 1 Testing:**
- Visit http://localhost:3000
- Navigate to /login and /register
- Submit forms and see validation
- Check routing between pages

### **Day 2: Dashboard Shell + User Management**
**Backend Implementation:**
```typescript
// app/api/users/profile/route.ts
export async function GET(request: Request) {
  const token = request.headers.get('authorization');
  const user = await validateToken(token);
  
  const profile = await getUserProfile(user.id);
  return Response.json(profile);
}

// Middleware for role-based access
export function withAuth(roles: string[]) {
  return async (request: Request) => {
    const token = request.headers.get('authorization');
    const user = await validateToken(token);
    
    if (!roles.includes(user.role)) {
      return Response.json({ error: 'Unauthorized' }, { status: 403 });
    }
    
    return user;
  };
}
```

**Frontend Implementation:**
```typescript
// app/dashboard/layout.tsx
export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  const { user, organization } = useAuth();

  return (
    <div className="dashboard-layout">
      <Sidebar>
        <div className="user-info">
          <Avatar src={user.avatar} />
          <div>
            <p className="user-name">{user.name}</p>
            <p className="user-role">{user.role}</p>
            <Badge variant="outline">{organization.tier}</Badge>
          </div>
        </div>
        
        <nav className="nav-menu">
          <NavLink href="/dashboard">Overview</NavLink>
          {user.role === 'admin' && (
            <>
              <NavLink href="/dashboard/admin">Admin Panel</NavLink>
              <NavLink href="/dashboard/admin/wallet">Wallet</NavLink>
            </>
          )}
          {user.role === 'ethics_officer' && (
            <NavLink href="/dashboard/ethics-officer">Cases</NavLink>
          )}
          {user.role === 'investigator' && (
            <NavLink href="/dashboard/investigator">Investigations</NavLink>
          )}
        </nav>
      </Sidebar>
      
      <main className="dashboard-content">
        {children}
      </main>
    </div>
  );
}
```

**🧪 Day 2 Testing:**
- Register new account and login
- Access role-specific dashboard
- View user profile and edit
- Test protected routes

### **Day 3: Free Tier Reporting**
**Backend Implementation:**
```typescript
// app/api/reports/route.ts
export async function POST(request: Request) {
  const user = await withAuth(['admin', 'ethics_officer'])(request);
  const { title, description, type, anonymous, attachments } = await request.json();

  // Generate anonymous ID
  const anonymousId = generateAnonymousId();

  // Create report
  const report = await createReport({
    anonymous_id: anonymousId,
    organization_id: user.organization_id,
    title,
    description,
    report_type: type,
    file_attachments: attachments,
    status: 'new'
  });

  return Response.json({
    report_id: report.id,
    anonymous_id: anonymousId,
    tracking_url: `/track/${anonymousId}`
  });
}

// app/api/reports/track/[id]/route.ts
export async function GET(request: Request, { params }: { params: { id: string } }) {
  const report = await getReportByAnonymousId(params.id);
  
  if (!report) {
    return Response.json({ error: 'Report not found' }, { status: 404 });
  }

  return Response.json({
    status: report.status,
    submitted_at: report.created_at,
    last_updated: report.updated_at,
    case_number: report.case?.case_number
  });
}
```

**Frontend Implementation:**
```typescript
// app/report/text/page.tsx
export default function TextReportPage() {
  const [reportData, setReportData] = useState({
    title: '',
    description: '',
    anonymous: true,
    attachments: []
  });
  const [submitted, setSubmitted] = useState(false);
  const [trackingId, setTrackingId] = useState('');

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    
    const response = await fetch('/api/reports', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ...reportData, type: 'text' })
    });

    if (response.ok) {
      const { anonymous_id } = await response.json();
      setTrackingId(anonymous_id);
      setSubmitted(true);
    }
  };

  if (submitted) {
    return (
      <div className="submission-success">
        <h2>Report Submitted Successfully</h2>
        <p>Your anonymous tracking ID: <strong>{trackingId}</strong></p>
        <p>You can track your report at: <Link href={`/track/${trackingId}`}>/track/{trackingId}</Link></p>
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} className="report-form">
      <Input 
        placeholder="Report Title"
        value={reportData.title}
        onChange={(e) => setReportData({...reportData, title: e.target.value})}
      />
      <Textarea 
        placeholder="Describe the incident..."
        value={reportData.description}
        onChange={(e) => setReportData({...reportData, description: e.target.value})}
      />
      <FileUpload 
        onFilesUploaded={(files) => setReportData({...reportData, attachments: files})}
        maxSize={5} // 5MB limit
      />
      <div className="anonymity-option">
        <Checkbox 
          checked={reportData.anonymous}
          onChange={(checked) => setReportData({...reportData, anonymous: checked})}
        />
        <label>Submit anonymously (recommended)</label>
      </div>
      <Button type="submit">Submit Report</Button>
    </form>
  );
}
```

**🧪 Day 3 Testing:**
- Submit text reports with file uploads
- Receive tracking ID
- Track report status anonymously
- View reports in dashboard

### **Day 4: Audio Tier + Case Management**
**Backend Implementation:**
```typescript
// app/api/voice/process/route.ts
export async function POST(request: Request) {
  const user = await withAuth(['admin', 'ethics_officer'])(request);
  const { audio_data, report_id } = await request.json();

  // Check if organization has audio tier access
  const organization = await getOrganization(user.organization_id);
  if (!['audio', 'video'].includes(organization.subscription_tier)) {
    return Response.json({ error: 'Audio tier required' }, { status: 403 });
  }

  // Process with VAPI
  const transcript = await processVAPIAudio(audio_data);

  // Update report with transcript
  await updateReport(report_id, {
    voice_transcript: transcript.text,
    voice_confidence_score: transcript.confidence,
    voice_duration_seconds: transcript.duration
  });

  return Response.json(transcript);
}

// app/api/cases/route.ts
export async function POST(request: Request) {
  const user = await withAuth(['ethics_officer'])(request);
  const { report_id, assigned_investigator_id, priority } = await request.json();

  const caseNumber = generateCaseNumber();
  
  const case_record = await createCase({
    case_number: caseNumber,
    report_id,
    assigned_ethics_officer: user.id,
    assigned_investigator: assigned_investigator_id,
    priority: priority || 'medium',
    status: 'open'
  });

  return Response.json(case_record);
}
```

**Frontend Implementation:**
```typescript
// app/report/voice/page.tsx
export default function VoiceReportPage() {
  const { organization } = useAuth();
  const [isRecording, setIsRecording] = useState(false);
  const [transcript, setTranscript] = useState('');
  const [confidence, setConfidence] = useState(0);

  // Check tier access
  if (!['audio', 'video'].includes(organization.tier)) {
    return (
      <div className="upgrade-required">
        <h2>Audio Tier Required</h2>
        <p>Upgrade to Audio tier ($99/month) to access voice reporting.</p>
        <Button onClick={() => router.push('/dashboard/admin/billing')}>
          Upgrade Now
        </Button>
      </div>
    );
  }

  return (
    <div className="voice-report-page">
      <h1>Voice Report Submission</h1>
      <VAPIVoiceWidget 
        onTranscriptComplete={(text, conf) => {
          setTranscript(text);
          setConfidence(conf);
        }}
        onRecordingStateChange={setIsRecording}
      />
      
      {transcript && (
        <div className="transcript-preview">
          <h3>Transcript Preview (Confidence: {confidence}%)</h3>
          <p>{transcript}</p>
          <Button onClick={handleSubmitVoiceReport}>
            Submit Voice Report
          </Button>
        </div>
      )}
    </div>
  );
}

// app/dashboard/ethics-officer/page.tsx
export default function EthicsOfficerDashboard() {
  const [reports, setReports] = useState([]);
  const [cases, setCases] = useState([]);

  return (
    <div className="ethics-dashboard">
      <div className="dashboard-header">
        <h1>Ethics Officer Dashboard</h1>
        <div className="stats-cards">
          <Card>
            <CardHeader>New Reports</CardHeader>
            <CardContent>{reports.filter(r => r.status === 'new').length}</CardContent>
          </Card>
          <Card>
            <CardHeader>Active Cases</CardHeader>
            <CardContent>{cases.filter(c => c.status === 'open').length}</CardContent>
          </Card>
        </div>
      </div>
      
      <div className="reports-section">
        <h2>New Reports</h2>
        {reports.map(report => (
          <ReportCard 
            key={report.id}
            report={report}
            onCreateCase={(reportId) => handleCreateCase(reportId)}
          />
        ))}
      </div>
      
      <div className="cases-section">
        <h2>Active Cases</h2>
        {cases.map(case_record => (
          <CaseCard 
            key={case_record.id}
            case={case_record}
            onAssignInvestigator={(caseId, investigatorId) => 
              handleAssignInvestigator(caseId, investigatorId)
            }
          />
        ))}
      </div>
    </div>
  );
}
```

**🧪 Day 4 Testing:**
- Record voice reports with VAPI
- View transcripts with confidence scores
- Create cases from reports
- Assign cases to investigators

---

## 🚀 **Docker Deployment Configuration**

### **Python Deployment Script Usage**
```bash
# Start entire platform
cd C:\Users\start\Desktop\study\Study\CascadeProjects\backFeed
python deployment/scripts/deploy.py

# Check health of all services
python deployment/scripts/health_check.py

# Restart specific service
python deployment/scripts/deploy.py restart

# View logs
python deployment/scripts/deploy.py logs frontend
python deployment/scripts/deploy.py logs backend

# Stop all containers
python deployment/scripts/deploy.py stop
```

### **Fixed URL Access Points**
- **Frontend Application**: http://localhost:3000
- **Backend API**: http://localhost:3001
- **Database**: localhost:5432 (PostgreSQL)
- **Cache**: localhost:6379 (Redis)

### **Environment Configuration**
```bash
# Frontend Environment Variables
NEXT_PUBLIC_SUPABASE_URL=http://localhost:54321
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
NEXT_PUBLIC_VAPI_API_KEY=your-vapi-key
NEXT_PUBLIC_TAVUS_API_KEY=your-tavus-key

# Backend Environment Variables
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/aegiswhistle
REDIS_URL=redis://localhost:6379
STRIPE_SECRET_KEY=your-stripe-key
POLYGON_RPC_URL=https://polygon-rpc.com
WALLET_PRIVATE_KEY=your-encrypted-wallet-key
```

---

## 🎯 **Success Metrics & Testing**

### **Daily Testing Protocol**
```bash
# Every morning startup
python deployment/scripts/deploy.py

# After each feature implementation
python deployment/scripts/health_check.py

# End of day testing
python deployment/scripts/deploy.py restart
# Test complete workflows at http://localhost:3000
```

### **Feature Completion Checklist**
**Day 1:** ✅ Authentication flow + navigation
**Day 2:** ✅ Role-based dashboards + user management
**Day 3:** ✅ Text reporting + tracking + file uploads
**Day 4:** ✅ Voice reporting + case creation + assignment
**Day 5:** ✅ Video reporting + wallet setup + tier upgrades
**Day 6:** ✅ Reward processing + claim codes + crypto transactions
**Day 7:** ✅ Complete case workflow + investigations + resolutions
**Day 8:** ✅ Analytics + tier monitoring + notifications
**Day 9:** ✅ Mobile responsive + error handling + performance
**Day 10:** ✅ Production deployment + onboarding + documentation

---

## 📝 **Implementation Notes**

### **Code Quality Standards**
- **TypeScript**: Strict typing for all components and APIs
- **Error Handling**: Comprehensive try-catch with user-friendly messages
- **Validation**: Zod schemas for all API inputs and form data
- **Security**: JWT tokens, encrypted passwords, role-based access
- **Performance**: Lazy loading, caching, optimized queries

### **Deployment Standards**
- **Containerization**: All services run in Docker containers
- **Port Consistency**: Fixed ports maintained across restarts
- **Health Monitoring**: Automated health checks for all services
- **Logging**: Centralized logging with structured JSON format
- **Recovery**: Automatic container restart on failure

### **Business Logic**
- **Tier Validation**: All features gated by subscription tier
- **Anonymous Tracking**: Secure anonymous ID generation
- **Crypto Processing**: Testnet transactions for development
- **Role-Based Access**: Strict RBAC implementation
- **Data Privacy**: Encryption for sensitive data, minimal data retention

This technical specification provides the complete roadmap for implementing AegisWhistle during the 10-day hackathon, ensuring daily deliverable frontend components with a production-ready architecture. 