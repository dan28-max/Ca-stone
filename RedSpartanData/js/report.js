/**
 * Report Management System - Clean Version
 * 
 * This script handles all the functionality for the report management system,
 * including table display, data manipulation, and form handling.
 */

// Main application object
// CRITICAL: Define a minimal ReportApp object immediately to prevent undefined errors
window.ReportApp = window.ReportApp || {};

(function() {
  'use strict';

  // Helper function to get base path from current location
  // Works for both local development and production
  function getBasePath() {
    const pathname = window.location.pathname;
    
    // Remove filename from pathname
    const lastSlash = pathname.lastIndexOf('/');
    if (lastSlash > 0) {
      const basePath = pathname.substring(0, lastSlash);
      // If base path is just '/', return empty string
      if (basePath === '/') {
        return '';
      }
      return basePath;
    }
    
    return '';
  }

  // Configuration
  var config = {
    admissiondata: {
      columns: ['ID', 'Campus', 'Semester', 'Academic Year', 'Category', 'Program', 'Male', 'Female'],
      displayName: 'Admission Data',
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Semester': {
          type: 'select',
          options: [
            { value: 'First Semester', label: 'First Semester' },
            { value: 'Midterm Semester', label: 'Midterm Semester' },
            { value: 'Second Semester', label: 'Second Semester' }
          ]
        },
        'Academic Year': {
          type: 'select',
          options: (() => {
            const currentYear = new Date().getFullYear();
            const years = [];
            // Generate years from current year to 10 years in the future
            for (let year = currentYear; year <= currentYear + 10; year++) {
              years.push({
                value: `${year}-${year + 1}`,
                label: `${year}-${year + 1}`
              });
            }
            return years;
          })()
        },
        'Category': {
          type: 'select',
          options: [
            { value: 'Total no. of applicants', label: 'Total no. of applicants' },
            { value: 'Total no. of qualifiers', label: 'Total no. of qualifiers' },
            { value: 'Total no. of enrolled', label: 'Total no. of enrolled' }
          ]
        }
      }
    },
    enrollmentdata: {
      columns: ['ID', 'Campus', 'Academic Year', 'Semester', 'College', 'Graduate/Undergrad', 'Program/Course', 'Male', 'Female'],
      displayName: 'Enrollment Data',
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Academic Year': {
          type: 'select',
          options: (() => {
            const currentYear = new Date().getFullYear();
            const years = [];
            // Generate years from current year going back 10 years, format: YYYY-YYYY+1
            for (let year = currentYear; year >= currentYear - 10; year--) {
              years.push({
                value: `${year}-${year + 1}`,
                label: `${year}-${year + 1}`
              });
            }
            return years;
          })()
        },
        'Semester': {
          type: 'select',
          options: [
            { value: 'First Semester', label: 'First Semester' },
            { value: 'Second Semester', label: 'Second Semester' }
          ]
        },
        'Graduate/Undergrad': {
          type: 'select',
          options: [
            { value: 'Graduate', label: 'Graduate' },
            { value: 'Undergraduate', label: 'Undergraduate' }
          ]
        }
      }
    },
    graduatesdata: {
      columns: ['ID', 'Campus', 'Academic Year', 'Semester', 'Degree Level', 'Subject Area', 'Course', 'Category/Total No. of Applicants', 'Male', 'Female'],
      displayName: 'Graduates Data',
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Academic Year': {
          type: 'select',
          options: [
            { value: '', label: 'Select Academic Year' },
            { value: 'AY 2024-2025', label: 'AY 2024-2025' },
            { value: 'AY 2023-2024', label: 'AY 2023-2024' },
            { value: 'AY 2022-2023', label: 'AY 2022-2023' },
            { value: 'AY 2021-2022', label: 'AY 2021-2022' },
            { value: 'AY 2020-2021', label: 'AY 2020-2021' }
          ]
        },
        'Semester': {
          type: 'select',
          options: [
            { value: '', label: 'Select Semester' },
            { value: 'First Semester', label: 'First Semester' },
            { value: 'Midterm Semester', label: 'Midterm Semester' },
            { value: 'Second Semester', label: 'Second Semester' }
          ]
        },
        'Degree Level': {
          type: 'select',
          options: [
            { value: '', label: 'Select Degree Level' },
            { value: 'Undergraduate Program', label: 'Undergraduate Program' },
            { value: 'Graduate Program', label: 'Graduate Program' }
          ]
        },
        'Subject Area': {
          type: 'select',
          options: [
            { value: '', label: 'Select Subject Area' },
            { value: 'STEM', label: 'STEM' },
            { value: 'Arts & Humanities/Social Science', label: 'Arts & Humanities/Social Science' }
          ]
        },
        'Course': {
          type: 'select',
          options: [
            { value: '', label: 'Select Course' },
            { value: 'Master of Science in Computer Engineering', label: 'Master of Science in Computer Engineering' },
            { value: 'Master of Engineering major in Chemical Engineering', label: 'Master of Engineering major in Chemical Engineering' },
            { value: 'Master of Engineering major in Civil Engineering', label: 'Master of Engineering major in Civil Engineering' },
            { value: 'Master of Engineering major in Electrical Engineering', label: 'Master of Engineering major in Electrical Engineering' },
            { value: 'Master of Engineering major in Environmental Engineering', label: 'Master of Engineering major in Environmental Engineering' },
            { value: 'Master of Engineering major in Industrial Engineering', label: 'Master of Engineering major in Industrial Engineering' },
            { value: 'Master of Engineering major in Mechanical Engineering', label: 'Master of Engineering major in Mechanical Engineering' },
            { value: 'Bachelor of Science in Chemical Engineering', label: 'Bachelor of Science in Chemical Engineering' },
            { value: 'Bachelor of Science in Civil Engineering', label: 'Bachelor of Science in Civil Engineering' },
            { value: 'Bachelor of Science in Civil Engineering major in Construction Engineering Management', label: 'Bachelor of Science in Civil Engineering major in Construction Engineering Management' },
            { value: 'Bachelor of Science in Civil Engineering major in Structural Engineering', label: 'Bachelor of Science in Civil Engineering major in Structural Engineering' },
            { value: 'Bachelor of Science in Civil Engineering Transportation Engineering', label: 'Bachelor of Science in Civil Engineering Transportation Engineering' },
            { value: 'Bachelor of Science in Computer Engineering', label: 'Bachelor of Science in Computer Engineering' },
            { value: 'Bachelor of Science in Electrical Engineering', label: 'Bachelor of Science in Electrical Engineering' },
            { value: 'Bachelor of Science in Electrical Engineering major in Machine Automation and Process Control', label: 'Bachelor of Science in Electrical Engineering major in Machine Automation and Process Control' },
            { value: 'Bachelor of Science in Electrical Engineering major in Renewable Energy Resources Design', label: 'Bachelor of Science in Electrical Engineering major in Renewable Energy Resources Design' },
            { value: 'Bachelor of Science in Electronics Engineering', label: 'Bachelor of Science in Electronics Engineering' },
            { value: 'Bachelor of Science in Food Engineering', label: 'Bachelor of Science in Food Engineering' },
            { value: 'Bachelor of Science in Industrial Engineering', label: 'Bachelor of Science in Industrial Engineering' },
            { value: 'Bachelor of Science in Instrumentation and Control Engineering', label: 'Bachelor of Science in Instrumentation and Control Engineering' },
            { value: 'Bachelor of Science in Mechanical Engineering', label: 'Bachelor of Science in Mechanical Engineering' },
            { value: 'Bachelor of Science in Mechatronics Engineering', label: 'Bachelor of Science in Mechatronics Engineering' },
            { value: 'Bachelor of Science in Petroleum Engineering', label: 'Bachelor of Science in Petroleum Engineering' },
            { value: 'Bachelor of Science in Sanitary Engineering', label: 'Bachelor of Science in Sanitary Engineering' },
            { value: 'Bachelor of Science in Architecture', label: 'Bachelor of Science in Architecture' },
            { value: 'Bachelor of Science in Interior Design', label: 'Bachelor of Science in Interior Design' },
            { value: 'Bachelor of Fine Arts and Design major in Visual Communication', label: 'Bachelor of Fine Arts and Design major in Visual Communication' },
            { value: 'Master of Science in Computer Science', label: 'Master of Science in Computer Science' },
            { value: 'Master of Science in Science in Information Technology', label: 'Master of Science in Science in Information Technology' },
            { value: 'Bachelor of Science in Computer Science', label: 'Bachelor of Science in Computer Science' },
            { value: 'Bachelor of Science in Information Technology', label: 'Bachelor of Science in Information Technology' },
            { value: 'Bachelor of Science in Information Technology major in Service Management Track', label: 'Bachelor of Science in Information Technology major in Service Management Track' },
            { value: 'Bachelor of Science in Information Technology Major in Business Analytics Track', label: 'Bachelor of Science in Information Technology Major in Business Analytics Track' },
            { value: 'Bachelor of Science in Information Technology major in Network Technology Track', label: 'Bachelor of Science in Information Technology major in Network Technology Track' },
            { value: 'Bachelor of Science in Information Technology major in Management Information System', label: 'Bachelor of Science in Information Technology major in Management Information System' },
            { value: 'Doctor of Technology', label: 'Doctor of Technology' },
            { value: 'Master of Technology', label: 'Master of Technology' },
            { value: 'Bachelor of Industrial Technology major in Automotive Technology', label: 'Bachelor of Industrial Technology major in Automotive Technology' },
            { value: 'Bachelor of Industrial Technology major in Civil Technology', label: 'Bachelor of Industrial Technology major in Civil Technology' },
            { value: 'Bachelor of Industrial Technology major in Computer Technology', label: 'Bachelor of Industrial Technology major in Computer Technology' },
            { value: 'Bachelor of Industrial Technology major in Drafting Technology', label: 'Bachelor of Industrial Technology major in Drafting Technology' },
            { value: 'Bachelor of Industrial Technology major in Electrical Technology', label: 'Bachelor of Industrial Technology major in Electrical Technology' },
            { value: 'Bachelor of Industrial Technology major in Electronics Technology', label: 'Bachelor of Industrial Technology major in Electronics Technology' },
            { value: 'Bachelor of Industrial Technology major in Food Technology', label: 'Bachelor of Industrial Technology major in Food Technology' },
            { value: 'Bachelor of Industrial Technology major in Instrumentation and Control Technology', label: 'Bachelor of Industrial Technology major in Instrumentation and Control Technology' },
            { value: 'Bachelor of Industrial Technology major in Mechatronics Technology', label: 'Bachelor of Industrial Technology major in Mechatronics Technology' },
            { value: 'Bachelor of Industrial Technology major in Mechanical Technology', label: 'Bachelor of Industrial Technology major in Mechanical Technology' },
            { value: 'Bachelor of Industrial Technology major in Welding and Fabrication Technology', label: 'Bachelor of Industrial Technology major in Welding and Fabrication Technology' },
            { value: 'BIT Ladderized Program-Technician Training Course major in Instrumentation and Control Technology', label: 'BIT Ladderized Program-Technician Training Course major in Instrumentation and Control Technology' },
            { value: 'BIT Ladderized Program-Vocational Training Course major in Mechanical Technology', label: 'BIT Ladderized Program-Vocational Training Course major in Mechanical Technology' },
            { value: 'BIT Ladderized Program-Technical Training Course major in Drafting Technology', label: 'BIT Ladderized Program-Technical Training Course major in Drafting Technology' },
            { value: 'BIT Ladderized Program-Technical Training Course major in Instrumentation and Control Technology', label: 'BIT Ladderized Program-Technical Training Course major in Instrumentation and Control Technology' },
            { value: 'BIT Ladderized Program-Technical Training Course major in Electrical Technology', label: 'BIT Ladderized Program-Technical Training Course major in Electrical Technology' },
            { value: 'BIT Ladderized Program-Technical Training Course major in Mechanical Technology', label: 'BIT Ladderized Program-Technical Training Course major in Mechanical Technology' },
            { value: 'Bachelor of Technical-Vocational Teacher Education', label: 'Bachelor of Technical-Vocational Teacher Education' },
            { value: 'Bachelor of Science in Agriculture major in Crop Science', label: 'Bachelor of Science in Agriculture major in Crop Science' },
            { value: 'Bachelor of Science in Agriculture major in Animal Science', label: 'Bachelor of Science in Agriculture major in Animal Science' },
            { value: 'Bachelor of Science in Forestry', label: 'Bachelor of Science in Forestry' },
            { value: 'Bachelor of Science in Information Technology in Business Analytics', label: 'Bachelor of Science in Information Technology in Business Analytics' },
            { value: 'Bachelor of Science in Management Accounting', label: 'Bachelor of Science in Management Accounting' }
          ]
        },
        'Category/Total No. of Applicants': {
          type: 'select',
          options: [
            { value: 'Total No. Applicants', label: 'Total No. Applicants' },
            { value: 'Total No. Graduates', label: 'Total No. Graduates' }
          ]
        }
      }
    },
    employee: {
      columns: ['ID', 'Campus', 'Data Generated', 'Category', 'Faculty Rank/Designation', 'Sex', 'Employee Status', 'Date Hired'],
      displayName: 'Employee',
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Data Generated': {
          type: 'date',
          options: []
        },
        'Date Hired': {
          type: 'date',
          options: []
        },
        'Category': {
          type: 'select',
          options: [
            { value: 'Teaching', label: 'Teaching' },
            { value: 'Non-Teaching', label: 'Non-Teaching' }
          ]
        },
        'Faculty Rank/Designation': {
          type: 'select',
          options: [
            { value: 'Teaching', label: 'Teaching' },
            { value: 'Non-Teaching', label: 'Non-Teaching' }
          ]
        },
        'Sex': {
          type: 'select',
          options: [
            { value: 'Male', label: 'Male' },
            { value: 'Female', label: 'Female' }
          ]
        }
      }
    },
    leaveprivilege: {
      columns: ['ID', 'Campus', 'Leave Type', 'Employee Name', 'Duration Days', 'No. of Days', 'Equivalent Pay'],
      displayName: 'Leave Privilege',
      requiredFields: ['Campus', 'Leave Type', 'Employee Name', 'Duration Days', 'No. of Days', 'Equivalent Pay'],
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Leave Type': {
          type: 'select',
          options: [
            { value: 'Sick Leave', label: 'Sick Leave' },
            { value: 'Vacation Leave', label: 'Vacation Leave' },
            { value: 'Maternity Leave', label: 'Maternity Leave' },
            { value: 'Paternity Leave', label: 'Paternity Leave' },
            { value: 'Emergency Leave', label: 'Emergency Leave' },
            { value: 'Study Leave', label: 'Study Leave' },
            { value: 'Other', label: 'Other' }
          ]
        }
      }
    },
    libraryvisitor: {
      columns: ['ID', 'Campus', 'Visit Date', 'Category', 'Sex', 'Total Visitors'],
      displayName: 'Library Visitor',
      requiredFields: ['Campus', 'Visit Date', 'Category', 'Sex', 'Total Visitors'],
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Category': {
          type: 'select',
          options: [
            { value: 'External', label: 'External' },
            { value: 'Internal', label: 'Internal' }
          ]
        },
        'Sex': {
          type: 'select',
          options: [
            { value: 'Male', label: 'Male' },
            { value: 'Female', label: 'Female' }
          ]
        }
      }
    },
    pwd: {
      columns: ['ID', 'Campus', 'Year', 'No. of PWD Students', 'No. of PWD Employees', 'Type of Disability', 'Sex'],
      displayName: 'PWD',
      requiredFields: ['Campus', 'Year', 'No. of PWD Students', 'No. of PWD Employees', 'Type of Disability', 'Sex'],
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Year': {
          type: 'select',
          options: (() => {
            const currentYear = new Date().getFullYear();
            const years = [];
            // Show previous 2 years, current year, and next 2 years
            for (let i = -2; i <= 2; i++) {
              const year = currentYear + i;
              years.push({ 
                value: year.toString(), 
                label: year.toString() 
              });
            }
            return years;
          })()
        },
        'Sex': {
          type: 'select',
          options: [
            { value: 'Male', label: 'Male' },
            { value: 'Female', label: 'Female' }
          ]
        }
      }
    },
    waterconsumption: {
      columns: ['ID', 'Campus', 'Date', 'Category', 'Prev Reading', 'Current Reading', 'Quantity (m^3)', 'Total Amount', 'Price/m^3', 'Month', 'Year', 'Remarks'],
      displayName: 'Water Consumption',
      requiredFields: ['Campus', 'Date', 'Category', 'Prev Reading', 'Current Reading', 'Quantity (m^3)'],
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Category': {
          type: 'select',
          options: [
            { value: 'Deep Well', label: 'Deep Well' },
            { value: 'Drinking Water', label: 'Drinking Water' }
          ]
        },
        'Month': {
          type: 'select',
          options: [
            { value: 'January', label: 'January' },
            { value: 'February', label: 'February' },
            { value: 'March', label: 'March' },
            { value: 'April', label: 'April' },
            { value: 'May', label: 'May' },
            { value: 'June', label: 'June' },
            { value: 'July', label: 'July' },
            { value: 'August', label: 'August' },
            { value: 'September', label: 'September' },
            { value: 'October', label: 'October' },
            { value: 'November', label: 'November' },
            { value: 'December', label: 'December' }
          ]
        },
        'Year': {
          type: 'select',
          options: (() => {
            const currentYear = new Date().getFullYear();
            const years = [];
            // Show previous 2 years, current year, and next 2 years
            for (let i = -2; i <= 2; i++) {
              const year = currentYear + i;
              years.push({ 
                value: year.toString(), 
                label: year.toString() 
              });
            }
            return years;
          })()
        }
      }
    },
    treatedwastewater: {
      columns: ['ID', 'Campus', 'Date', 'Treated Volume', 'Reused Volume', 'Effluent Volume'],
      displayName: 'Treated Wastewater',
      requiredFields: ['Campus', 'Date', 'Treated Volume', 'Reused Volume', 'Effluent Volume'],
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
      }
    },
    electricityconsumption: {
      columns: ['ID', 'Campus', 'Category', 'Month', 'Year', 'Prev Reading', 'Current Reading', 'Actual Consumption', 'Multiplier', 'Total Consumption', 'Total Amount', 'Price/kWh', 'Remarks'],
      displayName: 'Electricity Consumption',
      requiredFields: ['Campus', 'Category', 'Month', 'Year', 'Prev Reading', 'Current Reading'],
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Category': {
          type: 'select',
          options: [
            { value: 'Mains', label: 'Mains' },
            { value: 'Solar', label: 'Solar' },
            { value: 'Other', label: 'Other' }
          ]
        },
        'Month': {
          type: 'select',
          options: [
            { value: 'January', label: 'January' },
            { value: 'February', label: 'February' },
            { value: 'March', label: 'March' },
            { value: 'April', label: 'April' },
            { value: 'May', label: 'May' },
            { value: 'June', label: 'June' },
            { value: 'July', label: 'July' },
            { value: 'August', label: 'August' },
            { value: 'September', label: 'September' },
            { value: 'October', label: 'October' },
            { value: 'November', label: 'November' },
            { value: 'December', label: 'December' }
          ]
        },
        'Year': {
          type: 'select',
          options: (() => {
            const currentYear = new Date().getFullYear();
            const years = [];
            // Show previous 2 years, current year, and next 2 years
            for (let i = -2; i <= 2; i++) {
              const year = currentYear + i;
              years.push({ 
                value: year.toString(), 
                label: year.toString() 
              });
            }
            return years;
          })()
        }
      }
    },
    solidwaste: {
      columns: ['ID', 'Campus', 'Month', 'Year', 'Waste Type', 'Quantity', 'Remarks'],
      displayName: 'Solid Waste',
      requiredFields: ['Campus', 'Month', 'Year', 'Waste Type', 'Quantity'],
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Waste Type': {
          type: 'select',
          options: [
            { value: 'Biodegradable', label: 'Biodegradable' },
            { value: 'Hazardous', label: 'Hazardous' },
            { value: 'Recyclable', label: 'Recyclable' },
            { value: 'Residual', label: 'Residual' }
          ]
        },
        'Month': {
          type: 'select',
          options: [
            { value: 'January', label: 'January' },
            { value: 'February', label: 'February' },
            { value: 'March', label: 'March' },
            { value: 'April', label: 'April' },
            { value: 'May', label: 'May' },
            { value: 'June', label: 'June' },
            { value: 'July', label: 'July' },
            { value: 'August', label: 'August' },
            { value: 'September', label: 'September' },
            { value: 'October', label: 'October' },
            { value: 'November', label: 'November' },
            { value: 'December', label: 'December' }
          ]
        },
        'Year': {
          type: 'select',
          options: (() => {
            const currentYear = new Date().getFullYear();
            const years = [];
            // Show previous 2 years, current year, and next 2 years
            for (let i = -2; i <= 2; i++) {
              const year = currentYear + i;
              years.push({ 
                value: year.toString(), 
                label: year.toString() 
              });
            }
            return years;
          })()
        }
      }
    },
    campuspopulation: {
      columns: ['ID', 'Campus', 'Year', 'Students', 'IS Students', 'Employees', 'Canteen', 'Construction', 'Total'],
      displayName: 'Campus Population',
      requiredFields: ['Campus', 'Year', 'Students', 'IS Students', 'Employees']
    },
    foodwaste: {
      columns: ['ID', 'Campus', 'Date', 'Quantity (kg)', 'Remarks'],
      displayName: 'Food Waste',
      requiredFields: ['Campus', 'Date', 'Quantity (kg)'],
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
      }
    },
    fuelconsumption: {
      columns: ['ID', 'Campus', 'Date', 'Driver', 'Vehicle', 'Plate No', 'Fuel Type', 'Description', 'Transaction No', 'Odometer', 'Qty', 'Total Amount'],
      displayName: 'Fuel Consumption',
      requiredFields: ['Campus', 'Date', 'Vehicle', 'Fuel Type', 'Qty'],
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Vehicle': {
          type: 'select',
          options: [
            { value: '', label: 'Select Vehicle' },
            { value: 'Foton Bus', label: 'Foton Bus' },
            { value: 'Honda Civic', label: 'Honda Civic' },
            { value: 'Hyundai Starex', label: 'Hyundai Starex' },
            { value: 'Isuzu Sportivo', label: 'Isuzu Sportivo' },
            { value: 'Isuzu Traviz', label: 'Isuzu Traviz' },
            { value: 'Mitsubishi Adventure', label: 'Mitsubishi Adventure' },
            { value: 'Mitsubishi L300 FB Van', label: 'Mitsubishi L300 FB Van' },
            { value: 'Nissan Urvan', label: 'Nissan Urvan' },
            { value: 'Toyota Avanza', label: 'Toyota Avanza' },
            { value: 'Toyota Grandia', label: 'Toyota Grandia' },
            { value: 'Toyota Hi-Ace', label: 'Toyota Hi-Ace' },
            { value: 'Toyota Hilux', label: 'Toyota Hilux' },
            { value: 'Toyota Minibus', label: 'Toyota Minibus' },
            { value: 'Generator', label: 'Generator' },
            { value: 'Lawn Mower', label: 'Lawn Mower' }
          ]
        },
        'Plate No': {
          type: 'select',
          options: [
            { value: '', label: 'Select Plate No' },
            { value: 'P9U017', label: 'P9U017' },
            { value: 'P9T902', label: 'P9T902' },
            { value: 'P9M902', label: 'P9M902' },
            { value: 'A6F875', label: 'A6F875' },
            { value: 'SHS 165', label: 'SHS 165' },
            { value: 'S5W578', label: 'S5W578' },
            { value: 'SKT 627', label: 'SKT 627' },
            { value: 'KOC 825', label: 'KOC 825' },
            { value: 'B8B575', label: 'B8B575' },
            { value: 'SJD 280', label: 'SJD 280' },
            { value: 'BOU 837', label: 'BOU 837' },
            { value: 'SKT 626', label: 'SKT 626' },
            { value: 'S6C486', label: 'S6C486' },
            { value: 'SFN 552', label: 'SFN 552' },
            { value: 'SEU 721', label: 'SEU 721' },
            { value: 'S5W613', label: 'S5W613' }
          ]
        },
        'Fuel Type': {
          type: 'select',
          options: [
            { value: '', label: 'Select Fuel Type' },
            { value: 'Gasoline', label: 'Gasoline' },
            { value: 'Diesel', label: 'Diesel' },
            { value: 'Premium Gasoline', label: 'Premium Gasoline' },
            { value: 'Unleaded', label: 'Unleaded' },
            { value: 'Premium Diesel', label: 'Premium Diesel' }
          ]
        }
      }
    },
    distancetraveled: {
      columns: ['ID', 'Campus', 'Travel Date', 'Plate No', 'Vehicle', 'Fuel Type', 'Start Mileage', 'End Mileage', 'Total KM'],
      displayName: 'Distance Traveled',
      requiredFields: ['Campus', 'Travel Date', 'Vehicle', 'Start Mileage', 'End Mileage'],
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Plate No': {
          type: 'select',
          options: [
            { value: '', label: 'Select Plate No' },
            { value: 'P9U017', label: 'P9U017' },
            { value: 'P9T902', label: 'P9T902' },
            { value: 'P9M902', label: 'P9M902' },
            { value: 'A6F875', label: 'A6F875' },
            { value: 'SHS 165', label: 'SHS 165' },
            { value: 'S5W578', label: 'S5W578' },
            { value: 'SKT 627', label: 'SKT 627' },
            { value: 'KOC 825', label: 'KOC 825' },
            { value: 'B8B575', label: 'B8B575' },
            { value: 'SJD 280', label: 'SJD 280' },
            { value: 'BOU 837', label: 'BOU 837' },
            { value: 'SKT 626', label: 'SKT 626' },
            { value: 'S6C486', label: 'S6C486' },
            { value: 'SFN 552', label: 'SFN 552' },
            { value: 'SEU 721', label: 'SEU 721' },
            { value: 'S5W613', label: 'S5W613' }
          ]
        },
        'Vehicle': {
          type: 'select',
          options: [
            { value: '', label: 'Select Vehicle' },
            { value: 'Foton Bus', label: 'Foton Bus' },
            { value: 'Honda Civic', label: 'Honda Civic' },
            { value: 'Hyundai Starex', label: 'Hyundai Starex' },
            { value: 'Isuzu Sportivo', label: 'Isuzu Sportivo' },
            { value: 'Isuzu Traviz', label: 'Isuzu Traviz' },
            { value: 'Mitsubishi Adventure', label: 'Mitsubishi Adventure' },
            { value: 'Mitsubishi L300 FB Van', label: 'Mitsubishi L300 FB Van' },
            { value: 'Nissan Urvan', label: 'Nissan Urvan' },
            { value: 'Toyota Avanza', label: 'Toyota Avanza' },
            { value: 'Toyota Grandia', label: 'Toyota Grandia' },
            { value: 'Toyota Hi-Ace', label: 'Toyota Hi-Ace' },
            { value: 'Toyota Hilux', label: 'Toyota Hilux' },
            { value: 'Toyota Minibus', label: 'Toyota Minibus' },
            { value: 'Generator', label: 'Generator' },
            { value: 'Lawn Mower', label: 'Lawn Mower' }
          ]
        },
        'Fuel Type': {
          type: 'select',
          options: [
            { value: '', label: 'Select Fuel Type' },
            { value: 'Diesel', label: 'Diesel' },
            { value: 'Gasoline', label: 'Gasoline' }
          ]
        }
      }
    },
    budgetexpenditure: {
      columns: ['ID', 'Campus', 'Year', 'Particulars', 'Category', 'Budget Allocation', 'Actual Expenditure', 'Utilization Rate'],
      displayName: 'Budget Expenditure',
      requiredFields: ['Campus', 'Year', 'Particulars', 'Category', 'Budget Allocation', 'Actual Expenditure'],
      columnConfigs: {
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
        'Category': {
          type: 'select',
          options: [
            { value: 'IGI (STF+IGP)', label: 'IGI (STF+IGP)' },
            { value: 'MDS/GAA', label: 'MDS/GAA' }
          ]
        },
        'Year': {
          type: 'select',
          options: (() => {
            const currentYear = new Date().getFullYear();
            const years = [];
            for (let year = 2010; year <= currentYear + 1; year++) {
              years.push({ value: year.toString(), label: year.toString() });
            }
            return years;
          })()
        },
        'Particulars': {
          type: 'select',
          options: [
            { value: '', label: 'Select Particulars' },
            { value: 'Personnel Services', label: 'Personnel Services' },
            { value: 'Maintenance and Operating Expenses', label: 'Maintenance and Operating Expenses' },
            { value: 'Capital Outlay', label: 'Capital Outlay' },
            { value: 'Reserve Fund', label: 'Reserve Fund' }
          ]
        }
      }
    },
    flightaccommodation: {
      columns: ['ID', 'Campus', 'Office/Department', 'Year', 'Name of Traveller', 'Event Name/Purpose of Travel', 'Travel Date (mm/dd/yyyy)', 'Domestic/International', 'Origin Info or IATA code', 'Destination Info or IATA code', 'Class', 'One Way/Round Trip', 'kg CO2e', 'tCO2e'],
      displayName: 'Flight Accommodation',
      requiredFields: ['Campus', 'Year', 'Name of Traveller', 'Travel Date (mm/dd/yyyy)', 'Origin Info or IATA code', 'Destination Info or IATA code'],
      columnConfigs: {
        'Year': {
          type: 'select',
          options: (() => {
            const currentYear = new Date().getFullYear();
            const years = [];
            for (let year = currentYear; year >= 2000; year--) {
              years.push({ value: year.toString(), label: year.toString() });
            }
            return years;
          })()
        },
        'Domestic/International': {
          type: 'select',
          options: [
            { value: 'Domestic', label: 'Domestic' },
            { value: 'International', label: 'International' }
          ]
        },
        'Class': {
          type: 'select',
          options: [
            { value: 'Economy', label: 'Economy' },
            { value: 'Business Class', label: 'Business Class' },
            { value: 'First Class', label: 'First Class' },
            { value: 'Premium Economy', label: 'Premium Economy' }
          ]
        },
        'One Way/Round Trip': {
          type: 'select',
          options: [
            { value: 'One Way', label: 'One Way' },
            { value: 'Round Trip', label: 'Round Trip' },
            { value: 'Multi-City', label: 'Multi-City' }
          ]
        },
        // Campus config removed - Campus should always be read-only and auto-filled
        // Campus is handled specially in the code to always create read-only input
        // 'Campus': { ... } - REMOVED
      }
    }
  };

  // Private variables
  var currentReport = '';
  var reportData = {};
  var tables = {};
  
  // DOM Elements
  var dom = {
    confirmationModal: null,
    editModal: null,
    closeModalBtn: null,
    closeEditModalBtn: null,
    confirmSaveBtn: null,
    cancelModalBtn: null,
    modalContent: null,
    tablesContainer: null,
    reportDropdown: null,
    saveEditBtn: null,
    cancelEditBtn: null
  };

  // Configuration - Defined at the top of the file

  // Initialize DOM elements
  function initElements() {
    // Modal elements
    dom.confirmationModal = document.getElementById('confirmationModal');
    dom.editModal = document.getElementById('editModal');
    
    // Buttons
    dom.closeModalBtn = document.getElementById('closeModalBtn');
    dom.closeEditModalBtn = document.getElementById('closeEditModalBtn');
    dom.confirmSaveBtn = document.getElementById('confirmSaveBtn');
    dom.cancelModalBtn = document.getElementById('cancelModalBtn');
    dom.saveEditBtn = document.getElementById('saveEditBtn');
    dom.cancelEditBtn = document.getElementById('cancelEditBtn');
    
    // Other elements
    dom.modalContent = document.getElementById('modalContent');
    dom.tablesContainer = document.getElementById('tablesContainer');
    dom.reportDropdown = document.getElementById('reportDropdown');
  }

  // Show toast message with modern design
  function showToast(message, type = 'info') {
    console.log(`[${type.toUpperCase()}] ${message}`);
    
    // Remove existing toasts
    const existingToasts = document.querySelectorAll('.modern-toast');
    existingToasts.forEach(toast => {
      if (toast.parentNode) {
        toast.parentNode.removeChild(toast);
      }
    });
    
    // Create toast container if it doesn't exist
    let toastContainer = document.getElementById('toastContainer');
    if (!toastContainer) {
      toastContainer = document.createElement('div');
      toastContainer.id = 'toastContainer';
      toastContainer.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 10000;
        display: flex;
        flex-direction: column;
        gap: 12px;
        pointer-events: none;
      `;
      document.body.appendChild(toastContainer);
    }
    
    // Create toast element
    const toast = document.createElement('div');
    toast.className = 'modern-toast';
    
    // Set colors based on type
    const colors = {
      success: { bg: '#10b981', icon: '✓', gradient: 'linear-gradient(135deg, #10b981 0%, #059669 100%)' },
      error: { bg: '#ef4444', icon: '✕', gradient: 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)' },
      warning: { bg: '#f59e0b', icon: '⚠', gradient: 'linear-gradient(135deg, #f59e0b 0%, #d97706 100%)' },
      info: { bg: '#3b82f6', icon: 'ℹ', gradient: 'linear-gradient(135deg, #3b82f6 0%, #2563eb 100%)' }
    };
    
    const toastColor = colors[type] || colors.info;
    
    toast.style.cssText = `
      background: ${toastColor.gradient};
      color: white;
      padding: 16px 20px;
      border-radius: 12px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2), 0 0 0 1px rgba(255, 255, 255, 0.1);
      display: flex;
      align-items: center;
      gap: 12px;
      min-width: 300px;
      max-width: 400px;
      font-size: 14px;
      font-weight: 500;
      pointer-events: auto;
      animation: toastSlideIn 0.3s ease-out;
      position: relative;
      overflow: hidden;
    `;
    
    // Add shimmer effect - NO LEFT ICON, only message and right close button
    toast.innerHTML = `
      <div style="position: absolute; top: 0; left: -100%; width: 100%; height: 100%; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent); animation: shimmer 2s infinite;"></div>
      <div style="flex: 1; padding-right: 8px;">${message}</div>
      <button class="toast-close" style="background: rgba(255, 255, 255, 0.2); border: none; color: white; width: 24px; height: 24px; border-radius: 50%; cursor: pointer; display: flex; align-items: center; justify-content: center; font-size: 16px; flex-shrink: 0; transition: all 0.2s;">×</button>
    `;
    
    // Explicitly remove any icon elements that might exist (safety check)
    const iconElements = toast.querySelectorAll('[style*="border-radius: 50%"][style*="width: 32px"][style*="height: 32px"]');
    iconElements.forEach(el => {
      // Only remove if it's not the close button (close button is 24px, icon was 32px)
      if (el.style.width === '32px' && el.style.height === '32px' && !el.classList.contains('toast-close')) {
        el.remove();
      }
    });
    
    // Add animations
    const style = document.createElement('style');
    style.textContent = `
      @keyframes toastSlideIn {
        from {
          opacity: 0;
          transform: translateX(400px);
        }
        to {
          opacity: 1;
          transform: translateX(0);
        }
      }
      @keyframes shimmer {
        0% { left: -100%; }
        100% { left: 100%; }
      }
      .modern-toast:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.25);
      }
      .toast-close:hover {
        background: rgba(255, 255, 255, 0.3);
        transform: rotate(90deg);
      }
    `;
    if (!document.head.querySelector('#toast-animations')) {
      style.id = 'toast-animations';
      document.head.appendChild(style);
    }
    
    toastContainer.appendChild(toast);
    
    // Close button functionality - ensure only one close button exists
    const closeButtons = toast.querySelectorAll('.toast-close');
    // Remove any duplicate close buttons (keep only the first one)
    if (closeButtons.length > 1) {
      for (let i = 1; i < closeButtons.length; i++) {
        closeButtons[i].remove();
      }
    }
    
    const closeBtn = toast.querySelector('.toast-close');
    if (closeBtn) {
      closeBtn.addEventListener('click', () => {
        toast.style.animation = 'toastSlideIn 0.3s ease-out reverse';
        setTimeout(() => {
          if (toast.parentNode) {
            toast.parentNode.removeChild(toast);
          }
        }, 300);
      });
    }
    
    // Auto remove after 5 seconds
    setTimeout(() => {
      if (toast.parentNode) {
        toast.style.animation = 'toastSlideIn 0.3s ease-out reverse';
        setTimeout(() => {
          if (toast.parentNode) {
            toast.parentNode.removeChild(toast);
          }
        }, 300);
      }
    }, 5000);
  }

  // Modern confirmation modal with improved design
  function showConfirmation(message, confirmCallback, cancelCallback = null, options = {}) {
    // Default options
    const {
      title = 'Confirm Action',
      confirmText = 'Confirm',
      cancelText = 'Cancel',
      confirmButtonClass = 'btn-primary',
      cancelButtonClass = 'btn-outline-secondary',
      icon = '<i class="fas fa-exclamation-circle"></i>',
      showCloseButton = true,
      disableBackdropClose = false,
      disableEscapeKey = false,
      width = '500px',
      animation = 'fadeInUp',
      showIcon = true
    } = options;
    
    // Create modal if it doesn't exist
    let modal = document.getElementById('modernConfirmationModal');
    let modalBackdrop = document.getElementById('modernConfirmationModalBackdrop');
    
    if (!modal) {
      // Create backdrop
      modalBackdrop = document.createElement('div');
      modalBackdrop.id = 'modernConfirmationModalBackdrop';
      modalBackdrop.className = 'modern-modal-backdrop';
      
      // Create modal with animation classes
      modal = document.createElement('div');
      modal.id = 'modernConfirmationModal';
      const modalClasses = ['modern-modal', `animate__animated`, `animate__${animation}`];
      if (options.modalClass) {
        modalClasses.push(options.modalClass);
      }
      modal.className = modalClasses.join(' ');
      modal.style.maxWidth = width;
      modal.setAttribute('role', 'dialog');
      modal.setAttribute('aria-modal', 'true');
      modal.setAttribute('aria-labelledby', 'modernConfirmationModalTitle');
      
      // Modal content
      modal.innerHTML = `
        <div class="modern-modal-content">
          <div class="modern-modal-header">
            ${showIcon ? `<div class="modern-modal-icon">${icon}</div>` : ''}
            <div class="modern-modal-header-content">
              <h3 class="modern-modal-title" id="modernConfirmationModalTitle">${title}</h3>
              ${showCloseButton ? '<button type="button" class="btn-close" aria-label="Close">&times;</button>' : ''}
            </div>
          </div>
          <div class="modern-modal-body">${message}</div>
          <div class="modern-modal-footer">
            <button type="button" class="btn ${cancelButtonClass} btn-cancel">
              <span class="btn-text">${cancelText}</span>
            </button>
            <button type="button" class="btn ${confirmButtonClass} btn-confirm">
              <span class="btn-text">${confirmText}</span>
              <span class="btn-loader" style="display: none;">
                <i class="fas fa-spinner fa-spin"></i>
              </span>
            </button>
          </div>
        </div>
      `;
      
      document.body.appendChild(modalBackdrop);
      document.body.appendChild(modal);
    } else {
      // Update existing modal content
      modal.querySelector('.modern-modal-title').textContent = title;
      modal.querySelector('.modern-modal-body').innerHTML = message;
      modal.querySelector('.btn-confirm').textContent = confirmText;
      modal.querySelector('.btn-cancel').textContent = cancelText;
      modal.querySelector('.modern-modal-icon').innerHTML = icon;
      
      // Update modal class
      const modalClasses = ['modern-modal', `animate__animated`, `animate__${animation}`];
      if (options.modalClass) {
        modalClasses.push(options.modalClass);
      }
      modal.className = modalClasses.join(' ');
      
      // Update button classes
      modal.querySelector('.btn-confirm').className = `btn ${confirmButtonClass} btn-confirm`;
      modal.querySelector('.btn-cancel').className = `btn ${cancelButtonClass} btn-cancel`;
      
      // Toggle close button
      const closeButton = modal.querySelector('.btn-close');
      if (showCloseButton && !closeButton) {
        const header = modal.querySelector('.modern-modal-header');
        const closeBtn = document.createElement('button');
        closeBtn.className = 'btn-close';
        closeBtn.setAttribute('aria-label', 'Close');
        closeBtn.innerHTML = '&times;';
        header.appendChild(closeBtn);
      } else if (!showCloseButton && closeButton) {
        closeButton.remove();
      }
    }
    
    // Set up event handlers
    const confirmBtn = modal.querySelector('.btn-confirm');
    const cancelBtn = modal.querySelector('.btn-cancel');
    const closeBtn = modal.querySelector('.btn-close');
    const confirmBtnText = confirmBtn?.querySelector('.btn-text');
    const confirmBtnLoader = confirmBtn?.querySelector('.btn-loader');
    
    const handleConfirm = async (e) => {
      e?.stopPropagation();
      
      // Show loading state
      if (confirmBtn && confirmBtnText && confirmBtnLoader) {
        confirmBtn.disabled = true;
        confirmBtnText.style.visibility = 'hidden';
        confirmBtnLoader.style.display = 'inline-block';
      }
      
      try {
        // If confirmCallback returns a promise, wait for it
        const result = confirmCallback();
        if (result && typeof result.then === 'function') {
          await result;
        }
      } finally {
        // Clean up regardless of success/failure
        cleanup();
      }
    };
    
    const handleCancel = (e) => {
      e?.stopPropagation();
      cleanup();
      if (typeof cancelCallback === 'function') {
        cancelCallback();
      }
    };
    
    const handleKeyDown = (e) => {
      if (e.key === 'Escape' && !disableEscapeKey) {
        handleCancel(e);
      } else if (e.key === 'Enter' && document.activeElement === confirmBtn) {
        handleConfirm(e);
      }
    };
    
    const handleBackdropClick = (e) => {
      if ((e.target === modal || e.target === modalBackdrop) && !disableBackdropClose) {
        handleCancel(e);
      }
    };
    
    const cleanup = () => {
      confirmBtn?.removeEventListener('click', handleConfirm);
      cancelBtn?.removeEventListener('click', handleCancel);
      closeBtn?.removeEventListener('click', handleCancel);
      modal?.removeEventListener('click', handleBackdropClick);
      document.removeEventListener('keydown', handleKeyDown);
      
      // Animate out
      if (modal) modal.classList.remove('show');
      if (modalBackdrop) modalBackdrop.classList.remove('show');
      
      // Remove from DOM after animation
      setTimeout(() => {
        if (modal) modal.style.display = 'none';
        if (modalBackdrop) modalBackdrop.style.display = 'none';
      }, 200);
    };
    
    // Remove any existing event listeners to prevent duplicates
    const newConfirmBtn = confirmBtn.cloneNode(true);
    const newCancelBtn = cancelBtn.cloneNode(true);
    const newCloseBtn = closeBtn ? closeBtn.cloneNode(true) : null;
    
    confirmBtn.parentNode.replaceChild(newConfirmBtn, confirmBtn);
    cancelBtn.parentNode.replaceChild(newCancelBtn, cancelBtn);
    if (closeBtn) closeBtn.parentNode.replaceChild(newCloseBtn, closeBtn);
    
    // Add event listeners
    newConfirmBtn.addEventListener('click', handleConfirm);
    newCancelBtn.addEventListener('click', handleCancel);
    if (newCloseBtn) newCloseBtn.addEventListener('click', handleCancel);
    modal.addEventListener('click', handleBackdropClick);
    document.addEventListener('keydown', handleKeyDown);
    
    // Show the modal
    modal.style.display = 'block';
    modalBackdrop.style.display = 'flex';
    
    // Trigger reflow to enable transition
    void modal.offsetWidth;
    
    // Animate in
    setTimeout(() => {
      modal.classList.add('show');
      modalBackdrop.classList.add('show');
    }, 10);
    
    // Focus the confirm button for better keyboard navigation
    setTimeout(() => {
      newConfirmBtn.focus();
    }, 20);
  }

  // Close modal
  function closeModal(modalId = null) {
    if (modalId) {
      const modal = document.getElementById(modalId);
      if (modal) {
        // For modern modal
        if (modal.classList.contains('modern-modal')) {
          modal.classList.remove('show');
          const backdrop = document.getElementById('modernConfirmationModalBackdrop');
          if (backdrop) backdrop.classList.remove('show');
          
          // Remove from DOM after animation
          setTimeout(() => {
            modal.style.display = 'none';
            if (backdrop) backdrop.style.display = 'none';
          }, 200);
        } else {
          // For legacy modals
          modal.style.display = 'none';
        }
        document.body.style.overflow = 'auto';
      }
    } else {
      // Close all modals if no specific modal ID is provided
      const modals = document.querySelectorAll('.modal, .modern-modal');
      modals.forEach(modal => {
        modal.style.display = 'none';
      });
      
      const backdrops = document.querySelectorAll('.modal-backdrop, .modern-modal-backdrop');
      backdrops.forEach(backdrop => {
        backdrop.style.display = 'none';
      });
      
      document.body.style.overflow = 'auto';
    }
  }

  // Show modal
  function showModal(modalId) {
    closeModal(); // Close any open modals first
    const modal = document.getElementById(modalId);
    if (modal) {
      // For modern modal
      if (modal.classList.contains('modern-modal')) {
        modal.style.display = 'block';
        const backdrop = document.getElementById('modernConfirmationModalBackdrop');
        if (backdrop) backdrop.style.display = 'block';
        
        // Trigger reflow to enable transition
        void modal.offsetWidth;
        
        // Animate in
        setTimeout(() => {
          modal.classList.add('show');
          if (backdrop) backdrop.classList.add('show');
        }, 10);
      } else {
        // For legacy modals
        modal.style.display = 'block';
      }
      
      document.body.style.overflow = 'hidden';
      
      // Focus the first focusable element
      const focusable = modal.querySelector('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
      if (focusable) focusable.focus();
    }
  }

  // Add row function
  function addRow(tableId) {
    // Implementation of addRow
  }

  // Delete a row from the table (UI only)
  function deleteRow(tableId, rowIndex, button) {
    return new Promise((resolve) => {
      try {
        const table = tables[tableId];
        if (!table) {
          console.warn('Table not found:', tableId);
          resolve();
          return;
        }
        
        const row = button.closest('tr');
        if (!row) {
          console.warn('Row not found');
          resolve();
          return;
        }
        
        // Simply remove the row from the DOM
        row.remove();
        
        // If you need to update any internal state, do it here
        const rowId = row.getAttribute('data-row-id');
        if (rowId && reportData[tableId]) {
          reportData[tableId] = reportData[tableId].filter(item => item.ID !== rowId);
        }
        
        // Save the state if needed
        if (window.ReportApp && typeof window.ReportApp.saveState === 'function') {
          window.ReportApp.saveState();
        }
        
        resolve();
      } catch (error) {
        console.error('Error in deleteRow:', error);
        resolve(); // Still resolve to prevent unhandled promise rejection
      }
    });
  }

  // Save row function
  function saveRow(tableId, rowIndex, button) {
    // Implementation for saving a specific row
    ReportApp.showToast('Row saved successfully', 'success');
  }
  
  // Save state function
  function saveState() {
    try {
      console.log('Saving state...');
      // Save to localStorage
      if (typeof this.saveDraft === 'function') {
        console.log('Calling saveDraft...');
        this.saveDraft();
      } else {
        console.error('saveDraft is not a function');
      }
      console.log('State saved successfully');
      return true;
    } catch (error) {
      console.error('Error saving state:', error);
      return false;
    }
  }
  
  // Get user's campus from session or URL
  function getUserCampus() {
    try {
      // First try to get from URL parameters
      const urlParams = new URLSearchParams(window.location.search);
      const campus = urlParams.get('campus');
      
      if (campus) {
        console.log('Using campus from URL:', campus);
        return campus;
      }
      
      // If not in URL, try to get from sessionStorage
      const sessionCampus = sessionStorage.getItem('userCampus');
      if (sessionCampus) {
        console.log('Using campus from session:', sessionCampus);
        return sessionCampus;
      }
      
      console.warn('No campus found in URL or session, defaulting to "Main"');
      return 'Main';
    } catch (error) {
      console.error('Error getting user campus:', error);
      return 'Main'; // Default fallback
    }
  }
  
  // Adjust column widths for better table layout
  function adjustColumnWidths(table) {
    if (!table) return;
    
    // First, reset any existing column widths
    const allCells = table.querySelectorAll('th, td');
    allCells.forEach(cell => cell.style.width = '');
    
    // Get all header cells
    const headerCells = table.querySelectorAll('th');
    if (!headerCells.length) return;
    
    // Calculate max width for each column
    const colWidths = [];
    headerCells.forEach((th, colIndex) => {
      // Get all cells in this column (including header)
      const cells = Array.from(table.querySelectorAll(`tr > *:nth-child(${colIndex + 1})`));
      
      // Calculate the maximum width needed for this column
      let maxWidth = 0;
      cells.forEach(cell => {
        // Temporarily remove fixed width to get natural width
        const tempWidth = cell.style.width;
        cell.style.width = '';
        
        // Calculate width including padding
        const width = cell.offsetWidth + 
                     parseInt(window.getComputedStyle(cell).paddingLeft) + 
                     parseInt(window.getComputedStyle(cell).paddingRight);
        
        maxWidth = Math.max(maxWidth, width);
        
        // Restore original width
        cell.style.width = tempWidth;
      });
      
      // Add some padding and ensure minimum width
      colWidths[colIndex] = Math.min(Math.max(maxWidth + 20, 100), 300);
    });
    
    // Apply the calculated widths
    headerCells.forEach((th, index) => {
      if (colWidths[index]) {
        const width = colWidths[index] + 'px';
        th.style.width = width;
        
        // Apply same width to all cells in this column
        const cells = table.querySelectorAll(`tr > *:nth-child(${index + 1})`);
        cells.forEach(cell => {
          cell.style.width = width;
          cell.style.overflow = 'hidden';
          cell.style.textOverflow = 'ellipsis';
          cell.style.whiteSpace = 'nowrap';
        });
      }
    });
    
    // Set table layout to fixed for better performance
    table.style.tableLayout = 'fixed';
  }

  // Initialize the application
  function init() {
    console.log('Initializing ReportApp...');
    
    try {
      // Bind all methods to ReportApp
      const methods = {
        addRow,
        addTableRow,
        showTable,
        deleteRow,
        saveRow,
        saveState,
        adjustColumnWidths,
        getUserCampus,
        showToast,
        closeModal,
        showModal,
        init
      };
      
      // Bind all methods to ReportApp
      Object.entries(methods).forEach(([name, method]) => {
        if (typeof method === 'function') {
          ReportApp[name] = method.bind(ReportApp);
        }
      });
      
      console.log('ReportApp methods bound:', Object.keys(methods));
      
      // Initialize UI elements
      initElements();
      
      // Seed sessionStorage.userCampus from URL immediately (synchronous)
      try {
        const u = new URLSearchParams(window.location.search).get('campus');
        if (u) sessionStorage.setItem('userCampus', u);
      } catch(e) {}
      // Get user's campus and log it
      const campus = ReportApp.getUserCampus();
      console.log('User campus:', campus);
      
      // Store campus in ReportApp for easy access
      ReportApp.currentCampus = campus;
      
      // Debug: Log available table configurations
      console.log('Available table configurations:', Object.keys(config));
      
      // Check if we need to load a specific table
      const urlParams = new URLSearchParams(window.location.search);
      const tableName = urlParams.get('table');
      
      if (tableName) {
        console.log('Initial table to load from URL:', tableName);
        // Small delay to ensure everything is initialized
        setTimeout(() => {
          if (ReportApp.showTable) {
            ReportApp.showTable(tableName);
          } else {
            console.error('showTable is not available on ReportApp');
          }
        }, 100);
      }
      
      // Initialize tables data structure
      Object.keys(config).forEach(tableId => {
        if (config[tableId] && config[tableId].columns) {
          // Deep copy columnConfigs to ensure all entries are included
          // IMPORTANT: Explicitly exclude Campus config - it should never be in columnConfigs
          const columnConfigs = {};
          if (config[tableId].columnConfigs) {
            Object.keys(config[tableId].columnConfigs).forEach(key => {
              // NEVER include Campus in columnConfigs - it should always be read-only input
              if (key !== 'Campus' && key.toLowerCase() !== 'campus') {
                columnConfigs[key] = config[tableId].columnConfigs[key];
              }
            });
          }
          
          tables[tableId] = {
            data: [],
            columns: config[tableId].columns,
            columnConfigs: columnConfigs,
            displayName: config[tableId].displayName || tableId,
            requiredFields: config[tableId].requiredFields || []
          };
          
          console.log(`Initialized table: ${tableId}`, {
            columns: tables[tableId].columns,
            hasColumnConfigs: !!tables[tableId].columnConfigs,
            columnConfigKeys: Object.keys(tables[tableId].columnConfigs || {}),
            columnConfigs: tables[tableId].columnConfigs
          });
          
          if (tableId === 'admissiondata') {
            console.log('Admissiondata table initialized:');
            console.log('- Columns:', tables[tableId].columns);
            console.log('- ColumnConfigs keys:', Object.keys(tables[tableId].columnConfigs || {}));
            console.log('- Has Campus config:', !!(tables[tableId].columnConfigs && tables[tableId].columnConfigs['Campus']));
            console.log('- Full columnConfigs:', tables[tableId].columnConfigs);
            console.log('- Config source columnConfigs:', config[tableId].columnConfigs);
          }
        } else {
          console.warn(`Skipping invalid table configuration for: ${tableId}`, config[tableId]);
        }
      });
      
      console.log('ReportApp initialization complete');
      console.log('Available tables:', Object.keys(tables));
      return true;
    } catch (error) {
      console.error('Error initializing ReportApp:', error);
      return false;
    }
    
    // Debug: Log initialized tables
    console.log('Initialized tables:', Object.keys(tables));
    
    // Load any saved data
    ReportApp.loadInitialData();
    
    // Check for table parameter in URL
    const urlParams = new URLSearchParams(window.location.search);
    let tableParam = urlParams.get('table');
    
    // Add a small delay to ensure everything is loaded
    const self = this;
    setTimeout(() => {
      // Debug: Check if the requested table exists
      if (tableParam) {
        console.log(`Requested table: ${tableParam}, exists: ${!!tables[tableParam]}`);
      }
      
      // If no table specified or table doesn't exist, use the first available table
      if (!tableParam || !tables[tableParam]) {
        const availableTables = Object.keys(tables);
        if (availableTables.length > 0) {
          // If the requested table doesn't exist but we have other tables, use the first one
          if (tableParam && !tables[tableParam]) {
            console.warn(`Table '${tableParam}' not found. Available tables:`, availableTables);
            // Show error message to user
            if (dom.tablesContainer) {
              const errorMessage = document.createElement('div');
              errorMessage.className = 'error-message';
              errorMessage.innerHTML = `
                <h3>Error: Report Not Found</h3>
                <p>The requested report "${tableParam}" could not be found.</p>
                <p>Available reports: ${availableTables.join(', ')}</p>
                <p>Please check the report name or contact support if you believe this is an error.</p>
              `;
              dom.tablesContainer.innerHTML = '';
              dom.tablesContainer.appendChild(errorMessage);
            }
            
            // Update the URL to reflect the fallback table
            const newUrl = new URL(window.location);
            newUrl.searchParams.set('table', availableTables[0]);
            window.history.replaceState({}, '', newUrl);
            tableParam = availableTables[0];
          } else {
            tableParam = availableTables[0];
          }
          console.log('Using table:', tableParam);
        } else {
          console.error('No tables are available in the configuration');
          if (dom.tablesContainer) {
            dom.tablesContainer.innerHTML = `
              <div class="error-message">
                <h3>Error: No Reports Available</h3>
                <p>There are no reports configured in the system.</p>
                <p>Please contact support for assistance.</p>
              </div>`;
          }
          return;
        }
      }
      
      // Show the selected table
      console.log('Showing table:', tableParam);
      showTable(tableParam);
      
      // Update the dropdown if it exists
      if (dom.reportDropdown) {
        dom.reportDropdown.value = tableParam;
      }
    }, 100);
    
    // Set up modal close on outside click
    if (dom.editModal) {
      dom.editModal.addEventListener('click', (e) => {
        if (e.target === dom.editModal) {
          closeModal('editModal');
        }
      });
    }
    
    // Confirm save button
    if (dom.confirmSaveBtn) {
      dom.confirmSaveBtn.addEventListener('click', () => {
        confirmSave(true);
      });
    }
    
    // Cancel button
    if (dom.cancelModalBtn) {
      dom.cancelModalBtn.addEventListener('click', () => {
        closeModal('confirmationModal');
      });
    }
  }

  // Define all functions first
  function showTable(tableId) {
    // Implementation of showTable
    if (!tableId) return;
    
    const table = tables[tableId];
    if (!table) {
      console.error('Table not found:', tableId);
      return;
    }
    
    // Ensure we have the correct 'this' context
    const self = window.ReportApp;
    
    // Ensure dom.tablesContainer is initialized
    if (!dom.tablesContainer) {
      console.warn('dom.tablesContainer not initialized, attempting to initialize...');
      initElements();
      // Try again after initialization
        if (!dom.tablesContainer) {
          dom.tablesContainer = document.getElementById('tablesContainer');
          if (!dom.tablesContainer) {
            console.error('tablesContainer element not found in DOM');
            if (typeof window.showError === 'function') {
              window.showError('Error', 'Report container not found. Please refresh the page.');
            } else {
              alert('Error: Report container not found. Please refresh the page.');
            }
            return;
          }
        }
    }
    
    // Clear existing content
    dom.tablesContainer.innerHTML = '';
    
    // Create a container for the table header (title + add button)
    const headerContainer = document.createElement('div');
    headerContainer.className = 'd-flex justify-content-between align-items-center mb-3';
    headerContainer.style.padding = '0 15px';
    
    // Create a flex container for the title and button
    const headerContent = document.createElement('div');
    headerContent.style.display = 'flex';
    headerContent.style.justifyContent = 'space-between';
    headerContent.style.width = '100%';
    headerContent.style.alignItems = 'center';
    
    // Create table title (on left)
    const tableTitle = document.createElement('div');
    tableTitle.textContent = table.displayName || 'Table';
    tableTitle.style.fontSize = '1.3rem';
    tableTitle.style.fontWeight = '600';
    tableTitle.style.margin = '0';
    tableTitle.style.padding = '0';
    tableTitle.style.lineHeight = '1.2';
    
    // Create buttons container
    const buttonsContainer = document.createElement('div');
    buttonsContainer.style.display = 'flex';
    buttonsContainer.style.gap = '10px';
    buttonsContainer.style.marginLeft = 'auto'; // This will push the container to the right
    
    // Create add button
    const addButton = document.createElement('button');
    addButton.type = 'button';
    addButton.className = 'btn btn-primary btn-sm';
    addButton.innerHTML = '<i class="fas fa-plus"></i> Add Row';
    addButton.onclick = (e) => {
      e.preventDefault();
      e.stopPropagation();
      self.addRow(tableId);
    };
    
    // Create submit button
    const submitButton = document.createElement('button');
    submitButton.type = 'button';
    submitButton.className = 'btn btn-primary';
    submitButton.innerHTML = '<i class="fas fa-paper-plane"></i> Submit Report';
    submitButton.id = 'submitReportBtn';
    submitButton.style.cssText = `
      background: linear-gradient(135deg, #dc143c 0%, #c82333 100%);
      color: white;
      border: none;
      padding: 14px 32px;
      font-weight: 600;
      font-size: 15px;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(220, 20, 60, 0.3);
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 10px;
      cursor: pointer;
    `;
    
    // Add hover effect
    submitButton.addEventListener('mouseenter', () => {
      submitButton.style.transform = 'translateY(-2px)';
      submitButton.style.boxShadow = '0 6px 20px rgba(220, 20, 60, 0.4)';
    });
    
    submitButton.addEventListener('mouseleave', () => {
      submitButton.style.transform = 'translateY(0)';
      submitButton.style.boxShadow = '0 4px 15px rgba(220, 20, 60, 0.3)';
    });
    
    // Use the ReportApp instance directly
    
    // Use a proper event listener instead of onclick to maintain scope
    submitButton.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      
      // Use the modern confirmation dialog
      ReportApp.confirmSubmit(tableId)
        .then(confirmed => {
          if (confirmed) {
            // Show loading state
            submitButton.disabled = true;
            const originalText = submitButton.textContent;
            submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
            
            // The actual submission is handled by confirmSubmit
            // Just restore button state after a delay if needed
            setTimeout(() => {
              if (submitButton.disabled) {
                submitButton.disabled = false;
                submitButton.textContent = originalText;
              }
            }, 1000);
          }
        })
        .catch(error => {
          console.error('Error in submit confirmation:', error);
          ReportApp.showToast('Error confirming submission', 'error');
        });
    });
    
    // Add buttons to container
    buttonsContainer.appendChild(addButton);
    buttonsContainer.appendChild(submitButton);
    
    // Add title and buttons container to header content
    headerContent.appendChild(tableTitle);
    headerContent.appendChild(buttonsContainer);
    
    // Add header content to container
    headerContainer.appendChild(headerContent);
    
    // Add header container to the page
    dom.tablesContainer.appendChild(headerContainer);
    
    // Add spacing between header and table
    const spacingDiv = document.createElement('div');
    spacingDiv.style.height = '30px'; // Increased from 15px to 30px for more space
    dom.tablesContainer.appendChild(spacingDiv);
    
    // Create responsive container for the table with fixed height and internal scroll
    const tableResponsive = document.createElement('div');
    tableResponsive.className = 'table-responsive';
    tableResponsive.style.maxHeight = 'calc(100vh - 230px)'; // Adjusted for the extra space
    tableResponsive.style.overflowY = 'auto';
    tableResponsive.style.marginTop = '10px'; // Additional top margin
    
    // Create table element with fixed layout and sticky headers
    const tableEl = document.createElement('table');
    tableEl.id = tableId;
    tableEl.className = 'table table-bordered table-striped table-hover mb-0';
    tableEl.style.tableLayout = 'fixed';
    tableEl.style.width = '100%';
    
    // Create table header with sticky positioning
    const thead = document.createElement('thead');
    const headerRow = document.createElement('tr');
    headerRow.className = 'table-primary';
    thead.style.position = 'sticky';
    thead.style.top = '0';
    thead.style.zIndex = '10';
    
    // Add header cells based on table configuration
    table.columns.forEach(column => {
      if (column === 'ID') return; // Skip ID column in display
      
      const th = document.createElement('th');
      th.textContent = column.replace(/_/g, ' '); // Replace underscores with spaces
      th.setAttribute('data-column', column);
      th.style.whiteSpace = 'nowrap';
      th.style.backgroundColor = '#d32f2f'; // Red background
      th.style.color = 'white';
      th.style.fontWeight = '600';
      // Add tooltip for long text
      th.title = column.replace(/_/g, ' ');
      th.style.position = 'relative';
      headerRow.appendChild(th);
    });
    
    // Add action column header
    const actionTh = document.createElement('th');
    actionTh.textContent = 'Actions';
    actionTh.className = 'actions-column text-center';
    actionTh.style.backgroundColor = '#d32f2f'; // Red background
    actionTh.style.color = 'white';
    actionTh.style.fontWeight = '600';
    headerRow.appendChild(actionTh);
    
    thead.appendChild(headerRow);
    tableEl.appendChild(thead);
    
    // Create table body
    const tbody = document.createElement('tbody');
    tbody.id = `${tableId}Body`;
    
    // Add the table to the DOM
    tableEl.appendChild(tbody);
    tableResponsive.appendChild(tableEl);
    
    // Add the table to the page
    dom.tablesContainer.appendChild(tableResponsive);
    
    // Add existing rows to the table
    if (table.data && table.data.length > 0) {
      table.data.forEach((row, index) => {
        this.addTableRow(tableId, row, index, false);
      });
    } else {
      // Add an empty row if no data exists
      // Use setTimeout to ensure the table is fully rendered
      setTimeout(() => {
        this.addRow(tableId);
      }, 0);
    }
    
    // Assemble the table structure
    tableEl.appendChild(tbody);
    
    // Assemble the complete structure
    tableResponsive.appendChild(tableEl);
    
    // Add the table to the page
    dom.tablesContainer.appendChild(tableResponsive);
    
    // Try to restore draft after table is rendered
    setTimeout(() => {
      const draftRestored = ReportApp.restoreDraft(tableId);
      if (!draftRestored) {
        // If no draft, attach auto-save listeners for new data entry
        ReportApp.attachAutoSaveListeners(tableId);
      }
    }, 1000);
    
    // Calculate and set column widths after table is rendered
    setTimeout(() => {
      this.adjustColumnWidths(tableEl);
      // Add tooltips to all existing rows and headers
      addTooltipsToTable(tableEl);
    }, 100);
    
    return true;
  }
  
  // Add a new row to the table
  function addRow(tableId) {
    const table = tables[tableId];
    if (!table) {
      console.error('Table not found:', tableId);
      return null;
    }
    
    // Create a new empty row with default values
    const newRow = {};
    table.columns.forEach(column => {
      if (column === 'ID') {
        newRow[column] = Date.now(); // Use timestamp as temporary ID
      } else if (column === 'Campus') {
        // Pre-fill campus if available in sessionStorage
        newRow[column] = sessionStorage.getItem('userCampus') || '';
      } else {
        newRow[column] = ''; // Empty string as default value
      }
    });
    
    // Add the new row to the table data
    if (!table.data) {
      table.data = [];
    }
    
    const rowIndex = table.data.length;
    table.data.push(newRow);
    
    // Add the row to the UI
    // Call addTableRow directly - use the standalone function
    return addTableRow(tableId, newRow, rowIndex, true);
  }

  // Add a single row to the table
  function addTableRow(tableId, rowData = {}, rowIndex = -1, isNew = true) {
    console.log('=== addTableRow called (STANDALONE FUNCTION) === tableId:', tableId);
    // Ensure we have the ReportApp instance
    const self = window.ReportApp;
    const table = tables[tableId];
    if (!table) {
      console.error('Table not found:', tableId);
      return null;
    }
    
    console.log('Table found:', tableId, 'columns:', table.columns);
    console.log('Table columns array:', JSON.stringify(table.columns));
    if (tableId === 'admissiondata') {
      console.log('ADMISSIONDATA COLUMNS:', table.columns);
      console.log('Campus in columns?', table.columns.includes('Campus'));
      console.log('Campus index:', table.columns.indexOf('Campus'));
    }
    
    // Get user's campus from sessionStorage if available
    const userCampus = sessionStorage.getItem('userCampus') || '';
    
    const tbody = document.getElementById(`${tableId}Body`);
    const thead = document.querySelector(`#${tableId} thead`);
    if (!tbody || !thead) {
      console.error('Table body or head not found for table:', tableId);
      return null;
    }
    
    // Get the header cells to match the column structure
    const headerCells = thead.querySelectorAll('th');
    
    const tr = document.createElement('tr');
    const rowId = rowData.ID || `new-${Date.now()}-${rowIndex}`;
    tr.setAttribute('data-row-id', rowId);
    
    console.log('Adding row with data:', rowData);
    
    // Create cells based on the table's column configuration
    table.columns.forEach((columnName, colIndex) => {
      // Skip ID column in display (it's still stored in data)
      if (columnName === 'ID') {
        tr.dataset.rowId = rowData[columnName] || rowId;
        return;
      }
      
      const td = document.createElement('td');
      const cellValue = rowData[columnName] || '';
      
      // Debug: Log ALL columns for admissiondata
      if (tableId === 'admissiondata') {
        console.log('Processing column for admissiondata:', columnName, 'colIndex:', colIndex, 'columnName type:', typeof columnName, 'columnName === "Campus":', columnName === 'Campus');
      }
      
      // SPECIAL HANDLING FOR CAMPUS IN ALL REPORT TABLES - CHECK FIRST!
      // Campus column should ALWAYS be read-only and auto-filled, regardless of table
      // Check with case-insensitive comparison and trim
      const isCampusColumn = columnName === 'Campus' || columnName.trim() === 'Campus' || columnName.toLowerCase() === 'campus';
      console.log('Checking Campus condition:', {tableId, columnName, isCampusColumn, columnNameType: typeof columnName, columnNameLength: columnName.length});
      
      if (isCampusColumn) {
        console.log('>>> CAMPUS DETECTED! tableId:', tableId, 'columnName:', columnName, 'type:', typeof columnName);
        console.log(`=== CAMPUS INPUT (AUTO-FILLED) FOR ${tableId.toUpperCase()} ===`);
        
        // Resolve campus: URL param > sessionStorage > existing cell > default
        const userCampus = (new URLSearchParams(window.location.search).get('campus')) || sessionStorage.getItem('userCampus') || cellValue || 'Main';
        
        // Create read-only input field
        const input = document.createElement('input');
        input.type = 'text';
        input.className = 'form-control form-control-sm';
        input.name = columnName;
        input.id = `campus-input-${rowId}-${colIndex}`;
        input.style.width = '100%';
        input.readOnly = true;
        input.style.backgroundColor = '#f8f9fa';
        input.style.cursor = 'not-allowed';
        
        // Set value to user's campus
        if (userCampus) {
          input.value = userCampus;
          if (rowData) {
            rowData[columnName] = userCampus;
          }
          console.log(`Campus auto-filled with user's campus: ${userCampus}`);
        } else {
          // Keep existing cell value; do not auto-fetch or warn
          input.value = cellValue || '';
          if (rowData) {
            rowData[columnName] = cellValue || '';
          }
        }
        
        td.appendChild(input);
        console.log('Campus input created with value:', input.value);
        
        tr.appendChild(td);
        console.log('Appended td to tr. tr.children:', tr.children.length);
        
        // IMPORTANT: Return early - Campus is handled, don't continue to dropdown creation
        return; // Skip rest of column processing for Campus
      }
      
      // Handle different column types based on column name
      if (columnName.toLowerCase() === 'status' && tableId !== 'employee') {
        // Status badge
        const status = cellValue || 'Pending';
        const statusClass = status.toLowerCase() === 'approved' ? 'status-approved' : 
                          status.toLowerCase() === 'rejected' ? 'status-rejected' : 'status-pending';
        
        const statusBadge = document.createElement('span');
        statusBadge.className = `status-badge ${statusClass}`;
        statusBadge.textContent = status;
        td.appendChild(statusBadge);
        
      } else if (columnName === 'Data Generated' || columnName === 'Date Hired' || 
                columnName.toLowerCase().includes('date') ||
                (columnName.toLowerCase().includes('campus') && !(tableId === 'admissiondata' || tableId === 'enrollmentdata' || tableId === 'graduatesdata')) || 
                (columnName.toLowerCase().includes('type') && columnName !== 'Type of Disability') || 
                (columnName.toLowerCase().includes('category') && !(tableId === 'enrollmentdata' && columnName === 'Academic Year')) ||
                (columnName.toLowerCase() === 'academic year' && tableId !== 'enrollmentdata') ||
                columnName.toLowerCase() === 'semester' ||
                columnName.toLowerCase() === 'degree level' ||
                columnName.toLowerCase() === 'subject area' ||
                columnName.toLowerCase() === 'course' ||
                columnName.toLowerCase() === 'category/total no. of applicants' ||
                columnName === 'Category' ||
                columnName === 'Faculty Rank/Designation' ||
                columnName === 'Sex' ||
                columnName === 'Month' ||
                columnName === 'Year' ||
                columnName === 'Plate No' ||
                columnName === 'Vehicle' ||
                columnName === 'Fuel Type' ||
                columnName === 'Year' ||
                columnName === 'Particulars' ||
                columnName === 'Domestic/International' ||
                columnName === 'Class' ||
                columnName === 'One Way/Round Trip' ||
                columnName === 'Graduate/Undergrad') {
        // Campus should NEVER reach this code - it's handled above with early return
        // This debug log should never execute for Campus
        // Create date input for date columns
        if (columnName === 'Data Generated' || columnName === 'Date Hired' || columnName.toLowerCase().includes('date')) {
          const input = document.createElement('input');
          input.type = 'date';
          input.className = 'form-control form-control-sm';
          input.name = columnName;
          
          // Set the value if it exists
          if (cellValue) {
            try {
              const date = new Date(cellValue);
              if (!isNaN(date.getTime())) {
                const formattedDate = date.toISOString().split('T')[0];
                input.value = formattedDate;
              }
            } catch (error) {
              console.error('Error parsing date:', error);
            }
          }
          td.appendChild(input);
        } else {
          // Create select input for other columns
          const select = document.createElement('select');
          select.className = 'form-control form-control-sm';
          select.name = columnName;
          
          // UNIVERSAL CAMPUS CHECK - Campus should NEVER be a dropdown in ANY table
          // If we somehow get here, create read-only input instead of dropdown
          if (columnName === 'Campus' || columnName.toLowerCase() === 'campus') {
            console.error(`ERROR: Campus should have been handled above for ${tableId}! Creating read-only input as fallback.`);
            // Create read-only input instead of dropdown
            const input = document.createElement('input');
            input.type = 'text';
            input.className = 'form-control form-control-sm';
            input.name = columnName;
            input.readOnly = true;
            input.style.backgroundColor = '#f8f9fa';
            input.style.cursor = 'not-allowed';
            const userCampus = sessionStorage.getItem('userCampus') || cellValue || '';
            input.value = userCampus;
            if (rowData) {
              rowData[columnName] = userCampus;
            }
            td.appendChild(input);
            tr.appendChild(td);
            return; // Skip rest - Campus handled
          }
          
          // For other columns, try to get options from config (NOT Campus)
          if (columnName !== 'Campus' && columnName.toLowerCase() !== 'campus') {
            // For other columns, try to get options from config
            let optionsToUse = null;
            
            // For admissiondata, try config.admissiondata.columnConfigs first
            // CRITICAL: Never use Campus config - it should be read-only input
            if (tableId === 'admissiondata' && config && config.admissiondata && config.admissiondata.columnConfigs && 
                columnName !== 'Campus' && columnName.toLowerCase() !== 'campus' &&
                config.admissiondata.columnConfigs[columnName] && config.admissiondata.columnConfigs[columnName].options) {
              optionsToUse = config.admissiondata.columnConfigs[columnName].options;
              console.log('Using columnConfigs from config.admissiondata.columnConfigs for', columnName, 'in', tableId, ':', optionsToUse.length, 'options');
            }
            // Try table.columnConfigs (Campus should never be here, but double-check)
            else if (table.columnConfigs && columnName !== 'Campus' && columnName.toLowerCase() !== 'campus' &&
                     table.columnConfigs[columnName] && table.columnConfigs[columnName].options) {
              optionsToUse = table.columnConfigs[columnName].options;
              console.log('Using columnConfigs from table.columnConfigs for', columnName, 'in', tableId, ':', optionsToUse.length, 'options');
            }
            // Try config[tableId].columnConfigs (Campus should never be here, but double-check)
            else if (config && config[tableId] && config[tableId].columnConfigs && 
                     columnName !== 'Campus' && columnName.toLowerCase() !== 'campus' &&
                     config[tableId].columnConfigs[columnName] && config[tableId].columnConfigs[columnName].options) {
              optionsToUse = config[tableId].columnConfigs[columnName].options;
              console.log('Using columnConfigs from config[tableId].columnConfigs for', columnName, 'in', tableId, ':', optionsToUse.length, 'options');
            }
            
            if (optionsToUse) {
              // For other columns, use options from config
              optionsToUse.forEach(option => {
                const optionEl = document.createElement('option');
                optionEl.value = option.value || '';
                optionEl.textContent = option.label || option.value || '';
                if ((option.value || '') === (cellValue || '')) {
                  optionEl.selected = true;
                }
                select.appendChild(optionEl);
              });
            } else {
              // Only log warning for non-Campus and non-"Year in campuspopulation" columns
              if (!(((tableId === 'admissiondata' || tableId === 'enrollmentdata') && columnName === 'Campus') ||
                    (tableId === 'campuspopulation' && columnName === 'Year'))) {
                console.warn('Missing column config for:', columnName, 'in table:', tableId);
                console.log('Available configs in table.columnConfigs:', Object.keys(table.columnConfigs || {}));
                console.log('Available configs in config.admissiondata.columnConfigs:', Object.keys(config?.admissiondata?.columnConfigs || {}));
              }
            }
          }

          // Special case: Campus Population 'Year' must be a number input, not a select
          if (tableId === 'campuspopulation' && columnName === 'Year') {
            const input = document.createElement('input');
            input.type = 'number';
            input.min = '0';
            input.step = '1';
            input.placeholder = 'Enter year';
            input.className = 'form-control form-control-sm';
            input.name = 'Year';
            input.value = cellValue || '';
            input.addEventListener('keypress', function(e) {
              if (e.key === '-' || e.key === '+' || e.key === 'e' || e.key === 'E' || e.key === '.') {
                e.preventDefault();
              }
            });
            input.addEventListener('input', function() {
              this.value = this.value.replace(/[^0-9]/g, '');
              const row = this.closest('tr');
              if (row) calculateCampusPopulationTotal(row);
            });
            td.appendChild(input);
          } else {
            // Append the select for normal dropdowns
            td.appendChild(select);
          }
          console.log('Appended select to td. td now has', td.children.length, 'children');
        }
      } else {
        // Default text input or number input for numeric columns
        const input = document.createElement('input');
        
        // Check if this is a numeric column
        if (columnName === 'No. of PWD Students' || 
            columnName === 'No. of PWD Employees' ||
            columnName === 'Duration Days' ||
            columnName === 'No. of Days' ||
            columnName === 'Equivalent Pay' ||
            columnName === 'Total Visitors' ||
            columnName === 'Prev Reading' ||
            columnName === 'Current Reading' ||
            columnName === 'Price/m^3' ||
            columnName === 'Treated Volume' ||
            columnName === 'Reused Volume' ||
            columnName === 'Effluent Volume' ||
            columnName === 'Multiplier' ||
            columnName === 'Price/kWh' ||
            (tableId === 'solidwaste' && columnName === 'Quantity') ||
            columnName === 'Quantity (kg)' ||
            (tableId === 'fuelconsumption' && (columnName === 'Transaction No' || columnName === 'Odometer' || columnName === 'Qty' || columnName === 'Total Amount')) ||
            (tableId === 'distancetraveled' && (columnName === 'Start Mileage' || columnName === 'End Mileage')) ||
            (tableId === 'enrollmentdata' && (columnName === 'Male' || columnName === 'Female')) ||
            (tableId === 'graduatesdata' && (columnName === 'Male' || columnName === 'Female')) ||
            (tableId === 'admissiondata' && (columnName === 'Male' || columnName === 'Female')) ||
            (tableId === 'campuspopulation' && (columnName === 'Year' || columnName === 'Students' || columnName === 'IS Students' || columnName === 'Employees' || columnName === 'Canteen' || columnName === 'Construction'))
          ) {
          input.type = 'number';
          input.min = '0';
          // Use step='1' for integer-only fields
          if ((tableId === 'enrollmentdata' || tableId === 'graduatesdata' || tableId === 'admissiondata') && (columnName === 'Male' || columnName === 'Female')) {
            input.step = '1';
            input.placeholder = 'Enter number';
            // Prevent negative numbers and non-numeric input for Male/Female
            input.addEventListener('keypress', function(e) {
              if (e.key === '-' || e.key === '+' || e.key === 'e' || e.key === 'E' || e.key === '.') {
                e.preventDefault();
              }
            });
            input.addEventListener('input', function(e) {
              // Remove any non-numeric characters
              this.value = this.value.replace(/[^0-9]/g, '');
            });
          } else if (tableId === 'campuspopulation') {
            // Campus Population numeric fields are integers only
            input.step = '1';
            input.placeholder = 'Enter number';
            input.addEventListener('keypress', function(e) {
              if (e.key === '-' || e.key === '+' || e.key === 'e' || e.key === 'E' || e.key === '.') {
                e.preventDefault();
              }
            });
            input.addEventListener('input', function() {
              this.value = this.value.replace(/[^0-9]/g, '');
              calculateCampusPopulationTotal(tr);
            });
          } else {
            input.step = '0.01';
            input.placeholder = 'Enter number';
          }
          input.className = input.className || '';
          if (tableId === 'distancetraveled') {
            if (columnName === 'Start Mileage') {
              input.classList.add('start-mileage');
              input.placeholder = 'Enter start mileage';
            } else if (columnName === 'End Mileage') {
              input.classList.add('end-mileage');
              input.placeholder = 'Enter end mileage';
            }
          }
          input.addEventListener('keypress', function(e) {
            // Allow numbers, backspace, delete, tab, escape, and arrow keys
            const char = String.fromCharCode(e.which);
            const allowedKeys = [8, 9, 27, 37, 38, 39, 40, 46]; // Backspace, Tab, Escape, Arrow keys, Delete
            // Allow decimal point for numeric fields
            if ((!/[0-9.]/.test(char) && allowedKeys.indexOf(e.which) === -1) || (char === '.' && this.value.includes('.'))) {
              e.preventDefault();
            }
          });
          // Add calculation listener for distance traveled
          if (tableId === 'distancetraveled' && (columnName === 'Start Mileage' || columnName === 'End Mileage')) {
            input.addEventListener('input', function() {
              calculateTotalKMForRow(tr);
            });
          }
        } else if (tableId === 'distancetraveled' && columnName === 'Total KM') {
          // Total KM - read-only, auto-calculated
          input.type = 'number';
          input.readOnly = true;
          input.step = '0.01';
          input.classList.add('total-km');
          input.style.backgroundColor = '#f0f0f0';
          input.style.cursor = 'not-allowed';
          input.placeholder = 'Auto-calculated';
          // Don't set value from cellValue - it will be calculated
          // Mark this input so we skip setting value later
          input.dataset.autoCalculated = 'true';
        } else if (tableId === 'campuspopulation' && columnName === 'Total') {
          // Campus Population Total - read-only, auto-calculated
          input.type = 'number';
          input.readOnly = true;
          input.step = '1';
          input.classList.add('campus-total');
          input.style.backgroundColor = '#f0f0f0';
          input.style.cursor = 'not-allowed';
          input.placeholder = 'Auto-calculated';
        } else if (columnName === 'Quantity (m^3)' || 
                   (tableId === 'electricityconsumption' && (columnName === 'Actual Consumption' || columnName === 'Total Consumption' || columnName === 'Total Amount')) ||
                   (tableId !== 'electricityconsumption' && columnName === 'Total Amount')) {
          // Calculated fields - read-only
          input.type = 'number';
          input.readOnly = true;
          input.style.backgroundColor = '#f0f0f0';
          input.style.cursor = 'not-allowed';
        } else if (columnName === 'Type of Disability' || columnName === 'Employee Name' || 
                   (tableId === 'fuelconsumption' && columnName === 'Driver') ||
                   (tableId === 'flightaccommodation' && (columnName === 'Office/Department' || columnName === 'Event Name/Purpose of Travel')) ||
                   (tableId === 'enrollmentdata' && columnName === 'College')) {
          // Text input only - no numbers allowed
          input.type = 'text';
          input.placeholder = 'Enter text';
          const fieldDisplayName = columnName === 'Type of Disability' ? 'Type of Disability' : 
                                   columnName === 'Employee Name' ? 'Employee Name' : 
                                   columnName === 'Driver' ? 'Driver' :
                                   columnName === 'Office/Department' ? 'Office/Department' :
                                   columnName === 'Event Name/Purpose of Travel' ? 'Event Name/Purpose of Travel' :
                                   columnName === 'College' ? 'College' :
                                   columnName;
          
          input.addEventListener('keypress', function(e) {
            // Block numbers (0-9)
            const char = String.fromCharCode(e.which);
            if (/[0-9]/.test(char)) {
              e.preventDefault();
              // Show error message
              const row = this.closest('tr');
              if (row) {
                ReportApp.showToast(`Numbers are not allowed in ${fieldDisplayName} field. Only letters and text are permitted.`, 'error');
              }
            }
          });
          // Also prevent paste of numbers
          input.addEventListener('paste', function(e) {
            const pastedText = (e.clipboardData || window.clipboardData).getData('text');
            if (/[0-9]/.test(pastedText)) {
              e.preventDefault();
              ReportApp.showToast(`Cannot paste: Numbers are not allowed in ${fieldDisplayName} field. Only letters and text are permitted.`, 'error');
            }
          });
          // Create error message container
          const errorMsg = document.createElement('div');
          errorMsg.className = 'field-error-message';
          errorMsg.style.display = 'none';
          errorMsg.style.color = '#dc3545';
          errorMsg.style.fontSize = '12px';
          errorMsg.style.marginTop = '4px';
          errorMsg.style.fontWeight = '500';
          
          // Validate on change to catch any remaining numbers
          input.addEventListener('blur', function(e) {
            const value = this.value;
            const row = this.closest('tr');
            const rowIndex = Array.from(row.parentElement.children).indexOf(row) + 1;
            
            if (value && /[0-9]/.test(value)) {
              // Field is invalid - highlight prominently
              this.style.borderColor = '#dc3545';
              this.style.borderWidth = '2px';
              this.style.boxShadow = '0 0 0 0.2rem rgba(220, 53, 69, 0.25)';
              this.setAttribute('data-invalid', 'true');
              
              // Show error message below input
              errorMsg.textContent = `Numbers are not allowed. Only letters and text are permitted.`;
              errorMsg.style.display = 'block';
              
              // Highlight the row
              row.style.backgroundColor = 'rgba(220, 53, 69, 0.1)';
              row.setAttribute('data-has-error', 'true');
              
              // Scroll to field if needed
              const rect = this.getBoundingClientRect();
              const isVisible = rect.top >= 0 && rect.bottom <= window.innerHeight;
              if (!isVisible) {
                this.scrollIntoView({ behavior: 'smooth', block: 'center' });
              }
              
              const fieldName = columnName === 'Type of Disability' ? 'Type of Disability' : 
                                columnName === 'Employee Name' ? 'Employee Name' :
                                columnName === 'Office/Department' ? 'Office/Department' :
                                columnName === 'Event Name/Purpose of Travel' ? 'Event Name/Purpose of Travel' :
                                columnName === 'College' ? 'College' :
                                columnName;
              ReportApp.showToast(`${fieldName}: Only letters and text are allowed. Numbers are not permitted.`, 'error');
            } else if (value && !/[0-9]/.test(value)) {
              // Field is valid - show success message
              this.style.borderColor = '#28a745';
              this.style.borderWidth = '1px';
              this.style.boxShadow = '';
              this.removeAttribute('data-invalid');
              errorMsg.style.display = 'none';
              
              // Remove row highlight
              row.style.backgroundColor = '';
              row.removeAttribute('data-has-error');
              
              // Show success notification only if it was previously invalid
              if (this.getAttribute('data-was-invalid') === 'true') {
                const fieldName = columnName === 'Type of Disability' ? 'Type of Disability' : 
                                  columnName === 'Employee Name' ? 'Employee Name' :
                                  columnName === 'Office/Department' ? 'Office/Department' :
                                  columnName === 'Event Name/Purpose of Travel' ? 'Event Name/Purpose of Travel' :
                                  columnName === 'College' ? 'College' :
                                  columnName;
                ReportApp.showToast(`${fieldName} field is now valid.`, 'success');
                this.removeAttribute('data-was-invalid');
              }
            } else {
              this.style.borderColor = '';
              this.style.borderWidth = '';
              this.style.boxShadow = '';
              this.removeAttribute('data-invalid');
              errorMsg.style.display = 'none';
              row.style.backgroundColor = '';
              row.removeAttribute('data-has-error');
            }
          });
          
          // Also check on input for real-time validation
          input.addEventListener('input', function(e) {
            const value = this.value;
            if (value && /[0-9]/.test(value)) {
              this.setAttribute('data-was-invalid', 'true');
            }
          });
          
          // Add error message container to cell
          const cell = input.closest('td');
          if (cell) {
            cell.style.position = 'relative';
            cell.appendChild(errorMsg);
          }
          
          // Track if field was invalid
          input.addEventListener('keypress', function(e) {
            if (this.getAttribute('data-invalid') === 'true') {
              this.setAttribute('data-was-invalid', 'true');
            }
          });
          
          input.addEventListener('input', function(e) {
            const value = this.value;
            if (value && /[0-9]/.test(value)) {
              this.setAttribute('data-was-invalid', 'true');
            }
          });
        } else {
          input.type = 'text';
          // Add placeholder for regular text inputs if not already set
          if (!input.placeholder) {
            input.placeholder = 'Enter text';
          }
        }
        
        // Preserve existing classes (like start-mileage, end-mileage, total-km) when setting className
        const existingClasses = input.className ? input.className.split(' ').filter(c => c.trim()) : [];
        const baseClasses = 'form-control form-control-sm';
        const allClasses = [...new Set([...existingClasses, ...baseClasses.split(' ')])].filter(c => c.trim()).join(' ');
        input.className = allClasses;
        input.name = columnName;
        // Don't set value for auto-calculated Total KM field
        if (input.dataset.autoCalculated !== 'true') {
          input.value = cellValue;
        }
        
        // Set placeholder based on field type if not already set
        if (!input.placeholder && input.type === 'number') {
          input.placeholder = 'Enter number';
        } else if (!input.placeholder && input.type === 'text') {
          input.placeholder = 'Enter text';
        }
        
        // Add peso sign prefix for Price/m^3 and Total Amount columns in waterconsumption table
        // and Price/kWh and Total Amount columns in electricityconsumption table
        if ((tableId === 'waterconsumption' && (columnName === 'Price/m^3' || columnName === 'Total Amount')) ||
            (tableId === 'electricityconsumption' && (columnName === 'Price/kWh' || columnName === 'Total Amount'))) {
          const pesoWrapper = document.createElement('div');
          pesoWrapper.style.position = 'relative';
          pesoWrapper.style.width = '100%';
          
          const pesoSign = document.createElement('span');
          pesoSign.textContent = '₱';
          pesoSign.style.position = 'absolute';
          pesoSign.style.left = '10px';
          pesoSign.style.color = '#495057';
          pesoSign.style.fontWeight = '500';
          pesoSign.style.zIndex = '10';
          pesoSign.style.pointerEvents = 'none';
          pesoSign.style.fontSize = 'inherit';
          pesoSign.style.lineHeight = 'inherit';
          
          // Ensure input text is visible with proper padding and width
          input.style.paddingLeft = '28px';
          input.style.width = '100%';
          
          pesoWrapper.appendChild(pesoSign);
          pesoWrapper.appendChild(input);
          td.appendChild(pesoWrapper);
          
          // Position peso sign after input is rendered to match text baseline
          setTimeout(() => {
            const inputStyle = window.getComputedStyle(input);
            const inputPaddingTop = parseFloat(inputStyle.paddingTop);
            const inputLineHeight = parseFloat(inputStyle.lineHeight) || parseFloat(inputStyle.fontSize) * 1.5;
            const textCenter = inputPaddingTop + (inputLineHeight / 2);
            pesoSign.style.top = textCenter + 'px';
            pesoSign.style.transform = 'translateY(-50%)';
          }, 0);
        } else {
          td.appendChild(input);
        }
        
        // Add calculation logic for Electricity Consumption table
        if (tableId === 'electricityconsumption') {
          // Function to calculate Actual Consumption, Total Consumption, and Total Amount
          const calculateElectricityConsumption = function() {
            const row = input.closest('tr');
            if (!row) return;
            
            // Get input fields
            const prevReadingInput = row.querySelector('input[name="Prev Reading"]');
            const currentReadingInput = row.querySelector('input[name="Current Reading"]');
            const multiplierInput = row.querySelector('input[name="Multiplier"]');
            const priceInput = row.querySelector('input[name="Price/kWh"]');
            const actualConsumptionInput = row.querySelector('input[name="Actual Consumption"]');
            const totalConsumptionInput = row.querySelector('input[name="Total Consumption"]');
            const totalAmountInput = row.querySelector('input[name="Total Amount"]');
            
            if (prevReadingInput && currentReadingInput && actualConsumptionInput) {
              const prevReading = parseFloat(prevReadingInput.value) || 0;
              const currentReading = parseFloat(currentReadingInput.value) || 0;
              
              // Calculate Actual Consumption = Current Reading - Prev Reading (always positive)
              const actualConsumption = Math.abs(currentReading - prevReading);
              actualConsumptionInput.value = !isNaN(actualConsumption) ? actualConsumption.toFixed(2) : '0.00';
              
              // Calculate Total Consumption = Actual Consumption × Multiplier
              if (multiplierInput && totalConsumptionInput && !isNaN(actualConsumption)) {
                const multiplier = parseFloat(multiplierInput.value) || 0;
                const totalConsumption = actualConsumption * multiplier;
                totalConsumptionInput.value = !isNaN(totalConsumption) ? totalConsumption.toFixed(2) : '0.00';
                
                // Calculate Total Amount = Total Consumption × Price/kWh
                if (priceInput && totalAmountInput && !isNaN(totalConsumption)) {
                  const price = parseFloat(priceInput.value) || 0;
                  const totalAmount = totalConsumption * price;
                  totalAmountInput.value = !isNaN(totalAmount) ? totalAmount.toFixed(2) : '0.00';
                }
              }
            }
          };
          
          // Add event listeners for calculation triggers
          if (columnName === 'Prev Reading' || columnName === 'Current Reading' || columnName === 'Multiplier' || columnName === 'Price/kWh') {
            input.addEventListener('input', calculateElectricityConsumption);
            input.addEventListener('blur', calculateElectricityConsumption);
            input.addEventListener('change', calculateElectricityConsumption);
            // Also trigger calculation when this field gets a value
            setTimeout(calculateElectricityConsumption, 50);
          }
          
          // Always try to calculate on initial load
          setTimeout(calculateElectricityConsumption, 150);
        }
        
        // Add calculation logic for Water Consumption table
        if (tableId === 'waterconsumption') {
          // Function to calculate Quantity and Total Amount
          const calculateWaterConsumption = function() {
            const row = input.closest('tr');
            if (!row) return;
            
            // Get input fields
            const prevReadingInput = row.querySelector('input[name="Prev Reading"]');
            const currentReadingInput = row.querySelector('input[name="Current Reading"]');
            const priceInput = row.querySelector('input[name="Price/m^3"]');
            const quantityInput = row.querySelector('input[name="Quantity (m^3)"]');
            const totalAmountInput = row.querySelector('input[name="Total Amount"]');
            
            if (prevReadingInput && currentReadingInput && quantityInput) {
              const prevReading = parseFloat(prevReadingInput.value) || 0;
              const currentReading = parseFloat(currentReadingInput.value) || 0;
              
              // Calculate Quantity = Prev Reading - Current Reading (as per user requirement)
              // Using absolute value to ensure positive quantity
              const quantity = Math.abs(prevReading - currentReading);
              quantityInput.value = quantity.toFixed(2);
              
              // Calculate Total Amount = Quantity × Price/m^3
              if (priceInput && totalAmountInput) {
                const price = parseFloat(priceInput.value) || 0;
                const totalAmount = quantity * price;
                totalAmountInput.value = totalAmount >= 0 ? totalAmount.toFixed(2) : '0.00';
              }
            }
          };
          
          // Add event listeners for calculation triggers
          if (columnName === 'Prev Reading' || columnName === 'Current Reading' || columnName === 'Price/m^3') {
            input.addEventListener('input', calculateWaterConsumption);
            input.addEventListener('blur', calculateWaterConsumption);
            input.addEventListener('change', calculateWaterConsumption);
          }
          
          // Calculate on initial load if values exist
          if (cellValue) {
            setTimeout(calculateWaterConsumption, 100);
          }
        }
      }
      
      // Add cell to row
      tr.appendChild(td);
    });
    
    // Add action column with delete button only
    const actionTd = document.createElement('td');
    actionTd.className = 'actions-column text-center';
    
    // Add delete button
    const deleteButton = document.createElement('button');
    deleteButton.className = 'btn btn-sm btn-danger';
    deleteButton.title = 'Delete row';
    deleteButton.innerHTML = '<i class="fas fa-trash"></i>';
    deleteButton.onclick = (e) => {
      e.stopPropagation();
      e.preventDefault();
      
      // Use the new confirmDeleteRow method which uses showConfirmDialog
      ReportApp.confirmDeleteRow(tableId, rowIndex, deleteButton)
        .then(confirmed => {
          if (confirmed) {
            // Show loading state on the button
            const originalHTML = deleteButton.innerHTML;
            deleteButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            deleteButton.disabled = true;
            
            // Delete is handled by confirmDeleteRow, but restore button if needed
            setTimeout(() => {
              deleteButton.innerHTML = originalHTML;
              deleteButton.disabled = false;
            }, 500);
          }
        })
        .catch(error => {
          console.error('Error in delete confirmation:', error);
        });
    };
    actionTd.appendChild(deleteButton);
    
    // Add action column to row
    tr.appendChild(actionTd);
    
    // Add row to table body
    tbody.appendChild(tr);
    
    // Calculate Total KM for distance traveled table if this is a distance traveled row
    if (tableId === 'distancetraveled') {
      // Small delay to ensure all inputs are in DOM
      setTimeout(function() {
        calculateTotalKMForRow(tr);
      }, 10);
    }
    
    // Add tooltip functionality to all cells with long text
    addTooltipsToRow(tr);
    
    return tr;
  }
  
  // Function to add tooltips to all rows in a table
  function addTooltipsToTable(table) {
    const rows = table.querySelectorAll('tr');
    rows.forEach(row => {
      addTooltipsToRow(row);
    });
  }
  
  // Function to add tooltips to cells with long text
  function addTooltipsToRow(row) {
    const cells = row.querySelectorAll('td, th');
    cells.forEach(cell => {
      // Check if cell content is long or overflowing
      const cellText = cell.textContent.trim();
      const input = cell.querySelector('input, select, textarea');
      let textToShow = cellText;
      
      // If there's an input, get its value or placeholder
      if (input) {
        if (input.type === 'select-one' || input.tagName === 'SELECT') {
          textToShow = input.options[input.selectedIndex] ? input.options[input.selectedIndex].text : '';
        } else {
          textToShow = input.value || input.placeholder || cellText;
        }
      }
      
      // Always add tooltip capability for cells with inputs or long text
      // Check if text is long (more than 20 characters) or if cell is overflowing or has an input
      if (textToShow.length > 20 || cell.scrollWidth > cell.clientWidth || input) {
        cell.title = textToShow;
        cell.style.cursor = 'help';
        cell.style.position = 'relative';
        
        // Function to get current text
        const getCurrentText = () => {
          let currentText = cell.textContent.trim();
          const currentInput = cell.querySelector('input, select, textarea');
          if (currentInput) {
            if (currentInput.tagName === 'SELECT') {
              currentText = currentInput.options[currentInput.selectedIndex] ? 
                currentInput.options[currentInput.selectedIndex].text : '';
            } else {
              currentText = currentInput.value || currentInput.placeholder || currentText;
            }
          }
          return currentText;
        };
        
        // Add hover effect
        cell.addEventListener('mouseenter', function(e) {
          const currentText = getCurrentText();
          if (currentText && currentText.length > 0) {
            showCellTooltip(cell, currentText, e);
          }
        });
        
        cell.addEventListener('mouseleave', function() {
          hideCellTooltip();
        });
        
        // Update tooltip when input changes
        if (input) {
          input.addEventListener('input', function() {
            if (currentTooltip && cell.contains(this)) {
              const currentText = getCurrentText();
              if (currentTooltip) {
                currentTooltip.textContent = currentText;
              }
            }
          });
          
          input.addEventListener('change', function() {
            if (currentTooltip && cell.contains(this)) {
              const currentText = getCurrentText();
              if (currentTooltip) {
                currentTooltip.textContent = currentText;
              }
            }
          });
        }
      }
    });
  }
  
  // Global tooltip element
  let currentTooltip = null;
  
  function showCellTooltip(cell, text, event) {
    // Remove existing tooltip if any
    if (currentTooltip) {
      currentTooltip.remove();
    }
    
    // Create tooltip element
    const tooltip = document.createElement('div');
    tooltip.className = 'cell-tooltip';
    tooltip.textContent = text;
    tooltip.style.cssText = `
      position: fixed;
      background-color: rgba(0, 0, 0, 0.9);
      color: white;
      padding: 8px 12px;
      border-radius: 4px;
      font-size: 12px;
      z-index: 10000;
      max-width: 300px;
      word-wrap: break-word;
      white-space: normal;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
      pointer-events: none;
      opacity: 0;
      transition: opacity 0.2s;
    `;
    
    document.body.appendChild(tooltip);
    currentTooltip = tooltip;
    
    // Position tooltip near mouse/cell
    const rect = cell.getBoundingClientRect();
    const tooltipRect = tooltip.getBoundingClientRect();
    
    let left = rect.left + (rect.width / 2) - (tooltipRect.width / 2);
    let top = rect.top - tooltipRect.height - 10;
    
    // Adjust if tooltip goes off screen
    if (left < 10) left = 10;
    if (left + tooltipRect.width > window.innerWidth - 10) {
      left = window.innerWidth - tooltipRect.width - 10;
    }
    if (top < 10) {
      top = rect.bottom + 10;
    }
    
    tooltip.style.left = left + 'px';
    tooltip.style.top = top + 'px';
    
    // Fade in
    setTimeout(() => {
      tooltip.style.opacity = '1';
    }, 10);
  }
  
  function hideCellTooltip() {
    if (currentTooltip) {
      currentTooltip.style.opacity = '0';
      setTimeout(() => {
        if (currentTooltip && currentTooltip.parentNode) {
          currentTooltip.remove();
        }
        currentTooltip = null;
      }, 200);
    }
  }
  
  // Calculate Total KM for distance traveled table
  function calculateTotalKMForRow(row) {
    if (!row) {
      console.log('calculateTotalKMForRow: No row provided');
      return;
    }
    
    // Try multiple selector strategies
    const startMileageInput = row.querySelector('.start-mileage') || 
                              row.querySelector('input[name="Start Mileage"]') ||
                              Array.from(row.querySelectorAll('input[type="number"]')).find(input => 
                                input.name === 'Start Mileage' || input.placeholder && input.placeholder.includes('Start'));
    
    const endMileageInput = row.querySelector('.end-mileage') || 
                            row.querySelector('input[name="End Mileage"]') ||
                            Array.from(row.querySelectorAll('input[type="number"]')).find(input => 
                              input.name === 'End Mileage' || input.placeholder && input.placeholder.includes('End'));
    
    const totalKMInput = row.querySelector('.total-km') || 
                         row.querySelector('input[name="Total KM"]') ||
                         Array.from(row.querySelectorAll('input[readonly]')).find(input => 
                           input.name === 'Total KM' || input.placeholder === 'Auto-calculated');
    
    if (!startMileageInput || !endMileageInput || !totalKMInput) {
      console.log('calculateTotalKMForRow: Missing inputs', {
        start: !!startMileageInput,
        end: !!endMileageInput,
        total: !!totalKMInput,
        rowHTML: row.innerHTML.substring(0, 200) // First 200 chars for debugging
      });
      // Try to find all inputs in the row
      const allInputs = row.querySelectorAll('input');
      console.log('All inputs in row:', Array.from(allInputs).map(inp => ({
        name: inp.name,
        className: inp.className,
        type: inp.type,
        readonly: inp.readOnly
      })));
      return;
    }
    
    const startMileageStr = startMileageInput.value ? startMileageInput.value.trim() : '';
    const endMileageStr = endMileageInput.value ? endMileageInput.value.trim() : '';
    
    const startMileage = startMileageStr ? parseFloat(startMileageStr) : NaN;
    const endMileage = endMileageStr ? parseFloat(endMileageStr) : NaN;
    
    console.log('calculateTotalKMForRow:', {
      startMileageStr: startMileageStr,
      endMileageStr: endMileageStr,
      startMileage: startMileage,
      endMileage: endMileage,
      isNaNStart: isNaN(startMileage),
      isNaNEnd: isNaN(endMileage)
    });
    
    // Calculate: Total KM = Start Mileage - End Mileage
    // Only calculate if both values are valid numbers
    if (!isNaN(startMileage) && !isNaN(endMileage) && startMileageStr !== '' && endMileageStr !== '') {
      const totalKM = startMileage - endMileage;
      totalKMInput.value = totalKM.toFixed(2);
      console.log('calculateTotalKMForRow: Set Total KM to', totalKM.toFixed(2), '(Start:', startMileage, '- End:', endMileage, ')');
    } else {
      totalKMInput.value = '';
      console.log('calculateTotalKMForRow: Cleared Total KM - Start:', startMileageStr || 'empty', 'End:', endMileageStr || 'empty');
    }
  }
  
  // Make function accessible globally for debugging
  window.calculateTotalKMForRow = calculateTotalKMForRow;

  // Calculate Total for Campus Population row: sum of Students + IS Students + Employees + Canteen + Construction
  function calculateCampusPopulationTotal(row) {
    if (!row) return;
    const getInt = (name) => {
      const inp = row.querySelector(`input[name="${name}"]`) || row.querySelector(`input[name="${name.replace(/\s+/g,'_')}"]`);
      const v = inp && inp.value ? inp.value.trim() : '';
      return v === '' ? 0 : parseInt(v, 10) || 0;
    };
    const students = getInt('Students');
    const isStudents = getInt('IS Students');
    const employees = getInt('Employees');
    const canteen = getInt('Canteen');
    const construction = getInt('Construction');
    const total = students + isStudents + employees + canteen + construction;
    const totalInput = row.querySelector('input[name="Total"]') || row.querySelector('input.campus-total');
    if (totalInput) totalInput.value = String(total);
  }
  window.calculateCampusPopulationTotal = calculateCampusPopulationTotal;
  
  // Function to submit report data with confirmation
  const submitReportData = async function(tableId) {
    const submitBtn = document.querySelector('#submitReportBtn');
    const originalBtnText = submitBtn ? submitBtn.innerHTML : '';
    
    return new Promise((resolve) => {
      showConfirmation(
        'Are you sure you want to submit this report? This action cannot be undone.',
        async () => {
          try {
            // Show loading state
            if (submitBtn) {
              submitBtn.disabled = true;
              submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
            }

            // Get user data including office and campus
            let userData;
            try {
              userData = await ReportApp.getUserData();
              console.log('User data retrieved:', userData);
            } catch (error) {
              console.error('Authentication error:', error);
              // If we're here, getUserData has already handled the redirect
              resolve(false);
              return;
            }
            
            if (!userData) {
              console.error('No user data available');
              ReportApp.showToast('Error: Could not retrieve user information. Please log in again.', 'error');
              resolve(false);
              return;
            }
            
            // Get form data
            const form = document.querySelector('form');
            if (!form) {
              throw new Error('Form element not found');
            }
            
            // Validate empty required fields and empty rows for all tables
            const tableBody = document.querySelector(`#${tableId} tbody`);
            if (tableBody) {
              const tableConfig = config[tableId];
              const rowElements = tableBody.querySelectorAll('tr');
              const emptyRows = [];
              const emptyRequiredFields = [];
              let hasAnyData = false;
              
              // Check each row
              rowElements.forEach((row, rowIndex) => {
                let rowHasData = false;
                let rowHasEmptyRequired = false;
                const emptyFieldsInRow = [];
                
                // Check if row has any data (excluding ID field)
                const inputs = row.querySelectorAll('input, select, textarea');
                inputs.forEach(input => {
                  const fieldName = input.name || input.id;
                  const inputType = input.type;
                  const value = input.value ? input.value.trim() : '';
                  
                  // Skip ID fields, hidden fields, and checkboxes that are not checked
                  if (fieldName && 
                      fieldName !== 'ID' && 
                      fieldName !== 'action' && 
                      fieldName !== 'table' &&
                      inputType !== 'hidden') {
                    
                    // For select elements, check if not empty and not default "Select" option
                    if (input.tagName === 'SELECT') {
                      if (value && value !== '' && !value.toLowerCase().includes('select')) {
                        rowHasData = true;
                        hasAnyData = true;
                      }
                    } 
                    // For other inputs, check if not empty
                    else if (value && value !== '') {
                      rowHasData = true;
                      hasAnyData = true;
                    }
                  }
                });
                
                // If row has data, check for empty required fields
                if (rowHasData && tableConfig && tableConfig.requiredFields) {
                  const requiredFields = tableConfig.requiredFields || [];
                  requiredFields.forEach(fieldName => {
                    // Try different name formats
                    let input = row.querySelector(`input[name="${fieldName}"]`) ||
                                row.querySelector(`select[name="${fieldName}"]`) ||
                                row.querySelector(`textarea[name="${fieldName}"]`) ||
                                row.querySelector(`input[name="${fieldName.replace(/\s+/g, '_')}"]`) ||
                                row.querySelector(`select[name="${fieldName.replace(/\s+/g, '_')}"]`) ||
                                row.querySelector(`input[name="${fieldName.replace(/\//g, '-')}"]`) ||
                                row.querySelector(`select[name="${fieldName.replace(/\//g, '-')}"]`);
                    
                    if (input) {
                      const value = input.value ? input.value.trim() : '';
                      const isEmpty = !value || 
                                     value === '' || 
                                     value.toLowerCase().includes('select') ||
                                     value === 'Choose' ||
                                     value === 'Choose...';
                      
                      if (isEmpty) {
                        rowHasEmptyRequired = true;
                        emptyFieldsInRow.push(fieldName);
                        
                        // Highlight the empty field
                        input.style.borderColor = '#dc3545';
                        input.style.borderWidth = '2px';
                        input.style.boxShadow = '0 0 0 0.2rem rgba(220, 53, 69, 0.25)';
                        
                        // Highlight the row
                        row.style.backgroundColor = 'rgba(220, 53, 69, 0.1)';
                        row.style.outline = '2px solid #dc3545';
                        row.setAttribute('data-has-error', 'true');
                      }
                    }
                  });
                } else if (!rowHasData) {
                  // Empty row detected (no data at all)
                  emptyRows.push(rowIndex + 1);
                  row.style.backgroundColor = 'rgba(220, 53, 69, 0.15)';
                  row.style.outline = '2px solid #dc3545';
                  row.setAttribute('data-has-error', 'true');
                }
                
                if (rowHasEmptyRequired) {
                  emptyRequiredFields.push({
                    row: rowIndex + 1,
                    fields: emptyFieldsInRow
                  });
                }
              });
              
              // Check if table is completely empty (no rows or no data in any row)
              if (rowElements.length === 0) {
                throw new Error('Cannot submit: Table is empty. Please add data before submitting.');
              }
              
              if (!hasAnyData && rowElements.length > 0) {
                throw new Error('Cannot submit: Table is empty. Please add data before submitting.');
              }
              
              // Show error if there are empty rows or empty required fields
              if (emptyRows.length > 0 || emptyRequiredFields.length > 0) {
                let errorMessage = 'Cannot submit: ';
                const errors = [];
                
                if (emptyRows.length > 0) {
                  const rowText = emptyRows.length === 1 ? 'row' : 'rows';
                  errors.push(`Empty ${rowText} detected (${emptyRows.join(', ')}). Please add data or remove empty rows.`);
                }
                
                if (emptyRequiredFields.length > 0) {
                  emptyRequiredFields.forEach(item => {
                    const fieldsText = item.fields.length === 1 ? 'field' : 'fields';
                    errors.push(`Row ${item.row}: Empty required ${fieldsText} - ${item.fields.join(', ')}`);
                  });
                }
                
                errorMessage += errors.join(' ');
                
                // Scroll to first error
                const firstErrorRow = tableBody.querySelector('tr[data-has-error="true"]');
                if (firstErrorRow) {
                  firstErrorRow.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
                
                throw new Error(errorMessage);
              }
            } else {
              throw new Error('Cannot submit: Table not found. Please refresh the page and try again.');
            }
            
            // Validate Type of Disability field for PWD table - must not contain numbers
            if (tableId === 'pwd') {
              if (tableBody) {
                const rowElements = tableBody.querySelectorAll('tr');
                let hasInvalidTypeOfDisability = false;
                let invalidRowIndex = -1;
                
                rowElements.forEach((row, index) => {
                  const input = row.querySelector('input[name="Type of Disability"]') || 
                               row.querySelector('input[name="Type_of_Disability"]');
                  if (input) {
                    const value = input.value;
                    if (value && /[0-9]/.test(value)) {
                      hasInvalidTypeOfDisability = true;
                      invalidRowIndex = index + 1; // 1-based index for user display
                      input.style.borderColor = '#dc3545';
                      input.setAttribute('data-invalid', 'true');
                    }
                  }
                });
                
                if (hasInvalidTypeOfDisability) {
                  // Find and highlight all invalid fields
                  const invalidRows = [];
                  rowElements.forEach((row, index) => {
                    const input = row.querySelector('input[name="Type of Disability"]') || 
                                 row.querySelector('input[name="Type_of_Disability"]');
                    if (input) {
                      const value = input.value;
                      if (value && /[0-9]/.test(value)) {
                        const rowNum = index + 1;
                        invalidRows.push(rowNum);
                        
                        // Highlight the field prominently
                        input.style.borderColor = '#dc3545';
                        input.style.borderWidth = '2px';
                        input.style.boxShadow = '0 0 0 0.2rem rgba(220, 53, 69, 0.25)';
                        input.setAttribute('data-invalid', 'true');
                        
                        // Highlight the entire row
                        row.style.backgroundColor = 'rgba(220, 53, 69, 0.15)';
                        row.style.outline = '2px solid #dc3545';
                        row.setAttribute('data-has-error', 'true');
                        
                        // Show or update error message below input
                        let errorMsg = row.querySelector('.field-error-message');
                        if (!errorMsg) {
                          errorMsg = document.createElement('div');
                          errorMsg.className = 'field-error-message';
                          errorMsg.style.color = '#dc3545';
                          errorMsg.style.fontSize = '12px';
                          errorMsg.style.marginTop = '4px';
                          errorMsg.style.fontWeight = '500';
                          const cell = input.closest('td');
                          if (cell) {
                            cell.style.position = 'relative';
                            cell.appendChild(errorMsg);
                          }
                        }
                        errorMsg.textContent = `Numbers are not allowed. Only letters and text are permitted.`;
                        errorMsg.style.display = 'block';
                      }
                    }
                  });
                  
                  // Scroll to first invalid row
                  if (invalidRows.length > 0) {
                    const firstInvalidRow = tableBody.querySelector(`tr[data-has-error="true"]`);
                    if (firstInvalidRow) {
                      firstInvalidRow.scrollIntoView({ behavior: 'smooth', block: 'center' });
                      const firstInvalidInput = firstInvalidRow.querySelector('input[data-invalid="true"]');
                      if (firstInvalidInput) {
                        setTimeout(() => {
                          firstInvalidInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        }, 300);
                      }
                    }
                  }
                  
                  const rowsText = invalidRows.length === 1 
                    ? `row ${invalidRows[0]}` 
                    : `rows ${invalidRows.join(', ')}`;
                  
                  throw new Error(`Cannot Submit: Type of Disability field(s) contain numbers. Numbers are not allowed. Only letters and text are permitted. Please remove all numbers before submitting.`);
                }
              }
            }
            
            const formData = new FormData(form);
            const submissionData = Object.fromEntries(formData.entries());
            submissionData.tableId = tableId;
            
            // Add user data to submission
            if (userData.office) submissionData.office = userData.office;
            if (userData.campus) submissionData.campus = userData.campus;
            
            // Auto-detect base path
            const basePath = getBasePath();
            
            // Send the data to the server
            const apiUrl = `${basePath}/api/submit-report.php`;
            console.log('Submit report API URL:', apiUrl);
            const response = await fetch(apiUrl, {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
              },
              body: JSON.stringify(submissionData)
            });
            
            if (!response.ok) {
              const error = await response.json().catch(() => ({}));
              throw new Error(error.message || 'Failed to submit report');
            }
            
            const result = await response.json();
            
            if (result.success) {
              console.log('Report submitted successfully:', result);
              ReportApp.showToast('Report submitted successfully!', 'success');
              
              // Clear draft after successful submission
              ReportApp.clearDraft(tableId);
              
              // Redirect if needed
              if (result.redirect) {
                window.location.href = result.redirect;
              }
              resolve(true);
            } else {
              throw new Error(result.message || 'Failed to submit report');
            }
          } catch (error) {
            console.error('Error submitting report:', error);
            ReportApp.showToast(`Error: ${error.message || 'An error occurred while submitting the report'}`, 'error');
            resolve(false);
          } finally {
            // Reset button state
            if (submitBtn) {
              submitBtn.disabled = false;
              submitBtn.innerHTML = originalBtnText;
            }
          }
        },
        () => {
          // User cancelled
          console.log('Report submission cancelled');
          resolve(false);
        },
        {
          title: 'Submit Report',
          confirmText: 'Yes, submit',
          cancelText: 'No, cancel',
          confirmButtonClass: 'btn-primary',
          icon: 'fa-paper-plane',
          showCloseButton: true
        }
      );
    });
  };

  // Public API
  const ReportApp = {
    // Initialize with empty methods that will be defined later
    addRow: function() { console.error('addRow not yet initialized'); },
    addTableRow: function() { console.error('addTableRow not yet initialized'); },
    deleteRow: function() { console.error('deleteRow not yet initialized'); },
    saveRow: function(tableId, rowIndex, button) {
      // Implementation for saving a specific row
      ReportApp.showToast('Row saved successfully', 'success');
    },
    
    editRow: function(tableId, rowIndex, button) {
      const row = button.closest('tr');
      const inputs = row.querySelectorAll('input, select, textarea');
      
      // Toggle between view and edit mode
      if (row.classList.contains('editing')) {
        // Save changes
        const rowData = {};
        inputs.forEach(input => {
          rowData[input.name] = input.value;
        });
        
        // Here you can add code to save the changes to the server
        console.log('Saving row data:', rowData);
        
        // Exit edit mode
        row.classList.remove('editing');
        button.innerHTML = '<i class="fas fa-edit"></i>';
        
        // Show success message
        ReportApp.showToast('Changes saved successfully', 'success');
      } else {
        // Enter edit mode
        row.classList.add('editing');
        button.innerHTML = '<i class="fas fa-save"></i>';
      }
    },
    // Core methods
    init: init,
    showToast: showToast,
    closeModal: closeModal,
    showModal: showModal,
    getConfig: function() { return config; },
    getTables: function() { return tables; },
    
    // Table operations
    showTable: showTable,
    addTableRow: addTableRow,
    submitReportData: submitReportData,
    addRow: addRow,
    deleteRow: deleteRow,
    saveRow: saveRow,
    saveState: saveState,
    adjustColumnWidths: adjustColumnWidths,
    
    // Auto-draft functionality
    saveDraft: function(tableId) {
      try {
        const tbody = document.getElementById(`${tableId}Body`);
        if (!tbody) return;
        
        const rows = tbody.querySelectorAll('tr');
        const draftData = [];
        
        rows.forEach((row, rowIndex) => {
          const rowData = {};
          const inputs = row.querySelectorAll('input, select, textarea');
          
          inputs.forEach(input => {
            const fieldName = input.name || input.id;
            if (fieldName && fieldName !== 'ID' && input.type !== 'hidden') {
              const value = input.value ? input.value.trim() : '';
              if (value) {
                rowData[fieldName] = value;
              }
            }
          });
          
          // Only save row if it has data
          if (Object.keys(rowData).length > 0) {
            draftData.push(rowData);
          }
        });
        
        // Save to localStorage with table ID as key
        const draftKey = `report_draft_${tableId}`;
        localStorage.setItem(draftKey, JSON.stringify({
          tableId: tableId,
          data: draftData,
          timestamp: new Date().toISOString()
        }));
        
        console.log('Draft saved for', tableId, 'with', draftData.length, 'rows');
      } catch (error) {
        console.error('Error saving draft:', error);
      }
    },
    
    restoreDraft: function(tableId) {
      try {
        const draftKey = `report_draft_${tableId}`;
        const draftJson = localStorage.getItem(draftKey);
        
        if (!draftJson) {
          return false;
        }
        
        const draft = JSON.parse(draftJson);
        if (!draft.data || draft.data.length === 0) {
          return false;
        }
        
        // Check if draft is older than 30 days (optional cleanup)
        const draftDate = new Date(draft.timestamp);
        const daysDiff = (Date.now() - draftDate.getTime()) / (1000 * 60 * 60 * 24);
        if (daysDiff > 30) {
          localStorage.removeItem(draftKey);
          return false;
        }
        
        // Show restore notification
        ReportApp.showToast('Draft found! Restoring your previous work...', 'info');
        
        // Restore data after a short delay to ensure table is ready
        setTimeout(() => {
          const tbody = document.getElementById(`${tableId}Body`);
          if (!tbody) {
            console.warn('Table body not found for draft restoration');
            return;
          }
          
          // Clear existing rows (except first empty row if exists)
          const existingRows = tbody.querySelectorAll('tr');
          existingRows.forEach((row, index) => {
            // Keep first row if it's empty, remove others
            if (index > 0 || (index === 0 && row.querySelectorAll('input[value], select[value]').length > 0)) {
              row.remove();
            }
          });
          
          // Restore each row from draft
          draft.data.forEach((rowData, index) => {
            ReportApp.addTableRow(tableId, rowData, index, true);
          });
          
          // Re-attach auto-save listeners after restoration
          setTimeout(() => {
            ReportApp.attachAutoSaveListeners(tableId);
          }, 300);
          
          ReportApp.showToast(`Draft restored: ${draft.data.length} row(s) loaded`, 'success');
        }, 500);
        
        return true;
      } catch (error) {
        console.error('Error restoring draft:', error);
        return false;
      }
    },
    
    clearDraft: function(tableId) {
      try {
        const draftKey = `report_draft_${tableId}`;
        localStorage.removeItem(draftKey);
        console.log('Draft cleared for', tableId);
      } catch (error) {
        console.error('Error clearing draft:', error);
      }
    },
    
    attachAutoSaveListeners: function(tableId) {
      try {
        const tbody = document.getElementById(`${tableId}Body`);
        if (!tbody) return;
        
        // Check if already attached
        if (tbody.dataset.autoSaveAttached === 'true') {
          return;
        }
        
        // Mark as attached
        tbody.dataset.autoSaveAttached = 'true';
        
        // Debounce function to limit save frequency
        let saveTimeout;
        const debouncedSave = () => {
          clearTimeout(saveTimeout);
          saveTimeout = setTimeout(() => {
            ReportApp.saveDraft(tableId);
          }, 2000); // Save 2 seconds after last change
        };
        
        // Use event delegation on tbody to catch all input events
        // This works for existing and future inputs
        tbody.addEventListener('change', (e) => {
          if (e.target.matches('input, select, textarea')) {
            debouncedSave();
          }
        });
        
        tbody.addEventListener('input', (e) => {
          if (e.target.matches('input, select, textarea')) {
            debouncedSave();
          }
        });
        
        tbody.addEventListener('keyup', (e) => {
          if (e.target.matches('input, select, textarea')) {
            debouncedSave();
          }
        });
        
        console.log('Auto-save listeners attached for', tableId);
      } catch (error) {
        console.error('Error attaching auto-save listeners:', error);
      }
    },
    
    // User-related methods
    // Get user's campus from server and store in sessionStorage
    getUserCampus: function() {
      return new Promise((resolve) => {  
        // 1. Try to get from URL parameters first (most reliable if coming from dashboard)
        const urlParams = new URLSearchParams(window.location.search);
        const campusFromUrl = urlParams.get('campus');
        
        if (campusFromUrl) {
          console.log('Using campus from URL:', campusFromUrl);
          sessionStorage.setItem('userCampus', campusFromUrl);
          return resolve(campusFromUrl);
        }

        // 2. Try to get from session storage
        const cachedCampus = sessionStorage.getItem('userCampus') || localStorage.getItem('userCampus');
        if (cachedCampus) {
          console.log('Using cached campus:', cachedCampus);
          return resolve(cachedCampus);
        }

        // 3. If not in cache, try to get from page elements
        const pageCampus = document.querySelector('[data-campus]')?.dataset.campus || 
                          document.querySelector('meta[name="campus"]')?.content;
        if (pageCampus) {
          console.log('Using campus from page element:', pageCampus);
          sessionStorage.setItem('userCampus', pageCampus);
          return resolve(pageCampus);
        }

        // 4. As a last resort, try to fetch from server
        const basePath = getBasePath();
        const apiUrl = `${basePath}/api/auth.php?action=getUserCampus`;
        
        console.log('Fetching campus from server...');
        
        // Add timeout to prevent hanging
        const controller = new AbortController();
        const timeoutId = setTimeout(() => controller.abort(), 5000);
        
        fetch(apiUrl, {
          signal: controller.signal,
          credentials: 'include',
          headers: {
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'X-Requested-With': 'XMLHttpRequest'
          }
        })
        .then(response => {
          clearTimeout(timeoutId);
          if (!response.ok) {
            console.warn('Campus fetch failed with status:', response.status);
            return null; 
          }
          return response.json();
        })
        .then(data => {
          if (data?.campus) {
            const campus = data.campus.trim();
            console.log('Fetched campus from server:', campus);
            sessionStorage.setItem('userCampus', campus);
            resolve(campus);
          } else {
            console.warn('No valid campus data in response');
            resolve('Main'); 
          }
        })
        .catch(error => {
          clearTimeout(timeoutId);
          if (error.name === 'AbortError') {
            console.warn('Campus fetch timed out, using default campus');
          } else {
            console.warn('Error fetching campus, using default:', error.message);
          }
          resolve('Main'); 
        });
      });
    },
    
    // Adjust column widths for better table layout
    adjustColumnWidths: function(table) {
      if (!table) return;
      console.log('Adjusting column widths for table:', table.id);
      
      // Force table to auto-layout to calculate natural widths
      table.style.tableLayout = 'auto';
      
      // Get all header cells
      const headerCells = table.querySelectorAll('th');
      if (!headerCells.length) {
        console.warn('No header cells found in table');
        return;
      }
      
      // Get all data rows (skip the header row)
      const dataRows = table.querySelectorAll('tbody tr');
      
      // Calculate max width for each column
      const colWidths = [];
      
      // First pass: calculate max width for each column
      headerCells.forEach((th, colIndex) => {
        // Include header cell in width calculation
        let maxWidth = this.calculateCellWidth(th);
        
        // Check all cells in this column
        dataRows.forEach(row => {
          const cell = row.cells[colIndex];
          if (cell) {
            const cellWidth = this.calculateCellWidth(cell);
            maxWidth = Math.max(maxWidth, cellWidth);
          }
        });
        
        // Add some padding and ensure minimum width
        colWidths[colIndex] = Math.min(Math.max(maxWidth + 20, 100), 400);
      });
      
      // Second pass: apply the calculated widths
      headerCells.forEach((th, colIndex) => {
        if (colWidths[colIndex] !== undefined) {
          const width = colWidths[colIndex] + 'px';
          
          // Set width for header cell
          th.style.width = width;
          th.style.minWidth = width;
          th.style.maxWidth = width;
          
          // Set width for all cells in this column
          const cells = Array.from(dataRows).map(row => row.cells[colIndex]).filter(Boolean);
          cells.forEach(cell => {
            cell.style.width = width;
            cell.style.minWidth = width;
            cell.style.maxWidth = width;
            cell.style.overflow = 'hidden';
            cell.style.textOverflow = 'ellipsis';
            cell.style.whiteSpace = 'nowrap';
          });
          
          console.log(`Column ${colIndex + 1} width set to: ${width}`);
        }
      });
      
      // Set table layout to fixed for better performance
      table.style.tableLayout = 'fixed';
      
      // Force a reflow to ensure widths are applied
      table.offsetHeight;
    },
    // App initialization
    init: init,
    
    // Show success message
    showSuccessMessage: function() {
      showToast('Operation completed successfully', 'success');
    },
    
    // Show toast message
    showToast: showToast,
    
    // Close modal
    closeModal: closeModal,
    
    // Show modal
    showModal: showModal,
    
    // Data access
    config: config,
    tables: tables,
    getConfig: function() { return config; },
    getTables: function() { return tables; },
    
    // Load initial data
    loadInitialData: function() {
      console.log('Loading initial data...');
      
      // Load data for each table from localStorage
      Object.keys(tables).forEach(tableId => {
        try {
          const savedData = localStorage.getItem(`table_${tableId}`);
          if (savedData) {
            tables[tableId].data = JSON.parse(savedData);
            console.log(`Loaded data for ${tableId}:`, tables[tableId].data);
          }
        } catch (error) {
          console.error(`Error loading data for ${tableId}:`, error);
        }
      });
    },
    
    // Fetch table data from server
    fetchTableData: function(tableId) {
      return new Promise((resolve, reject) => {
        console.log(`Fetching data for table: ${tableId}`);
        
        // Auto-detect base path
        const basePath = getBasePath();
        
        // Fetch data from API
        fetch(`${basePath}/api/get_table_data.php?table=${tableId}`)
          .then(response => {
            if (!response.ok) {
              throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
          })
          .then(result => {
            console.log(`Fetched data for ${tableId}:`, result);
            if (result.success && result.data) {
              // Update table data with fetched data
              if (!tables[tableId]) {
                tables[tableId] = {};
              }
              tables[tableId].data = result.data;
              console.log(`Updated ${tableId} data:`, tables[tableId].data.length, 'rows');
              resolve(result.data);
            } else {
              console.warn(`No data returned for ${tableId}`);
              tables[tableId].data = [];
              resolve([]);
            }
          })
          .catch(error => {
            console.error(`Error fetching data for ${tableId}:`, error);
            // Set empty data on error
            if (!tables[tableId]) {
              tables[tableId] = {};
            }
            tables[tableId].data = [];
            reject(error);
          });
      });
    },
    
    // Show table
    showTable: function(tableId) {
      console.log(`Attempting to show table: ${tableId}`);
      console.log('Available tables:', Object.keys(tables));
      
      if (!tableId) {
        console.error('No table ID provided');
        return false;
      }
      
      const table = tables[tableId];
      if (!table) {
        console.error(`Table '${tableId}' not found. Available tables:`, Object.keys(tables));
        return false;
      }
      
      // Ensure dom.tablesContainer is initialized
      if (!dom.tablesContainer) {
        console.warn('dom.tablesContainer not initialized, attempting to initialize...');
        initElements();
        // Try again after initialization
          if (!dom.tablesContainer) {
            dom.tablesContainer = document.getElementById('tablesContainer');
            if (!dom.tablesContainer) {
              console.error('tablesContainer element not found in DOM');
              if (typeof window.showError === 'function') {
                window.showError('Error', 'Report container not found. Please refresh the page.');
              } else {
                alert('Error: Report container not found. Please refresh the page.');
              }
              return false;
            }
          }
      }
      
      // Clear existing content
      dom.tablesContainer.innerHTML = '';
      
      // Create a container for the table header (title + add button)
      const headerContainer = document.createElement('div');
      headerContainer.className = 'd-flex justify-content-between align-items-center mb-3';
      headerContainer.style.padding = '0 15px';
      
      // Create a flex container for the title and button
      const headerContent = document.createElement('div');
      headerContent.style.display = 'flex';
      headerContent.style.justifyContent = 'space-between';
      headerContent.style.width = '100%';
      headerContent.style.alignItems = 'center';
      
      // Create table title (on left)
      const tableTitle = document.createElement('div');
      tableTitle.textContent = table.displayName || 'Table';
      tableTitle.style.fontSize = '1.3rem';
      tableTitle.style.fontWeight = '600';
      tableTitle.style.margin = '0';
      tableTitle.style.padding = '0';
      tableTitle.style.lineHeight = '1.2';
      
      // Create buttons container
      const buttonsContainer = document.createElement('div');
      buttonsContainer.style.display = 'flex';
      buttonsContainer.style.gap = '10px';
      buttonsContainer.style.marginLeft = 'auto'; // This will push the container to the right
      
      // Ensure we have the ReportApp instance for event handlers
      const reportApp = window.ReportApp;
      
      // Create add button
      const addButton = document.createElement('button');
      addButton.type = 'button';
      addButton.className = 'btn btn-primary btn-sm';
      addButton.innerHTML = '<i class="fas fa-plus"></i> Add Row';
      addButton.onclick = (e) => {
        e.preventDefault();
        e.stopPropagation();
        this.addRow(tableId);
      };
      
      // Create submit button
      const submitButton = document.createElement('button');
      submitButton.type = 'button';
      submitButton.className = 'btn btn-primary btn-sm';
      submitButton.id = 'submitReportBtn';
      submitButton.innerHTML = '<i class="fas fa-paper-plane"></i> Submit Report';
      submitButton.style.cssText = `
        background: linear-gradient(135deg, #dc143c 0%, #c82333 100%);
        color: white;
        border: none;
        padding: 14px 32px;
        font-weight: 600;
        font-size: 15px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(220, 20, 60, 0.3);
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 10px;
        cursor: pointer;
      `;
      
      // Add hover effect
      submitButton.addEventListener('mouseenter', () => {
        submitButton.style.transform = 'translateY(-2px)';
        submitButton.style.boxShadow = '0 6px 20px rgba(220, 20, 60, 0.4)';
      });
      
      submitButton.addEventListener('mouseleave', () => {
        submitButton.style.transform = 'translateY(0)';
        submitButton.style.boxShadow = '0 4px 15px rgba(220, 20, 60, 0.3)';
      });
      submitButton.onclick = (e) => {
        e.preventDefault();
        e.stopPropagation();
        
        // Use the modern confirmation dialog
        ReportApp.confirmSubmit(tableId)
          .then(confirmed => {
            if (confirmed) {
              // Show loading state
              submitButton.disabled = true;
              const originalText = submitButton.innerHTML;
              submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
              
              // The actual submission is handled by confirmSubmit
              // Just restore button state after a delay if needed
              setTimeout(() => {
                if (submitButton.disabled) {
                  submitButton.disabled = false;
                  submitButton.innerHTML = originalText;
                }
              }, 1000);
            }
          })
          .catch(error => {
            console.error('Error in submit confirmation:', error);
          });
      };
      
      // Add buttons to container
      buttonsContainer.appendChild(addButton);
      buttonsContainer.appendChild(submitButton);
      
      // Add title and buttons container to header content
      headerContent.appendChild(tableTitle);
      headerContent.appendChild(buttonsContainer);
      
      // Add header content to container
      headerContainer.appendChild(headerContent);
      
      // Add header container to the page
      dom.tablesContainer.appendChild(headerContainer);
      
      // Add spacing between header and table
      const spacingDiv = document.createElement('div');
      spacingDiv.style.height = '30px'; // Increased from 15px to 30px for more space
      dom.tablesContainer.appendChild(spacingDiv);
      
      // Create responsive container for the table with fixed height and internal scroll
      const tableResponsive = document.createElement('div');
      tableResponsive.className = 'table-responsive';
      tableResponsive.style.maxHeight = 'calc(100vh - 230px)'; // Adjusted for the extra space
      tableResponsive.style.overflowY = 'auto';
      tableResponsive.style.marginTop = '10px'; // Additional top margin
      
      // Create table element with fixed layout and sticky headers
      const tableEl = document.createElement('table');
      tableEl.id = tableId;
      tableEl.className = 'table table-bordered table-striped table-hover mb-0';
      tableEl.style.tableLayout = 'fixed';
      tableEl.style.width = '100%';
      
      // Create table header with sticky positioning
      const thead = document.createElement('thead');
      const headerRow = document.createElement('tr');
      headerRow.className = 'table-primary';
      thead.style.position = 'sticky';
      thead.style.top = '0';
      thead.style.zIndex = '10';
      
      // Add header cells based on table configuration
      table.columns.forEach(column => {
        if (column === 'ID') return; // Skip ID column in display
        
        const th = document.createElement('th');
        th.textContent = column.replace(/_/g, ' '); // Replace underscores with spaces
        th.setAttribute('data-column', column);
        th.style.whiteSpace = 'nowrap';
        headerRow.appendChild(th);
      });
      
      // Add action column header
      const actionTh = document.createElement('th');
      actionTh.textContent = 'Actions';
      actionTh.className = 'actions-column text-center';
      headerRow.appendChild(actionTh);
      
      thead.appendChild(headerRow);
      tableEl.appendChild(thead);
      
      // Create table body
      const tbody = document.createElement('tbody');
      tbody.id = `${tableId}Body`;
      
      // Add the table to the DOM
      tableEl.appendChild(tbody);
      tableResponsive.appendChild(tableEl);
      
      // Add the table to the page
      dom.tablesContainer.appendChild(tableResponsive);
      
      // Fetch fresh data from server
      this.fetchTableData(tableId).then(() => {
        // Clear existing rows first
        const tbodyEl = document.getElementById(`${tableId}Body`);
        if (tbodyEl) {
          tbodyEl.innerHTML = '';
        }
        
        // Add existing rows to the table after data is fetched
        if (table.data && table.data.length > 0) {
          table.data.forEach((row, index) => {
            this.addTableRow(tableId, row, index, false);
          });
        } else {
          // Add an empty row if no data exists
          // Use setTimeout to ensure the table is fully rendered
          setTimeout(() => {
            this.addRow(tableId);
          }, 0);
        }
      }).catch(error => {
        console.error('Error fetching table data:', error);
        // Fallback to empty row if fetch fails
        setTimeout(() => {
          this.addRow(tableId);
        }, 0);
      });
      
      // Calculate and set column widths after table is rendered
      setTimeout(() => {
        this.adjustColumnWidths(tableEl);
      }, 100);
      
      return true;
    },
    
    // Add a new row to the table
    addRow: addRow,
    
    // Add a single row to the table
    addTableRow: function(tableId, rowData, rowIndex, isNew = true) {
      console.log('=== ReportApp.addTableRow called ===', {tableId, rowIndex, isNew, rowData});
      const table = tables[tableId];
      if (!table) {
        console.error('Table not found:', tableId);
        return null;
      }
      
      // Get user's campus from sessionStorage if available
      const userCampus = sessionStorage.getItem('userCampus') || '';
      
      const tbody = document.getElementById(`${tableId}Body`);
      const thead = document.querySelector(`#${tableId} thead`);
      if (!tbody || !thead) {
        console.error('Table body or head not found for table:', tableId);
        return null;
      }
      
      // Get the header cells to match the column structure
      const headerCells = thead.querySelectorAll('th');
      
      const tr = document.createElement('tr');
      const rowId = rowData.ID || `new-${Date.now()}-${rowIndex}`;
      tr.setAttribute('data-row-id', rowId);
      
      console.log('Adding row with data:', rowData);
      if (tableId === 'admissiondata') {
        console.log('Processing admissiondata row. Columns:', table.columns);
        console.log('Row data keys:', Object.keys(rowData));
      }
      
      // SPECIAL HANDLING FOR ADMISSION DATA AND ENROLLMENT DATA TABLES
      if (tableId === 'admissiondata' || tableId === 'enrollmentdata') {
        console.log(`=== ${tableId.toUpperCase()} TABLE - SPECIAL HANDLING ===`);
        console.log('Row data:', rowData);
        console.log('Table columns:', table.columns);
        console.log('Table columnConfigs:', table.columnConfigs);
        console.log('Table columnConfigs keys:', Object.keys(table.columnConfigs || {}));
        console.log(`Config.${tableId}.columnConfigs:`, config[tableId]?.columnConfigs);
        console.log(`Config.${tableId}.columnConfigs keys:`, Object.keys(config[tableId]?.columnConfigs || {}));
        
        // Process each column for admission/enrollment data
        table.columns.forEach((columnName, colIndex) => {
          // Skip ID column in display
          if (columnName === 'ID') {
            tr.dataset.rowId = rowData[columnName] || rowData['id'] || rowData['ID'] || rowId;
            return;
          }
          
          const td = document.createElement('td');
          // Get value from rowData - try multiple key formats
          let cellValue = rowData[columnName] || rowData[columnName.toLowerCase()] || rowData[columnName.toUpperCase()] || '';
          
          console.log(`Processing ${tableId} column: ${columnName}, value: ${cellValue}`);
          
          // CAMPUS COLUMN - AUTO-FILLED WITH USER'S CAMPUS (READ-ONLY)
          if (columnName === 'Campus' || columnName.toLowerCase() === 'campus') {
            console.log(`>>> CREATING CAMPUS INPUT (AUTO-FILLED) FOR ${tableId.toUpperCase()}`);
            
            // Resolve campus: URL param > sessionStorage > existing cell > default
            const userCampus = (new URLSearchParams(window.location.search).get('campus')) || sessionStorage.getItem('userCampus') || cellValue || 'Main';
            
            // Create read-only input field
            const input = document.createElement('input');
            input.type = 'text';
            input.className = 'form-control form-control-sm';
            input.name = 'Campus';
            input.id = `campus-input-${rowId}-${colIndex}`;
            input.style.width = '100%';
            input.readOnly = true;
            input.style.backgroundColor = '#f8f9fa';
            input.style.cursor = 'not-allowed';
            
            // Set value to user's campus
            if (userCampus) {
              input.value = userCampus;
              rowData['Campus'] = userCampus;
              console.log(`Campus auto-filled with user's campus: ${userCampus}`);
            } else {
              // Keep existing cell value; do not auto-fetch or warn
              input.value = cellValue || '';
              rowData['Campus'] = cellValue || '';
            }
            
            // Add change event to update rowData if value changes
            input.addEventListener('change', (e) => {
              rowData['Campus'] = e.target.value;
              this.saveState();
            });
            
            td.appendChild(input);
            tr.appendChild(td);
            console.log(`Campus input created for ${tableId} with value: ${input.value}`);
            return;
          }
          
          // MALE/FEMALE COLUMNS - MUST BE NUMBER ONLY
          if (columnName === 'Male' || columnName === 'Female' || columnName.toLowerCase() === 'male' || columnName.toLowerCase() === 'female') {
            console.log(`>>> CREATING NUMBER INPUT FOR ${columnName} IN ADMISSION DATA`);
            const input = document.createElement('input');
            input.type = 'number';
            input.min = '0';
            input.step = '1';
            input.className = 'form-control form-control-sm';
            input.name = columnName;
            input.placeholder = 'Enter number';
            
            if (cellValue) {
              input.value = cellValue;
            }
            
            // Prevent non-numeric input
            input.addEventListener('keypress', function(e) {
              if (e.key === '-' || e.key === '+' || e.key === 'e' || e.key === 'E' || e.key === '.' || e.key === ',') {
                e.preventDefault();
              }
            });
            
            input.addEventListener('input', function(e) {
              this.value = this.value.replace(/[^0-9]/g, '');
            });
            
            input.addEventListener('paste', function(e) {
              e.preventDefault();
              const pasted = (e.clipboardData || window.clipboardData).getData('text');
              this.value = pasted.replace(/[^0-9]/g, '');
            });
            
            input.addEventListener('change', (e) => {
              rowData[columnName] = e.target.value;
              this.saveState();
            });
            
            td.appendChild(input);
            tr.appendChild(td);
            console.log(`${columnName} number input created`);
            return;
          }
          
          // OTHER COLUMNS - Handle based on columnConfigs
          // Try multiple sources for column config
          let columnConfig = null;
          
          // Try from table.columnConfigs first
          if (table && table.columnConfigs && table.columnConfigs[columnName]) {
            columnConfig = table.columnConfigs[columnName];
            console.log(`Using columnConfig from table.columnConfigs for ${columnName}`);
          }
          // Try from config.admissiondata.columnConfigs
          else if (config && config.admissiondata && config.admissiondata.columnConfigs && config.admissiondata.columnConfigs[columnName]) {
            columnConfig = config.admissiondata.columnConfigs[columnName];
            console.log(`Using columnConfig from config.admissiondata.columnConfigs for ${columnName}`);
          }
          
          // ALWAYS check for campus column FIRST - never create dropdown for campus
          if (columnName === 'Campus' || columnName.toLowerCase() === 'campus') {
            console.log(`Campus column detected in columnConfig handling - creating read-only input for ${tableId}`);
            // Get user campus from sessionStorage
            const userCampus = sessionStorage.getItem('userCampus') || cellValue || '';
            
            // Create read-only input field
            const input = document.createElement('input');
            input.type = 'text';
            input.className = 'form-control form-control-sm';
            input.name = columnName;
            input.readOnly = true;
            input.style.backgroundColor = '#f8f9fa';
            input.style.cursor = 'not-allowed';
            
            // Set value to user's campus
            if (userCampus) {
              input.value = userCampus;
              if (rowData) {
                rowData[columnName] = userCampus;
              }
              console.log(`Campus auto-filled with user's campus: ${userCampus}`);
            } else {
              // Keep existing cell value; do not auto-fetch or warn
              input.value = cellValue || '';
              if (rowData) {
                rowData[columnName] = cellValue || '';
              }
            }
            
            td.appendChild(input);
            tr.appendChild(td);
            return; // Skip to next column - campus handled
          }
          
          // Safety check: Campus should NEVER use config-based select - always handled above
          if (columnName === 'Campus' || columnName.toLowerCase() === 'campus') {
            console.error('ERROR: Campus column reached columnConfig select creation - should have been handled earlier!');
            // This should not happen, but create read-only input as fallback
            const userCampus = (new URLSearchParams(window.location.search).get('campus')) || sessionStorage.getItem('userCampus') || cellValue || 'Main';
            const input = document.createElement('input');
            input.type = 'text';
            input.className = 'form-control form-control-sm';
            input.name = columnName;
            input.readOnly = true;
            input.style.backgroundColor = '#f8f9fa';
            input.style.cursor = 'not-allowed';
            input.value = userCampus;
            if (rowData) {
              rowData[columnName] = userCampus;
            }
            td.appendChild(input);
            tr.appendChild(td);
            return;
          }
          
          if (columnConfig && columnConfig.type === 'select') {
            // Create select dropdown (NOT for campus - campus is handled above)
            const select = document.createElement('select');
            select.className = 'form-control form-control-sm';
            select.name = columnName;
            
            const options = columnConfig.options || [];
            if (options.length === 0) {
              console.warn(`No options found for ${columnName} in admissiondata`);
            }
            
            options.forEach(opt => {
              const option = document.createElement('option');
              option.value = opt.value || '';
              option.textContent = opt.label || opt.value || '';
              if ((opt.value || '') === (cellValue || '')) {
                option.selected = true;
              }
              select.appendChild(option);
            });
            
            select.addEventListener('change', (e) => {
              rowData[columnName] = e.target.value;
              this.saveState();
            });
            
            td.appendChild(select);
          } else {
            // Regular text input
            const input = document.createElement('input');
            input.type = 'text';
            input.className = 'form-control form-control-sm';
            input.name = columnName;
            input.value = cellValue;
            input.placeholder = `Enter ${columnName}`;
            
            input.addEventListener('change', (e) => {
              rowData[columnName] = e.target.value;
              this.saveState();
            });
            
            td.appendChild(input);
          }
          
          tr.appendChild(td);
        });
        
        // Add action buttons
        const actionsTd = document.createElement('td');
        actionsTd.className = 'actions-column text-center';
        const actionsDiv = document.createElement('div');
        actionsDiv.className = 'action-buttons';
        
        const deleteBtn = document.createElement('button');
        deleteBtn.type = 'button';
        deleteBtn.className = 'btn btn-danger btn-sm';
        deleteBtn.innerHTML = '<i class="fas fa-trash"></i>';
        deleteBtn.onclick = () => {
          if (confirm('Are you sure you want to delete this row?')) {
            const index = table.data.findIndex(r => (r.ID || r.id) === rowId);
            if (index !== -1) {
              table.data.splice(index, 1);
              this.saveState();
              tr.remove();
            }
          }
        };
        
        actionsDiv.appendChild(deleteBtn);
        actionsTd.appendChild(actionsDiv);
        tr.appendChild(actionsTd);
        
        // Add row to table
        tbody.appendChild(tr);
        console.log(`${tableId} row added successfully`);
        return;
      }
      
      // REGULAR HANDLING FOR OTHER TABLES
      // Loop removed as requested
      
      // Create action buttons cell
      const actionsTd = document.createElement('td');
      actionsTd.className = 'actions-column text-center';
      
      const actionsDiv = document.createElement('div');
      actionsDiv.className = 'action-buttons';
      
      // Only add delete button (no save/check button)
      // Add delete button
      const deleteBtn = document.createElement('button');
      deleteBtn.type = 'button';
      deleteBtn.className = 'btn btn-danger btn-sm';
      deleteBtn.title = 'Delete this row';
      deleteBtn.innerHTML = '<i class="fas fa-trash"></i>';
      deleteBtn.onclick = (e) => {
        e.preventDefault();
        if (confirm('Are you sure you want to delete this row?')) {
          const reportApp = window.ReportApp || this;
          reportApp.deleteRow(tableId, rowIndex, deleteBtn);
        }
      };
      actionsDiv.appendChild(deleteBtn);
      actionsTd.appendChild(actionsDiv);
      tr.appendChild(actionsTd);
      
      // Add the row to the table
      tbody.appendChild(tr);
      
      // Focus the first input if it's a new row
      if (isNew) {
        const firstInput = tr.querySelector('input, select');
        if (firstInput) {
          firstInput.focus();
          
          // Add a small delay to handle dropdowns
          if (firstInput.tagName === 'SELECT') {
            setTimeout(() => {
              firstInput.click(); // Open dropdown if it's a select element
            }, 100);
          }
        }
      }
      
      return tr;
    },
    
    // Get user data from session or server
    getUserData: function() {
      return new Promise((resolve, reject) => {
        // Try to get user data from session storage first
        const sessionData = {
          id: sessionStorage.getItem('userId'),
          username: sessionStorage.getItem('username'),
          email: sessionStorage.getItem('email'),
          role: sessionStorage.getItem('role') || 'user',
          campus: sessionStorage.getItem('campus') || 'Main',
          office: sessionStorage.getItem('office') || 'Default Office'
        };
        
        // If we have valid session data, use it
        if (sessionData.id) {
          console.log('Using cached user data from session storage');
          return resolve(sessionData);
        }

        console.log('Session data incomplete, checking with server...');
        
        // Auto-detect base path
        const basePath = getBasePath();
        const apiUrl = `${basePath}/api/auth.php?action=check_session`;
        
        console.log('Making request to:', apiUrl);
        
        // Set a timeout to prevent hanging
        const controller = new AbortController();
        const timeoutId = setTimeout(() => controller.abort(), 5000); // 5 second timeout
        
        fetch(apiUrl, {
          method: 'GET',
          credentials: 'include',
          signal: controller.signal,
          headers: {
            'Accept': 'application/json',
            'Cache-Control': 'no-cache',
            'X-Requested-With': 'XMLHttpRequest'
          }
        })
        .then(response => {
          console.log('Auth response status:', response.status);
          clearTimeout(timeoutId); // Clear the timeout since we got a response
          
          if (response.status === 401) {
            // Handle unauthorized - session expired
            console.log('Session expired, preparing to redirect to login');
            sessionStorage.clear();
            
            // Get current path and search parameters
            let currentPath = window.location.pathname;
            const searchParams = window.location.search;
            
            // Remove any leading /rework/ from the path
            currentPath = currentPath.replace(/^\/rework\//, '/');
            
            // Build the return URL (current page + search params)
            const returnUrl = currentPath + searchParams;
            
            // Build the login URL with the correct path
            const loginUrl = `/rework/login.html?return=${encodeURIComponent(returnUrl)}`;
            
            console.log('Redirecting to:', loginUrl);
            
            // Add a small delay to ensure any pending operations complete
            setTimeout(() => {
              window.location.href = loginUrl;
            }, 100);
            
            return Promise.reject(new Error('Not authenticated'));
          }
          
          if (!response.ok) {
            console.error('Auth check failed with status:', response.status);
            return response.text().then(text => {
              console.error('Auth check error response:', text);
              try {
                const errData = JSON.parse(text);
                throw new Error(errData.message || 'Failed to check session');
              } catch (e) {
                throw new Error(`Auth check failed: ${response.status} ${response.statusText}`);
              }
            });
          }
          
          return response.json();
        })
        .then(data => {
          if (data && data.success && data.user) {
            // Store in session storage for future use
            const user = data.user;
            sessionStorage.setItem('user_id', user.id || '');
            sessionStorage.setItem('username', user.username || '');
            sessionStorage.setItem('user_email', user.email || '');
            sessionStorage.setItem('user_role', user.role || 'user');
            sessionStorage.setItem('user_campus', user.campus || '');
            sessionStorage.setItem('user_office', user.office || '');
            
            console.log('User data retrieved from server:', user);
            
            if (!user.office) {
              this.showToast('Error: No office assigned to your account. Please contact your administrator.', 'error');
              return reject(new Error('No office assigned'));
            }
            
            resolve(user);
          } else {
            throw new Error(data && data.message ? data.message : 'Invalid response format');
          }
        })
        .catch(error => {
          console.error('Error in getUserData:', error);
          reject(error);
        });
      });
    },
    
    // Public API
    
    // Show confirmation dialog before submitting
    confirmSubmit: function(tableId) {
      // Use the global confirm dialog if available, otherwise fallback to browser's confirm
      if (window.showConfirmDialog) {
        return showConfirmDialog({
          title: 'Confirm Submission',
          message: 'Are you sure you want to submit this report?',
          subtitle: 'This action cannot be undone',
          confirmText: 'Submit',
          cancelText: 'Cancel',
          type: 'info',
          icon: 'paper-plane'
        }).then(confirmed => {
          if (confirmed) {
            return this.submitReportData(tableId);
          }
          return false;
        }).catch(error => {
          console.error('Error in confirm submit:', error);
          this.showToast('Error confirming submission', 'error');
          return false;
        });
      } else {
        // Fallback to browser's confirm
        if (confirm('Are you sure you want to submit this report?')) {
          return this.submitReportData(tableId);
        }
        return Promise.resolve(false);
      }
    },
    
    // Submit report data
    submitReportData: async function(tableId) {
      const submitBtn = document.querySelector('#submitReportBtn');
      const originalBtnText = submitBtn ? submitBtn.innerHTML : '';
      const basePath = getBasePath();
      
      try {
        // Show loading state
        if (submitBtn) {
          submitBtn.disabled = true;
          submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
        }

        // Get and log all URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        console.log('All URL parameters:', Object.fromEntries(urlParams.entries()));
        
        // Get office and campus from URL parameters
        let office = urlParams.get('office');
        let campus = urlParams.get('campus');
        console.log('Raw office from URL:', JSON.stringify(office));
        console.log('Raw campus from URL:', JSON.stringify(campus));
        
        // Ensure office is set, default to 'RGO' if not found
        if (!office) {
          office = 'RGO';
          console.warn('No office specified in URL, defaulting to RGO');
        } else {
          // Clean up the office value
          office = office.toString().trim().toUpperCase();
          console.log('Using office from URL:', office);
        }
        
        // Debug: Log all URL parameters
        console.log('All URL parameters:', {
          office: office,
          campus: campus,
          fullUrl: window.location.href,
          search: window.location.search
        });
        
        // Ensure campus is set, default to 'Main' if not found
        if (!campus) {
          campus = 'Main';
          console.warn('No campus specified in URL, defaulting to Main');
        }
        
        // Log the values being used
        console.log('Using office:', office, 'campus:', campus);
        
        // Create user data object with the extracted values
        // Ensure office is properly formatted and validated
        const userData = {
          office: office.toString().trim().toUpperCase(), // Force uppercase and trim
          campus: campus ? campus.toString().trim() : 'Main', // Ensure campus is a string
          id: 'system', // System user ID
          source: 'report-form',
          timestamp: new Date().toISOString()
        };
        
        console.log('User data prepared for submission:', JSON.stringify(userData, null, 2));

        // Validate empty required fields and empty rows for all tables FIRST
        // DO THIS BEFORE collecting rows to prevent submission
        // This checks the actual DOM table, not just the rows array
        let tableBody = document.querySelector(`#${tableId} tbody`);
        let rows = []; // Declare rows outside the if block so it's accessible later
        if (tableBody) {
          const tableConfig = config[tableId];
          const rowElements = tableBody.querySelectorAll('tr');
          const emptyRows = [];
          const emptyRequiredFields = [];
          let hasAnyData = false;
          
          // FIRST: Clear all previous error markers and styling before validation
          rowElements.forEach(row => {
            row.removeAttribute('data-has-error');
            row.style.backgroundColor = '';
            row.style.outline = '';
            const inputs = row.querySelectorAll('input, select, textarea');
            inputs.forEach(input => {
              input.style.borderColor = '';
              input.style.borderWidth = '';
              input.style.boxShadow = '';
              input.removeAttribute('data-invalid');
            });
          });
          
          // Check each row
          rowElements.forEach((row, rowIndex) => {
            let rowHasData = false;
            let rowHasEmptyRequired = false;
            const emptyFieldsInRow = [];
            
            // Check if row has any data (excluding ID field)
            const inputs = row.querySelectorAll('input, select, textarea');
            inputs.forEach(input => {
              const fieldName = input.name || input.id;
              const inputType = input.type;
              const value = input.value ? input.value.trim() : '';
              
              // Skip ID fields, hidden fields, and checkboxes that are not checked
              if (fieldName && 
                  fieldName !== 'ID' && 
                  fieldName !== 'action' && 
                  fieldName !== 'table' &&
                  inputType !== 'hidden') {
                
                // For select elements, check if not empty and not default "Select" option
                if (input.tagName === 'SELECT') {
                  if (value && value !== '' && !value.toLowerCase().includes('select')) {
                    rowHasData = true;
                    hasAnyData = true;
                  }
                } 
                // For other inputs, check if not empty
                else if (value && value !== '') {
                  rowHasData = true;
                  hasAnyData = true;
                }
              }
            });
            
            // If row has data, check for empty fields - ALL columns must be filled
            // Get all expected columns from table config
            const expectedColumns = tableConfig && tableConfig.columns ? tableConfig.columns.filter(col => col !== 'ID') : [];
            
            // Check ALL columns for empty values - no empty columns allowed
            if (rowHasData && expectedColumns.length > 0) {
              // ALWAYS check ALL columns - no empty columns allowed
              expectedColumns.forEach(fieldName => {
                // Try different name formats
                let input = row.querySelector(`input[name="${fieldName}"]`) ||
                            row.querySelector(`select[name="${fieldName}"]`) ||
                            row.querySelector(`textarea[name="${fieldName}"]`) ||
                            row.querySelector(`input[name="${fieldName.replace(/\s+/g, '_')}"]`) ||
                            row.querySelector(`select[name="${fieldName.replace(/\s+/g, '_')}"]`) ||
                            row.querySelector(`input[name="${fieldName.replace(/\//g, '-')}"]`) ||
                            row.querySelector(`select[name="${fieldName.replace(/\//g, '-')}"]`);
                
                if (input) {
                  const value = input.value ? input.value.trim() : '';
                  const isEmpty = !value || 
                                 value === '' || 
                                 value.toLowerCase().includes('select') ||
                                 value === 'Choose' ||
                                 value === 'Choose...' ||
                                 (input.tagName === 'SELECT' && (value === '' || value === null));
                  
                  if (isEmpty) {
                    rowHasEmptyRequired = true;
                    emptyFieldsInRow.push(fieldName);
                    
                    // Highlight the empty field
                    input.style.borderColor = '#dc3545';
                    input.style.borderWidth = '2px';
                    input.style.boxShadow = '0 0 0 0.2rem rgba(220, 53, 69, 0.25)';
                    
                    // Highlight the row
                    row.style.backgroundColor = 'rgba(220, 53, 69, 0.1)';
                    row.style.outline = '2px solid #dc3545';
                    row.setAttribute('data-has-error', 'true');
                  }
                } else {
                  // Input not found for this column - treat as missing
                  rowHasEmptyRequired = true;
                  emptyFieldsInRow.push(fieldName);
                  row.style.backgroundColor = 'rgba(220, 53, 69, 0.1)';
                  row.style.outline = '2px solid #dc3545';
                  row.setAttribute('data-has-error', 'true');
                }
              });
            } else if (!rowHasData) {
              // Empty row detected (no data at all)
              emptyRows.push(rowIndex + 1);
              row.style.backgroundColor = 'rgba(220, 53, 69, 0.15)';
              row.style.outline = '2px solid #dc3545';
              row.setAttribute('data-has-error', 'true');
            }
            
            if (rowHasEmptyRequired) {
              emptyRequiredFields.push({
                row: rowIndex + 1,
                fields: emptyFieldsInRow
              });
            }
          });
          
          // Check if table is completely empty (no rows or no data in any row)
          if (rowElements.length === 0) {
            this.showToast('Cannot submit: Table is empty. Please add data before submitting.', 'error');
            if (submitBtn) {
              submitBtn.disabled = false;
              submitBtn.innerHTML = originalBtnText;
            }
            return;
          }
          
          if (!hasAnyData && rowElements.length > 0) {
            this.showToast('Cannot submit: Table is empty. Please add data before submitting.', 'error');
            if (submitBtn) {
              submitBtn.disabled = false;
              submitBtn.innerHTML = originalBtnText;
            }
            return;
          }
          
          // Show error if there are empty rows or empty/incomplete columns
          if (emptyRows.length > 0 || emptyRequiredFields.length > 0) {
            let errorMessage = 'Cannot submit: ';
            const errors = [];
            
            if (emptyRows.length > 0) {
              const rowText = emptyRows.length === 1 ? 'row' : 'rows';
              errors.push(`Empty ${rowText} detected (${emptyRows.join(', ')}). Please add data or remove empty rows.`);
            }
            
            if (emptyRequiredFields.length > 0) {
              emptyRequiredFields.forEach(item => {
                const fieldsText = item.fields.length === 1 ? 'column' : 'columns';
                errors.push(`Row ${item.row}: Empty ${fieldsText} - ${item.fields.join(', ')}`);
              });
            }
            
            errorMessage += errors.join(' ');
            
            // Scroll to first error
            const firstErrorRow = tableBody.querySelector('tr[data-has-error="true"]');
            if (firstErrorRow) {
              firstErrorRow.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
            
            // Show error toast and prevent submission
            this.showToast(errorMessage, 'error');
            
            // Re-enable submit button
            if (submitBtn) {
              submitBtn.disabled = false;
              submitBtn.innerHTML = originalBtnText;
            }
            
            return; // STOP submission - prevent sending data to server
          }
          
          // Now collect rows AFTER validation passes
          // Since validation passed (we got here), collect all rows that have data
          rows = []; // Reset rows array (already declared above)
          const rowElementsAfterValidation = tableBody.querySelectorAll('tr');
          console.log('Found rows after validation:', rowElementsAfterValidation.length);
          
          rowElementsAfterValidation.forEach((row) => {
            const rowData = {};
            const inputs = row.querySelectorAll('input, select, textarea');
            let rowHasValidData = false;
            
            inputs.forEach(input => {
              const fieldName = input.name || input.id;
              if (fieldName && fieldName !== 'action' && fieldName !== 'table' && fieldName !== 'ID') {
                const value = input.value ? input.value.trim() : '';
                // Only include non-empty values (skip "Select..." options)
                if (value && value !== '' && !value.toLowerCase().includes('select') && value !== 'Choose' && value !== 'Choose...') {
                  rowData[fieldName] = value;
                  rowHasValidData = true;
                }
              }
            });
            
            // Only add row if it has valid data
            if (rowHasValidData && Object.keys(rowData).length > 0) {
              rows.push(rowData);
            }
          });
          
          // Final check - ensure we have at least one valid row
          if (rows.length === 0) {
            this.showToast('Cannot submit: No valid rows with complete data. Please fill in all columns.', 'error');
            if (submitBtn) {
              submitBtn.disabled = false;
              submitBtn.innerHTML = originalBtnText;
            }
            return;
          }
        } else {
          this.showToast('Cannot submit: Table not found. Please refresh the page and try again.', 'error');
          if (submitBtn) {
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalBtnText;
          }
          return;
        }

        // Validate Type of Disability field - must not contain numbers
        if (tableId === 'pwd') {
          let hasInvalidTypeOfDisability = false;
          let invalidRowIndex = -1;
          
          rows.forEach((row, index) => {
            const typeOfDisability = row['Type of Disability'] || row['Type_of_Disability'] || '';
            if (typeOfDisability && /[0-9]/.test(typeOfDisability)) {
              hasInvalidTypeOfDisability = true;
              invalidRowIndex = index + 1; // 1-based index for user display
            }
          });
          
          if (hasInvalidTypeOfDisability) {
            // Find and highlight all invalid fields
            const tableBody = document.querySelector(`#${tableId} tbody`);
            const invalidRows = [];
            
            if (tableBody) {
              const rowElements = tableBody.querySelectorAll('tr');
              rowElements.forEach((row, index) => {
                const input = row.querySelector('input[name="Type of Disability"]') || 
                             row.querySelector('input[name="Type_of_Disability"]');
                if (input) {
                  const value = input.value;
                  if (value && /[0-9]/.test(value)) {
                    const rowNum = index + 1;
                    invalidRows.push(rowNum);
                    
                    // Highlight the field prominently
                    input.style.borderColor = '#dc3545';
                    input.style.borderWidth = '2px';
                    input.style.boxShadow = '0 0 0 0.2rem rgba(220, 53, 69, 0.25)';
                    input.setAttribute('data-invalid', 'true');
                    
                    // Highlight the entire row
                    row.style.backgroundColor = 'rgba(220, 53, 69, 0.15)';
                    row.style.outline = '2px solid #dc3545';
                    row.setAttribute('data-has-error', 'true');
                    
                    // Show or update error message below input
                    let errorMsg = row.querySelector('.field-error-message');
                    if (!errorMsg) {
                      errorMsg = document.createElement('div');
                      errorMsg.className = 'field-error-message';
                      errorMsg.style.color = '#dc3545';
                      errorMsg.style.fontSize = '12px';
                      errorMsg.style.marginTop = '4px';
                      errorMsg.style.fontWeight = '500';
                      const cell = input.closest('td');
                      if (cell) {
                        cell.style.position = 'relative';
                        cell.appendChild(errorMsg);
                      }
                    }
                    errorMsg.textContent = `Numbers are not allowed. Only letters and text are permitted.`;
                    errorMsg.style.display = 'block';
                  }
                }
              });
              
              // Scroll to first invalid row
              if (invalidRows.length > 0) {
                const firstInvalidRow = tableBody.querySelector(`tr[data-has-error="true"]`);
                if (firstInvalidRow) {
                  firstInvalidRow.scrollIntoView({ behavior: 'smooth', block: 'center' });
                  // Also scroll the input field into view
                  const firstInvalidInput = firstInvalidRow.querySelector('input[data-invalid="true"]');
                  if (firstInvalidInput) {
                    setTimeout(() => {
                      firstInvalidInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    }, 300);
                  }
                }
              }
            }
            
            const rowsText = invalidRows.length === 1 
              ? `row ${invalidRows[0]}` 
              : `rows ${invalidRows.join(', ')}`;
            
            this.showToast(`Submission Failed: Type of Disability field(s) contain numbers. Numbers are not allowed. Only letters and text are permitted. Please remove all numbers before submitting.`, 'error');
            return;
          }
        }

        // Ensure we have valid office and campus values
        const submissionOffice = (userData.office || 'RGO').trim().toUpperCase();
        const submissionCampus = (userData.campus || 'Main').trim();
        
        console.log('Preparing submission with:', {
          office: submissionOffice,
          campus: submissionCampus,
          rowCount: rows.length
        });
        
        // Prepare data for submission with proper formatting
        const submissionData = {
          tableName: tableId,
          data: rows,
          description: `Submission for ${tableId}`,
          office: submissionOffice,  // Force uppercase to match server expectations
          campus: submissionCampus,
          userId: 'system',
          submittedBy: 'System',
          timestamp: new Date().toISOString()
        };
        
        // Log the exact data being sent with more details
        console.log('=== SUBMISSION DEBUG INFO ===');
        console.log('Submission URL:', `${basePath}/api/submit_report.php`);
        console.log('Current URL:', window.location.href);
        console.log('URL Parameters:', Object.fromEntries(new URLSearchParams(window.location.search).entries()));
        
        // Create a clean copy of submission data for logging
        const submissionDataForLogging = {
          ...submissionData,
          data: `[${submissionData.data.length} rows]` // Truncate data for cleaner logs
        };
        console.log('Submission Data:', JSON.stringify(submissionDataForLogging, null, 2));
        
        // Skip session update to prevent 401 errors
        console.log('Skipping session update to prevent 401 errors');
        
        console.log('============================');
        // Include office and campus in the URL as parameters
        const apiUrl = new URL(`${basePath}/api/submit_report.php`, window.location.origin);
        apiUrl.searchParams.append('office', office);
        apiUrl.searchParams.append('campus', campus);
        console.log('Final API URL:', apiUrl.toString());
        
        // Log the exact request being sent
        console.log('Sending request to:', apiUrl);
        const requestBody = JSON.stringify(submissionData);
        console.log('Request body:', requestBody);
        
        const response = await fetch(apiUrl, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'X-Debug': 'true'  // Add debug header
          },
          body: requestBody,
          credentials: 'include'  // Important for sending session cookies
        });

        if (!response.ok) {
          // Log detailed error information
          console.error('=== SERVER RESPONSE ERROR ===');
          console.error('Status:', response.status, response.statusText);
          
          // Try to get the response as text first
          let errorText;
          try {
            errorText = await response.text();
            console.error('Response text:', errorText);
            
            // Try to parse as JSON if possible
            try {
              const errorJson = JSON.parse(errorText);
              console.error('Parsed error:', errorJson);
            } catch (e) {
              console.error('Could not parse error as JSON');
            }
          } catch (e) {
            console.error('Could not read response text:', e);
            errorText = 'No error details available';
          }
          
          if (response.status === 400) {
            console.error('Bad Request - Possible issues:');
            console.error('- Missing or invalid office parameter');
            console.error('- Invalid data format');
            console.error('- Server-side validation failed');
          } else if (response.status === 401) {
            console.error('Unauthorized - Session may have expired');
          } else if (response.status === 500) {
            console.error('Server Error - Check server logs for details');
          }
          
          console.error('Request details:', {
            url: apiUrl,
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'X-Requested-With': 'XMLHttpRequest'
            },
            body: requestBody
          });
          
          console.error('===========================');
          
          throw new Error(errorText || `Server responded with status: ${response.status}`);
        }

        const data = await response.json();
        if (data && data.success) {
          this.showToast('Report submitted successfully!', 'success');
          
          // Check if we're in an iframe (report table modal)
          const isInIframe = window.self !== window.top;
          
          if (isInIframe) {
            // Send message to parent window to close the modal
            try {
              window.parent.postMessage({
                type: 'reportSubmitted',
                success: true,
                tableName: tableId,
                message: 'Report submitted successfully!'
              }, '*');
              console.log('Sent message to parent window to close modal');
            } catch (error) {
              console.error('Error sending message to parent:', error);
            }
            
            // Also close after a delay as fallback
            setTimeout(() => {
              try {
                if (window.parent && window.parent.closeReportModal) {
                  window.parent.closeReportModal();
                }
              } catch (error) {
                console.error('Error calling parent closeReportModal:', error);
              }
            }, 1500);
          } else {
            // Close modal if not in iframe (standalone page)
            setTimeout(() => {
              const modal = document.getElementById('reportModal');
              if (modal) {
                const bsModal = bootstrap.Modal.getInstance(modal);
                if (bsModal) {
                  bsModal.hide();
                } else {
                  // Fallback if Bootstrap modal instance not found
                  modal.style.display = 'none';
                  modal.classList.remove('show');
                  document.body.classList.remove('modal-open');
                  const backdrop = document.querySelector('.modal-backdrop');
                  if (backdrop) backdrop.remove();
                }
              }
            }, 1500);
          }
        } else {
          throw new Error(data?.message || 'Failed to submit report');
        }
      } catch (error) {
        console.error('Error submitting report:', error);
        
        // Show error message to user
        const errorMessage = error.message || 'Error submitting report. Please try again.';
        this.showToast(errorMessage, 'error');
      } finally {
        // Restore button state
        if (submitBtn) {
          submitBtn.disabled = false;
          submitBtn.innerHTML = originalBtnText;
        }
      }
    },
    
    // Add a new row
    addRow: function(tableId) {
      console.log('addRow called with tableId:', tableId);
      
      const table = tables[tableId];
      if (!table) {
        console.error('Table not found:', tableId);
        return;
      }
      
      console.log('Table found:', table);
      
      // Create a new row with empty values
      const newRow = { ID: Date.now().toString() };
      console.log('New row created with ID:', newRow.ID);
      
      table.columns.forEach(col => {
        if (col !== 'ID') newRow[col] = '';
      });
      
      // Initialize data array if it doesn't exist
      if (!table.data) {
        console.log('Initializing empty data array for table:', tableId);
        table.data = [];
      }
      
      // Add the new row to the beginning of the data array
      console.log('Adding new row to table data:', newRow);
      table.data.unshift(newRow);
      
      try {
        // Save the data
        console.log('Saving state...');
        this.saveState();
        
        // Add the row to the table
        console.log('Adding row to DOM...');
        this.addTableRow(tableId, newRow, 0, true);
        console.log('Row added successfully');
      } catch (error) {
        console.error('Error in addRow:', error);
      }
    },
    
    // Show confirmation before deleting a row
    confirmDeleteRow: function(tableId, rowIndex, button) {
      // Use the global confirm dialog if available, otherwise fallback to browser's confirm
      if (window.showConfirmDialog) {
        return showConfirmDialog({
          title: 'Confirm Delete',
          message: 'Are you sure you want to delete this row?',
          subtitle: 'This action cannot be undone',
          confirmText: 'Delete',
          cancelText: 'Cancel',
          type: 'danger',
          confirmButtonClass: 'btn-danger',
          icon: 'trash-alt'
        }).then(confirmed => {
          if (confirmed) {
            this.deleteRow(tableId, rowIndex, button);
          }
          return confirmed;
        }).catch(error => {
          console.error('Error in confirm delete:', error);
          this.showToast('Error confirming deletion', 'error');
          return false;
        });
      } else {
        // Fallback to browser's confirm
        if (confirm('Are you sure you want to delete this row?')) {
          this.deleteRow(tableId, rowIndex, button);
          return Promise.resolve(true);
        }
        return Promise.resolve(false);
      }
    },
    
    // Delete a row
    deleteRow: function(tableId, rowIndex, button) {
      const table = tables[tableId];
      if (!table || !table.data) return;
      
      // Remove the row from the data array
      table.data.splice(rowIndex, 1);
      
      // Save the updated data
      this.saveState();
      
      // Remove the row from the DOM
      const row = button.closest('tr');
      if (row) {
        row.remove();
      }
      
      // Show success message
      this.showToast('Row deleted successfully', 'success');
    },
    
    // Save draft
    saveDraft: function() {
      try {
        // Save each table's data to localStorage
        Object.keys(tables).forEach(tableId => {
          const table = tables[tableId];
          if (table && table.data) {
            localStorage.setItem(`table_${tableId}`, JSON.stringify(table.data));
          }
        });
        
        // Silent success
        return true;
      } catch (error) {
        console.error('Error saving draft:', error);
        return false;
      }
    },
    
    
    // Save state (moved to standalone function)
    saveState: saveState,
    
    // Adjust column widths (moved to standalone function)
    adjustColumnWidths: adjustColumnWidths
  };

  // Initialize ReportApp
  function initializeReportApp() {
    try {
      console.log('Initializing ReportApp...');
      
      // Ensure showTable is bound even if init() fails
      if (typeof showTable === 'function' && typeof ReportApp.showTable !== 'function') {
        console.log('Binding showTable as fallback...');
        ReportApp.showTable = showTable.bind(ReportApp);
      }
      
      // Initialize the application
      const initSuccess = init();
      
      if (!initSuccess) {
        console.error('Failed to initialize ReportApp, but showTable should be available');
        // Ensure showTable is still bound
        if (typeof showTable === 'function') {
          ReportApp.showTable = showTable.bind(ReportApp);
        }
        return ReportApp;
      }
      
      console.log('ReportApp initialized successfully');
      console.log('showTable type:', typeof ReportApp.showTable);
      return ReportApp;
    } catch (error) {
      console.error('Error initializing ReportApp:', error);
      console.error('Error stack:', error.stack);
      
      // Ensure showTable is bound even after error
      if (typeof showTable === 'function') {
        console.log('Binding showTable after error...');
        ReportApp.showTable = showTable.bind(ReportApp);
      }
      
      // Try to load table after a delay if tableName is provided
      if (tableName) {
        console.log('Attempting to load table after error:', tableName);
        setTimeout(() => {
          try {
            if (window.ReportApp && typeof window.ReportApp.showTable === 'function') {
              window.ReportApp.showTable(tableName);
            } else {
              console.error('ReportApp or showTable not available after error');
            }
          } catch (e) {
            console.error('Error in table loading after initialization error:', e);
          }
        }, 500);
      } else {
        console.log('No table specified in URL');
      }
      
      // Return ReportApp even if initialization failed
      return ReportApp;
    }
  };
  
  // Make the ReportApp available globally immediately (before initialization)
  // This allows the initialization check to see ReportApp exists
  // CRITICAL: Set this even if there's an error, so the error handler can access it
  try {
    window.ReportApp = ReportApp;
  } catch (e) {
    console.error('Error setting window.ReportApp:', e);
    // Create a minimal ReportApp object as fallback
    window.ReportApp = window.ReportApp || { showTable: function() { console.error('ReportApp not initialized'); } };
  }
  
  // Initialize the ReportApp when the DOM is fully loaded
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function() {
      try {
        initializeReportApp();
        // Ensure window.ReportApp is updated after initialization
        window.ReportApp = ReportApp;
        // Setup autosave/recovery after init
        try { setupReportAutosaveRecovery(); } catch(e) { console.warn('Autosave setup failed:', e); }
      } catch (e) {
        console.error('Error in DOMContentLoaded initialization:', e);
        window.ReportApp = window.ReportApp || ReportApp;
      }
    });
  } else {
    try {
      initializeReportApp();
      // Ensure window.ReportApp is updated after initialization
      window.ReportApp = ReportApp;
      // Setup autosave/recovery after init
      try { setupReportAutosaveRecovery(); } catch(e) { console.warn('Autosave setup failed:', e); }
    } catch (e) {
      console.error('Error in immediate initialization:', e);
      window.ReportApp = window.ReportApp || ReportApp;
    }
  }
  
  return ReportApp;
})();

// ========================================
// Autosave & Recovery for Report Progress
// ========================================
(function(){
  // Build a stable draft key based on table, task and campus
  function buildDraftKey() {
    const params = new URLSearchParams(window.location.search || '');
    const table = (params.get('table') || window.tableName || 'unknown').toString().toLowerCase();
    const taskId = params.get('task_id') || 'none';
    const campus = params.get('campus') || 'all';
    return `report_draft:${table}:${taskId}:${campus}`;
  }

  function collectDraftPayload() {
    try {
      const dataByTable = {};
      if (typeof tables === 'object' && tables) {
        Object.keys(tables).forEach(id => {
          const t = tables[id];
          if (t && Array.isArray(t.data)) {
            dataByTable[id] = t.data;
          }
        });
      }
      return {
        ts: Date.now(),
        url: location.pathname + location.search,
        data: dataByTable
      };
    } catch (e) {
      console.warn('collectDraftPayload failed:', e);
      return null;
    }
  }

  function saveDraftNow() {
    const key = buildDraftKey();
    const payload = collectDraftPayload();
    if (!payload) return;
    try {
      localStorage.setItem(key, JSON.stringify(payload));
    } catch (e) {
      console.warn('saveDraftNow failed:', e);
    }
  }

  let autosaveTimer = null;
  function scheduleAutosave(delayMs = 1500) {
    if (autosaveTimer) clearTimeout(autosaveTimer);
    autosaveTimer = setTimeout(() => {
      try { saveDraftNow(); } catch(e) { console.warn('autosave failed:', e); }
    }, delayMs);
  }

  function attachAutosaveListeners() {
    try {
      document.addEventListener('input', function(e){
        const el = e.target;
        if (!el) return;
        if (el.matches('input, textarea, select, [contenteditable="true"]')) {
          scheduleAutosave(1200);
        }
      }, true);
      window.addEventListener('beforeunload', function(){
        try { saveDraftNow(); } catch(e) {}
      });
    } catch (e) {
      console.warn('attachAutosaveListeners failed:', e);
    }
  }

  function attachLogoutSaveHook() {
    try {
      const selectors = [
        '#logout',
        '#logoutBtn',
        '.logout',
        '.logout-link',
        '[data-action="logout"]',
        'a[href*="logout"]',
        'button[name="logout"]'
      ];

      document.addEventListener('click', function(e){
        const el = e.target && e.target.closest && e.target.closest('a,button');
        if (!el) return;
        let isLogout = false;
        try {
          if (selectors.some(sel => el.matches(sel))) isLogout = true;
        } catch(_) {}
        const href = el.getAttribute && (el.getAttribute('href') || '');
        if (/logout/i.test(href || '')) isLogout = true;
        const marker = ((el.getAttribute && el.getAttribute('name')) || '') + ' ' + (el.id || '') + ' ' + (el.className || '');
        if (/logout/i.test(marker)) isLogout = true;
        if (isLogout) {
          try { saveDraftNow(); } catch(_) {}
        }
      }, true);

      document.addEventListener('submit', function(e){
        const form = e.target;
        if (!form) return;
        let isLogout = false;
        const action = (form.getAttribute && form.getAttribute('action')) || '';
        if (/logout/i.test(action)) isLogout = true;
        if (!isLogout) {
          try { if (form.matches('[data-action="logout"]')) isLogout = true; } catch(_) {}
        }
        if (isLogout) {
          try { saveDraftNow(); } catch(_) {}
        }
      }, true);
    } catch (e) {
      console.warn('attachLogoutSaveHook failed:', e);
    }
  }

  function tryRestoreDraft() {
    const key = buildDraftKey();
    try {
      let raw = localStorage.getItem(key);
      if (!raw) {
        try {
          const params = new URLSearchParams(window.location.search || '');
          const table = (params.get('table') || window.tableName || 'unknown').toString().toLowerCase();
          const prefix = `report_draft:${table}:`;
          let latestKey = null;
          let latestTs = -1;
          for (let i = 0; i < localStorage.length; i++) {
            const k = localStorage.key(i);
            if (k && k.startsWith(prefix)) {
              try {
                const v = JSON.parse(localStorage.getItem(k) || 'null');
                if (v && typeof v.ts === 'number' && v.ts > latestTs) {
                  latestTs = v.ts;
                  latestKey = k;
                  raw = JSON.stringify(v);
                }
              } catch(_) {}
            }
          }
          if (!raw) return;
        } catch(_) { return; }
      }
      const draft = JSON.parse(raw);
      // Silently restore without prompt
      applyDraft(draft);
    } catch (e) {
      console.warn('tryRestoreDraft failed:', e);
    }
  }

  function applyDraft(draft) {
    try {
      const data = draft && draft.data ? draft.data : null;
      if (!data) return;
      if (typeof tables === 'object' && tables) {
        Object.keys(data).forEach(id => {
          if (tables[id]) {
            tables[id].data = Array.isArray(data[id]) ? data[id] : tables[id].data;
          }
        });
      }
      // Persist current state and attempt UI refresh if available
      try { if (window.ReportApp && typeof window.ReportApp.saveState === 'function') window.ReportApp.saveState(); } catch(e){}
      try {
        const p = new URLSearchParams(window.location.search || '');
        const t = p.get('table');
        if (t && window.ReportApp && typeof window.ReportApp.showTable === 'function') {
          window.ReportApp.showTable(t);
        }
      } catch(e){}
      try { if (typeof adjustColumnWidths === 'function') adjustColumnWidths(); } catch(e){}
    } catch (e) {
      console.warn('applyDraft failed:', e);
    }
  }

  // Expose a one-time setup to be called after ReportApp is ready
  window.setupReportAutosaveRecovery = function() {
    attachAutosaveListeners();
    attachLogoutSaveHook();
    // Delay restore slightly to allow initial render
    setTimeout(tryRestoreDraft, 300);
  };
})();
