# AegisWhistle

A secure, blockchain-based whistleblowing platform built on Hyperledger Fabric.

## Overview

AegisWhistle provides a secure and anonymous way for individuals to report misconduct, with features including:

- **Anonymous Reporting**: Submit reports without revealing your identity
- **Blockchain Security**: Immutable record-keeping using Hyperledger Fabric
- **End-to-End Encryption**: Secure communication channels
- **Multi-Platform Support**: Web and mobile interfaces
- **Compliance Ready**: Built with GDPR and other regulations in mind

## Project Structure

```
AegisWhistle/
├── docs/                    # Documentation
│   ├── architecture/        # System architecture diagrams
│   ├── api/                 # API documentation
│   └── compliance/          # Compliance documentation
├── chaincode/               # Hyperledger Fabric chaincode
├── backend/                 # Backend services
├── frontend/                # Frontend applications
└── scripts/                 # Utility scripts
```

## Getting Started

### Prerequisites

- Node.js 16+
- Docker and Docker Compose
- Hyperledger Fabric 2.2+
- Go 1.17+ (for chaincode development)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/openEfficiency.git
   cd openEfficiency/AegisWhistle
   ```

2. Install dependencies:
   ```bash
   cd backend
   npm install
   
   cd ../frontend
   npm install
   ```

3. Set up environment variables:
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

4. Start the development environment:
   ```bash
   docker-compose up -d
   ```

## Documentation

- [Implementation Plan](./AegisWhistle-Implementation-Plan.md)
- [Technical Documentation](./docs/)
- [API Reference](./docs/api/README.md)

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For questions or support, please open an issue in the repository.
