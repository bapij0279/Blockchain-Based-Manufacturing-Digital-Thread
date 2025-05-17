# Blockchain-Based Manufacturing Digital Thread

A comprehensive blockchain-based system for tracking products throughout their entire lifecycle, from design to disposal.

## Overview

This project implements a digital thread for manufacturing processes using blockchain technology. The system consists of five interconnected smart contracts that work together to create a secure, transparent, and immutable record of a product's journey from conception to end-of-life.

## Smart Contracts

### 1. Design Verification Contract

The Design Verification Contract validates product specifications and design requirements before manufacturing begins.

**Key Features:**
- Design registration with versioning
- Design approval/rejection workflow
- Status tracking and verification

**Functions:**
- `register-design`: Register a new product design
- `approve-design`: Approve a design for production
- `reject-design`: Reject a design with comments
- `update-design-status`: Update the status of a design

### 2. Material Tracking Contract

The Material Tracking Contract records all components and raw materials used in the production process.

**Key Features:**
- Material registration and inventory management
- Batch tracking and supplier information
- Material consumption tracking per product

**Functions:**
- `register-material`: Register new materials in inventory
- `update-material-quantity`: Update material quantities
- `add-material-to-product`: Associate materials with a product

### 3. Process Parameter Contract

The Process Parameter Contract monitors and records critical manufacturing conditions and parameters.

**Key Features:**
- Parameter threshold definition
- Real-time parameter recording
- Status tracking for manufacturing conditions

**Functions:**
- `set-parameter-threshold`: Define acceptable parameter ranges
- `record-process-parameter`: Record parameter values during manufacturing
- `update-parameter-status`: Update the status of recorded parameters

### 4. Quality Verification Contract

The Quality Verification Contract records testing and inspection results throughout the manufacturing process.

**Key Features:**
- Test requirement definition
- Quality test recording
- Pass/fail tracking

**Functions:**
- `define-test-requirement`: Define test requirements and acceptance criteria
- `record-quality-test`: Record test results
- `update-quality-test`: Update existing test results

### 5. Lifecycle Tracking Contract

The Lifecycle Tracking Contract follows the product through use and disposal, creating a complete history.

**Key Features:**
- Product registration and status tracking
- Ownership transfer recording
- Lifecycle event logging

**Functions:**
- `register-product`: Register a new manufactured product
- `update-product-status`: Update product status
- `transfer-ownership`: Record ownership transfers
- `record-lifecycle-event`: Log events throughout product lifecycle

## Implementation Details

### Technology Stack

- **Smart Contract Language**: Clarity (.clar)
- **Testing Framework**: Vitest

### Data Structure

Each contract uses maps to store data with appropriate keys:

- **Design Verification**: Designs and design approvals
- **Material Tracking**: Materials and product-material associations
- **Process Parameter**: Process parameters and parameter thresholds
- **Quality Verification**: Quality tests and test requirements
- **Lifecycle Tracking**: Products and lifecycle events

### Security Features

- Principal-based access control
- Error handling with specific error codes
- Data validation before storage

## Usage Examples

### Registering a New Design

```clarity
(contract-call? .design-verification register-design 
  "design-123" 
  "Product XYZ" 
  "1.0.0" 
  "Detailed specifications for Product XYZ")
