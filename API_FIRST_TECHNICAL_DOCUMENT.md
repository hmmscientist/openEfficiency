# AegisWhistle API-First Technical Document

## Executive Summary

This document outlines a strategic approach to building AegisWhistle with a flexible core infrastructure that can operate in both traditional full-stack mode and API-first mode. The architecture is designed to be **toggleable** in Phase 1, allowing seamless transition between approaches without major refactoring.

## 1. Architecture Philosophy

### 1.1 Dual-Mode Architecture
The core infrastructure will be built with **architectural flexibility** as a first-class citizen, supporting:

- **Traditional Mode**: Next.js full-stack with server-side rendering and API routes
- **API-First Mode**: Headless backend with RESTful/GraphQL APIs serving multiple frontend clients
- **Hybrid Mode**: Selective API exposure while maintaining traditional features

### 1.2 Toggle-Ready Design Principles

```typescript
// Configuration-driven architecture
interface ArchitectureConfig {
  mode: 'traditional' | 'api-first' | 'hybrid';
  apiExposure: {
    public: boolean;
    authentication: 'session' | 'jwt' | 'both';
    cors: CorsConfig;
    rateLimit: RateLimitConfig;
  };
  frontend: {
    ssr: boolean;
    spa: boolean;
    multiClient: boolean;
  };
}
```

## 2. Core Infrastructure Design

### 2.1 Flexible Backend Architecture

#### Service Layer Abstraction
```typescript
// Universal service interface
interface ServiceLayer {
  // Business logic remains consistent across modes
  reportService: ReportService;
  userService: UserService;
  departmentService: DepartmentService;
  organizationService: OrganizationService;
  
  // Mode-specific adapters
  getAdapter(): 'nextjs' | 'express' | 'fastify';
  getAuthStrategy(): AuthStrategy;
  getDataAccess(): DataAccessLayer;
}
```

#### Database Abstraction Layer
```typescript
// Database-agnostic interface
interface DataAccessLayer {
  // Supports all subscription tier databases
  provider: 'postgresql' | 'mysql' | 'mongodb' | 'hyperledger';
  
  // Universal query interface
  query<T>(operation: QueryOperation): Promise<T>;
  transaction<T>(operations: QueryOperation[]): Promise<T>;
  
  // Mode-specific optimizations
  getConnectionPool(): ConnectionPool;
  enableCaching(strategy: CacheStrategy): void;
}
```

### 2.2 Authentication & Authorization Flexibility

#### Dual Authentication System
```typescript
interface AuthSystem {
  // Traditional session-based (Phase 1 default)
  sessionAuth: {
    provider: 'next-auth' | 'custom';
    storage: 'database' | 'redis';
    csrf: boolean;
  };
  
  // API-ready JWT system (toggleable)
  jwtAuth: {
    provider: 'jose' | 'jsonwebtoken';
    strategy: 'access-refresh' | 'single-token';
    storage: 'httpOnly' | 'localStorage' | 'secure-storage';
  };
  
  // Unified permission system
  permissions: RoleBasedAccessControl;
}
```

#### Department-Based Authorization
```typescript
interface DepartmentAuth {
  // Works in both modes
  validateDepartmentAccess(
    userId: string, 
    departmentId: string, 
    action: string
  ): Promise<boolean>;
  
  // Subscription tier enforcement
  enforceSubscriptionLimits(
    organizationId: string, 
    resource: string
  ): Promise<boolean>;
}
```

### 2.3 API Layer Design

#### Unified API Interface
```typescript
// Next.js API routes that can be extracted
// /api/v1/reports/route.ts
export async function GET(request: NextRequest) {
  const service = getReportService();
  const auth = await validateAuth(request);
  
  // Business logic (mode-independent)
  const reports = await service.getReports(auth.user, {
    departmentId: request.nextUrl.searchParams.get('departmentId'),
    status: request.nextUrl.searchParams.get('status')
  });
  
  return NextResponse.json(reports);
}

// Same logic works for standalone API server
export const getReportsHandler = async (req: Request, res: Response) => {
  const service = getReportService();
  const auth = await validateAuth(req);
  
  const reports = await service.getReports(auth.user, {
    departmentId: req.query.departmentId,
    status: req.query.status
  });
  
  res.json(reports);
};
```

#### GraphQL Integration Ready
```typescript
// GraphQL schema (mode-independent)
const typeDefs = `
  type Query {
    reports(departmentId: ID, status: ReportStatus): [Report!]!
    departments(organizationId: ID!): [Department!]!
  }
  
  type Mutation {
    createReport(input: CreateReportInput!): Report!
    assignInvestigator(reportId: ID!, investigatorId: ID!): Report!
  }
`;

// Resolvers work in both modes
const resolvers = {
  Query: {
    reports: async (_, args, context) => {
      return await context.services.reportService.getReports(
        context.user, 
        args
      );
    }
  }
};
```

## 3. Phase 1 Implementation Strategy

### 3.1 Traditional Mode (Default)
```typescript
// next.config.js
const config = {
  // Traditional Next.js configuration
  experimental: {
    serverActions: true,
    serverComponentsExternalPackages: ['@aegis/core']
  },
  
  // API preparation
  async rewrites() {
    return [
      {
        source: '/api/v1/:path*',
        destination: '/api/:path*'
      }
    ];
  }
};
```

### 3.2 Toggle Configuration
```typescript
// config/architecture.ts
export const architectureConfig: ArchitectureConfig = {
  mode: process.env.ARCHITECTURE_MODE || 'traditional',
  
  apiExposure: {
    public: process.env.EXPOSE_PUBLIC_API === 'true',
    authentication: process.env.API_AUTH_MODE || 'session',
    cors: {
      enabled: process.env.CORS_ENABLED === 'true',
      origins: process.env.CORS_ORIGINS?.split(',') || []
    }
  },
  
  frontend: {
    ssr: process.env.SSR_ENABLED !== 'false',
    spa: process.env.SPA_MODE === 'true',
    multiClient: process.env.MULTI_CLIENT === 'true'
  }
};
```

### 3.3 Service Registration System
```typescript
// services/registry.ts
class ServiceRegistry {
  private services = new Map();
  
  register<T>(name: string, implementation: T): void {
    this.services.set(name, implementation);
  }
  
  get<T>(name: string): T {
    return this.services.get(name);
  }
  
  // Mode-specific initialization
  initializeForMode(mode: ArchitectureMode): void {
    switch (mode) {
      case 'traditional':
        this.initializeTraditionalServices();
        break;
      case 'api-first':
        this.initializeApiServices();
        break;
      case 'hybrid':
        this.initializeHybridServices();
        break;
    }
  }
}
```

## 4. Department-Based Multi-Tenancy

### 4.1 Flexible Tenant Isolation
```typescript
interface TenantContext {
  organizationId: string;
  departmentIds: string[];
  subscriptionTier: SubscriptionTier;
  
  // Works in both modes
  getDatabaseConfig(): DatabaseConfig;
  getFeatureFlags(): FeatureFlags;
  getRateLimits(): RateLimitConfig;
}

// Middleware for both modes
export const tenantMiddleware = (mode: ArchitectureMode) => {
  return async (request: Request, context: any) => {
    const tenant = await resolveTenant(request);
    
    // Inject tenant context
    context.tenant = tenant;
    context.services = getServicesForTenant(tenant);
    
    return context;
  };
};
```

### 4.2 Subscription Tier Enforcement
```typescript
// Unified subscription enforcement
class SubscriptionEnforcer {
  async validateAccess(
    tenant: TenantContext,
    resource: string,
    action: string
  ): Promise<boolean> {
    const limits = this.getSubscriptionLimits(tenant.subscriptionTier);
    
    switch (resource) {
      case 'departments':
        return tenant.departmentIds.length <= limits.maxDepartments;
      case 'api_calls':
        return await this.checkRateLimit(tenant, limits.apiCallsPerHour);
      case 'storage':
        return await this.checkStorageLimit(tenant, limits.maxStorage);
    }
  }
}
```

## 5. API Design for Future Flexibility

### 5.1 RESTful API Structure 