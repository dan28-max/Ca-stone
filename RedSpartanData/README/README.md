# Spartan Data - Complete Dashboard System

A full-stack web application with PHP backend, MySQL database, and modern frontend for data management and user administration. This document provides a comprehensive overview of the system architecture, code organization, and how different components interact with each other.

## 📋 Table of Contents
- [System Overview](#-system-overview)
- [🚀 Features](#-features)
- [🏗️ System Architecture](#%EF%B8%8F-system-architecture)
- [🔗 Component Interaction](#-component-interaction)
- [📂 Code Organization](#-code-organization)
- [🔑 Authentication Flow](#-authentication-flow)
- [🛠️ Technology Stack](#%EF%B8%8F-technology-stack)
- [⚙️ Configuration](#%EF%B8%8F-configuration)
- [🚀 Getting Started](#-getting-started)
- [🔧 Development](#-development)
- [📝 License](#-license)

## 🌐 System Overview

The Spartan Data system is designed as a comprehensive data management solution with role-based access control. The system is built with a clear separation of concerns between the frontend and backend components, communicating through a RESTful API.

### Core Components:
1. **Frontend**: Single-page application built with vanilla JavaScript, HTML5, and CSS3
2. **Backend API**: PHP-based REST API handling business logic and data processing
3. **Database**: MySQL database for persistent data storage
4. **Authentication**: Session-based authentication with role management
5. **UI Components**: Custom-built responsive components with a consistent design system

## 🚀 Features

- **🔐 Secure Authentication**: Role-based login system (Admin/User)
- **📊 Dynamic Dashboard**: Real-time statistics and analytics
- **👥 User Management**: Complete user administration (Admin only)
- **📈 Analytics**: Performance metrics and engagement data
- **🎨 Modern UI**: White and red theme with responsive design
- **🔒 Session Management**: Secure PHP sessions with database storage
- **📱 Mobile Responsive**: Works on all devices

## 🏗️ System Architecture

### Frontend Architecture
- **Single Page Application (SPA)**: Built with vanilla JavaScript
- **Component-based UI**: Modular components for better maintainability
- **Responsive Design**: Works on desktop and mobile devices
- **State Management**: Client-side state management for a smooth user experience

### Backend Architecture
- **RESTful API**: Stateless API endpoints for all data operations
- **MVC Pattern**: Follows Model-View-Controller architecture
- **Database Abstraction**: PDO for secure database interactions
- **Session Management**: Secure session handling with proper validation

### Data Flow
1. User interacts with the frontend interface
2. Frontend makes API calls to the backend
3. Backend processes requests and interacts with the database
4. Response is sent back to the frontend
5. Frontend updates the UI based on the response

## 🔗 Component Interaction

### Key Components and Their Relationships

1. **Authentication System**
   - Handles user login/logout
   - Manages session tokens
   - Controls access to protected routes

2. **Dashboard System**
   - Displays key metrics and analytics
   - Fetches real-time data from the backend
   - Updates UI based on user role

3. **User Management**
   - CRUD operations for user accounts
   - Role-based access control
   - Profile management

4. **Campus Management**
   - Manage campus hierarchy
   - Parent-child relationship between campuses
   - Used for access control and data organization

## 📂 Code Organization

```
public_html/
├── api/                    # PHP API endpoints
│   ├── auth/              # Authentication endpoints
│   ├── users/             # User management endpoints
│   ├── campus/            # Campus management endpoints
│   └── reports/           # Report-related endpoints
├── assets/                # Static assets
│   ├── css/               # Stylesheets
│   ├── js/                # JavaScript files
│   └── images/            # Image files
├── config/                # Configuration files
│   └── database.php       # Database configuration
├── includes/              # PHP includes
│   ├── auth.php           # Authentication helpers
│   ├── db.php             # Database connection
│   └── functions.php      # Utility functions
├── admin-dashboard.html   # Main admin interface
├── index.html             # Public landing page
└── README.md              # This file
```

### Key JavaScript Files
- `admin-dashboard-clean.js`: Main application logic for the admin dashboard
- `auth.js`: Handles authentication-related functionality
- `campus-management.js`: Campus management module
- `user-management.js`: User management module

## 🔑 Authentication Flow

1. **Login Process**
   - User submits credentials via login form
   - Frontend sends credentials to `/api/auth/login`
   - Backend validates credentials and creates a session
   - Session token is stored in cookies/headers

2. **Protected Routes**
   - Each API call includes session token
   - Backend verifies token validity
   - Access is granted/denied based on user role

3. **Session Management**
   - Session timeout after inactivity
   - Automatic token refresh
   - Secure cookie settings

## 🛠️ Technology Stack

- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Backend**: PHP 7.4+
- **Database**: MySQL 5.7+
- **Server**: XAMPP (Apache)
- **Styling**: Custom CSS with Font Awesome icons

## 📋 Prerequisites

- XAMPP installed and running
- PHP 7.4 or higher
- MySQL 5.7 or higher
- Modern web browser

## 🚀 Getting Started

### 1. Start XAMPP
```bash
# Start Apache and MySQL services in XAMPP Control Panel
```

### 2. Database Setup
1. Open your browser and go to: `http://localhost/Rework/setup.php`
2. Follow the setup instructions
3. The script will create the database and insert default data

### 3. Access the Application
1. Go to: `http://localhost/Rework/login.html`
2. Use the default credentials:
   - **Admin**: `admin@spartandata.com` / `admin123`
   - **User**: `user@spartandata.com` / `user123`

## 📁 Project Structure

```
Rework/
├── api/                    # PHP API endpoints
│   ├── auth.php           # Authentication API
│   └── dashboard.php      # Dashboard data API
├── config/                # Configuration files
│   └── database.php       # Database configuration
├── database/              # Database files
│   └── schema.sql         # Database schema
├── includes/              # PHP helper functions
│   └── functions.php      # Utility functions
├── index.html             # Main dashboard
├── login.html             # Login page
├── setup.php              # Database setup script
├── styles.css             # Dashboard styling
├── login-styles.css       # Login page styling
├── script.js              # Dashboard JavaScript
├── login-script.js        # Login JavaScript
└── README.md              # This file
```

## 🔧 Configuration

### Database Configuration
Edit `config/database.php` if you need to change database settings:

```php
private $host = 'localhost';
private $db_name = 'spartan_data';
private $username = 'root';
private $password = '';
```

### Default Users
The system comes with two default users:
- **Admin User**: Full access to all features
- **Regular User**: Limited access to appropriate sections

## 🎯 API Endpoints

### Authentication API (`api/auth.php`)
- `POST ?action=login` - User login
- `POST ?action=logout` - User logout
- `GET ?action=check` - Check authentication status

### Dashboard API (`api/dashboard.php`)
- `GET ?action=overview` - Get dashboard overview data
- `GET ?action=analytics` - Get analytics data
- `GET ?action=users` - Get users list (Admin only)
- `POST ?action=update_stats` - Update dashboard statistics

## 🔒 Security Features

- **Password Hashing**: Bcrypt password encryption
- **Session Management**: Secure PHP sessions with database storage
- **CSRF Protection**: Cross-site request forgery prevention
- **Input Validation**: Server-side input sanitization
- **Role-based Access**: Different permissions for Admin/User
- **Activity Logging**: Track all user actions

## 📊 Database Schema

### Tables
- **users**: User accounts and profiles
- **user_sessions**: Active user sessions
- **system_settings**: Application configuration
- **activity_logs**: User activity tracking
- **dashboard_stats**: Dashboard statistics

## 🎨 Customization

### Theme Colors
The system uses a white and red theme. To customize:
1. Edit `styles.css` and `login-styles.css`
2. Update color variables in CSS
3. Modify the logo and branding

### Adding New Features
1. Create new API endpoints in `api/` folder
2. Add corresponding frontend JavaScript
3. Update database schema if needed
4. Add proper authentication checks

## 🐛 Troubleshooting

### Common Issues

1. **"Can't reach the site"**
   - Ensure XAMPP Apache is running
   - Check if you're accessing `http://localhost/Rework/`

2. **Database connection failed**
   - Verify MySQL is running in XAMPP
   - Check database credentials in `config/database.php`
   - Run `setup.php` to create the database

3. **Login not working**
   - Check browser console for errors
   - Verify API endpoints are accessible
   - Ensure database is properly set up

4. **Session issues**
   - Clear browser cookies and cache
   - Check PHP session configuration
   - Verify database connection

### Debug Mode
Enable error reporting in PHP by adding to the top of PHP files:
```php
error_reporting(E_ALL);
ini_set('display_errors', 1);
```

## 📝 Default Credentials

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@spartandata.com | admin123 |
| User | user@spartandata.com | user123 |

## 🔄 Updates and Maintenance

### Regular Maintenance
- Clean expired sessions: The system automatically cleans expired sessions
- Monitor activity logs: Check `activity_logs` table for user activities
- Update statistics: Dashboard stats are updated automatically

### Backup
- Database: Export MySQL database regularly
- Files: Backup the entire project folder
- Sessions: Sessions are stored in database and cleaned automatically

## 📞 Support

For issues or questions:
1. Check the troubleshooting section
2. Review browser console for errors
3. Check PHP error logs in XAMPP
4. Verify database connectivity

## 🎉 Success!

Once everything is set up, you'll have a fully functional dashboard system with:
- ✅ Secure authentication
- ✅ Role-based access control
- ✅ Real-time dashboard data
- ✅ User management
- ✅ Activity tracking
- ✅ Modern responsive UI

Enjoy your new Spartan Data dashboard system! 🚀




