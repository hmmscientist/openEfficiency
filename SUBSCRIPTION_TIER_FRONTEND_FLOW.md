# AegisWhistle Subscription Tier Frontend Flow

## Overview
This document outlines the complete frontend user experience flow for Organization Administrators to select and manage subscription tiers within the AegisWhistle platform.

## 1. Subscription Tier Selection Flow

### 1.1 Entry Points

#### Primary Entry Points:
1. **Organization Setup Wizard** (New organizations)
2. **Admin Dashboard → Billing & Subscription** (Existing organizations)
3. **Upgrade Prompts** (When limits are reached)
4. **Direct Link from Marketing Pages**

### 1.2 Subscription Tier Overview Page

#### Page Structure:
```typescript
interface SubscriptionOverviewPage {
  currentTier: SubscriptionTier | null;
  availableTiers: SubscriptionTier[];
  usageMetrics: OrganizationUsage;
  billingInfo: BillingInformation;
  upgradeRecommendations: UpgradeRecommendation[];
}
```

#### Visual Layout: 