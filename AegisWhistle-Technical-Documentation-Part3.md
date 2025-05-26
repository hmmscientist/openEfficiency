# AegisWhistle Technical Documentation - Part 3

## Voice Processing Integration

### VAPI Configuration

```javascript
const vapiConfig = {
  model: "gpt-4",
  voice: "empathetic-female",
  systemPrompt: `You are an empathetic AI assistant helping someone report workplace concerns confidentially.

  GUIDELINES:
  - Be warm, understanding, and non-judgmental
  - NEVER ask for personal information (names, employee IDs, etc.)
  - Focus on the incident: What happened? When? Where? Who was involved?
  - Ask clarifying questions about the situation, not the person
  - Provide emotional support and reassurance
  - End with a clear summary of the incident
  - Remind them they'll receive a report ID to track progress

  CONVERSATION FLOW:
  1. Welcome and establish trust
  2. Listen to their concern
  3. Ask clarifying questions about the incident
  4. Summarize what you understood
  5. Confirm accuracy and provide next steps

  TONE: Professional yet caring, like a trusted counselor
  RESPONSE LENGTH: Keep responses concise but supportive`,
  maxDuration: 1800, // 30 minutes max
  transcriptionProvider: "deepgram",
  anonymousMode: true
}
```

### Gemini Live AI Configuration

```javascript
const geminiConfig = {
  model: "gemini-1.5-pro",
  systemInstruction: vapiSystemPrompt, // Same as VAPI
  generationConfig: {
    temperature: 0.7,
    topK: 40,
    topP: 0.95,
    maxOutputTokens: 150,
  },
  safetySettings: [
    {
      category: "HARM_CATEGORY_HARASSMENT",
      threshold: "BLOCK_MEDIUM_AND_ABOVE"
    }
  ],
  audioConfig: {
    encoding: "LINEAR16",
    sampleRateHertz: 16000,
    languageCode: "en-US"
  },
  responseConfig: {
    responseType: "AUDIO_AND_TEXT",
    modalities: ["AUDIO", "TEXT"]
  }
}
```

#### VAPI vs. Gemini Live AI: Detailed Comparison

AegisWhistle offers two advanced voice AI options for whistleblower interactions, allowing organizations to choose based on their specific requirements:

| Feature | VAPI | Gemini Live AI |
|---------|------|---------------|
| **Base Model** | GPT-4 | Gemini 1.5 Pro |
| **Voice Quality** | Multiple voice options with emotional range | Natural, conversational voice with multilingual support |
| **Latency** | Very low latency (<500ms) | Low latency (500-800ms) |
| **Cost Structure** | Per-minute pricing | Per-API call pricing |
| **Integration Complexity** | Simple JavaScript SDK | Requires more custom implementation |
| **Customization** | High voice customization | High response customization |
| **Multilingual Support** | 10+ languages | 40+ languages |
| **Emotion Detection** | Limited | Advanced |

**Key Advantages of Each Option:**

**VAPI Strengths:**
- Simpler integration with pre-built UI components
- More voice customization options (gender, accent, emotional tone)
- Slightly lower latency for real-time conversations
- Better documentation and support resources

**Gemini Live AI Strengths:**
- More advanced contextual understanding
- Superior multilingual capabilities
- Better handling of complex, nuanced conversations
- More granular control over response generation parameters
- Advanced safety filters and content moderation

**Implementation Considerations:**

Organizations can configure their AegisWhistle instance to use either VAPI or Gemini Live AI as the default voice processing engine. The platform allows for seamless switching between the two options without affecting the underlying complaint management system. The choice typically depends on:

1. **Language Requirements**: Organizations with multilingual workforces may prefer Gemini Live AI
2. **Integration Timeline**: Faster deployments may benefit from VAPI's simpler integration
3. **Budget Considerations**: Different pricing models suit different usage patterns
4. **Compliance Requirements**: Some regions may have specific AI provider requirements

### Voice Processing Flow

#### End-to-End Implementation Process

1. **Initiation Phase**
   - Whistleblower visits organization's subdomain (e.g., uber.aegiswhistle.com)
   - System loads organization-specific configuration (anonymity level, voice AI preference, etc.)
   - Whistleblower clicks "Speak Up" button to initiate voice session
   - Frontend establishes WebSocket connection to voice processing backend

2. **Voice AI Initialization**
   - System determines which voice AI to use (VAPI or Gemini Live AI) based on organization settings
   - For VAPI:
     ```javascript
     const session = await vapi.createSession({
       agentId: config.agentId,
       caller: { // Anonymous caller object
         id: generateAnonymousId(),
         name: "Anonymous Whistleblower"
       },
       metadata: {
         organizationId: "uber",
         anonymityLevel: "encrypted"
       }
     });
     ```
   - For Gemini Live AI:
     ```javascript
     const gemini = new GoogleGenerativeAI(API_KEY).getGenerativeModel({
       model: "gemini-1.5-pro",
       generationConfig: geminiConfig.generationConfig,
       safetySettings: geminiConfig.safetySettings
     });
     
     const chat = gemini.startChat({
       history: [],
       systemInstruction: geminiConfig.systemInstruction
     });
     ```

3. **Conversation and Guidance**
   - Voice AI agent introduces itself and explains the whistleblower process
   - Agent guides whistleblower through structured reporting process:
     - What happened? (incident details)
     - When and where did it occur? (time and location)
     - Who was involved? (roles, not names)
     - Any supporting evidence or witnesses?
     - Impact of the incident
   - Real-time transcription and emotion analysis occurs during conversation
   - System periodically saves encrypted conversation state to prevent data loss

4. **Summarization and Processing**
   - Upon completion, AI generates a structured summary of the report
   - Summary is presented to whistleblower for verification
   - Whistleblower can make corrections or additions
   - Final summary is prepared for blockchain storage

5. **Secure Storage Process**
   - System generates unique 10-digit alphanumeric report ID (e.g., "AG7X9M2K4P")
   - Based on anonymity settings, whistleblower identity is:
     - Not stored (complete anonymity)
     - Encrypted with organization's public key (encrypted anonymity)
     - Stored with pseudonym (pseudo-anonymity)
   - Complaint data is submitted to organization's Hyperledger Fabric network:
     ```javascript
     const complaintData = {
       summary: aiGeneratedSummary,
       transcriptHash: hashTranscript(fullTranscript),
       category: detectedCategory,
       anonymityLevel: organizationSettings.anonymityLevel,
       whistleblowerIdentity: processIdentity(whistleblowerData, anonymityLevel),
       metadata: {
         source: "voice",
         processingAgent: useVapi ? "vapi" : "gemini",
         ipAddress: anonymizeIp(requestIp),
         browserFingerprint: anonymizeFingerprint(fingerprint)
       }
     };
     
     const reportId = await fabricGateway.submitTransaction(
       'complaintManagementChaincode',
       'createComplaint',
       JSON.stringify(complaintData)
     );
     ```

6. **Notification and Follow-up**
   - Whistleblower receives report ID and follow-up instructions
   - Ethics Officer is notified of new complaint via secure channel
   - System generates initial audit trail records
   - Whistleblower receives optional anonymous communication channel setup

### Frontend Integration

#### Unified Voice AI Integration Component

AegisWhistle provides a unified frontend component that can seamlessly work with either VAPI or Gemini Live AI based on organization configuration. This approach allows organizations to switch between voice AI providers without requiring frontend changes.

```javascript
// Frontend JavaScript for website integration with Voice AI (VAPI or Gemini)
// Configuration - loaded from organization settings
const config = {
  // Common settings
  organizationId: "uber",
  ethicsDashboardUrl: "https://ethics-dashboard.example.com/api/summaries",
  
  // Voice AI provider settings (determined by organization preference)
  voiceAiProvider: "vapi", // or "gemini"
  
  // VAPI-specific settings
  vapi: {
    baseUrl: "https://api.vapi.ai",
    apiKey: process.env.VAPI_API_KEY, // Loaded from secure environment variables
    agentId: "your-agent-id"
  },
  
  // Gemini-specific settings
  gemini: {
    apiKey: process.env.GEMINI_API_KEY, // Loaded from secure environment variables
    model: "gemini-1.5-pro"
  },
  
  // Anonymity settings (from organization configuration)
  anonymityLevel: "encrypted", // complete, encrypted, pseudo
  
  // UI customization
  uiTheme: "light", // or "dark"
  primaryColor: "#0073b1", // Organization brand color
  logo: "https://cdn.aegiswhistle.com/orgs/uber/logo.png"
};

// Initialize Voice AI agent on page load
document.addEventListener('DOMContentLoaded', () => {
  loadOrganizationConfig().then(orgConfig => {
    // Merge organization config with defaults
    Object.assign(config, orgConfig);
    
    // Initialize the appropriate voice AI
    if (config.voiceAiProvider === "vapi") {
      initializeVapiAgent();
    } else {
      initializeGeminiAgent();
    }
    
    setupCommonEventListeners();
    setupAnonymityControls();
  });
});

// Initialize the VAPI agent
function initializeVapiAgent() {
  console.log("Initializing VAPI for organization: " + config.organizationId);
  
  // Load VAPI SDK
  const script = document.createElement('script');
  script.src = 'https://cdn.vapi.ai/sdk.js';
  script.async = true;
  script.onload = () => {
    // Configure VAPI with organization-specific settings
    window.vapi.configure({
      apiKey: config.vapi.apiKey,
      baseUrl: config.vapi.baseUrl,
      agentId: config.vapi.agentId,
      // Add organization context to all conversations
      metadata: {
        organizationId: config.organizationId,
        anonymityLevel: config.anonymityLevel
      }
    });
    
    // Setup UI components
    setupVapiUI();
  };
  document.head.appendChild(script);
}

// Initialize the Gemini Live AI agent
function initializeGeminiAgent() {
  console.log("Initializing Gemini Live AI for organization: " + config.organizationId);
  
  // Load Google AI SDK
  const script = document.createElement('script');
  script.src = 'https://cdn.googleapis.com/ai/generativelanguage/v1beta/google-ai-generativelanguage.min.js';
  script.async = true;
  script.onload = () => {
    // Initialize Google AI client
    window.googleAI = new GoogleGenerativeAI(config.gemini.apiKey);
    
    // Setup custom UI for Gemini (since it doesn't have a pre-built UI)
    setupGeminiUI();
  };
  document.head.appendChild(script);
}
    // Initialize VAPI with configuration
    window.VAPI.init({
      apiKey: config.apiKey,
      agentId: config.agentId,
      // Optional configuration
      enableTranscript: true,
      enableSummary: true,
      language: 'en-US'
    });
  };
  document.head.appendChild(script);
}

// Send the conversation summary to the Ethics dashboard
async function sendSummaryToEthicsDashboard(summary, conversationId) {
  try {
    // Enrich summary with metadata
    const enrichedSummary = {
      content: summary,
      conversationId: conversationId,
      timestamp: new Date().toISOString(),
      source: window.location.href,
      userId: getUserId(),
      agentId: config.agentId
    };
    
    // Send to Ethics dashboard
    const response = await fetch(config.ethicsDashboardUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${config.apiKey}`
      },
      body: JSON.stringify(enrichedSummary)
    });
    
    if (!response.ok) {
      throw new Error(`Failed to send summary: ${response.status} ${response.statusText}`);
    }
    
    const result = await response.json();
    console.log("Summary sent to Ethics dashboard", result);
    
    // Display confirmation to user if needed
    if (result.reward) {
      displayRewardNotification(result.reward);
    }
  } catch (error) {
    console.error("Error sending summary to Ethics dashboard:", error);
    // Implement retry logic if needed
  }
}
```

## Professional Marketplace

### Marketplace Structure

```
Professional Marketplace
├── Legal Services
│ ├── Corporate Lawyers
│ ├── Employment Law Specialists
│ ├── Compliance Attorneys
│ └── Legal Consultants
├── Medical Services
│ ├── Occupational Health Doctors
│ ├── Mental Health Professionals
│ ├── Psychiatrists
│ └── Counselors
├── Alternative Medicine
│ ├── Chiropractors
│ ├── Physical Therapists
│ ├── Acupuncturists
│ └── Wellness Coaches
└── Specialized Services
  ├── Private Investigators
  ├── Forensic Accountants
  ├── Technical Experts
  └── Industry Consultants
```

### Verification System

**Professional Verification Process**:

1. **Initial Registration**
   - Business license verification
   - Professional certification validation
   - Background check (if required)
   - Insurance verification

2. **Document Verification**
   - Automated document scanning (OCR)
   - Third-party verification services
   - Manual review by platform administrators

3. **Ongoing Monitoring**
   - Annual license renewal checks
   - Client feedback and ratings
   - Complaint handling system
   - Performance metrics tracking

### Service Request Flow

1. Organization admin or Ethics Officer browses available services
2. Selects appropriate service provider based on needs
3. Submits service request with case details, budget, and urgency
4. Service provider receives notification and accepts/declines
5. If accepted, provider is linked to the case
6. Direct communication established between organization and provider
7. Provider delivers services
8. Organization pays via platform
9. Organization rates and reviews the service

## Reward System

### Built-in Wallet System

```javascript
const walletConfig = {
  supportedNetworks: ["ethereum", "polygon", "bsc"],
  supportedTokens: ["USDC", "USDT", "DAI", "ETH", "MATIC"],
  escrowContract: "0x...", // Smart contract for holding rewards
  minimumReward: 10, // USD equivalent
  maximumReward: 10000 // USD equivalent
}
```

### External Wallet Integration

- MetaMask Web3 integration
- WalletConnect protocol support
- Hardware wallet compatibility (Ledger, Trezor)

### Reward Processing Flow

1. Ethics Officer approves reward for valid disclosure
2. System checks organization wallet balance
3. Generates one-time anonymous wallet
4. Transfers crypto from organization wallet to anonymous wallet
5. Sends claim instructions to whistleblower
6. Whistleblower can claim reward to personal wallet (optional)
7. All transactions recorded in blockchain for audit

### Security & Privacy Architecture

**Configurable Anonymity Levels**:
- Level 1: Complete anonymity (no identity stored)
- Level 2: Encrypted identity (reversible by court order)
- Level 3: Pseudo-anonymous (internal tracking only)

**Data Encryption**:

```javascript
const encryptionConfig = {
  algorithms: {
    symmetric: "AES-256-GCM",
    asymmetric: "RSA-4096",
    hashing: "SHA-256"
  },
  keyManagement: {
    provider: "AWS KMS", // or Hardware Security Module
    rotationPolicy: "90days",
    accessControl: "strict"
  }
}
```

**Audit Trail System**:
- Blockchain-based Immutable Logging
- All user actions logged with timestamps
- Cryptographic proof of data integrity
- Non-repudiation for all transactions
- Compliance-ready audit reports
