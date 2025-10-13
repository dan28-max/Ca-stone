// Enhanced User Dashboard with Admin-Style UI
class UserDashboard {
    constructor() {
        this.currentUser = null;
        this.assignedReports = [];
        this.submissions = [];
        this.init();
    }

    async init() {
        console.log('Initializing enhanced user dashboard...');
        
        // Load user session
        await this.loadUserSession();
        
        // Setup event listeners
        this.setupEventListeners();
        
        // Load dashboard data
        await this.loadDashboardData();
        
        console.log('Dashboard initialized successfully');
    }

    async loadUserSession() {
        // Bypass authentication for testing
        // TODO: Implement proper authentication for production
        
        // Get user from session/localStorage
        const userSession = localStorage.getItem('userSession');
        if (userSession) {
            this.currentUser = JSON.parse(userSession);
        } else {
            // Set default test user
            this.currentUser = {
                id: 1,
                name: 'Test User',
                email: 'user@test.com',
                role: 'user',
                office: 'Test Office',
                campus: 'Test Campus'
            };
            // Save to localStorage
            localStorage.setItem('userSession', JSON.stringify(this.currentUser));
        }
        
        this.updateUserInfo();
    }

    updateUserInfo() {
        if (!this.currentUser) return;
        
        // Update user display
        document.getElementById('userName').textContent = this.currentUser.name || 'User';
        document.getElementById('userRole').textContent = this.currentUser.role || 'User';
        
        // Update avatar
        const avatar = document.getElementById('userAvatar');
        if (this.currentUser.name) {
            avatar.textContent = this.currentUser.name.charAt(0).toUpperCase();
        }
    }

    setupEventListeners() {
        // Navigation menu
        document.querySelectorAll('.nav-item').forEach(item => {
            item.addEventListener('click', () => {
                const section = item.dataset.section;
                if (section) {
                    this.showSection(section);
                }
            });
        });
    }

    showSection(sectionId) {
        // Update page title
        const titles = {
            'dashboard': { title: 'Dashboard', subtitle: 'Welcome back! Here\'s your overview' },
            'my-reports': { title: 'My Reports', subtitle: 'All reports assigned to you' },
            'submissions': { title: 'Submissions History', subtitle: 'View all your submitted reports' },
            'notifications': { title: 'Notifications', subtitle: 'Stay updated with important alerts' },
            'analytics': { title: 'My Analytics', subtitle: 'View your performance and submission trends' },
            'profile': { title: 'My Profile', subtitle: 'View and update your profile information' },
            'help': { title: 'Help & Guide', subtitle: 'Learn how to use the system effectively' }
        };
        
        if (titles[sectionId]) {
            document.getElementById('pageTitle').textContent = titles[sectionId].title;
            document.getElementById('pageSubtitle').textContent = titles[sectionId].subtitle;
        }
        
        // Hide all sections
        document.querySelectorAll('.content-section').forEach(section => {
            section.classList.remove('active');
        });
        
        // Show selected section
        const section = document.getElementById(sectionId);
        if (section) {
            section.classList.add('active');
        }
        
        // Update nav items
        document.querySelectorAll('.nav-item').forEach(item => {
            if (item.dataset.section === sectionId) {
                item.classList.add('active');
            } else {
                item.classList.remove('active');
            }
        });
        
        // Load section-specific data
        if (sectionId === 'my-reports') {
            this.loadMyReports();
        } else if (sectionId === 'submissions') {
            this.loadSubmissions();
        } else if (sectionId === 'notifications') {
            this.loadNotifications();
        } else if (sectionId === 'analytics') {
            this.loadAnalytics();
        } else if (sectionId === 'profile') {
            this.loadProfile();
        } else if (sectionId === 'help') {
            this.loadHelp();
        }
    }

    async loadDashboardData() {
        try {
            // Load assigned reports
            await this.loadAssignedReports();
            
            // Update statistics
            this.updateStatistics();
        } catch (error) {
            console.error('Error loading dashboard data:', error);
        }
    }

    async loadAssignedReports() {
        try {
            const response = await fetch('api/user_tasks.php?action=get_assigned');
            
            // Check if response is OK
            if (!response.ok) {
                // API not available, use demo data for testing
                this.assignedReports = this.getDemoReports();
                this.renderAssignedReports();
                return;
            }
            
            const result = await response.json();
            
            if (result.success) {
                this.assignedReports = result.tasks || [];
                this.renderAssignedReports();
            } else {
                // Use demo data
                this.assignedReports = this.getDemoReports();
                this.renderAssignedReports();
            }
        } catch (error) {
            console.error('Error loading assigned reports:', error);
            // Use demo data for testing
            this.assignedReports = this.getDemoReports();
            this.renderAssignedReports();
        }
    }
    
    getDemoReports() {
        // Demo data for testing when API is not available
        return [
            {
                id: 1,
                table_name: 'campuspopulation',
                description: 'Campus Population Report',
                office: 'Registrar Office',
                campus: 'Lipa Campus',
                assigned_at: new Date().toISOString()
            },
            {
                id: 2,
                table_name: 'admissiondata',
                description: 'Admission Data Report',
                office: 'Admissions Office',
                campus: 'Lipa Campus',
                assigned_at: new Date().toISOString()
            },
            {
                id: 3,
                table_name: 'enrollmentdata',
                description: 'Enrollment Data Report',
                office: 'Registrar Office',
                campus: 'Lipa Campus',
                assigned_at: new Date().toISOString()
            }
        ];
    }

    renderAssignedReports() {
        const container = document.getElementById('assignedReportsContainer');
        
        if (this.assignedReports.length === 0) {
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-clipboard-check"></i>
                    <h3>All Caught Up!</h3>
                    <p>You have no pending reports to submit</p>
                </div>
            `;
            return;
        }
        
        const reportsHTML = this.assignedReports.map(report => `
            <div class="report-card">
                <div class="report-card-header">
                    <h3>
                        <i class="fas fa-file-alt"></i>
                        ${this.formatReportName(report.table_name)}
                    </h3>
                    <p>${report.description || 'No description available'}</p>
                </div>
                <div class="report-card-body">
                    <div class="report-meta">
                        <div class="meta-item">
                            <i class="fas fa-building"></i>
                            <span><strong>Office:</strong> ${report.office || 'N/A'}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span><strong>Campus:</strong> ${report.campus || 'N/A'}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-calendar"></i>
                            <span><strong>Assigned:</strong> ${this.formatDate(report.assigned_at)}</span>
                        </div>
                    </div>
                </div>
                <div class="report-card-footer">
                    <span class="status-badge pending">Pending</span>
                    <button class="btn-submit-report" onclick="userDashboard.submitReport('${report.table_name}', ${report.id})">
                        <i class="fas fa-paper-plane"></i>
                        <span>Submit Report</span>
                    </button>
                </div>
            </div>
        `).join('');
        
        container.innerHTML = `<div class="reports-grid">${reportsHTML}</div>`;
    }

    async loadMyReports() {
        const container = document.getElementById('myReportsContainer');
        container.innerHTML = `
            <div class="loading-state">
                <i class="fas fa-spinner fa-spin"></i>
                <p>Loading reports...</p>
            </div>
        `;
        
        await this.loadAssignedReports();
        
        if (this.assignedReports.length === 0) {
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <h3>No Reports</h3>
                    <p>You don't have any reports assigned yet</p>
                </div>
            `;
        } else {
            container.innerHTML = `<div class="reports-grid">${this.renderAllReports()}</div>`;
        }
    }

    renderAllReports() {
        return this.assignedReports.map(report => `
            <div class="report-card">
                <div class="report-card-header">
                    <h3>
                        <i class="fas fa-file-alt"></i>
                        ${this.formatReportName(report.table_name)}
                    </h3>
                    <p>${report.description || 'No description available'}</p>
                </div>
                <div class="report-card-body">
                    <div class="report-meta">
                        <div class="meta-item">
                            <i class="fas fa-building"></i>
                            <span><strong>Office:</strong> ${report.office || 'N/A'}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-calendar"></i>
                            <span><strong>Assigned:</strong> ${this.formatDate(report.assigned_at)}</span>
                        </div>
                    </div>
                </div>
                <div class="report-card-footer">
                    <span class="status-badge ${report.submitted ? 'completed' : 'pending'}">
                        ${report.submitted ? 'Completed' : 'Pending'}
                    </span>
                    ${!report.submitted ? `
                    <button class="btn-submit-report" onclick="userDashboard.submitReport('${report.table_name}', ${report.id})">
                        <i class="fas fa-paper-plane"></i>
                        <span>Submit</span>
                    </button>
                    ` : ''}
                </div>
            </div>
        `).join('');
    }

    async loadSubmissions() {
        const container = document.getElementById('submissionsContainer');
        container.innerHTML = `
            <div class="loading-state">
                <i class="fas fa-spinner fa-spin"></i>
                <p>Loading submissions...</p>
            </div>
        `;
        
        try {
            const response = await fetch('api/user_submissions.php');
            
            // Check if response is OK
            if (!response.ok) {
                // Submissions API not available, use demo data
                this.submissions = this.getDemoSubmissions();
                if (this.submissions.length > 0) {
                    container.innerHTML = `<div class="reports-grid">${this.renderSubmissions()}</div>`;
                } else {
                    container.innerHTML = `
                        <div class="empty-state">
                            <i class="fas fa-inbox"></i>
                            <h3>No Submissions Yet</h3>
                            <p>You haven't submitted any reports yet</p>
                        </div>
                    `;
                }
                return;
            }
            
            const result = await response.json();
            
            if (result.success && result.submissions.length > 0) {
                this.submissions = result.submissions;
                container.innerHTML = `<div class="reports-grid">${this.renderSubmissions()}</div>`;
            } else {
                container.innerHTML = `
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h3>No Submissions Yet</h3>
                        <p>You haven't submitted any reports yet</p>
                    </div>
                `;
            }
        } catch (error) {
            console.error('Error loading submissions:', error);
            // Show demo data instead of error
            this.submissions = this.getDemoSubmissions();
            if (this.submissions.length > 0) {
                container.innerHTML = `<div class="reports-grid">${this.renderSubmissions()}</div>`;
            } else {
                container.innerHTML = `
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h3>No Submissions Yet</h3>
                        <p>You haven't submitted any reports yet</p>
                    </div>
                `;
            }
        }
    }
    
    getDemoSubmissions() {
        // Demo submissions for testing
        return [
            {
                id: 1,
                table_name: 'graduatesdata',
                submitted_at: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000).toISOString(),
                status: 'Approved'
            },
            {
                id: 2,
                table_name: 'employee',
                submitted_at: new Date(Date.now() - 10 * 24 * 60 * 60 * 1000).toISOString(),
                status: 'Pending Review'
            }
        ];
    }

    renderSubmissions() {
        return this.submissions.map(submission => `
            <div class="report-card">
                <div class="report-card-header">
                    <h3>
                        <i class="fas fa-file-check"></i>
                        ${this.formatReportName(submission.table_name)}
                    </h3>
                </div>
                <div class="report-card-body">
                    <div class="report-meta">
                        <div class="meta-item">
                            <i class="fas fa-calendar-check"></i>
                            <span><strong>Submitted:</strong> ${this.formatDate(submission.submitted_at)}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-info-circle"></i>
                            <span><strong>Status:</strong> ${submission.status || 'Pending Review'}</span>
                        </div>
                    </div>
                </div>
                <div class="report-card-footer">
                    <span class="status-badge completed">Submitted</span>
                </div>
            </div>
        `).join('');
    }

    updateStatistics() {
        const totalAssigned = this.assignedReports.length;
        const completed = this.submissions.length;
        const pending = totalAssigned - completed;
        
        document.getElementById('totalAssignedCount').textContent = totalAssigned;
        document.getElementById('completedCount').textContent = completed;
        document.getElementById('pendingCount').textContent = pending;
        document.getElementById('dueSoonCount').textContent = '0';
    }

    submitReport(tableName, taskId) {
        // Redirect to report submission page
        window.location.href = `report.html?table=${tableName}&task_id=${taskId}`;
    }

    formatReportName(tableName) {
        return tableName
            .replace(/([A-Z])/g, ' $1')
            .replace(/_/g, ' ')
            .split(' ')
            .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
            .join(' ')
            .trim();
    }

    formatDate(dateString) {
        if (!dateString) return 'N/A';
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', { 
            year: 'numeric', 
            month: 'short', 
            day: 'numeric' 
        });
    }

    showEmptyState(containerId, message) {
        const container = document.getElementById(containerId);
        container.innerHTML = `
            <div class="empty-state">
                <i class="fas fa-inbox"></i>
                <h3>${message}</h3>
            </div>
        `;
    }

    showNotification(message, type = 'info') {
        // Simple notification (can be enhanced with a toast library)
        alert(message);
    }

    // New Section Functions

    loadNotifications() {
        const container = document.getElementById('notificationsContainer');
        
        const notifications = [
            {
                id: 1,
                type: 'deadline',
                title: 'Deadline Approaching',
                message: 'Campus Population Report is due in 3 days',
                time: '2 hours ago',
                read: false
            },
            {
                id: 2,
                type: 'success',
                title: 'Report Approved',
                message: 'Your Graduates Data report has been approved',
                time: '1 day ago',
                read: false
            },
            {
                id: 3,
                type: 'info',
                title: 'New Report Assigned',
                message: 'Enrollment Data report has been assigned to you',
                time: '2 days ago',
                read: true
            },
            {
                id: 4,
                type: 'warning',
                title: 'Submission Reminder',
                message: 'You have 2 pending reports to submit',
                time: '3 days ago',
                read: true
            }
        ];
        
        const notificationsHTML = `
            <div class="notifications-list">
                ${notifications.map(notif => `
                    <div class="notification-item ${notif.read ? 'read' : 'unread'} ${notif.type}">
                        <div class="notification-icon">
                            <i class="fas fa-${notif.type === 'deadline' ? 'clock' : notif.type === 'success' ? 'check-circle' : notif.type === 'warning' ? 'exclamation-triangle' : 'info-circle'}"></i>
                        </div>
                        <div class="notification-content">
                            <h4>${notif.title}</h4>
                            <p>${notif.message}</p>
                            <span class="notification-time">${notif.time}</span>
                        </div>
                        ${!notif.read ? '<div class="unread-badge"></div>' : ''}
                    </div>
                `).join('')}
            </div>
        `;
        
        container.innerHTML = notificationsHTML;
    }

    loadAnalytics() {
        const container = document.getElementById('analyticsContainer');
        
        const totalAssigned = this.assignedReports.length;
        const completed = this.submissions.length;
        const pending = totalAssigned - completed;
        const completionRate = totalAssigned > 0 ? Math.round((completed / totalAssigned) * 100) : 0;
        
        const analyticsHTML = `
            <div class="analytics-grid">
                <!-- Performance Overview -->
                <div class="analytics-card full-width">
                    <h3><i class="fas fa-chart-line"></i> Performance Overview</h3>
                    <div class="performance-stats">
                        <div class="perf-stat">
                            <div class="perf-value">${completionRate}%</div>
                            <div class="perf-label">Completion Rate</div>
                        </div>
                        <div class="perf-stat">
                            <div class="perf-value">${completed}</div>
                            <div class="perf-label">Reports Submitted</div>
                        </div>
                        <div class="perf-stat">
                            <div class="perf-value">${pending}</div>
                            <div class="perf-label">Pending Reports</div>
                        </div>
                        <div class="perf-stat">
                            <div class="perf-value">${totalAssigned}</div>
                            <div class="perf-label">Total Assigned</div>
                        </div>
                    </div>
                </div>

                <!-- Submission Trend -->
                <div class="analytics-card">
                    <h3><i class="fas fa-chart-bar"></i> Submission Trend</h3>
                    <div class="trend-chart">
                        <div class="chart-placeholder">
                            <i class="fas fa-chart-area"></i>
                            <p>Chart visualization coming soon</p>
                        </div>
                    </div>
                </div>

                <!-- Report Types -->
                <div class="analytics-card">
                    <h3><i class="fas fa-pie-chart"></i> Report Types</h3>
                    <div class="report-types-list">
                        ${this.assignedReports.slice(0, 5).map(report => `
                            <div class="type-item">
                                <span>${this.formatReportName(report.table_name)}</span>
                                <span class="type-badge">${report.submitted ? 'Completed' : 'Pending'}</span>
                            </div>
                        `).join('')}
                    </div>
                </div>
            </div>
        `;
        
        container.innerHTML = analyticsHTML;
    }

    loadProfile() {
        const container = document.getElementById('profileContainer');
        
        const profileHTML = `
            <div class="profile-grid">
                <!-- Profile Card -->
                <div class="profile-card">
                    <div class="profile-avatar-large">
                        ${this.currentUser.name.charAt(0).toUpperCase()}
                    </div>
                    <h3>${this.currentUser.name}</h3>
                    <p class="profile-role">${this.currentUser.role}</p>
                </div>

                <!-- Profile Details -->
                <div class="profile-details-card">
                    <h3><i class="fas fa-user-circle"></i> Personal Information</h3>
                    <div class="detail-item">
                        <label><i class="fas fa-envelope"></i> Email</label>
                        <span>${this.currentUser.email}</span>
                    </div>
                    <div class="detail-item">
                        <label><i class="fas fa-building"></i> Office</label>
                        <span>${this.currentUser.office}</span>
                    </div>
                    <div class="detail-item">
                        <label><i class="fas fa-map-marker-alt"></i> Campus</label>
                        <span>${this.currentUser.campus}</span>
                    </div>
                    <div class="detail-item">
                        <label><i class="fas fa-id-badge"></i> User ID</label>
                        <span>#${this.currentUser.id}</span>
                    </div>
                </div>

                <!-- Account Settings -->
                <div class="profile-settings-card">
                    <h3><i class="fas fa-cog"></i> Account Settings</h3>
                    <button class="profile-btn">
                        <i class="fas fa-key"></i>
                        <span>Change Password</span>
                    </button>
                    <button class="profile-btn">
                        <i class="fas fa-bell"></i>
                        <span>Notification Preferences</span>
                    </button>
                    <button class="profile-btn">
                        <i class="fas fa-shield-alt"></i>
                        <span>Privacy Settings</span>
                    </button>
                </div>
            </div>
        `;
        
        container.innerHTML = profileHTML;
    }

    loadHelp() {
        const container = document.getElementById('helpContainer');
        
        const helpHTML = `
            <div class="help-grid">
                <!-- Quick Start Guide -->
                <div class="help-card">
                    <div class="help-icon">
                        <i class="fas fa-rocket"></i>
                    </div>
                    <h3>Quick Start Guide</h3>
                    <p>Learn the basics of using the system</p>
                    <ul class="help-list">
                        <li><i class="fas fa-check"></i> View assigned reports</li>
                        <li><i class="fas fa-check"></i> Submit data entries</li>
                        <li><i class="fas fa-check"></i> Track deadlines</li>
                        <li><i class="fas fa-check"></i> View submission history</li>
                    </ul>
                </div>

                <!-- FAQs -->
                <div class="help-card">
                    <div class="help-icon">
                        <i class="fas fa-question-circle"></i>
                    </div>
                    <h3>Frequently Asked Questions</h3>
                    <div class="faq-list">
                        <div class="faq-item">
                            <h4>How do I submit a report?</h4>
                            <p>Click on "Submit Report" button on any assigned report card, fill in the required data, and click submit.</p>
                        </div>
                        <div class="faq-item">
                            <h4>Can I edit submitted reports?</h4>
                            <p>Once submitted, reports cannot be edited. Please contact your administrator if changes are needed.</p>
                        </div>
                        <div class="faq-item">
                            <h4>What happens after I submit?</h4>
                            <p>Your submission will be reviewed by an administrator. You'll receive a notification once it's approved.</p>
                        </div>
                    </div>
                </div>

                <!-- Contact Support -->
                <div class="help-card">
                    <div class="help-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h3>Contact Support</h3>
                    <p>Need additional help? Reach out to our support team</p>
                    <div class="contact-info">
                        <div class="contact-item">
                            <i class="fas fa-envelope"></i>
                            <span>support@spartandata.com</span>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-phone"></i>
                            <span>+63 123 456 7890</span>
                        </div>
                    </div>
                </div>

                <!-- Video Tutorials -->
                <div class="help-card">
                    <div class="help-icon">
                        <i class="fas fa-video"></i>
                    </div>
                    <h3>Video Tutorials</h3>
                    <p>Watch step-by-step video guides</p>
                    <button class="help-btn">
                        <i class="fas fa-play-circle"></i>
                        <span>Watch Tutorials</span>
                    </button>
                </div>
            </div>
        `;
        
        container.innerHTML = helpHTML;
    }
}

// Logout function
function logout() {
    if (confirm('Are you sure you want to logout?')) {
        localStorage.removeItem('userSession');
        window.location.href = 'login.html';
    }
}

// Initialize dashboard
const userDashboard = new UserDashboard();
