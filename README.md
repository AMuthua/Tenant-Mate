# tenant_mate_v3

A new Flutter project.

## Getting Started with MPESA Integrations:-
                         ### M-Pesa Integration Documentation
This document outlines the integration of M-Pesa payment functionality within the TenantMate application.

1. Overview

The M-Pesa integration allows tenants to conveniently pay their rent and other dues directly through their mobile phones using the M-Pesa service. The integration utilizes the Safaricom M-Pesa API to initiate and process payment transactions.

2. Integration Architecture

The M-Pesa integration follows a client-server architecture:

Client (TenantMate App): The mobile application initiates the payment request, collects necessary information (amount, phone number), and displays the payment status.
Server (Backend): The backend server handles the communication with the M-Pesa API, processes the payment request, and updates the application database with payment details.
M-Pesa API: Safaricom's API provides the services for initiating and confirming M-Pesa transactions.
3. Implementation Details

3.1. Prerequisites

Safaricom M-Pesa Developer Account: You need a developer account with Safaricom to access the M-Pesa API.
M-Pesa API Credentials: Obtain the necessary API credentials (consumer key, consumer secret, short code, etc.) from your Safaricom developer account.
Backend Server: A backend server capable of handling HTTP requests and processing API responses.
Flutter Application: The TenantMate Flutter application.
3.2. Backend Implementation

API Endpoint: Create an API endpoint on the backend server to handle M-Pesa payment requests.
Authentication: Implement OAuth 2.0 authentication to securely access the M-Pesa API using your API credentials.
Transaction Initiation: Use the M-Pesa API to initiate a "Customer to Business" (C2B) transaction.
Callback Handling: Implement a callback URL to receive transaction confirmation from the M-Pesa API.
Database Update: Upon successful transaction confirmation, update the application database with the payment details (transaction ID, amount, date, etc.).
Error Handling: Implement robust error handling to manage API errors and transaction failures.
3.3. Flutter Application Implementation

User Interface: Create a payment interface in the Flutter application to collect the tenant's phone number and payment amount.
API Request: Send an HTTP request to the backend API endpoint with the payment details.
Loading Indicator: Display a loading indicator while waiting for the payment confirmation.
Payment Status: Display the payment status (success, pending, failed) to the tenant.
Transaction History: Implement a transaction history screen to display the tenant's payment records.
3.4. M-Pesa API Integration

OAuth 2.0 Authentication: Obtain an access token from the M-Pesa API using your consumer key and consumer secret.
C2B Transaction: Initiate a C2B transaction using the "stk push" or "stk push query" API endpoints.
Callback URL: Provide your backend server's callback URL to receive transaction confirmation.
Transaction Status Query: Use the M-Pesa API to query the transaction status if needed.

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Note To any new dev:-
Reading the docs isn't rocket science, try and understand first why what you're reading works the way it does. 
