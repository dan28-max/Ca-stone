// Admin Dashboard JavaScript

console.log('AdminDashboard script loaded');

class AdminDashboard {
    constructor() {
        this.currentSection = 'dashboard';
        this.currentStep = 1;
        this.submissions = [];
        this.filteredSubmissions = [];
        this.availableReports = [];
        this.selectedReports = [];
        this.availableOffices = [];
        this.selectedOffices = [];
        this.userCampus = null;
        this.userRole = null;
        this.isSuperAdmin = false;
    }

    // Get user session and campus info
    getUserSession() {
        const sessionData = localStorage.getItem('spartan_session');
        if (sessionData) {
            try {
                const session = JSON.parse(sessionData);
                this.userCampus = session.campus;
                this.userRole = session.role;
                this.isSuperAdmin = session.role === 'super_admin';
                
                console.log('User Session:', {
                    campus: this.userCampus,
                    role: this.userRole,
                    isSuperAdmin: this.isSuperAdmin
                });
                
                return session;
            } catch (e) {
                console.error('Error parsing session:', e);
                return null;
            }
        }
        return null;
    }

    // Authentication check (bypassed for development)
    async checkAuth() {
        console.log('Auth check - bypassed for development');
        this.getUserSession();
        return true;
    }

    async init() {
        console.log('Initializing admin dashboard...');
        
        try {
            const isAuthenticated = await this.checkAuth();
            if (!isAuthenticated) {
                return;
            }
            
            // Display campus restriction info
            this.displayCampusInfo();
            
            this.setupEventListeners();
            this.loadDashboardData();
            this.loadSystemSettings();
            await this.loadAvailableReports();
            await this.loadAvailableOffices();
            
            console.log('Admin dashboard initialized successfully');
        } catch (error) {
            console.error('Error initializing admin dashboard:', error);
        }
    }

    displayCampusInfo() {
        const userName = document.getElementById('userName');
        const userRole = document.getElementById('userRole');
        
        if (userName && this.userCampus) {
            if (this.isSuperAdmin) {
                userRole.textContent = 'Super Administrator - All Campuses';
            } else {
                userRole.textContent = `${this.userCampus} Campus Admin`;
                
                // Add campus filter notice to dashboard
                this.addCampusFilterNotice();
            }
        }
    }
    
    addCampusFilterNotice() {
        // Add a notice banner showing campus filtering is active
        const contentArea = document.querySelector('.content-area');
        if (!contentArea) return;
        
        // Check if notice already exists
        if (document.getElementById('campusFilterNotice')) return;
        
        const notice = document.createElement('div');
        notice.id = 'campusFilterNotice';
        notice.style.cssText = `
            background: linear-gradient(135deg, #dc143c 0%, #a00000 100%);
            color: white;
            padding: 15px 25px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 4px 12px rgba(220, 20, 60, 0.3);
            animation: slideInDown 0.5s ease;
        `;
        
        notice.innerHTML = `
            <i class="fas fa-filter" style="font-size: 24px;"></i>
            <div style="flex: 1;">
                <strong style="font-size: 16px; display: block; margin-bottom: 3px;">Campus Filter Active</strong>
                <span style="font-size: 14px; opacity: 0.9;">Showing data only for <strong>${this.userCampus}</strong> campus</span>
            </div>
            <i class="fas fa-check-circle" style="font-size: 24px;"></i>
        `;
        
        // Add animation keyframe
        if (!document.getElementById('campusFilterAnimation')) {
            const style = document.createElement('style');
            style.id = 'campusFilterAnimation';
            style.textContent = `
                @keyframes slideInDown {
                    from {
                        transform: translateY(-20px);
                        opacity: 0;
                    }
                    to {
                        transform: translateY(0);
                        opacity: 1;
                    }
                }
            `;
            document.head.appendChild(style);
        }
        
        contentArea.insertBefore(notice, contentArea.firstChild);
    }

    setupEventListeners() {
        console.log('Setting up event listeners...');
        
        // Navigation menu
        document.querySelectorAll('.nav-item').forEach(item => {
            item.addEventListener('click', (e) => {
                const section = e.currentTarget.dataset.section;
                if (section) {
                    this.showSection(section);
                }
            });
        });

        // Menu toggle
        const menuToggle = document.querySelector('.menu-toggle');
        if (menuToggle) {
            menuToggle.addEventListener('click', () => {
                document.querySelector('.sidebar').classList.toggle('collapsed');
            });
        }

        // Select all reports checkbox
        const selectAllReports = document.getElementById('selectAllReports');
        if (selectAllReports) {
            selectAllReports.addEventListener('change', (e) => {
                this.toggleSelectAllReports(e.target.checked);
            });
        }

        // Step navigation buttons
        const nextToStep2 = document.getElementById('nextToStep2');
        if (nextToStep2) {
            nextToStep2.addEventListener('click', () => this.goToStep(2));
        }

        const nextToStep3 = document.getElementById('nextToStep3');
        if (nextToStep3) {
            nextToStep3.addEventListener('click', () => this.goToStep(3));
        }

        const confirmAssignment = document.getElementById('confirmAssignment');
        if (confirmAssignment) {
            confirmAssignment.addEventListener('click', () => this.confirmAssignment());
        }

        // Filter submissions
        const statusFilter = document.getElementById('statusFilter');
        const campusFilter = document.getElementById('campusFilter');
        if (statusFilter) {
            statusFilter.addEventListener('change', () => this.filterSubmissions());
        }
        if (campusFilter) {
            campusFilter.addEventListener('change', () => this.filterSubmissions());
        }
    }

    showSection(sectionId) {
        console.log('Showing section:', sectionId);
        
        // Hide all sections
        document.querySelectorAll('.content-section').forEach(section => {
            section.classList.remove('active');
        });
        
        // Show selected section
        const section = document.getElementById(sectionId);
        if (section) {
            section.classList.add('active');
            this.currentSection = sectionId;
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
        if (sectionId === 'submissions') {
            this.loadSubmissions();
        } else if (sectionId === 'users') {
            this.loadUsers();
        } else if (sectionId === 'analytics') {
            this.loadAnalytics();
        }
    }

    async loadAvailableReports() {
        try {
            console.log('Fetching reports from api/get_reports.php...');
            const response = await fetch('api/get_reports.php');
            console.log('Reports response status:', response.status);
            
            const result = await response.json();
            console.log('Reports result:', result);
            
            if (result.success) {
                this.availableReports = result.reports;
                console.log('Loaded reports:', this.availableReports);
                this.renderReportsList();
            } else {
                console.error('Failed to load reports:', result.error);
            }
        } catch (error) {
            console.error('Error loading reports:', error);
        }
    }

    renderReportsList() {
        const tbody = document.getElementById('reportsTableBody');
        if (!tbody) return;
        
        tbody.innerHTML = '';
        
        this.availableReports.forEach(report => {
            const row = document.createElement('tr');
            const isSelected = this.selectedReports.includes(report.table_name);
            
            row.innerHTML = `
                <td>
                    <input type="checkbox" 
                           value="${report.table_name}" 
                           ${isSelected ? 'checked' : ''}
                           onchange="adminDashboard.toggleReportSelection('${report.table_name}', this.checked)">
                </td>
                <td>${report.display_name}</td>
                <td>${report.description || 'No description'}</td>
            `;
            
            tbody.appendChild(row);
        });

        this.updateStepButtons();
    }

    toggleReportSelection(tableName, isSelected) {
        if (isSelected) {
            if (!this.selectedReports.includes(tableName)) {
                this.selectedReports.push(tableName);
            }
        } else {
            this.selectedReports = this.selectedReports.filter(r => r !== tableName);
        }
        
        this.updateStepButtons();
        console.log('Selected reports:', this.selectedReports);
    }

    toggleSelectAllReports(selectAll) {
        const checkboxes = document.querySelectorAll('#reportsTableBody input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAll;
            this.toggleReportSelection(checkbox.value, selectAll);
        });
    }

    async loadAvailableOffices() {
        try {
            console.log('Fetching offices from api/get_offices.php...');
            const response = await fetch('api/get_offices.php');
            console.log('Offices response status:', response.status);
            
            const result = await response.json();
            console.log('Offices result:', result);
            
            if (result.success) {
                // Filter offices by campus if not super admin
                if (this.isSuperAdmin) {
                    this.availableOffices = result.offices;
                    console.log('Super Admin - Loaded all offices:', this.availableOffices.length);
                } else {
                    this.availableOffices = result.offices.filter(office => 
                        office.campus === this.userCampus
                    );
                    console.log(`Campus Admin (${this.userCampus}) - Loaded ${this.availableOffices.length} offices`);
                }
                this.renderOfficesList();
            } else {
                console.error('Failed to load offices:', result.error);
            }
        } catch (error) {
            console.error('Error loading offices:', error);
        }
    }

    renderOfficesList() {
        const container = document.querySelector('.campuses-container');
        if (!container) return;
        
        // Group offices by campus
        const officesByCampus = {};
        this.availableOffices.forEach(office => {
            if (!officesByCampus[office.campus]) {
                officesByCampus[office.campus] = [];
            }
            officesByCampus[office.campus].push(office);
        });
        
        // Show campus restriction message if not super admin
        let html = '';
        if (!this.isSuperAdmin && this.userCampus) {
            html += `
                <div class="campus-restriction-notice">
                    <i class="fas fa-info-circle"></i>
                    <span>You can only assign reports to offices in <strong>${this.userCampus}</strong> campus</span>
                </div>
            `;
        }
        
        Object.keys(officesByCampus).forEach(campus => {
            html += `
                <div class="campus-group">
                    <h4>${campus}</h4>
                    <div class="offices-list">
            `;
            
            officesByCampus[campus].forEach(office => {
                const isSelected = this.selectedOffices.includes(office.id);
                const officeIdStr = typeof office.id === 'string' ? `'${office.id}'` : office.id;
                html += `
                    <label class="office-checkbox">
                        <input type="checkbox" 
                               value="${office.id}" 
                               ${isSelected ? 'checked' : ''}
                               onchange="adminDashboard.toggleOfficeSelection(${officeIdStr}, this.checked)">
                        <span>${office.office_name}</span>
                    </label>
                `;
            });
            
            html += `
                    </div>
                </div>
            `;
        });
        
        container.innerHTML = html;
    }

    toggleOfficeSelection(officeId, isSelected) {
        if (isSelected) {
            if (!this.selectedOffices.includes(officeId)) {
                this.selectedOffices.push(officeId);
            }
        } else {
            this.selectedOffices = this.selectedOffices.filter(o => o !== officeId);
        }
        
        this.updateStepButtons();
        console.log('Selected offices:', this.selectedOffices);
    }

    goToStep(stepNumber) {
        console.log('Going to step:', stepNumber);
        
        // Hide all steps
        document.querySelectorAll('.assignment-step-formal').forEach(step => {
            step.classList.remove('active');
            step.style.display = 'none';
        });
        
        // Show selected step
        const step = document.getElementById(`step${stepNumber}`);
        if (step) {
            step.classList.add('active');
            step.style.display = 'block';
        }
        
        // Update step indicators - handle both old and new classes
        const stepIndicators = document.querySelectorAll('.step-formal, .step');
        stepIndicators.forEach((stepEl, index) => {
            const stepNum = index + 1;
            if (stepNum < stepNumber) {
                stepEl.classList.add('completed');
                stepEl.classList.remove('active');
            } else if (stepNum === stepNumber) {
                stepEl.classList.add('active');
                stepEl.classList.remove('completed');
            } else {
                stepEl.classList.remove('active', 'completed');
            }
        });
        
        this.currentStep = stepNumber;
        
        // Update confirmation if on step 3
        if (stepNumber === 3) {
            this.updateConfirmation();
        }
    }

    updateStepButtons() {
        const nextToStep2 = document.getElementById('nextToStep2');
        const nextToStep3 = document.getElementById('nextToStep3');
        
        if (nextToStep2) {
            nextToStep2.disabled = this.selectedReports.length === 0;
        }
        
        if (nextToStep3) {
            nextToStep3.disabled = this.selectedOffices.length === 0;
        }
    }

    updateConfirmation() {
        const reportsList = document.getElementById('selectedReportsList');
        const officesList = document.getElementById('selectedOfficesList');
        
        if (reportsList) {
            reportsList.innerHTML = this.selectedReports.map(tableName => {
                const report = this.availableReports.find(r => r.table_name === tableName);
                return `<li>${report ? report.display_name : tableName}</li>`;
            }).join('');
        }
        
        if (officesList) {
            officesList.innerHTML = this.selectedOffices.map(officeId => {
                const office = this.availableOffices.find(o => o.id === officeId);
                return `<li>${office ? office.office_name : officeId}</li>`;
            }).join('');
        }
    }

    async confirmAssignment() {
        if (this.selectedReports.length === 0 || this.selectedOffices.length === 0) {
            alert('Please select at least one report and one office');
            return;
        }

        try {
            const payload = {
                reports: this.selectedReports,
                offices: this.selectedOffices
            };
            
            console.log('Sending assignment payload:', payload);
            
            const response = await fetch('api/assign_table.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(payload),
                credentials: 'include'
            });

            console.log('Assignment response status:', response.status);
            
            const responseText = await response.text();
            console.log('Assignment response text:', responseText);
            
            let result;
            try {
                result = JSON.parse(responseText);
            } catch (e) {
                console.error('Failed to parse response as JSON:', responseText);
                alert('Server returned invalid response: ' + responseText.substring(0, 200));
                return;
            }

            console.log('Assignment result:', result);

            if (result.success) {
                alert('Reports assigned successfully!');
                this.selectedReports = [];
                this.selectedOffices = [];
                this.goToStep(1);
                this.renderReportsList();
                this.renderOfficesList();
            } else {
                alert('Failed to assign reports: ' + (result.error || result.message));
            }
        } catch (error) {
            console.error('Error assigning reports:', error);
            alert('Error assigning reports: ' + error.message);
        }
    }

    async loadSubmissions() {
        try {
            console.log('Loading submissions...');
            const response = await fetch('api/get_all_submissions.php', {
                credentials: 'include'
            });
            
            const result = await response.json();
            console.log('Submissions result:', result);
            
            if (result.success) {
                // Filter submissions by campus if not super admin
                if (this.isSuperAdmin) {
                    this.submissions = result.data || [];
                    console.log('Super Admin - Loaded all submissions:', this.submissions.length);
                } else {
                    this.submissions = (result.data || []).filter(submission => 
                        submission.campus === this.userCampus
                    );
                    console.log(`Campus Admin (${this.userCampus}) - Loaded ${this.submissions.length} submissions`);
                }
                
                this.filteredSubmissions = [...this.submissions];
                this.updateSubmissionStats();
                this.renderSubmissions();
            } else {
                console.error('Failed to load submissions:', result.error);
                this.renderEmptySubmissions('Error loading submissions: ' + result.error);
            }
        } catch (error) {
            console.error('Error loading submissions:', error);
            this.renderEmptySubmissions('Error loading submissions: ' + error.message);
        }
    }

    updateSubmissionStats() {
        const pending = this.submissions.filter(s => s.status === 'pending').length;
        const approved = this.submissions.filter(s => s.status === 'approved').length;
        const rejected = this.submissions.filter(s => s.status === 'rejected').length;
        
        document.getElementById('pendingCount').textContent = pending;
        document.getElementById('approvedCount').textContent = approved;
        document.getElementById('rejectedCount').textContent = rejected;
        document.getElementById('totalCount').textContent = this.submissions.length;
    }

    renderSubmissions() {
        const tbody = document.getElementById('submissionsTableBody');
        if (!tbody) return;

        if (this.filteredSubmissions.length === 0) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="10" style="text-align: center; padding: 40px;">
                        <i class="fas fa-inbox" style="font-size: 48px; color: #ccc; margin-bottom: 15px; display: block;"></i>
                        <p style="color: #666; margin: 0;">No submissions found</p>
                    </td>
                </tr>
            `;
            return;
        }

        tbody.innerHTML = '';

        this.filteredSubmissions.forEach(submission => {
            const row = document.createElement('tr');
            
            const statusClass = submission.status === 'pending' ? 'status-pending' : 
                              submission.status === 'approved' ? 'status-approved' : 'status-rejected';
            
            row.innerHTML = `
                <td>${submission.id}</td>
                <td>${this.formatTableName(submission.table_name)}</td>
                <td>${submission.campus || '-'}</td>
                <td>${submission.office || '-'}</td>
                <td>${submission.submitted_by || '-'}</td>
                <td style="text-align: center;">${submission.record_count || 0}</td>
                <td>${new Date(submission.submitted_at).toLocaleString()}</td>
                <td><span class="status-badge ${statusClass}">${submission.status || 'pending'}</span></td>
                <td>
                    <div class="submission-actions">
                        <button class="btn-sm btn-view" onclick="adminDashboard.viewSubmissionDetails('${submission.table_name}', '${submission.id}')">
                            <i class="fas fa-eye"></i> View
                        </button>
                        ${submission.status === 'pending' ? `
                            <button class="btn-sm btn-approve" onclick="adminDashboard.approveSubmission(${submission.id})">
                                <i class="fas fa-check"></i> Approve
                            </button>
                            <button class="btn-sm btn-reject" onclick="adminDashboard.rejectSubmission(${submission.id})">
                                <i class="fas fa-times"></i> Reject
                            </button>
                        ` : ''}
                        <button class="btn-sm btn-download" onclick="adminDashboard.downloadSubmission(${submission.id})">
                            <i class="fas fa-download"></i> Export
                        </button>
                    </div>
                </td>
            `;
            
            tbody.appendChild(row);
        });
    }

    renderEmptySubmissions(message = 'No submissions found') {
        const tbody = document.getElementById('submissionsTableBody');
        if (!tbody) return;
        
        tbody.innerHTML = `
            <tr>
                <td colspan="10" style="text-align: center; padding: 40px;">
                    <i class="fas fa-exclamation-circle" style="font-size: 48px; color: #dc143c; margin-bottom: 15px; display: block;"></i>
                    <p style="color: #666; margin: 0;">${message}</p>
                </td>
            </tr>
        `;
    }

    formatTableName(tableName) {
        const tableNames = {
            'admissiondata': 'Admission Data',
            'enrollmentdata': 'Enrollment Data',
            'graduatesdata': 'Graduates Data',
            'employee': 'Employee Data',
            'leaveprivilege': 'Leave Privilege',
            'libraryvisitor': 'Library Visitor',
            'pwd': 'PWD Data',
            'waterconsumption': 'Water Consumption',
            'treatedwastewater': 'Treated Wastewater',
            'electricityconsumption': 'Electricity Consumption',
            'solidwaste': 'Solid Waste',
            'campuspopulation': 'Campus Population',
            'foodwaste': 'Food Waste',
            'fuelconsumption': 'Fuel Consumption',
            'distancetraveled': 'Distance Traveled',
            'budgetexpenditure': 'Budget Expenditure',
            'flightaccommodation': 'Flight Accommodation'
        };
        return tableNames[tableName] || tableName;
    }

    filterSubmissions() {
        const statusFilter = document.getElementById('statusFilter')?.value || '';
        const campusFilter = document.getElementById('campusFilter')?.value || '';
        const reportTypeFilter = document.getElementById('reportTypeFilter')?.value || '';
        
        this.filteredSubmissions = this.submissions.filter(submission => {
            const statusMatch = !statusFilter || submission.status === statusFilter;
            const campusMatch = !campusFilter || submission.campus === campusFilter;
            const reportMatch = !reportTypeFilter || submission.table_name === reportTypeFilter;
            return statusMatch && campusMatch && reportMatch;
        });
        
        this.renderSubmissions();
    }

    async viewSubmissionDetails(tableName, submissionId) {
        try {
            const response = await fetch(`api/get_submission_details.php?submission_id=${submissionId}`);
            const result = await response.json();
            
            if (result.success) {
                this.showSubmissionDetailsModal(result.data, tableName, submissionId, result.submission);
            } else {
                alert('Failed to load submission details: ' + result.error);
            }
        } catch (error) {
            console.error('Error loading submission details:', error);
            alert('Error loading submission details');
        }
    }

    showSubmissionDetailsModal(data, tableName, submissionId, submission) {
        let modal = document.getElementById('submissionDetailsModal');
        if (!modal) {
            modal = document.createElement('div');
            modal.id = 'submissionDetailsModal';
            modal.className = 'edit-modal';
            modal.innerHTML = `
                <div class="modal-content-formal">
                    <div class="modal-header-formal">
                        <h3><i class="fas fa-file-alt"></i> Submission Details</h3>
                        <button class="modal-close" onclick="document.getElementById('submissionDetailsModal').classList.remove('active')">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="modal-body-formal" id="submissionDetailsBody"></div>
                    <div class="modal-footer-formal">
                        <button class="btn-formal btn-secondary" onclick="document.getElementById('submissionDetailsModal').classList.remove('active')">Close</button>
                    </div>
                </div>
            `;
            document.body.appendChild(modal);
        }

        const body = document.getElementById('submissionDetailsBody');
        let html = `
            <div style="margin-bottom: 20px; padding: 15px; background: #f8f9fa; border-radius: 6px;">
                <h4 style="margin-bottom: 10px;">${this.formatTableName(tableName)}</h4>
                <p style="margin: 5px 0;"><strong>Submission ID:</strong> ${submissionId}</p>
                <p style="margin: 5px 0;"><strong>Campus:</strong> ${submission?.campus || '-'}</p>
                <p style="margin: 5px 0;"><strong>Office:</strong> ${submission?.office || '-'}</p>
                <p style="margin: 5px 0;"><strong>Records:</strong> ${data.length}</p>
                <p style="margin: 5px 0;"><strong>Status:</strong> <span class="status-badge status-${submission?.status || 'pending'}">${submission?.status || 'pending'}</span></p>
            </div>
        `;

        if (data.length > 0) {
            const columns = Object.keys(data[0]);
            html += `
                <div style="overflow-x: auto;">
                    <table class="formal-table">
                        <thead>
                            <tr>${columns.map(col => `<th>${col}</th>`).join('')}</tr>
                        </thead>
                        <tbody>
                            ${data.map(row => `
                                <tr>${columns.map(col => `<td>${row[col] || '-'}</td>`).join('')}</tr>
                            `).join('')}
                        </tbody>
                    </table>
                </div>
            `;
        } else {
            html += '<p style="text-align: center; color: #999; padding: 20px;">No data records found</p>';
        }

        body.innerHTML = html;
        modal.classList.add('active');
    }

    async approveSubmission(submissionId) {
        if (!confirm('Are you sure you want to approve this submission?')) return;
        
        try {
            const response = await fetch('api/update_submission_status.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ submission_id: submissionId, status: 'approved' })
            });
            
            const result = await response.json();
            if (result.success) {
                alert('Submission approved successfully');
                this.loadSubmissions();
            } else {
                alert('Failed to approve: ' + result.error);
            }
        } catch (error) {
            alert('Error approving submission: ' + error.message);
        }
    }

    async rejectSubmission(submissionId) {
        if (!confirm('Are you sure you want to reject this submission?')) return;
        
        try {
            const response = await fetch('api/update_submission_status.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ submission_id: submissionId, status: 'rejected' })
            });
            
            const result = await response.json();
            if (result.success) {
                alert('Submission rejected');
                this.loadSubmissions();
            } else {
                alert('Failed to reject: ' + result.error);
            }
        } catch (error) {
            alert('Error rejecting submission: ' + error.message);
        }
    }

    downloadSubmission(submissionId) {
        window.open(`api/export_submission.php?submission_id=${submissionId}`, '_blank');
    }

    async viewSubmission(submissionId) {
        try {
            const response = await fetch(`api/admin_submissions.php?action=details&submission_id=${submissionId}`, {
                credentials: 'include'
            });
            
            const result = await response.json();
            
            if (result.success) {
                this.showSubmissionModal(result.data);
            } else {
                alert('Failed to load submission details: ' + result.error);
            }
        } catch (error) {
            console.error('Error loading submission details:', error);
            alert('Error loading submission details');
        }
    }

    showSubmissionModal(submission) {
        let modal = document.getElementById('submissionModal');
        if (!modal) {
            modal = document.createElement('div');
            modal.id = 'submissionModal';
            modal.className = 'modal-overlay';
            modal.style.cssText = 'display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 10000; align-items: center; justify-content: center;';
            
            modal.innerHTML = `
                <div class="modal-container" style="max-width: 90%; max-height: 90%; overflow-y: auto; background: white; border-radius: 8px; padding: 20px;">
                    <div class="modal-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                        <h3 id="submissionModalTitle">Submission Details</h3>
                        <button class="modal-close" onclick="closeSubmissionModal()" style="background: none; border: none; font-size: 24px; cursor: pointer;">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="modal-body" id="submissionModalBody">
                        <!-- Content will be loaded here -->
                    </div>
                </div>
            `;
            
            document.body.appendChild(modal);
        }

        const title = document.getElementById('submissionModalTitle');
        const body = document.getElementById('submissionModalBody');
        
        title.textContent = `${this.formatTableName(submission.table_name)} - ${submission.campus}`;
        
        let tableHtml = `
            <div class="submission-info">
                <p><strong>Submitted by:</strong> ${submission.user_name} (${submission.user_email})</p>
                <p><strong>Campus:</strong> ${submission.campus}</p>
                <p><strong>Office:</strong> ${submission.office}</p>
                <p><strong>Date:</strong> ${new Date(submission.submission_date).toLocaleString()}</p>
                <p><strong>Status:</strong> <span class="status-badge status-${submission.status}">${submission.status}</span></p>
            </div>
            <hr>
            <h4>Submitted Data (${submission.data.length} records)</h4>
        `;
        
        if (submission.data && submission.data.length > 0) {
            const columns = Object.keys(submission.data[0]);
            
            tableHtml += `
                <div style="overflow-x: auto;">
                    <table class="table" style="width: 100%; border-collapse: collapse;">
                        <thead>
                            <tr>
                                ${columns.map(col => `<th style="border: 1px solid #ddd; padding: 8px; background: #f5f5f5;">${col}</th>`).join('')}
                            </tr>
                        </thead>
                        <tbody>
                            ${submission.data.map(row => `
                                <tr>
                                    ${columns.map(col => `<td style="border: 1px solid #ddd; padding: 8px;">${row[col] || ''}</td>`).join('')}
                                </tr>
                            `).join('')}
                        </tbody>
                    </table>
                </div>
            `;
        }
        
        body.innerHTML = tableHtml;
        modal.style.display = 'flex';
    }

    async loadDashboardData() {
        console.log('Loading dashboard data...');
        
        try {
            // Load dashboard statistics
            await Promise.all([
                this.loadDashboardStats(),
                this.loadRecentSubmissions(),
                this.loadUserActivity()
            ]);
        } catch (error) {
            console.error('Error loading dashboard data:', error);
        }
    }
    
    async loadAnalytics() {
        console.log('Loading analytics...');
        
        try {
            const response = await fetch('api/get_all_submissions.php');
            const result = await response.json();
            
            if (result.success) {
                let submissions = result.data || [];
                
                // Filter by campus if not super admin
                if (!this.isSuperAdmin && this.userCampus) {
                    submissions = submissions.filter(s => s.campus === this.userCampus);
                    console.log(`Filtered by campus ${this.userCampus}: ${submissions.length} submissions`);
                }
                
                // Filter by table type if selected
                const tableFilter = document.getElementById('analyticsTableFilter');
                if (tableFilter && tableFilter.value !== 'all') {
                    submissions = submissions.filter(s => s.table_name === tableFilter.value);
                    console.log(`Filtered by table ${tableFilter.value}: ${submissions.length} submissions`);
                }
                
                // Filter by time range
                const timeRange = document.getElementById('analyticsTimeRange');
                if (timeRange && timeRange.value !== 'all') {
                    const now = new Date();
                    const days = parseInt(timeRange.value);
                    const cutoffDate = new Date(now.getTime() - (days * 24 * 60 * 60 * 1000));
                    
                    submissions = submissions.filter(s => {
                        const submittedDate = new Date(s.submitted_at);
                        return submittedDate >= cutoffDate;
                    });
                    console.log(`Filtered by time range ${timeRange.value}: ${submissions.length} submissions`);
                }
                
                // Create charts
                this.createStatusChart(submissions);
                this.createCampusChart(submissions);
                this.createReportTypeChart(submissions);
                this.createTimelineChart(submissions);
                this.updateAnalyticsSummary(submissions);
                
                // Show active filters
                this.showActiveFilters();
            }
        } catch (error) {
            console.error('Error loading analytics:', error);
        }
    }
    
    showActiveFilters() {
        const tableFilter = document.getElementById('analyticsTableFilter');
        const timeRange = document.getElementById('analyticsTimeRange');
        const banner = document.getElementById('analyticsFilterBanner');
        const bannerText = document.getElementById('filterBannerText');
        
        let filters = [];
        
        if (tableFilter && tableFilter.value !== 'all') {
            const selectedOption = tableFilter.options[tableFilter.selectedIndex].text;
            filters.push(`Report Type: ${selectedOption}`);
        }
        
        if (timeRange && timeRange.value !== 'all') {
            const selectedOption = timeRange.options[timeRange.selectedIndex].text;
            filters.push(`Time: ${selectedOption}`);
        }
        
        if (!this.isSuperAdmin && this.userCampus) {
            filters.push(`Campus: ${this.userCampus}`);
        }
        
        // Show/hide banner based on filters
        if (banner && bannerText) {
            if (filters.length > 0) {
                bannerText.textContent = filters.join(' | ');
                banner.style.display = 'flex';
            } else {
                banner.style.display = 'none';
            }
        }
    }
    
    clearAnalyticsFilters() {
        const tableFilter = document.getElementById('analyticsTableFilter');
        const timeRange = document.getElementById('analyticsTimeRange');
        
        if (tableFilter) tableFilter.value = 'all';
        if (timeRange) timeRange.value = 'all';
        
        this.loadAnalytics();
        this.showNotification('Filters cleared', 'info');
    }
    
    // System Settings Methods
    saveSystemSettings() {
        const settings = {
            systemName: document.getElementById('settingSystemName')?.value,
            recordsPerPage: document.getElementById('settingRecordsPerPage')?.value,
            dateFormat: document.getElementById('settingDateFormat')?.value,
            maintenanceMode: document.getElementById('settingMaintenanceMode')?.checked,
            autoApprove: document.getElementById('settingAutoApprove')?.checked,
            requireApproval: document.getElementById('settingRequireApproval')?.checked,
            maxFileSize: document.getElementById('settingMaxFileSize')?.value,
            deadlineDays: document.getElementById('settingDeadlineDays')?.value,
            twoFactor: document.getElementById('settingTwoFactor')?.checked,
            sessionTimeout: document.getElementById('settingSessionTimeout')?.value,
            passwordLength: document.getElementById('settingPasswordLength')?.value,
            failedAttempts: document.getElementById('settingFailedAttempts')?.value,
            ipWhitelist: document.getElementById('settingIPWhitelist')?.checked,
            autoBackup: document.getElementById('settingAutoBackup')?.checked,
            backupFrequency: document.getElementById('settingBackupFrequency')?.value,
            dataRetention: document.getElementById('settingDataRetention')?.value,
            exportFormat: document.getElementById('settingExportFormat')?.value
        };
        
        // Save to localStorage for now (in production, save to database)
        localStorage.setItem('systemSettings', JSON.stringify(settings));
        
        console.log('Settings saved:', settings);
        this.showNotification('System settings saved successfully!', 'success');
        
        // Apply maintenance mode if enabled
        if (settings.maintenanceMode) {
            this.showNotification('Maintenance mode enabled - Users will not be able to access the system', 'info');
        }
    }
    
    loadSystemSettings() {
        const savedSettings = localStorage.getItem('systemSettings');
        if (!savedSettings) return;
        
        try {
            const settings = JSON.parse(savedSettings);
            
            // Apply saved settings to form
            if (settings.systemName) document.getElementById('settingSystemName').value = settings.systemName;
            if (settings.recordsPerPage) document.getElementById('settingRecordsPerPage').value = settings.recordsPerPage;
            if (settings.dateFormat) document.getElementById('settingDateFormat').value = settings.dateFormat;
            if (settings.maintenanceMode !== undefined) document.getElementById('settingMaintenanceMode').checked = settings.maintenanceMode;
            if (settings.autoApprove !== undefined) document.getElementById('settingAutoApprove').checked = settings.autoApprove;
            if (settings.requireApproval !== undefined) document.getElementById('settingRequireApproval').checked = settings.requireApproval;
            if (settings.maxFileSize) document.getElementById('settingMaxFileSize').value = settings.maxFileSize;
            if (settings.deadlineDays) document.getElementById('settingDeadlineDays').value = settings.deadlineDays;
            if (settings.twoFactor !== undefined) document.getElementById('settingTwoFactor').checked = settings.twoFactor;
            if (settings.sessionTimeout) document.getElementById('settingSessionTimeout').value = settings.sessionTimeout;
            if (settings.passwordLength) document.getElementById('settingPasswordLength').value = settings.passwordLength;
            if (settings.failedAttempts) document.getElementById('settingFailedAttempts').value = settings.failedAttempts;
            if (settings.ipWhitelist !== undefined) document.getElementById('settingIPWhitelist').checked = settings.ipWhitelist;
            if (settings.autoBackup !== undefined) document.getElementById('settingAutoBackup').checked = settings.autoBackup;
            if (settings.backupFrequency) document.getElementById('settingBackupFrequency').value = settings.backupFrequency;
            if (settings.dataRetention) document.getElementById('settingDataRetention').value = settings.dataRetention;
            if (settings.exportFormat) document.getElementById('settingExportFormat').value = settings.exportFormat;
            
            console.log('Settings loaded:', settings);
        } catch (error) {
            console.error('Error loading settings:', error);
        }
    }
    
    createBackup() {
        this.showNotification('Creating database backup...', 'info');
        
        // Simulate backup creation
        setTimeout(() => {
            const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
            const filename = `spartan_data_backup_${timestamp}.sql`;
            
            this.showNotification(`Backup created: ${filename}`, 'success');
            console.log('Backup created:', filename);
            
            // In production, this would call an API to create actual backup
            // For now, just show success message
        }, 2000);
    }
    
    restoreBackup() {
        const confirmed = confirm('Are you sure you want to restore from backup? This will overwrite current data.');
        
        if (!confirmed) return;
        
        this.showNotification('Restore from backup functionality - Coming soon', 'info');
        console.log('Restore backup requested');
        
        // In production, this would show file picker and restore from selected backup
    }
    
    createStatusChart(submissions) {
        const ctx = document.getElementById('statusChart');
        if (!ctx) return;
        
        const statusCounts = {
            pending: submissions.filter(s => s.status === 'pending').length,
            approved: submissions.filter(s => s.status === 'approved').length,
            rejected: submissions.filter(s => s.status === 'rejected').length
        };
        
        // Destroy existing chart if it exists
        if (this.statusChart) {
            this.statusChart.destroy();
        }
        
        this.statusChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Pending', 'Approved', 'Rejected'],
                datasets: [{
                    data: [statusCounts.pending, statusCounts.approved, statusCounts.rejected],
                    backgroundColor: [
                        '#f59e0b',
                        '#10b981',
                        '#ef4444'
                    ],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 15,
                            font: {
                                size: 13,
                                weight: '600'
                            }
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = ((context.parsed / total) * 100).toFixed(1);
                                return context.label + ': ' + context.parsed + ' (' + percentage + '%)';
                            }
                        }
                    }
                }
            }
        });
    }
    
    createCampusChart(submissions) {
        const ctx = document.getElementById('campusChart');
        if (!ctx) return;
        
        // Count submissions by campus
        const campusCounts = {};
        submissions.forEach(s => {
            const campus = s.campus || 'Unknown';
            campusCounts[campus] = (campusCounts[campus] || 0) + 1;
        });
        
        const campuses = Object.keys(campusCounts).sort();
        const counts = campuses.map(c => campusCounts[c]);
        
        // Destroy existing chart if it exists
        if (this.campusChart) {
            this.campusChart.destroy();
        }
        
        this.campusChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: campuses,
                datasets: [{
                    label: 'Submissions',
                    data: counts,
                    backgroundColor: '#dc143c',
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    }
    
    createReportTypeChart(submissions) {
        const ctx = document.getElementById('reportTypeChart');
        if (!ctx) return;
        
        // Count submissions by report type
        const typeCounts = {};
        submissions.forEach(s => {
            const type = this.formatTableName(s.table_name);
            typeCounts[type] = (typeCounts[type] || 0) + 1;
        });
        
        const types = Object.keys(typeCounts).sort((a, b) => typeCounts[b] - typeCounts[a]);
        const counts = types.map(t => typeCounts[t]);
        
        // Destroy existing chart if it exists
        if (this.reportTypeChart) {
            this.reportTypeChart.destroy();
        }
        
        this.reportTypeChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: types,
                datasets: [{
                    label: 'Submissions',
                    data: counts,
                    backgroundColor: '#dc143c',
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                indexAxis: 'y',
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    x: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    }
    
    createTimelineChart(submissions) {
        const ctx = document.getElementById('timelineChart');
        if (!ctx) return;
        
        // Group submissions by date
        const dateCounts = {};
        submissions.forEach(s => {
            const date = new Date(s.submitted_at).toLocaleDateString();
            dateCounts[date] = (dateCounts[date] || 0) + 1;
        });
        
        const dates = Object.keys(dateCounts).sort((a, b) => new Date(a) - new Date(b));
        const counts = dates.map(d => dateCounts[d]);
        
        // Destroy existing chart if it exists
        if (this.timelineChart) {
            this.timelineChart.destroy();
        }
        
        this.timelineChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: dates,
                datasets: [{
                    label: 'Submissions',
                    data: counts,
                    borderColor: '#dc143c',
                    backgroundColor: 'rgba(220, 20, 60, 0.1)',
                    fill: true,
                    tension: 0.4,
                    borderWidth: 3,
                    pointRadius: 5,
                    pointBackgroundColor: '#dc143c',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    }
    
    updateAnalyticsSummary(submissions) {
        const total = submissions.length;
        const approved = submissions.filter(s => s.status === 'approved').length;
        const approvalRate = total > 0 ? ((approved / total) * 100).toFixed(1) : 0;
        
        const campuses = [...new Set(submissions.map(s => s.campus))].filter(c => c);
        const activeCampuses = campuses.length;
        
        // Update summary cards
        const totalEl = document.getElementById('analyticsTotalSubmissions');
        const approvalEl = document.getElementById('analyticsApprovalRate');
        const campusesEl = document.getElementById('analyticsActiveCampuses');
        
        if (totalEl) totalEl.textContent = total;
        if (approvalEl) approvalEl.textContent = approvalRate + '%';
        if (campusesEl) campusesEl.textContent = activeCampuses;
        
        // Calculate average processing time (if timestamps available)
        const processedSubmissions = submissions.filter(s => s.status !== 'pending' && s.updated_at);
        if (processedSubmissions.length > 0) {
            const avgTime = processedSubmissions.reduce((sum, s) => {
                const submitted = new Date(s.submitted_at);
                const updated = new Date(s.updated_at);
                const hours = (updated - submitted) / (1000 * 60 * 60);
                return sum + hours;
            }, 0) / processedSubmissions.length;
            
            const timeEl = document.getElementById('analyticsAvgTime');
            if (timeEl) {
                if (avgTime < 24) {
                    timeEl.textContent = avgTime.toFixed(1) + 'h';
                } else {
                    timeEl.textContent = (avgTime / 24).toFixed(1) + 'd';
                }
            }
        }
    }
    
    async loadDashboardStats() {
        try {
            // Load user statistics
            const usersResponse = await fetch('api/users.php?action=list');
            const usersResult = await usersResponse.json();
            
            if (usersResult.success) {
                let users = usersResult.users;
                
                // Filter by campus if not super admin
                if (!this.isSuperAdmin && this.userCampus) {
                    users = users.filter(u => 
                        u.campus === this.userCampus || 
                        u.role === 'super_admin' ||
                        u.campus === 'All Campuses'
                    );
                    console.log(`Filtered users for ${this.userCampus}: ${users.length} users`);
                }
                
                const totalUsers = users.length;
                const adminUsers = users.filter(u => u.role === 'admin' || u.role === 'super_admin').length;
                const activeUsers = users.filter(u => u.status === 'active').length;
                const inactiveUsers = users.filter(u => u.status !== 'active').length;
                
                // Update dashboard stats
                const dashTotalUsers = document.getElementById('dashTotalUsers');
                const dashAdminUsers = document.getElementById('dashAdminUsers');
                const dashActiveUsers = document.getElementById('dashActiveUsers');
                const dashInactiveUsers = document.getElementById('dashInactiveUsers');
                
                if (dashTotalUsers) dashTotalUsers.textContent = totalUsers;
                if (dashAdminUsers) dashAdminUsers.textContent = adminUsers;
                if (dashActiveUsers) dashActiveUsers.textContent = activeUsers;
                if (dashInactiveUsers) dashInactiveUsers.textContent = inactiveUsers;
            }
            
            // Load submission statistics
            const submissionsResponse = await fetch('api/get_all_submissions.php');
            const submissionsResult = await submissionsResponse.json();
            
            if (submissionsResult.success) {
                let submissions = submissionsResult.data || [];
                
                // Filter by campus if not super admin
                if (!this.isSuperAdmin && this.userCampus) {
                    submissions = submissions.filter(s => s.campus === this.userCampus);
                    console.log(`Filtered submissions for ${this.userCampus}: ${submissions.length} submissions`);
                }
                
                const totalReports = submissions.length;
                const pendingReports = submissions.filter(s => s.status === 'pending').length;
                const approvedReports = submissions.filter(s => s.status === 'approved').length;
                const rejectedReports = submissions.filter(s => s.status === 'rejected').length;
                
                // Update dashboard stats
                const dashTotalReports = document.getElementById('dashTotalReports');
                const dashPendingReports = document.getElementById('dashPendingReports');
                const dashApprovedReports = document.getElementById('dashApprovedReports');
                const dashRejectedReports = document.getElementById('dashRejectedReports');
                
                if (dashTotalReports) dashTotalReports.textContent = totalReports;
                if (dashPendingReports) dashPendingReports.textContent = pendingReports;
                if (dashApprovedReports) dashApprovedReports.textContent = approvedReports;
                if (dashRejectedReports) dashRejectedReports.textContent = rejectedReports;
            }
        } catch (error) {
            console.error('Error loading dashboard stats:', error);
        }
    }
    
    async loadRecentSubmissions() {
        try {
            const response = await fetch('api/get_all_submissions.php');
            const result = await response.json();
            
            if (result.success) {
                let submissions = result.data || [];
                
                // Filter by campus if not super admin
                if (!this.isSuperAdmin && this.userCampus) {
                    submissions = submissions.filter(s => s.campus === this.userCampus);
                    console.log(`Filtered recent submissions for ${this.userCampus}: ${submissions.length} submissions`);
                }
                
                const recent = submissions.slice(0, 5); // Get last 5 submissions
                
                const container = document.getElementById('recentSubmissionsList');
                if (!container) return;
                
                if (recent.length === 0) {
                    container.innerHTML = `
                        <div class="loading-state">
                            <i class="fas fa-inbox"></i>
                            <p>No recent submissions</p>
                        </div>
                    `;
                    return;
                }
                
                container.innerHTML = recent.map(sub => `
                    <div class="submission-item" style="padding: 15px; border-bottom: 1px solid #f0f0f0; cursor: pointer;" onclick="adminDashboard.viewSubmissionDetails('${sub.table_name}', '${sub.id}')">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <strong>${this.formatTableName(sub.table_name)}</strong>
                                <p style="margin: 5px 0; color: #666; font-size: 13px;">${sub.campus || 'Unknown'} - ${sub.office || 'Unknown'}</p>
                            </div>
                            <span class="status-badge status-${sub.status}">${sub.status}</span>
                        </div>
                        <p style="margin: 5px 0 0 0; color: #999; font-size: 12px;">${new Date(sub.submitted_at).toLocaleString()}</p>
                    </div>
                `).join('');
            }
        } catch (error) {
            console.error('Error loading recent submissions:', error);
        }
    }
    
    async loadUserActivity() {
        try {
            const response = await fetch('api/users.php?action=list');
            const result = await response.json();
            
            if (result.success) {
                let users = result.users;
                
                // Filter by campus if not super admin
                if (!this.isSuperAdmin && this.userCampus) {
                    users = users.filter(u => 
                        u.campus === this.userCampus || 
                        u.role === 'super_admin' ||
                        u.campus === 'All Campuses'
                    );
                    console.log(`Filtered user activity for ${this.userCampus}: ${users.length} users`);
                }
                
                const recentActivity = users
                    .filter(u => u.last_login)
                    .sort((a, b) => new Date(b.last_login) - new Date(a.last_login))
                    .slice(0, 5);
                
                const container = document.getElementById('userActivityList');
                if (!container) return;
                
                if (recentActivity.length === 0) {
                    container.innerHTML = `
                        <div class="loading-state">
                            <i class="fas fa-user-clock"></i>
                            <p>No recent activity</p>
                        </div>
                    `;
                    return;
                }
                
                container.innerHTML = recentActivity.map(user => `
                    <div class="activity-item" style="padding: 15px; border-bottom: 1px solid #f0f0f0;">
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <div class="user-avatar-small">
                                <i class="fas fa-user"></i>
                            </div>
                            <div style="flex: 1;">
                                <strong>${user.name}</strong>
                                <p style="margin: 5px 0 0 0; color: #666; font-size: 13px;">Last login: ${new Date(user.last_login).toLocaleString()}</p>
                            </div>
                            <span class="role-badge role-${user.role.replace('_', '-')}">${user.role.replace('_', ' ')}</span>
                        </div>
                    </div>
                `).join('');
            }
        } catch (error) {
            console.error('Error loading user activity:', error);
        }
    }

    // User Management Methods
    async loadUsers() {
        try {
            console.log('Loading users...');
            const response = await fetch('api/users.php?action=list');
            const result = await response.json();
            
            if (result.success) {
                // Filter users by campus if not super admin
                let users = result.users;
                if (!this.isSuperAdmin && this.userCampus) {
                    users = users.filter(user => 
                        user.campus === this.userCampus || user.role === 'super_admin'
                    );
                    console.log(`Campus Admin (${this.userCampus}) - Showing ${users.length} users`);
                }
                this.renderUsersTable(users);
            } else {
                console.error('Failed to load users:', result.error);
                this.showNotification('Failed to load users', 'error');
            }
        } catch (error) {
            console.error('Error loading users:', error);
            this.showNotification('Error loading users', 'error');
        }
    }

    renderUsersTable(users) {
        const tbody = document.getElementById('usersTableBody');
        if (!tbody) return;
        
        if (!users || users.length === 0) {
            tbody.innerHTML = '<tr><td colspan="9" style="text-align: center; padding: 40px;"><i class="fas fa-users" style="font-size: 48px; color: #ccc; margin-bottom: 10px;"></i><p style="color: #666;">No users found</p></td></tr>';
            return;
        }
        
        // Update statistics
        this.updateUserStats(users);
        
        tbody.innerHTML = '';
        
        users.forEach((user, index) => {
            const row = document.createElement('tr');
            const statusClass = user.status === 'active' ? 'status-approved' : 
                               user.status === 'inactive' ? 'status-pending' : 'status-rejected';
            
            let roleDisplay = user.role;
            let roleBadgeClass = 'role-user';
            if (user.role === 'super_admin') {
                roleDisplay = 'Super Admin';
                roleBadgeClass = 'role-super-admin';
            } else if (user.role === 'admin') {
                roleDisplay = 'Admin';
                roleBadgeClass = 'role-admin';
            } else {
                roleDisplay = 'User';
                roleBadgeClass = 'role-user';
            }
            
            const lastLogin = user.last_login ? new Date(user.last_login).toLocaleString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            }) : '<span style="color: #999;">Never</span>';
            
            row.innerHTML = `
                <td style="text-align: center;"><strong>#${user.id}</strong></td>
                <td>
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <div class="user-avatar-small">
                            <i class="fas fa-user"></i>
                        </div>
                        <strong>${user.name || '-'}</strong>
                    </div>
                </td>
                <td>${user.email || '-'}</td>
                <td><span class="role-badge ${roleBadgeClass}">${roleDisplay}</span></td>
                <td>${user.campus || '-'}</td>
                <td>${user.office || '-'}</td>
                <td><span class="status-badge ${statusClass}">${user.status || 'active'}</span></td>
                <td>${lastLogin}</td>
                <td class="action-buttons" style="text-align: center;">
                    <button class="btn-sm btn-view" onclick="editUser(${user.id})" title="Edit User">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-sm btn-reject" onclick="deleteUser(${user.id})" title="Delete User">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            `;
            tbody.appendChild(row);
        });
    }

    updateUserStats(users) {
        const totalUsers = users.length;
        const admins = users.filter(u => u.role === 'admin' || u.role === 'super_admin').length;
        const activeUsers = users.filter(u => u.status === 'active').length;
        const inactiveUsers = users.filter(u => u.status === 'inactive' || u.status === 'suspended').length;
        
        const totalEl = document.getElementById('totalUsersCount');
        const adminEl = document.getElementById('adminCount');
        const activeEl = document.getElementById('activeUsersCount');
        const inactiveEl = document.getElementById('inactiveUsersCount');
        
        if (totalEl) totalEl.textContent = totalUsers;
        if (adminEl) adminEl.textContent = admins;
        if (activeEl) activeEl.textContent = activeUsers;
        if (inactiveEl) inactiveEl.textContent = inactiveUsers;
    }

    showAddUserModal() {
        const modal = document.getElementById('userModal');
        const form = document.getElementById('userForm');
        const title = document.getElementById('userModalTitle');
        const subtitle = modal.querySelector('.modal-subtitle');
        const passwordLabel = document.getElementById('passwordLabel');
        const campusSelect = document.getElementById('userCampus');
        const passwordInput = document.getElementById('userPassword');
        
        // Update modal title and subtitle
        title.textContent = 'Add New User';
        if (subtitle) {
            subtitle.textContent = 'Create a new user account for the system';
        }
        
        // Update password label
        if (passwordLabel) {
            passwordLabel.textContent = '';
            passwordLabel.style.display = 'none';
        }
        
        // Reset form
        form.reset();
        document.getElementById('userId').value = '';
        
        // Make password required for new users
        if (passwordInput) {
            passwordInput.required = true;
            passwordInput.placeholder = 'Enter secure password';
        }
        
        // Reset password strength indicator
        const strengthFill = document.getElementById('strengthFill');
        const strengthText = document.getElementById('strengthText');
        if (strengthFill) strengthFill.className = 'strength-fill';
        if (strengthText) {
            strengthText.textContent = 'Minimum 6 characters required';
            strengthText.style.color = '#666';
        }
        
        // If campus admin, lock campus to their campus
        if (!this.isSuperAdmin && this.userCampus && campusSelect) {
            campusSelect.value = this.userCampus;
            campusSelect.disabled = true;
            
            // Add notice
            const campusGroup = campusSelect.closest('.form-group-modern');
            let notice = campusGroup?.querySelector('.campus-lock-notice');
            if (campusGroup && !notice) {
                notice = document.createElement('small');
                notice.className = 'campus-lock-notice form-help';
                notice.style.color = '#dc143c';
                notice.innerHTML = `<i class="fas fa-lock"></i> Locked to your campus: <strong>${this.userCampus}</strong>`;
                campusGroup.appendChild(notice);
            }
        } else if (campusSelect) {
            campusSelect.disabled = false;
            const campusGroup = campusSelect.closest('.form-group-modern');
            const notice = campusGroup?.querySelector('.campus-lock-notice');
            if (notice) notice.remove();
        }
        
        // Show modal
        modal.style.display = 'flex';
        
        // Focus on first input
        setTimeout(() => {
            const firstInput = modal.querySelector('input[type="text"]');
            if (firstInput) firstInput.focus();
        }, 100);
    }

    async showEditUserModal(userId) {
        try {
            const response = await fetch(`api/users.php?action=get&id=${userId}`);
            const result = await response.json();
            
            if (result.success) {
                const user = result.user;
                const modal = document.getElementById('userModal');
                const title = document.getElementById('userModalTitle');
                const subtitle = modal.querySelector('.modal-subtitle');
                const passwordLabel = document.getElementById('passwordLabel');
                const passwordInput = document.getElementById('userPassword');
                
                // Update modal title and subtitle
                title.textContent = 'Edit User';
                if (subtitle) {
                    subtitle.textContent = `Update information for ${user.name}`;
                }
                
                // Update password label
                if (passwordLabel) {
                    passwordLabel.textContent = '(Leave blank to keep current)';
                    passwordLabel.style.display = 'inline';
                }
                
                // Fill form with user data
                document.getElementById('userId').value = user.id;
                document.getElementById('userName').value = user.name || '';
                document.getElementById('userEmail').value = user.email || '';
                document.getElementById('userRole').value = user.role || 'user';
                document.getElementById('userStatus').value = user.status || 'active';
                document.getElementById('userCampus').value = user.campus || '';
                document.getElementById('userOffice').value = user.office || '';
                
                // Password not required for edit
                if (passwordInput) {
                    passwordInput.value = '';
                    passwordInput.required = false;
                    passwordInput.placeholder = 'Leave blank to keep current password';
                }
                
                // Reset password strength indicator
                const strengthFill = document.getElementById('strengthFill');
                const strengthText = document.getElementById('strengthText');
                if (strengthFill) strengthFill.className = 'strength-fill';
                if (strengthText) {
                    strengthText.textContent = 'Leave blank to keep current password';
                    strengthText.style.color = '#666';
                }
                
                // Handle role-based field visibility
                handleRoleChange();
                
                // Show modal
                modal.style.display = 'flex';
                
                // Focus on first input
                setTimeout(() => {
                    const firstInput = modal.querySelector('input[type="text"]');
                    if (firstInput) firstInput.focus();
                }, 100);
            } else {
                this.showNotification('Failed to load user: ' + result.error, 'error');
            }
        } catch (error) {
            console.error('Error loading user:', error);
            this.showNotification('Error loading user', 'error');
        }
    }

    async saveUserFromModal(event) {
        event.preventDefault();
        
        const userId = document.getElementById('userId').value;
        const isEdit = userId !== '';
        
        const name = document.getElementById('userName').value.trim();
        const email = document.getElementById('userEmail').value.trim();
        const password = document.getElementById('userPassword').value;
        const role = document.getElementById('userRole').value;
        const status = document.getElementById('userStatus').value;
        const campus = document.getElementById('userCampus').value;
        const office = document.getElementById('userOffice').value.trim();
        
        // Validation
        if (!name || !email) {
            this.showNotification('Name and email are required', 'error');
            return;
        }
        
        if (!isEdit && !password) {
            this.showNotification('Password is required for new users', 'error');
            return;
        }
        
        if (password && password.length < 6) {
            this.showNotification('Password must be at least 6 characters', 'error');
            return;
        }
        
        const userData = {
            name,
            email,
            role,
            status,
            campus,
            office
        };
        
        if (isEdit) {
            userData.id = userId;
            if (password) {
                userData.password = password;
            }
        } else {
            userData.password = password;
        }
        
        try {
            const action = isEdit ? 'update' : 'create';
            const response = await fetch(`api/users.php?action=${action}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(userData)
            });
            
            const result = await response.json();
            
            if (result.success) {
                this.showNotification(isEdit ? 'User updated successfully!' : 'User created successfully!', 'success');
                closeUserModal();
                this.loadUsers();
            } else {
                this.showNotification('Error: ' + result.error, 'error');
            }
        } catch (error) {
            console.error('Error saving user:', error);
            this.showNotification('Error saving user', 'error');
        }
    }

    showDeleteUserModal(userId) {
        // First, get user info
        fetch(`api/users.php?action=get&id=${userId}`)
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    const user = result.user;
                    const modal = document.getElementById('deleteModal');
                    const userInfo = document.getElementById('deleteUserInfo');
                    
                    userInfo.innerHTML = `<strong>${user.name}</strong> (${user.email})`;
                    modal.dataset.userId = userId;
                    modal.style.display = 'flex';
                }
            })
            .catch(error => {
                console.error('Error loading user:', error);
                this.showNotification('Error loading user', 'error');
            });
    }

    async confirmDeleteUser() {
        const modal = document.getElementById('deleteModal');
        const userId = modal.dataset.userId;
        
        if (!userId) return;
        
        try {
            const response = await fetch('api/users.php?action=delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ id: userId })
            });
            
            const result = await response.json();
            
            if (result.success) {
                this.showNotification('User deleted successfully', 'success');
                closeDeleteModal();
                this.loadUsers();
            } else {
                this.showNotification('Error: ' + result.error, 'error');
            }
        } catch (error) {
            console.error('Error deleting user:', error);
            this.showNotification('Error deleting user', 'error');
        }
    }

    showNotification(message, type = 'info') {
        // Create notification element
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle'}"></i>
            <span>${message}</span>
        `;
        
        document.body.appendChild(notification);
        
        // Show notification
        setTimeout(() => {
            notification.classList.add('show');
        }, 100);
        
        // Hide and remove notification
        setTimeout(() => {
            notification.classList.remove('show');
            setTimeout(() => {
                notification.remove();
            }, 300);
        }, 3000);
    }

    // Data Tables Management
    async loadTableData() {
        const reportType = document.getElementById('reportTypeSelect').value;
        
        if (!reportType) {
            alert('Please select a report type');
            return;
        }

        const container = document.getElementById('dataTableContainer');
        const tableInfo = document.getElementById('tableInfo');
        
        container.innerHTML = '<div class="empty-state"><i class="fas fa-spinner fa-spin"></i><h3>Loading data...</h3></div>';

        try {
            const response = await fetch(`api/get_table_data.php?table=${reportType}`);
            const result = await response.json();

            if (result.success && result.data.length > 0) {
                this.renderDataTable(result.data, reportType);
                
                // Update table info
                document.getElementById('totalRecords').textContent = result.data.length;
                document.getElementById('lastUpdated').textContent = new Date().toLocaleString();
                tableInfo.style.display = 'flex';
            } else {
                container.innerHTML = `
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h3>No Data Found</h3>
                        <p>There are no records for this report type</p>
                    </div>
                `;
                tableInfo.style.display = 'none';
            }
        } catch (error) {
            console.error('Error loading table data:', error);
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>Error Loading Data</h3>
                    <p>${error.message}</p>
                </div>
            `;
        }
    }

    renderDataTable(data, tableName) {
        const container = document.getElementById('dataTableContainer');
        
        if (!data || data.length === 0) {
            container.innerHTML = '<div class="empty-state"><i class="fas fa-inbox"></i><h3>No data available</h3></div>';
            return;
        }

        const columns = Object.keys(data[0]);
        
        let tableHTML = `
            <div class="data-table-wrapper">
                <table class="data-table">
                    <thead>
                        <tr>
                            ${columns.map(col => `<th>${col}</th>`).join('')}
                            <th class="actions-cell">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
        `;

        data.forEach((row, index) => {
            tableHTML += '<tr>';
            columns.forEach(col => {
                tableHTML += `<td>${row[col] || '-'}</td>`;
            });
            tableHTML += `
                <td class="actions-cell">
                    <button class="action-btn edit" onclick="adminDashboard.editRecord('${tableName}', ${row.id || index})">
                        <i class="fas fa-edit"></i> Edit
                    </button>
                    <button class="action-btn copy" onclick="adminDashboard.copyRecord(${index})">
                        <i class="fas fa-copy"></i> Copy
                    </button>
                    <button class="action-btn delete" onclick="adminDashboard.deleteRecord('${tableName}', ${row.id || index})">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                </td>
            </tr>`;
        });

        tableHTML += `
                    </tbody>
                </table>
            </div>
        `;

        container.innerHTML = tableHTML;
        this.currentTableData = data;
    }

    editRecord(tableName, recordId) {
        alert(`Edit functionality for ${tableName} record ${recordId} - Coming soon`);
    }

    copyRecord(index) {
        if (this.currentTableData && this.currentTableData[index]) {
            const record = this.currentTableData[index];
            const text = JSON.stringify(record, null, 2);
            
            navigator.clipboard.writeText(text).then(() => {
                alert('Record copied to clipboard!');
            }).catch(err => {
                console.error('Failed to copy:', err);
            });
        }
    }

    async deleteRecord(tableName, recordId) {
        if (!confirm('Are you sure you want to delete this record?')) {
            return;
        }

        try {
            const response = await fetch('api/delete_record.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    table: tableName,
                    id: recordId
                }),
                credentials: 'include'
            });

            const result = await response.json();

            if (result.success) {
                alert('Record deleted successfully');
                this.loadTableData();
            } else {
                alert('Failed to delete record: ' + result.error);
            }
        } catch (error) {
            console.error('Error deleting record:', error);
            alert('Error deleting record');
        }
    }

    exportTableData() {
        const reportType = document.getElementById('reportTypeSelect').value;
        
        if (!reportType) {
            alert('Please select a report type first');
            return;
        }

        if (!this.currentTableData || this.currentTableData.length === 0) {
            alert('No data to export. Please load data first.');
            return;
        }

        // Convert to CSV
        const columns = Object.keys(this.currentTableData[0]);
        let csv = columns.join(',') + '\n';
        
        this.currentTableData.forEach(row => {
            const values = columns.map(col => {
                const value = row[col] || '';
                return `"${value}"`;
            });
            csv += values.join(',') + '\n';
        });

        // Download
        const blob = new Blob([csv], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `${reportType}_${new Date().toISOString().split('T')[0]}.csv`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        window.URL.revokeObjectURL(url);
    }
}

// Global functions
function closeSubmissionModal() {
    const modal = document.getElementById('submissionModal');
    if (modal) {
        modal.style.display = 'none';
    }
}

// User Management Functions
function addUser() {
    window.adminDashboard.showAddUserModal();
}

function editUser(userId) {
    window.adminDashboard.showEditUserModal(userId);
}

function deleteUser(userId) {
    window.adminDashboard.showDeleteUserModal(userId);
}

function saveUser(event) {
    window.adminDashboard.saveUserFromModal(event);
}

function closeUserModal() {
    const modal = document.getElementById('userModal');
    modal.style.display = 'none';
}

function closeDeleteModal() {
    const modal = document.getElementById('deleteModal');
    modal.style.display = 'none';
}

function confirmDeleteUser() {
    window.adminDashboard.confirmDeleteUser();
}

function handleRoleChange() {
    const role = document.getElementById('userRole').value;
    const officeGroup = document.getElementById('officeGroup');
    const campusSelect = document.getElementById('userCampus');
    
    if (role === 'super_admin') {
        // Super admin: All Campuses, no office
        campusSelect.value = 'All Campuses';
        campusSelect.disabled = true;
        officeGroup.style.display = 'none';
    } else if (role === 'admin') {
        // Campus admin: specific campus, no office
        campusSelect.disabled = false;
        officeGroup.style.display = 'none';
    } else {
        // Office user: specific campus and office
        campusSelect.disabled = false;
        officeGroup.style.display = 'block';
    }
}

function togglePasswordVisibility(inputId) {
    const input = document.getElementById(inputId);
    const button = input.nextElementSibling;
    const icon = button.querySelector('i');
    
    if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        input.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
}

function filterUsersTable() {
    const searchTerm = document.getElementById('userSearch').value.toLowerCase();
    const roleFilter = document.getElementById('userRoleFilter').value;
    const statusFilter = document.getElementById('userStatusFilter').value;
    
    const tbody = document.getElementById('usersTableBody');
    const rows = tbody.getElementsByTagName('tr');
    
    let visibleCount = 0;
    
    for (let row of rows) {
        if (row.cells.length < 2) continue; // Skip loading/empty rows
        
        const name = row.cells[1].textContent.toLowerCase();
        const email = row.cells[2].textContent.toLowerCase();
        const role = row.cells[3].textContent.toLowerCase();
        const status = row.cells[6].textContent.toLowerCase();
        
        const matchesSearch = name.includes(searchTerm) || email.includes(searchTerm);
        const matchesRole = !roleFilter || role.includes(roleFilter.replace('_', ' ').toLowerCase());
        const matchesStatus = !statusFilter || status.includes(statusFilter);
        
        if (matchesSearch && matchesRole && matchesStatus) {
            row.style.display = '';
            visibleCount++;
        } else {
            row.style.display = 'none';
        }
    }
    
    // Show "no results" message if needed
    if (visibleCount === 0 && rows.length > 0) {
        const noResultsRow = tbody.querySelector('.no-results-row');
        if (!noResultsRow) {
            const newRow = tbody.insertRow(0);
            newRow.className = 'no-results-row';
            newRow.innerHTML = '<td colspan="9" style="text-align: center; padding: 40px;"><i class="fas fa-search" style="font-size: 48px; color: #ccc; margin-bottom: 10px;"></i><p style="color: #666;">No users match your filters</p></td>';
        }
    } else {
        const noResultsRow = tbody.querySelector('.no-results-row');
        if (noResultsRow) noResultsRow.remove();
    }
}

function backupData() {
    alert('Backup Data functionality - Coming soon');
}

function systemMaintenance() {
    alert('System Maintenance functionality - Coming soon');
}

function generateReport() {
    alert('Generate Report functionality - Coming soon');
}

// Notification Functions
function toggleNotifications() {
    const dropdown = document.getElementById('notificationsDropdown');
    dropdown.classList.toggle('show');
    
    // Close when clicking outside
    if (dropdown.classList.contains('show')) {
        setTimeout(() => {
            document.addEventListener('click', closeNotificationsOutside);
        }, 100);
        
        // Load notifications
        loadNotifications();
    }
}

function closeNotificationsOutside(event) {
    const dropdown = document.getElementById('notificationsDropdown');
    const notifications = document.querySelector('.notifications');
    
    if (!dropdown.contains(event.target) && !notifications.contains(event.target)) {
        dropdown.classList.remove('show');
        document.removeEventListener('click', closeNotificationsOutside);
    }
}

function loadNotifications() {
    // Sample notifications - replace with actual API call
    const notifications = [
        {
            id: 1,
            type: 'success',
            icon: 'fa-check-circle',
            title: 'Report Approved',
            message: 'Campus Population report from Lipa has been approved',
            time: '5 minutes ago',
            unread: true
        },
        {
            id: 2,
            type: 'warning',
            icon: 'fa-exclamation-triangle',
            title: 'Pending Review',
            message: '3 new submissions awaiting your review',
            time: '1 hour ago',
            unread: true
        },
        {
            id: 3,
            type: 'info',
            icon: 'fa-user-plus',
            title: 'New User Added',
            message: 'John Doe has been added to the system',
            time: '2 hours ago',
            unread: false
        }
    ];
    
    renderNotifications(notifications);
}

function renderNotifications(notifications) {
    const list = document.getElementById('notificationsList');
    const badge = document.getElementById('notificationCount');
    
    if (notifications.length === 0) {
        list.innerHTML = `
            <div class="notification-empty">
                <i class="fas fa-bell-slash"></i>
                <p>No new notifications</p>
            </div>
        `;
        badge.textContent = '0';
        badge.style.display = 'none';
        return;
    }
    
    const unreadCount = notifications.filter(n => n.unread).length;
    badge.textContent = unreadCount;
    badge.style.display = unreadCount > 0 ? 'flex' : 'none';
    
    list.innerHTML = notifications.map(notif => `
        <div class="notification-item ${notif.unread ? 'unread' : ''}" onclick="markAsRead(${notif.id})">
            <div class="notification-icon ${notif.type}">
                <i class="fas ${notif.icon}"></i>
            </div>
            <div class="notification-content">
                <div class="notification-title">${notif.title}</div>
                <div class="notification-message">${notif.message}</div>
                <div class="notification-time">${notif.time}</div>
            </div>
        </div>
    `).join('');
}

function markAsRead(notificationId) {
    console.log('Marking notification as read:', notificationId);
    // Implement mark as read functionality
}

function markAllAsRead(event) {
    event.stopPropagation();
    console.log('Marking all notifications as read');
    const badge = document.getElementById('notificationCount');
    badge.textContent = '0';
    badge.style.display = 'none';
    
    // Remove unread class from all items
    document.querySelectorAll('.notification-item.unread').forEach(item => {
        item.classList.remove('unread');
    });
}

function viewAllNotifications(event) {
    event.preventDefault();
    console.log('Viewing all notifications');
    // Navigate to notifications page or show modal
}

// Password Strength Checker
function checkPasswordStrength() {
    const password = document.getElementById('userPassword').value;
    const strengthFill = document.getElementById('strengthFill');
    const strengthText = document.getElementById('strengthText');
    
    if (!password) {
        strengthFill.className = 'strength-fill';
        strengthText.textContent = 'Minimum 6 characters required';
        return;
    }
    
    let strength = 0;
    if (password.length >= 6) strength++;
    if (password.length >= 10) strength++;
    if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
    if (/\d/.test(password)) strength++;
    if (/[^a-zA-Z\d]/.test(password)) strength++;
    
    if (strength <= 2) {
        strengthFill.className = 'strength-fill weak';
        strengthText.textContent = 'Weak password';
        strengthText.style.color = '#dc3545';
    } else if (strength <= 3) {
        strengthFill.className = 'strength-fill medium';
        strengthText.textContent = 'Medium password';
        strengthText.style.color = '#ffc107';
    } else {
        strengthFill.className = 'strength-fill strong';
        strengthText.textContent = 'Strong password';
        strengthText.style.color = '#28a745';
    }
}

// Add password strength checker on input
document.addEventListener('DOMContentLoaded', () => {
    const passwordInput = document.getElementById('userPassword');
    if (passwordInput) {
        passwordInput.addEventListener('input', checkPasswordStrength);
    }
});

// Navigation and Dashboard Functions
function navigateToSection(sectionId) {
    if (window.adminDashboard) {
        window.adminDashboard.showSection(sectionId);
    }
}

function refreshDashboard() {
    if (window.adminDashboard) {
        window.adminDashboard.loadDashboardData();
        window.adminDashboard.showNotification('Dashboard refreshed', 'success');
    }
}

function updateDashboardStats() {
    if (window.adminDashboard) {
        window.adminDashboard.loadDashboardStats();
    }
}

function exportChart(chartId) {
    const canvas = document.getElementById(chartId);
    if (!canvas) {
        alert('Chart not found');
        return;
    }
    
    // Convert canvas to image
    const url = canvas.toDataURL('image/png');
    
    // Create download link
    const link = document.createElement('a');
    link.download = `${chartId}_${new Date().toISOString().split('T')[0]}.png`;
    link.href = url;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    
    if (window.adminDashboard) {
        window.adminDashboard.showNotification('Chart exported successfully', 'success');
    }
}

function exportReportStats() {
    alert('Export Report Stats - Coming soon');
}

function exportCampusStats() {
    alert('Export Campus Stats - Coming soon');
}

function exportUserActivity() {
    alert('Export User Activity - Coming soon');
}

function exportAllData() {
    alert('Export All Data - Coming soon');
}

function generateStatisticsReport() {
    alert('Generate Statistics Report - Coming soon');
}

// Initialize dashboard when DOM is loaded
document.addEventListener('DOMContentLoaded', async () => {
    console.log('DOMContentLoaded - Initializing AdminDashboard');
    try {
        window.adminDashboard = new AdminDashboard();
        await window.adminDashboard.init();
        console.log('AdminDashboard initialized successfully');
    } catch (error) {
        console.error('Failed to initialize AdminDashboard:', error);
    }
});
