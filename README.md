# Bicycle Sharing Network Smart Contract System

A comprehensive blockchain-based bicycle sharing network built on Stacks using Clarity smart contracts. This system manages bike availability, user registration, payments, maintenance coordination, and theft prevention.

## System Overview

The bicycle sharing network consists of five interconnected smart contracts:

1. **User Management Contract** (`user-management.clar`)
    - User registration and profile management
    - Credit/balance tracking
    - User verification and status management

2. **Bike Management Contract** (`bike-management.clar`)
    - Bike registration and tracking
    - Location and availability status
    - Bike condition monitoring

3. **Rental System Contract** (`rental-system.clar`)
    - Bike rental and return processing
    - Payment handling and fee calculation
    - Rental history tracking

4. **Maintenance Contract** (`maintenance.clar`)
    - Maintenance scheduling and tracking
    - Repair coordination
    - Maintenance worker management

5. **Analytics Contract** (`analytics.clar`)
    - Usage statistics and reporting
    - Network optimization data
    - Performance metrics

## Key Features

### User Management
- Secure user registration with unique identifiers
- Balance management for rental payments
- User status tracking (active, suspended, banned)
- Profile information storage

### Bike Tracking
- Real-time bike location updates
- Availability status management
- Bike condition monitoring
- Theft prevention through blockchain verification

### Rental System
- Seamless bike rental and return process
- Dynamic pricing based on duration and demand
- Payment processing with automatic deductions
- Rental history for users and bikes

### Maintenance Coordination
- Scheduled maintenance tracking
- Repair request management
- Maintenance worker assignment
- Service history logging

### Analytics & Optimization
- Usage pattern analysis
- Popular route identification
- Network performance metrics
- Demand forecasting data

## Data Structures

### User Profile
- Principal ID (unique identifier)
- Balance (STX tokens)
- Status (active/suspended/banned)
- Registration timestamp
- Total rentals count

### Bike Information
- Unique bike ID
- Current location (latitude/longitude)
- Availability status
- Condition rating
- Last maintenance date

### Rental Record
- Rental ID
- User principal
- Bike ID
- Start/end timestamps
- Total cost
- Distance traveled

### Maintenance Record
- Maintenance ID
- Bike ID
- Maintenance type
- Scheduled/completed dates
- Assigned worker
- Cost and notes

## Security Features

- Principal-based authentication
- Role-based access control
- Theft prevention through blockchain verification
- Secure payment processing
- Data integrity validation

## Getting Started

1. Deploy contracts to Stacks blockchain
2. Initialize system with admin credentials
3. Register bikes in the network
4. Set up maintenance workers
5. Begin user registration and operations

## Testing

The system includes comprehensive tests using Vitest:
- Unit tests for each contract function
- Integration tests for cross-contract interactions
- Edge case and error handling tests
- Performance and gas optimization tests

## Configuration

- `Clarinet.toml`: Clarinet configuration for local development
- `package.json`: Node.js dependencies and scripts
- Test files: Comprehensive test coverage for all functionality

## Usage Examples

### Register a New User
```clarity
(contract-call? .user-management register-user)
