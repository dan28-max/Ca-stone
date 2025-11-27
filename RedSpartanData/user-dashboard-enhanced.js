// Enhanced User Dashboard with Admin-Style UI
class UserDashboard {
    constructor() {
        this.currentUser = null;
        this.assignedReports = [];
        this.submissions = [];
        // Activity log state
        this.userActivities = [];
        // Campus mapping (extend as needed)
        this.campusMap = {
            'Main': 'Main',
            'Lipa': 'Lipa',
            'Alangilan': 'Alangilan',
            'Mabini': 'Mabini',
            'Nasugbu': 'Nasugbu',
            'Balayan': 'Balayan',
            'SanJuan': 'San Juan',
            'Lemery': 'Lemery',
            'Rosario': 'Rosario',
            'Malvar': 'Malvar'
        };
        // Demo mode off by default; production should use live APIs
        this.useDemoAPIs = false;
        this.dateSortOrder = 'desc'; // 'asc' or 'desc'
        this.analyticsReportType = ''; // For filtering analytics by report type
        this.allSubmissions = []; // Store all submissions for analytics
        // Calendar state
        this.currentMonth = new Date();
        this.calendarEvents = [];
        // Dashboard sync
        this.sync = window.dashboardSync || null;
        this.init();
    }

    getSubmissionStats(tableName) {
        try {
            const t = String(tableName || '').toLowerCase();
            const list = Array.isArray(this.submissions) ? this.submissions : [];
            const filtered = list.filter(s => String(s.table_name || s.report_type || '').toLowerCase() === t);
            const count = filtered.length;
            let latest = '';
            if (count) {
                const dates = filtered.map(s => new Date(s.submission_date || s.submitted_at || s.created_at)).filter(d => !isNaN(d));
                if (dates.length) {
                    const max = new Date(Math.max.apply(null, dates));
                    latest = max.toLocaleDateString(undefined, { month: 'short', day: '2-digit', year: 'numeric' });
                }
            }
            return { count, latest };
        } catch(_) { return { count: 0, latest: '' }; }
    }

    getIconForTable(tableName) {
        const key = String(tableName || '').toLowerCase();
        const map = {
            admissiondata: 'fa-file-signature',
            enrollmentdata: 'fa-user-graduate',
            graduatesdata: 'fa-graduation-cap',
            employee: 'fa-id-badge',
            leaveprivilege: 'fa-umbrella-beach',
            libraryvisitor: 'fa-book-open',
            pwd: 'fa-wheelchair',
            waterconsumption: 'fa-tint',
            treatedwastewater: 'fa-recycle',
            electricityconsumption: 'fa-bolt',
            solidwaste: 'fa-trash',
            campuspopulation: 'fa-users',
            foodwaste: 'fa-utensils',
            fuelconsumption: 'fa-gas-pump',
            distancetraveled: 'fa-route',
            budgetexpenditure: 'fa-coins',
            flightaccommodation: 'fa-plane'
        };
        return map[key] || 'fa-file-alt';
    }

    viewTaskDetails(taskId) {
        try {
            const r = (this.assignedReports || []).find(x => String(x.id) === String(taskId));
            if (!r) { alert('Task not found'); return; }
            // Build a lightweight detail modal using the same overlay as report modal
            let overlay = document.getElementById('taskDetailsOverlay');
            if (overlay) overlay.parentElement.removeChild(overlay);
            overlay = document.createElement('div');
            overlay.id = 'taskDetailsOverlay';
            overlay.style.cssText = 'position:fixed;inset:0;z-index:9998;background:rgba(0,0,0,0.4);display:flex;align-items:center;justify-content:center;padding:24px';
            const card = document.createElement('div');
            card.style.cssText = 'width:min(560px,96vw);background:#fff;border-radius:16px;box-shadow:0 20px 60px rgba(0,0,0,0.25);overflow:hidden;border:1px solid #e5e7eb;';
            const header = document.createElement('div');
            header.style.cssText = 'display:flex;align-items:center;justify-content:space-between;padding:12px 16px;background:linear-gradient(90deg,#dc143c,#ef4444);color:#fff';
            header.innerHTML = `<div style="font-weight:800;">Task Details</div><button type="button" style="background:transparent;border:0;color:#fff;font-size:18px;cursor:pointer" id="tdClose"><i class="fas fa-times"></i></button>`;
            const body = document.createElement('div');
            body.style.cssText = 'padding:16px;display:flex;flex-direction:column;gap:10px';
            const facts = [
                ['Report', this.formatReportName(r.table_name)],
                ['Description', r.description || 'No description available'],
                ['Office', r.assigned_office || r.office || 'N/A'],
                ['Campus', r.assigned_campus || r.campus || r.campus_name || 'N/A'],
                ['Assigned', this.formatDate(r.assigned_at)],
                ['Due', r.deadline_formatted || r.deadline || 'No deadline'],
            ];
            facts.forEach(([k,v]) => {
                const row = document.createElement('div');
                row.innerHTML = `<strong style="display:inline-block;min-width:110px;color:#374151;">${k}:</strong> <span style="color:#111827;">${v}</span>`;
                body.appendChild(row);
            });
            const footer = document.createElement('div');
            footer.style.cssText = 'padding:12px 16px;display:flex;justify-content:flex-end;gap:10px;background:#f9fafb;border-top:1px solid #e5e7eb';
            const close = document.createElement('button');
            close.className = 'btn-secondary';
            close.innerHTML = '<i class="fas fa-times"></i> Close';
            close.onclick = () => { overlay.parentElement && overlay.parentElement.removeChild(overlay); };
            const go = document.createElement('button');
            go.className = 'btn-submit-report';
            go.innerHTML = '<i class="fas fa-paper-plane"></i> Submit Report';
            go.onclick = () => { overlay.parentElement && overlay.parentElement.removeChild(overlay); this.submitReport(r.table_name, r.id, r.assigned_office || r.office || ''); };
            footer.appendChild(close);
            footer.appendChild(go);
            card.appendChild(header); card.appendChild(body); card.appendChild(footer);
            overlay.appendChild(card);
            document.body.appendChild(overlay);
            overlay.addEventListener('click', (e) => { if (e.target === overlay) { overlay.parentElement && overlay.parentElement.removeChild(overlay); } });
            document.getElementById('tdClose')?.addEventListener('click', () => { overlay.parentElement && overlay.parentElement.removeChild(overlay); });
        } catch(_) { alert('Unable to open details'); }
    }

    // Read query parameter by name
    getQueryParam(name) {
        try {
            const url = new URL(window.location.href);
            return url.searchParams.get(name);
        } catch(_) { return null; }
    }

    // If redirected back with a table indicator, remove that task immediately
    handleSubmissionReturn() {
        // Disabled to avoid any layout/section change on return from report
        return;
    }

    // Core initialization restored
    async init() {
        try {
            await this.loadUserSession();
        } catch (_) {}
        try { this.setupEventListeners(); } catch(_) {}
        try { this.installSubmissionInterceptor(); } catch(_) {}
        try { this.setupMessageListener && this.setupMessageListener(); } catch(_) {}
        try { await this.loadSubmissions(); } catch(_) {}
        try { await this.loadUserActivities(); } catch(_) {}
        try { await this.loadAnalytics(); } catch(_) {}
        // Load assigned tasks on startup so pending-removal can apply instantly
        try { await this.loadAssignedReports(); } catch(_) {}
        // Handle return-from-submit via URL query params
        try { this.handleSubmissionReturn(); } catch(_) {}
        
        // Register with global sync manager
        window.userDashboard = this;
    }

    // Wrap window.fetch to detect successful report submissions and update UI instantly
    installSubmissionInterceptor() {
        if (this._fetchWrapped) return;
        const originalFetch = window.fetch.bind(window);
        const self = this;
        window.fetch = async function(input, init) {
            const url = (typeof input === 'string') ? input : (input && input.url) || '';
            let submittedTable = null;
            try {
                if (url.includes('api/submit_report.php')) {
                    // Try to read tableName from request body
                    if (init && init.body && typeof init.body === 'string') {
                        try { const body = JSON.parse(init.body); submittedTable = body.tableName || body.table || null; } catch(_) {}
                    } else if (input && typeof input !== 'string' && input.body) {
                        try { const clone = input.clone(); const txt = await clone.text(); const body = JSON.parse(txt); submittedTable = body.tableName || body.table || null; } catch(_) {}
                    }
                    // Fallback: read from URL query
                    if (!submittedTable) {
                        try { const u = new URL(url, window.location.origin); submittedTable = u.searchParams.get('table') || submittedTable; } catch(_) {}
                    }
                }
            } catch(_) {}

            const resp = await originalFetch(input, init);
            try {
                if (url.includes('api/submit_report.php')) {
                    const clone = resp.clone();
                    let ok = resp.ok;
                    let result = null;
                    try { result = await clone.json(); } catch(_) { result = null; }
                    if (ok && result && result.success) {
                        if (submittedTable) {
                            // Store and remove immediately
                            try { localStorage.setItem('lastSubmittedTask', JSON.stringify({ table: submittedTable })); } catch(_) {}
                            try {
                                self.applyPendingRemoval();
                                self.renderAssignedReports();
                            } catch(_) {}
                            // Force a quick refresh from server to reflect completed status
                            try {
                                setTimeout(() => { self.loadAssignedReports(); }, 200);
                                // Start aggressive short polling to guarantee disappearance
                                self.ensureTaskGone && self.ensureTaskGone(submittedTable);
                            } catch(_) {}
                            
                            // Refresh analytics after successful submission with retry logic
                            try {
                                const refreshAnalytics = async (attempt = 1) => {
                                    try {
                                        // Force reload submissions to get latest data (with cache busting)
                                        await self.loadSubmissions(true);
                                        // Then refresh analytics (force refresh even if dashboard not visible)
                                        await self.refreshUserAnalyticsIfVisible(true);
                                        
                                        // If still no data and we haven't tried too many times, retry
                                        if (attempt < 3 && (!self.allSubmissions || self.allSubmissions.length === 0)) {
                                            setTimeout(() => refreshAnalytics(attempt + 1), 2000);
                                        }
                                    } catch (err) {
                                        console.error(`Error refreshing analytics after fetch submission (attempt ${attempt}):`, err);
                                        // Retry on error
                                        if (attempt < 3) {
                                            setTimeout(() => refreshAnalytics(attempt + 1), 2000);
                                        }
                                    }
                                };
                                
                                // Start refresh after initial delay
                                setTimeout(() => refreshAnalytics(1), 1500);
                            } catch(_) {}
                            
                            // Sync: Notify admin dashboard about new submission
                            if (self.sync) {
                                self.sync.broadcast('submission_updated', { 
                                    table: submittedTable,
                                    timestamp: Date.now() 
                                });
                            }
                        } else {
                            // If we couldn't extract table, still trigger a refresh
                            try {
                                self.loadAssignedReports();
                                self.ensureTaskGone && self.ensureTaskGone();
                            } catch(_) {}
                            
                            // Sync: Notify admin dashboard about new submission
                            if (self.sync) {
                                self.sync.broadcast('submission_updated', { 
                                    timestamp: Date.now() 
                                });
                            }
                        }
                    }
                }
            } catch(_) {}
            return resp;
        };
        this._fetchWrapped = true;
    }

    // Short, bounded polling to guarantee the submitted task disappears
    ensureTaskGone(submittedTable) {
        try {
            const lastInfo = (function(){
                try { const v = localStorage.getItem('lastSubmittedTask'); return v ? JSON.parse(v) : null; } catch(_) { return null; }
            })();
            const last = submittedTable || (lastInfo && lastInfo.table) || null;
            if (!last) return;
            const target = last.toString().toLowerCase();
            const targetOffice = (lastInfo && (lastInfo.office || '')) ? String(lastInfo.office).toLowerCase() : '';
            let tries = 0;
            const maxTries = 5; // ~3s total at 600ms intervals
            const tick = async () => {
                tries++;
                try {
                    // Remove any matching DOM card now
                    document.querySelectorAll('.report-card,[data-table]')
                        .forEach(el => {
                            const ct = (el.getAttribute('data-table') || '').toLowerCase();
                            const co = (el.getAttribute('data-office') || '').toLowerCase();
                            const match = ct === target && (!targetOffice || co === targetOffice);
                            if (match && el.parentElement) el.parentElement.removeChild(el);
                        });
                } catch(_) {}
                try { await this.loadAssignedReports(); } catch(_) {}
                if (tries < maxTries) {
                    this._ensureTimer = setTimeout(tick, 600);
                } else {
                    try { localStorage.removeItem('lastSubmittedTask'); } catch(_) {}
                }
            };
            // kick off
            this._ensureTimer && clearTimeout(this._ensureTimer);
            tick();
        } catch(_) {}
    }

    // Immediately refresh the My Tasks grid and empty state
    refreshMyTasksNow() {
        try {
            const container = this.getTasksContainer();
            const emptyState = document.getElementById('dataEmpty') || document.getElementById('reportsEmpty');
            if (container) {
                // Remove any lingering cards for recently submitted task
                const last = localStorage.getItem('lastSubmittedTask');
                if (last) {
                    try {
                        const info = JSON.parse(last);
                        const tName = (info.table || info.tableName || '').toString().toLowerCase();
                        const tOffice = (info.office || info.assigned_office || '').toString().toLowerCase();
                        container.querySelectorAll('.report-card,[data-table]')
                            .forEach(el => {
                                const ct = (el.getAttribute('data-table') || '').toLowerCase();
                                const co = (el.getAttribute('data-office') || '').toLowerCase();
                                if (ct && tName && ct === tName && (!tOffice || co === tOffice) && el.parentElement) el.parentElement.removeChild(el);
                            });
                    } catch(_) {}
                }
                // Show quick feedback while reloading from server
                container.innerHTML = '<div class="loading-state" style="text-align:center; padding:24px; color:#666;"><i class="fas fa-spinner fa-spin"></i> Updating tasks...</div>';
            }
            if (emptyState) emptyState.style.display = 'none';
            // Kick a reload
            this.loadAssignedReports && this.loadAssignedReports();
        } catch(_) {}
    }

    async loadUserSession() {
        try {
            const resp = await fetch('api/simple_auth.php?action=check', { credentials: 'include' });
            if (!resp.ok) throw new Error('auth http ' + resp.status);
            const result = await resp.json();
            if (result && result.success && result.data && result.data.authenticated) {
                this.currentUser = {
                    id: result.data.user_id,
                    username: result.data.username,
                    name: result.data.username,
                    role: result.data.role || 'User'
                };
                this.useDemoAPIs = false;
                this.updateUserInfo();
                return true;
            }
        } catch (_) {}
        // Fallback to any cached session
        try {
            const cached = localStorage.getItem('userSession');
            if (cached) {
                this.currentUser = JSON.parse(cached);
                this.updateUserInfo();
                return true;
            }
        } catch(_) {}
        return false;
    }

    updateUserInfo() {
        const displayName = (this.currentUser?.username || this.currentUser?.name || 'User');
        const role = this.currentUser?.role || 'User';
        const nameEl = document.getElementById('userName');
        const roleEl = document.getElementById('userRole');
        const avatarEl = document.getElementById('userAvatar');
        if (nameEl) nameEl.textContent = displayName;
        if (roleEl) roleEl.textContent = role;
        if (avatarEl && displayName) avatarEl.textContent = displayName.charAt(0).toUpperCase();
    }

    setupEventListeners() {
        // Basic nav switching if present
        document.querySelectorAll('.nav-item').forEach(item => {
            item.addEventListener('click', () => {
                const section = item.dataset.section;
                if (section) this.showSection(section);
            });
        });

        // Auto-refresh assigned reports when the page regains focus or becomes visible
        const refreshAssigned = () => {
            try { this.loadAssignedReports(); } catch(_) {}
        };
        if (!this._refreshBound) {
            window.addEventListener('focus', refreshAssigned);
            document.addEventListener('visibilitychange', () => {
                if (document.visibilityState === 'visible') refreshAssigned();
            });
            // Listen for cross-tab storage updates set by report.html
            window.addEventListener('storage', (e) => {
                try {
                    if (e && e.key === 'lastSubmittedTask' && e.newValue) {
                        this.applyPendingRemoval();
                        this.renderAssignedReports();
                        this.loadAssignedReports();
                    }
                } catch(_) {}
            });
            // Allow direct postMessage from report.html
            window.addEventListener('message', (event) => {
                try {
                    const data = event && event.data;
                    // Accept both structured and unstructured messages from report.html
                    if (data && data.type === 'report-submitted') {
                        localStorage.setItem('lastSubmittedTask', JSON.stringify({ table: data.table, office: data.office || '' }));
                        // Close modal on successful submission
                        this.closeReportModal && this.closeReportModal();
                    }
                    // Also handle 'reportSubmitted' type from report.js
                    if (data && data.type === 'reportSubmitted' && data.success) {
                        localStorage.setItem('lastSubmittedTask', JSON.stringify({ table: data.tableName || data.table, office: data.office || '' }));
                        // Close modal on successful submission
                        this.closeReportModal && this.closeReportModal();
                    }
                    // Treat postMessage as a completion signal, remove only the matching card
                    this.applyPendingRemoval();
                    // Soft reload without flashing the grid
                    this.loadAssignedReports();
                    
                    // Refresh analytics after successful submission
                    if ((data && data.type === 'report-submitted') || (data && data.type === 'reportSubmitted' && data.success)) {
                        // Reload submissions first, then refresh analytics with multiple attempts
                        const refreshAnalytics = async (attempt = 1) => {
                            try {
                                // Force reload submissions to get latest data (with cache busting)
                                await this.loadSubmissions(true);
                                // Then refresh analytics (force refresh even if dashboard not visible)
                                await this.refreshUserAnalyticsIfVisible(true);
                                
                                // If still no data and we haven't tried too many times, retry
                                if (attempt < 3 && (!this.allSubmissions || this.allSubmissions.length === 0)) {
                                    setTimeout(() => refreshAnalytics(attempt + 1), 2000);
                                }
                            } catch (err) {
                                console.error(`Error refreshing after submission (attempt ${attempt}):`, err);
                                // Retry on error
                                if (attempt < 3) {
                                    setTimeout(() => refreshAnalytics(attempt + 1), 2000);
                                }
                            }
                        };
                        
                        // Start refresh after initial delay
                        setTimeout(() => refreshAnalytics(1), 1500);
                    }
                } catch(_) {}
            });
            this._refreshBound = true;
        }
    }

    async showSection(sectionId) {
        const titles = {
            'dashboard': { title: 'Dashboard', subtitle: 'Welcome back! Here\'s your overview' },
            'my-tasks': { title: 'My Tasks', subtitle: 'Manage your tasks' },
            'calendar': { title: 'Calendar', subtitle: 'View your deadlines and upcoming tasks' },
            'submissions': { title: 'Submissions History', subtitle: 'View all your submitted reports' },
            'activity-log': { title: 'Activity Log', subtitle: 'See your recent activities in the system' },
            'profile': { title: 'My Profile', subtitle: 'View and update your profile information' },
            'help': { title: 'Help & Guide', subtitle: 'Learn how to use the system effectively' }
        };
        if (titles[sectionId]) {
            const t = titles[sectionId];
            const titleEl = document.getElementById('pageTitle');
            const subEl = document.getElementById('pageSubtitle');
            if (titleEl) titleEl.textContent = t.title;
            if (subEl) subEl.textContent = t.subtitle;
        }
        document.querySelectorAll('.content-section').forEach(sec => sec.classList.remove('active'));
        const target = document.getElementById(sectionId);
        if (target) {
            target.classList.add('active');
            console.log('Section activated:', sectionId, 'Element:', target);
            
        }
        
        if (sectionId === 'activity-log') {
            this.loadUserActivities();
        } else if (sectionId === 'submissions') {
            this.loadSubmissions();
        } else if (sectionId === 'my-tasks') {
            // Ensure tasks are loaded/refreshed whenever My Tasks is shown
            this.loadAssignedReports();
        } else if (sectionId === 'calendar') {
            console.log('Calendar section clicked, loading calendar...');
            // Small delay to ensure DOM is ready
            setTimeout(() => {
                const calendarSection = document.getElementById('calendar');
                console.log('Calendar section element:', calendarSection);
                if (calendarSection) {
                    console.log('Calendar section classes:', calendarSection.className);
                }
                this.loadCalendar();
            }, 50);
        } else if (sectionId === 'dashboard') {
            // Refresh analytics when dashboard section is shown
            // Use setTimeout to ensure section is marked as active first
            setTimeout(() => {
                this.refreshUserAnalyticsIfVisible(true);
            }, 100);
        }
    }

    async loadUserActivities() {
        try {
            const container = document.getElementById('userActivityList');
            if (container) {
                container.innerHTML = '<div class="loading-state" style="text-align:center; padding:40px;"><i class="fas fa-spinner fa-spin" style="font-size:24px; color:#dc143c;"></i><p style="margin-top:10px; color:#666;">Loading activity...</p></div>';
                // Immediately show demo activities to avoid perceived hang; will be replaced if API succeeds
                try {
                    const demo = this.getDemoActivities();
                    if (Array.isArray(demo) && demo.length) {
                        this.userActivitiesOriginal = demo;
                        this.setupActivityFilters();
                        this.renderUserActivities(this.filterActivities());
                    }
                } catch(_) {}
            }

            // Demo mode
            if (this.useDemoAPIs) {
                this.userActivitiesOriginal = this.getDemoActivities();
                this.setupActivityFilters();
                this.renderUserActivities(this.filterActivities());
                return;
            }

            // Add timeout/abort to avoid infinite spinner
            const controller = new AbortController();
            const timeoutId = setTimeout(() => controller.abort(), 7000);
            // Include current user id if available to ensure server scopes correctly
            const qp = new URLSearchParams();
            if (this.currentUser && this.currentUser.id) qp.set('user_id', this.currentUser.id);
            const url = 'api/user_activities.php' + (qp.toString() ? ('?' + qp.toString()) : '');
            const resp = await fetch(url, { credentials: 'include', signal: controller.signal, headers: { 'Cache-Control': 'no-cache', 'Pragma': 'no-cache', 'X-Requested-With': 'XMLHttpRequest' } });
            clearTimeout(timeoutId);
            if (!resp.ok) throw new Error('HTTP ' + resp.status);
            const result = await resp.json();
            let activities = (result && (result.activities || result.data)) || [];
            activities = Array.isArray(activities) ? activities : [];
            // Client-side safety filter to current user
            const uid = this.currentUser?.id;
            const uname = (this.currentUser?.username || this.currentUser?.name || '').toString().toLowerCase();
            if (uid || uname) {
                activities = activities.filter(a => {
                    const aUid = a.user_id || a.userId || a.uid || a.userID;
                    const aUname = (a.username || a.user || a.name || '').toString().toLowerCase();
                    return (uid && String(aUid) === String(uid)) || (uname && aUname === uname);
                });
            }
            this.userActivitiesOriginal = activities;
            if (!this.userActivitiesOriginal.length && result && result.success === false) {
                throw new Error(result.error || 'No activities');
            }
            this.setupActivityFilters();
            this.renderUserActivities(this.filterActivities());
        } catch (e) {
            console.error('Failed to load user activities:', e);
            const container = document.getElementById('userActivityList');
            if (container) {
                // Fallback to demo activities so the user sees content
                try {
                    this.userActivitiesOriginal = this.getDemoActivities();
                    this.setupActivityFilters();
                    this.renderUserActivities(this.filterActivities());
                } catch(_) {
                    const message = (e && e.name === 'AbortError') ? 'Request timed out. Please try again.' : 'Unable to load activity log.';
                    container.innerHTML = '<div class="loading-state" style="text-align:center; padding:40px;"><i class="fas fa-exclamation-circle" style="font-size:32px; color:#ef4444;"></i><p style="margin-top:10px; color:#666;">' + message + '</p></div>';
                }
            }
        }
    }

    renderUserActivities(activities) {
        const container = document.getElementById('userActivityList');
        const countEl = document.getElementById('userActivityCount');
        if (!container) return;
        const list = Array.isArray(activities) ? activities : [];
        if (countEl) countEl.textContent = String(list.length);
        if (!list.length) {
            container.innerHTML = '<div style="text-align:center; padding:40px; color:#666;"><i class="fas fa-inbox" style="font-size:42px; color:#ccc; display:block; margin-bottom:8px;"></i>No recent activity</div>';
            return;
        }

        const colorFor = (action) => {
            const a = (action || '').toString().toLowerCase();
            if (a.includes('login')) return '#3b82f6';
            if (a.includes('logout')) return '#6b7280';
            if (a.includes('submit')) return '#10b981';
            if (a.includes('update') || a.includes('edit')) return '#f59e0b';
            if (a.includes('delete') || a.includes('remove')) return '#ef4444';
            return '#dc143c';
        };

        const html = list.map((a) => {
            const actionRaw = (a.action || a.event || 'activity').toString();
            const action = this.formatActionName(actionRaw);
            const c = colorFor(actionRaw);
            const date = a.created_at ? new Date(a.created_at) : (a.timestamp ? new Date(a.timestamp) : null);
            const dateStr = date ? this.formatDateToPhilippines(date) : '';
            const timeAgo = date ? this.getTimeAgo(date) : '';
            const campusCode = a.campus_code || a.campus || '';
            const campusName = this.campusMap[campusCode] || a.campus_name || campusCode || '';
            const desc = a.description || a.details || '';
            const username = a.username || a.user || a.name || 'User';
            const unameBadge = (a.username || '').toString();
            const campusBadge = campusName ? `<span style="background:#e5ecff; color:#1e40af; font-weight:700; padding:4px 8px; border-radius:999px; font-size:10px;">${campusName.toUpperCase()}</span>` : '';
            const avatarText = (username || 'U').toString().charAt(0).toUpperCase();
            const actionBadge = `<span style=\"background:${c}1a; color:${c}; font-weight:700; padding:4px 8px; border-radius:999px; font-size:10px; display:inline-flex; align-items:center; gap:6px;\"><i class=\"fas fa-bolt\"></i>${action}</span>`;

            return `
                <div class="activity-card" style="position:relative; background:#fff; border:1px solid #e5e7eb; border-radius:16px; padding:16px; box-shadow:0 2px 12px rgba(0,0,0,0.06);">
                    <span style="position:absolute; right:12px; top:12px; background:#e5ecff; color:#1e40af; border-radius:999px; font-size:10px; padding:4px 8px;">${timeAgo || ''}</span>
                    <div style="display:flex; gap:12px;">
                        <div style="width:44px; height:44px; border-radius:12px; background: linear-gradient(135deg, ${c}20, ${c}35); color:${c}; display:flex; align-items:center; justify-content:center; font-size:18px; font-weight:800;">
                            ${avatarText}
                        </div>
                        <div style="flex:1;">
                            <div style="display:flex; align-items:center; gap:8px; flex-wrap:wrap;">
                                <strong style="color:#111827;">${username}</strong>
                                ${unameBadge ? `<span style=\"background:#eef2f7; color:#374151; padding:4px 8px; border-radius:999px; font-size:10px;\">${unameBadge}</span>` : ''}
                                ${campusBadge}
                                ${actionBadge}
                            </div>
                            <div style="height:1px; background:#f1f5f9; margin:10px 0;"></div>
                            <div style="border-radius:12px; border:1px solid #e5e7eb; background:#f9fafb; padding:12px; color:#111827;">
                                ${desc ? this.escapeHtml(desc) : action}
                            </div>
                            <div style="display:flex; align-items:center; gap:16px; color:#6b7280; font-size:12px; margin-top:10px;">
                                <span><i class=\"fas fa-calendar\"></i> ${dateStr || ''}</span>
                                ${campusName ? `<span><i class=\"fas fa-map-marker-alt\"></i> ${campusName}</span>` : ''}
                            </div>
                        </div>
                    </div>
                </div>`;
        }).join('');
        container.innerHTML = html;
    }

    escapeHtml(str) {
        return String(str).replace(/[&<>"]+/g, s => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[s]));
    }

    setupActivityFilters() {
        // Populate campus options once
        const campusSel = document.getElementById('userActivityCampus');
        if (campusSel && !campusSel._populated) {
            const campuses = Object.values(this.campusMap || {});
            campuses.forEach(c => {
                const opt = document.createElement('option');
                opt.value = c;
                opt.textContent = c;
                campusSel.appendChild(opt);
            });
            campusSel._populated = true;
        }

        const bind = (id, evt, fn) => {
            const el = document.getElementById(id);
            if (el && !el._bound) { el.addEventListener(evt, fn); el._bound = true; }
        };
        bind('userActivityCampus', 'change', () => this.renderUserActivities(this.filterActivities()));
        bind('userActivityDateFrom', 'change', () => this.renderUserActivities(this.filterActivities()));
        bind('userActivityDateTo', 'change', () => this.renderUserActivities(this.filterActivities()));

        const clearBtn = document.getElementById('userActivityClearBtn');
        if (clearBtn && !clearBtn._bound) {
            clearBtn.addEventListener('click', () => {
                const c = document.getElementById('userActivityCampus'); if (c) c.value = '';
                const f = document.getElementById('userActivityDateFrom'); if (f) f.value = '';
                const t = document.getElementById('userActivityDateTo'); if (t) t.value = '';
                this.renderUserActivities(this.filterActivities());
            });
            clearBtn._bound = true;
        }

        // No export button for user activity log
    }

    filterActivities() {
        const list = Array.isArray(this.userActivitiesOriginal) ? this.userActivitiesOriginal : [];
        const campus = (document.getElementById('userActivityCampus')?.value || '').toString();
        const fromStr = document.getElementById('userActivityDateFrom')?.value || '';
        const toStr = document.getElementById('userActivityDateTo')?.value || '';
        const from = fromStr ? new Date(fromStr + 'T00:00:00') : null;
        const to = toStr ? new Date(toStr + 'T23:59:59') : null;

        return list.filter(a => {
            const campusCode = a.campus_code || a.campus || '';
            const campusName = this.campusMap[campusCode] || a.campus_name || campusCode || '';
            if (campus && campusName !== campus) return false;
            const d = a.created_at ? new Date(a.created_at) : (a.timestamp ? new Date(a.timestamp) : null);
            if (from && d && d < from) return false;
            if (to && d && d > to) return false;
            return true;
        });
    }

    // Export removed per design requirements

    // Helpers similar to admin
    getTimeAgo(date) {
        const now = new Date();
        const seconds = Math.floor((now - date) / 1000);
        const minutes = Math.floor(seconds / 60);
        const hours = Math.floor(minutes / 60);
        const days = Math.floor(hours / 24);
        if (seconds < 60) return 'just now';
        if (minutes < 60) return `${minutes}m ago`;
        if (hours < 24) return `${hours}h ago`;
        return `${days}d ago`;
    }

    formatActionName(str) {
        return String(str || '')
            .replace(/_/g, ' ')
            .replace(/\b\w/g, c => c.toUpperCase());
    }

    getDemoActivities() {
        // Simple demo list
        const now = Date.now();
        return [
            { action: 'login', description: 'Logged in to the system', created_at: new Date(now - 1000*60*5).toISOString(), campus: 'Main' },
            { action: 'open_report', description: 'Opened Enrollment Data report', created_at: new Date(now - 1000*60*60).toISOString(), campus: 'Main' },
            { action: 'submit_report', description: 'Submitted Solid Waste report', created_at: new Date(now - 1000*60*90).toISOString(), campus: 'Main' }
        ];
    }

    async loadAssignedReports() {
        // If using demo mode, skip API call
        if (this.useDemoAPIs) {
            this.assignedReports = this.getDemoReports();
            if (document.getElementById('assignedReportsContainer')) {
                this.applyPendingRemoval();
                this.renderAssignedReports();
            }
            return;
        }
        
        try {
            console.log('Fetching assigned tasks...');
            const response = await fetch('api/user_tasks.php?action=get_assigned', {
                method: 'GET',
                credentials: 'include',  // Important: include session cookies
                headers: {
                    'Cache-Control': 'no-cache'
                }
            });
            
            console.log('Response status:', response.status);
            
            // Check if response is OK
            if (!response.ok) {
                if (response.status === 401) {
                    // Unauthorized - redirect to login
                    window.location.href = 'login.html';
                    return;
                }
                
                // Try to get error details
                try {
                    const errorData = await response.json();
                    console.error('API Error Details:', errorData);
                    console.error('Error Message:', errorData.message);
                    if (errorData.file) console.error('Error File:', errorData.file);
                    if (errorData.line) console.error('Error Line:', errorData.line);
                    if (errorData.trace) console.error('Stack Trace:', errorData.trace);
                } catch (e) {
                    console.error('Could not parse error response');
                }
                // On error, set empty array and render to clear loading state
                this.assignedReports = [];
                this.renderAssignedReports();
                return;
            }
            
            const result = await response.json();
            console.log('API Response:', result);
            
            if (result.success) {
                const incoming = result.data || result.tasks || [];
                // Handle empty array - clear existing reports and show empty state
                if (!Array.isArray(incoming) || incoming.length === 0) {
                    console.warn('Tasks API returned empty; clearing assigned reports');
                    this.assignedReports = [];
                    // Remove any recently-submitted task flagged by report.html
                    this.applyPendingRemoval();
                    // Always render to clear loading state and show empty state
                    this.renderAssignedReports();
                    return;
                }
                // Normalize fields to avoid N/A display
                const prevByTable = new Map((this.assignedReports || []).map(r => [String(r.table_name||'').toLowerCase(), r]));
                this.assignedReports = incoming.map(r => {
                    const key = String(r.table_name || '').toLowerCase();
                    const prev = prevByTable.get(key) || {};
                    return {
                        ...r,
                        office: (r.assigned_office || r.office || prev.assigned_office || prev.office || ''),
                        assigned_office: (r.assigned_office || prev.assigned_office || r.office || prev.office || ''),
                        campus: (r.assigned_campus || r.campus || r.campus_name || prev.assigned_campus || prev.campus || prev.campus_name || ''),
                        assigned_campus: (r.assigned_campus || prev.assigned_campus || r.campus || prev.campus || r.campus_name || prev.campus_name || '')
                    };
                });
                console.log('Assigned reports loaded:', this.assignedReports.length);
                // Remove any recently-submitted task flagged by report.html
                this.applyPendingRemoval();
                this.renderAssignedReports();
            } else {
                console.error('API returned success=false:', result);
                console.error('Error message:', result.message);
                // On error, set empty array and render to clear loading state
                this.assignedReports = [];
                this.renderAssignedReports();
            }
        } catch (error) {
            console.error('Error loading assigned reports:', error);
            // On error, set empty array and render to clear loading state
            this.assignedReports = [];
            this.renderAssignedReports();
        }
    }

    // Remove a recently submitted task if flagged in localStorage by the submission page
    applyPendingRemoval() {
        try {
            const raw = localStorage.getItem('lastSubmittedTask');
            if (!raw) return;
            const info = JSON.parse(raw);
            if (!info || !Array.isArray(this.assignedReports)) return;
            const tName = (info.table || info.tableName || '').toString().toLowerCase();
            if (!tName) { localStorage.removeItem('lastSubmittedTask'); return; }
            // Remove by table name only to guarantee disappearance
            this.assignedReports = this.assignedReports.filter(r => (r.table_name || '').toString().toLowerCase() !== tName);
            // Also remove any matching cards already in DOM
            try {
                document.querySelectorAll('.report-card').forEach(card => {
                    const ct = (card.getAttribute('data-table') || '').toLowerCase();
                    if (ct === tName && card.parentElement) card.parentElement.removeChild(card);
                });
            } catch(_) {}
            localStorage.removeItem('lastSubmittedTask');
        } catch(_) {}
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

    // Find whichever container is present for tasks
    getTasksContainer() {
        return document.getElementById('assignedReportsContainer')
            || document.getElementById('myTasksContainer')
            || document.getElementById('dataEntryTasksGrid');
    }

    renderAssignedReports() {
        const container = this.getTasksContainer();
        // If no container is present, skip rendering
        if (!container) return;

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

        const reportsHTML = this.assignedReports.map(report => {
            const tName = report.table_name || '';
            const icon = this.getIconForTable ? this.getIconForTable(tName) : 'fa-file-alt';
            const priority = (report.priority || '').toString().toLowerCase();
            const priorityLabel = priority ? `${priority} priority` : 'low priority';
            const priorityClass = priority ? `priority-${priority}` : 'priority-low';
            const dueText = (report.deadline_formatted || report.deadline || '').toString() || 'No deadline';
            const stats = this.getSubmissionStats ? this.getSubmissionStats(tName) : { count: 0, latest: '' };
            return `
            <div class="report-card enhanced-card" data-table="${tName}" data-office="${report.assigned_office || report.office || ''}" style="
                position: relative;
                background: linear-gradient(to bottom, #ffffff 0%, #fafbfc 100%);
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08), 0 0 0 1px rgba(220, 20, 60, 0.05);
                overflow: hidden;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                border: 1px solid #e8eaed;
            " onmouseover="this.style.transform='translateY(-6px)'; this.style.boxShadow='0 12px 32px rgba(0, 0, 0, 0.12), 0 0 0 1px rgba(220, 20, 60, 0.1)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 20px rgba(0, 0, 0, 0.08), 0 0 0 1px rgba(220, 20, 60, 0.05)';">
                <div class="report-card-header" style="
                    background: linear-gradient(135deg, #ffffff 0%, #fff7f8 100%);
                    padding: 20px 22px;
                    border-bottom: 1px solid rgba(226, 232, 240, 0.8);
                    display: flex;
                    align-items: flex-start;
                    gap: 14px;
                    position: relative;
                ">
                    <div class="icon" style="
                        width: 48px;
                        height: 48px;
                        border-radius: 12px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                        color: #dc143c;
                        box-shadow: 0 4px 12px rgba(220, 20, 60, 0.15);
                        flex-shrink: 0;
                        transition: transform 0.3s ease;
                    ">
                        <i class="fas ${icon}" style="font-size: 20px;"></i>
                    </div>
                    <div class="title-wrap" style="flex: 1; display: flex; flex-direction: column; gap: 6px; min-width: 0;">
                        <h3 style="
                            font-size: 18px;
                            margin: 0;
                            color: #1a202c;
                            font-weight: 800;
                            letter-spacing: -0.2px;
                            line-height: 1.3;
                        ">${this.formatReportName(tName)}</h3>
                        <p style="
                            font-size: 13px;
                            color: #64748b;
                            margin: 0;
                            font-weight: 500;
                            line-height: 1.5;
                        ">${report.description || 'No description available'}</p>
                        <div class="subline" style="
                            display: inline-flex;
                            align-items: center;
                            gap: 6px;
                            font-size: 12px;
                            color: #475569;
                            margin-top: 4px;
                            font-weight: 600;
                        ">
                            <i class="fas fa-clock" style="color: #94a3b8; font-size: 11px;"></i> 
                            Due: ${dueText}
                        </div>
                    </div>
                    <span class="priority-chip ${priorityClass}" style="
                        margin-left: auto;
                        padding: 8px 14px;
                        border-radius: 12px;
                        font-size: 10px;
                        font-weight: 900;
                        letter-spacing: 0.5px;
                        text-transform: uppercase;
                        flex-shrink: 0;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                        transition: all 0.2s ease;
                    ">${priorityLabel.toUpperCase()}</span>
                </div>
                
                <div class="report-card-footer" style="
                    padding: 16px 22px 20px 22px;
                    background: linear-gradient(to top, #f8f9fa 0%, #ffffff 100%);
                    border-top: 1px solid #f0f4f8;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    gap: 12px;
                ">
                    <div class="actions-wrap" style="display: flex; align-items: center; gap: 12px; width: 100%;">
                        <button class="btn-secondary" onclick="userDashboard.viewTaskDetails(${report.id})" style="
                            background: #ffffff;
                            border: 2px solid #e2e8f0;
                            color: #475569;
                            border-radius: 10px;
                            font-weight: 600;
                            padding: 10px 16px;
                            display: inline-flex;
                            align-items: center;
                            gap: 8px;
                            cursor: pointer;
                            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                            font-size: 13px;
                            flex: 0 0 auto;
                        " onmouseover="this.style.background='#f8f9fa'; this.style.borderColor='#dc143c'; this.style.color='#dc143c'; this.style.transform='translateY(-2px)';" onmouseout="this.style.background='#ffffff'; this.style.borderColor='#e2e8f0'; this.style.color='#475569'; this.style.transform='translateY(0)';">
                            <i class="fas fa-info-circle"></i> Details
                        </button>
                        <button class="btn-submit-report" onclick="userDashboard.submitReport('${tName}', ${report.id}, '${(report.assigned_office || report.office || '').replace(/'/g, "\\'")}')" style="
                            flex: 1;
                            padding: 12px 20px;
                            background: linear-gradient(135deg, #dc143c 0%, #a00000 100%);
                            color: #fff;
                            border: none;
                            border-radius: 10px;
                            font-weight: 700;
                            font-size: 14px;
                            cursor: pointer;
                            display: inline-flex;
                            align-items: center;
                            justify-content: center;
                            gap: 10px;
                            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                            box-shadow: 0 4px 12px rgba(220, 20, 60, 0.3);
                            letter-spacing: 0.3px;
                            text-transform: uppercase;
                            font-size: 13px;
                        " onmouseover="this.style.transform='translateY(-3px)'; this.style.boxShadow='0 8px 20px rgba(220, 20, 60, 0.4)'; this.style.background='linear-gradient(135deg, #a00000 0%, #7a0000 100%)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 12px rgba(220, 20, 60, 0.3)'; this.style.background='linear-gradient(135deg, #dc143c 0%, #a00000 100%)';">
                            <i class="fas fa-play-circle"></i>
                            <span>Start Task</span>
                        </button>
                    </div>
                </div>
            </div>`;
        }).join('');
        
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

    async loadSubmissions(forceRefresh = false) {
        try {
            // Add cache-busting parameter if force refresh
            const url = forceRefresh 
                ? `api/user_submissions.php?t=${Date.now()}`
                : 'api/user_submissions.php';
            
            const response = await fetch(url, {
                credentials: 'include',
                cache: forceRefresh ? 'no-cache' : 'default',
                headers: forceRefresh ? {
                    'Cache-Control': 'no-cache, no-store, must-revalidate',
                    'Pragma': 'no-cache',
                    'Expires': '0'
                } : {}
            });
            
            if (!response.ok) {
                if (response.status === 401) {
                    window.location.href = 'login.html';
                    return;
                }
                // Try to get error details
                const text = await response.text();
                console.error('API Error Response:', text);
                try {
                    const errorData = JSON.parse(text);
                    throw new Error(errorData.message || 'Failed to load submissions');
                } catch (e) {
                    throw new Error('Failed to load submissions: ' + response.status);
                }
            }
            
            const result = await response.json();
            
            if (result.success) {
                this.allSubmissions = result.submissions || [];
                
                // Sort by date (newest first) on initial load
                this.allSubmissions.sort((a, b) => {
                    const dateA = new Date(a.submission_date || a.submitted_at).getTime();
                    const dateB = new Date(b.submission_date || b.submitted_at).getTime();
                    return dateB - dateA; // Newest first
                });
                
                this.filteredSubmissions = [...this.allSubmissions];
                
                console.log('Loaded submissions:', this.allSubmissions);
                
                // Populate report type filter
                this.populateReportTypeFilter();
                
                // Render submissions (admin-like cards UI)
                if (document.getElementById('reportTypeCardsContainerUser')) {
                    this.renderSubmissionsCards();
                } else if (document.getElementById('submissionsTableBody')) {
                    // Fallback to old table if container not present
                    this.renderSubmissionsTable();
                }
                
                // Refresh analytics if dashboard section is visible (skip submissions load to avoid loop)
                if (!this._skipRefreshCall) {
                    this.refreshUserAnalyticsIfVisible(false, true);
                }
            } else {
                this.renderEmptySubmissions('Failed to load submissions');
            }
        } catch (error) {
            console.error('Error loading submissions:', error);
            this.renderEmptySubmissions('Error loading submissions');
        }
    }
    
    populateReportTypeFilter() {
        const reportFilter = document.getElementById('submissionReportFilter');
        if (!reportFilter) return;
        
        // Get unique report types
        const reportTypes = [...new Set(this.allSubmissions.map(s => s.table_name))];
        
        // Clear existing options except first
        reportFilter.innerHTML = '<option value="">All Reports</option>';
        
        // Add report type options
        reportTypes.forEach(type => {
            const option = document.createElement('option');
            option.value = type;
            option.textContent = this.formatReportName(type);
            reportFilter.appendChild(option);
        });
    }
    
    filterSubmissions() {
        const reportFilter = document.getElementById('submissionReportFilter')?.value || '';
        
        this.filteredSubmissions = this.allSubmissions.filter(submission => {
            const reportMatch = !reportFilter || submission.table_name === reportFilter;
            return reportMatch;
        });
        
        // Render cards if present, otherwise fallback to table
        if (document.getElementById('reportTypeCardsContainerUser')) {
            this.renderSubmissionsCards();
        } else if (document.getElementById('submissionsTableBody')) {
            this.renderSubmissionsTable();
        }
    }

    renderSubmissionsCards() {
        const container = document.getElementById('reportTypeCardsContainerUser');
        if (!container) return;
        const list = Array.isArray(this.filteredSubmissions) ? this.filteredSubmissions : [];
        if (list.length === 0) {
            container.innerHTML = '<div class="empty-state"><i class="fas fa-inbox"></i><h3>No Submissions</h3><p>You have not submitted any reports yet</p></div>';
            return;
        }
        const html = list.map(item => {
            const id = item.id || item.submission_id || item.ID || '';
            const reportName = this.formatReportName(item.table_name || item.report_type || 'Report');
            const campus = item.campus || item.campus_name || '';
            const office = item.office || '';
            const count = item.records || item.record_count || item.row_count || 0;
            const dt = new Date(item.submission_date || item.submitted_at || item.created_at || Date.now());
            const dateStr = dt.toLocaleString();
            return `
            <div class="report-type-card">
                <div class="report-type-card-header">
                    <div class="icon"><i class="fas fa-file-alt"></i></div>
                    <h3>${reportName}</h3>
                </div>
                <div class="report-type-card-body">
                    <div class="metric"><span class="label">Records</span><span class="value">${count}</span></div>
                    <div class="meta"><span><i class=\"fas fa-map-marker-alt\"></i> ${campus || 'N/A'}</span><span><i class=\"fas fa-building\"></i> ${office || 'N/A'}</span></div>
                    <div class="meta"><span><i class=\"fas fa-clock\"></i> ${dateStr}</span></div>
                </div>
                <div class="report-type-card-footer">
                    <button class="btn-secondary" onclick="userDashboard.viewSubmission('${id}')"><i class="fas fa-eye"></i> View</button>
                </div>
            </div>`;
        }).join('');
        container.innerHTML = html;
    }

    viewSubmission(id) {
        const all = Array.isArray(this.allSubmissions) ? this.allSubmissions : [];
        const sub = all.find(s => String(s.id || s.submission_id || s.ID) === String(id));
        if (!sub) return;
        const overlay = document.createElement('div');
        overlay.id = 'submissionViewModal';
        overlay.style.position = 'fixed';
        overlay.style.inset = '0';
        overlay.style.background = 'rgba(0,0,0,0.4)';
        overlay.style.zIndex = '999999';
        overlay.style.display = 'flex';
        overlay.style.alignItems = 'center';
        overlay.style.justifyContent = 'center';
        const panel = document.createElement('div');
        panel.style.width = 'min(680px, 92vw)';
        panel.style.background = '#fff';
        panel.style.borderRadius = '12px';
        panel.style.boxShadow = '0 10px 30px rgba(0,0,0,0.2)';
        panel.style.overflow = 'hidden';
        const title = this.formatReportName(sub.table_name || sub.report_type || 'Submission');
        const count = sub.records || sub.record_count || sub.row_count || 0;
        const dt = new Date(sub.submission_date || sub.submitted_at || sub.created_at || Date.now());
        const body = `
            <div style="padding:16px 16px 0; display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #eee;">
                <h3 style="margin:0; display:flex; align-items:center; gap:8px;"><i class=\"fas fa-file-alt\"></i> ${this.escapeHtml(title)}</h3>
                <button onclick="document.getElementById('submissionViewModal').remove()" style="background:transparent; border:none; font-size:18px; cursor:pointer;"><i class=\"fas fa-times\"></i></button>
            </div>
            <div style="padding:16px; display:grid; gap:10px;">
                <div><strong>Campus:</strong> ${this.escapeHtml(sub.campus || sub.campus_name || 'N/A')}</div>
                <div><strong>Office:</strong> ${this.escapeHtml(sub.office || 'N/A')}</div>
                <div><strong>Records:</strong> ${count}</div>
                <div><strong>Submitted:</strong> ${dt.toLocaleString()}</div>
                <div style="max-height:260px; overflow:auto; background:#fafafa; border:1px solid #eee; border-radius:8px; padding:12px;">
                    <pre style="margin:0; white-space:pre-wrap;">${this.escapeHtml(JSON.stringify(sub, null, 2))}</pre>
                </div>
            </div>
            <div style="padding:12px 16px; border-top:1px solid #eee; display:flex; justify-content:flex-end; gap:8px;">
                <button class="btn-secondary" onclick="document.getElementById('submissionViewModal').remove()"><i class="fas fa-times"></i> Close</button>
            </div>`;
        panel.innerHTML = body;
        overlay.appendChild(panel);
        overlay.addEventListener('click', (e) => { if (e.target === overlay) overlay.remove(); });
        document.body.appendChild(overlay);
    }
    
    refreshSubmissions() {
        this.loadSubmissions();
    }
    
    sortByDate() {
        // Toggle sort order
        this.dateSortOrder = this.dateSortOrder === 'asc' ? 'desc' : 'asc';
        
        // Update icon
        const sortIcon = document.getElementById('dateSortIcon');
        if (sortIcon) {
            sortIcon.className = this.dateSortOrder === 'asc' 
                ? 'fas fa-sort-up' 
                : 'fas fa-sort-down';
        }
        
        // Sort submissions by date
        this.filteredSubmissions.sort((a, b) => {
            const dateA = new Date(a.submission_date || a.submitted_at).getTime();
            const dateB = new Date(b.submission_date || b.submitted_at).getTime();
            
            if (this.dateSortOrder === 'asc') {
                return dateA - dateB; // Oldest first
            } else {
                return dateB - dateA; // Newest first
            }
        });
        
        // Re-render table only if element exists
        if (document.getElementById('submissionsTableBody')) {
            this.renderSubmissionsTable();
        } else {
            console.warn('submissionsTableBody not found - skipping render in sortByDate');
        }
    }
    
    renderSubmissionsTable() {
        const tbody = document.getElementById('submissionsTableBody');
        if (!tbody) {
            console.warn('submissionsTableBody not found - element may not exist on this page/section');
            console.warn('Current URL:', window.location.href);
            console.warn('Available sections:', Array.from(document.querySelectorAll('.content-section')).map(s => s.id));
            return;
        }
        
        console.log('Rendering submissions table with', this.filteredSubmissions.length, 'submissions');
        
        const table = tbody.closest('table');
        const thead = table ? table.querySelector('thead') : null;
        if (thead) {
            const existing = thead.querySelector('tr.filters-row');
            if (existing) existing.remove();
            const headers = Array.from(thead.querySelectorAll('tr:first-child th'));
            const filterTr = document.createElement('tr');
            filterTr.className = 'filters-row';
            headers.forEach((th, idx) => {
                const cell = document.createElement('th');
                if (idx === headers.length - 1) {
                    cell.textContent = '';
                } else {
                    const sel = document.createElement('select');
                    sel.className = 'formal-select';
                    sel.style.minWidth = '120px';
                    const label = 'All ' + th.textContent.trim();
                    sel.innerHTML = '<option value="">' + label + '</option>';
                    cell.appendChild(sel);
                    sel.addEventListener('change', () => applyFilters());
                    cell.dataset.colIdx = String(idx);
                }
                filterTr.appendChild(cell);
            });
            thead.appendChild(filterTr);
            const populateOptions = () => {
                const rows = Array.from(tbody.querySelectorAll('tr'));
                headers.forEach((th, idx) => {
                    if (idx === headers.length - 1) return;
                    const sel = filterTr.children[idx].querySelector('select');
                    if (!sel) return;
                    const selected = sel.value;
                    const values = Array.from(new Set(rows.map(tr => (tr.children[idx]?.textContent || '').trim()).filter(v => v !== ''))).sort((a,b)=>a.localeCompare(b));
                    sel.innerHTML = '<option value="">' + ('All ' + th.textContent.trim()) + '</option>' + values.map(v => '<option value="' + v.replace(/"/g,'&quot;') + '">' + v.replace(/</g,'&lt;').replace(/>/g,'&gt;') + '</option>').join('');
                    sel.value = selected;
                });
            };
            const applyFilters = () => {
                const controls = Array.from(filterTr.querySelectorAll('select')).map((sel, i) => ({ sel, colIdx: i }));
                const active = controls.filter(c => c.sel.value);
                Array.from(tbody.querySelectorAll('tr')).forEach(tr => {
                    const show = active.every(c => (tr.children[c.colIdx]?.textContent || '').trim() === c.sel.value);
                    tr.style.display = show ? '' : 'none';
                });
            };
            table._populateSubmissionFilters = populateOptions;
            table._applySubmissionFilters = applyFilters;
        }

        if (this.filteredSubmissions.length === 0) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="6" style="text-align: center; padding: 40px;">
                        <i class="fas fa-inbox" style="font-size: 48px; color: #cbd5e0; margin-bottom: 15px; display: block;"></i>
                        <p style="color: #666; margin: 0;">No submissions found</p>
                    </td>
                </tr>
            `;
            return;
        }
        
        tbody.innerHTML = '';
        
        this.filteredSubmissions.forEach(submission => {
            const row = document.createElement('tr');
            
            row.innerHTML = `
                <td>${this.formatReportName(submission.table_name)}</td>
                <td>${submission.campus || '-'}</td>
                <td>${submission.office || '-'}</td>
                <td style="text-align: center;">${submission.record_count || 0}</td>
                <td>${new Date(submission.submission_date).toLocaleString()}</td>
                <td>
                    <div class="submission-actions" style="display: flex; gap: 8px;">
                        <button class="btn-sm btn-view" onclick="userDashboard.viewSubmission(${submission.id})" title="View Details">
                            <i class="fas fa-eye"></i>
                        </button>
                        <button class="btn-sm btn-download" onclick="userDashboard.downloadSubmission(${submission.id})" title="Export CSV">
                            <i class="fas fa-download"></i>
                        </button>
                    </div>
                </td>
            `;
            
            tbody.appendChild(row);
        });

        if (table && typeof table._populateSubmissionFilters === 'function') {
            table._populateSubmissionFilters();
            if (typeof table._applySubmissionFilters === 'function') table._applySubmissionFilters();
        }
    }
    
    renderSubmissionsCards() {
        const container = document.getElementById('reportTypeCardsContainerUser');
        if (!container) return;
        const submissions = Array.isArray(this.filteredSubmissions) ? this.filteredSubmissions : [];

        if (submissions.length === 0) {
            container.innerHTML = `
                <div class="empty-state" style="grid-column: 1 / -1; text-align:center; padding: 32px;">
                    <i class="fas fa-inbox" style="font-size: 42px; color: #cbd5e0; display:block; margin-bottom: 10px;"></i>
                    <div style="color:#666;">No submissions found</div>
                </div>
            `;
            return;
        }

        // Group submissions by report type
        // Filter out submissions with 0 records (where all data was deleted)
        const validSubmissions = submissions.filter(s => {
            const recordCount = s.record_count || s.records || s.row_count || 0;
            return recordCount > 0;
        });
        
        const groups = {};
        validSubmissions.forEach(s => {
            const key = s.table_name || 'unknown';
            if (!groups[key]) groups[key] = [];
            groups[key].push(s);
        });

        const cardsHtml = Object.entries(groups).map(([tableName, list]) => {
            const sorted = list.slice().sort((a, b) => {
                const aDate = new Date(a.submission_date || a.submitted_at).getTime() || 0;
                const bDate = new Date(b.submission_date || b.submitted_at).getTime() || 0;
                return bDate - aDate;
            });
            const latest = sorted[0] || null;
            const latestDate = latest && (latest.submission_date || latest.submitted_at) ? this.formatDate(latest.submission_date || latest.submitted_at) : 'N/A';
            const total = list.length;
            const displayName = this.formatReportName(tableName);
            // Use FA5-compatible icons like admin
            const iconMap = {
                campuspopulation: 'fa-users',
                admissiondata: 'fa-file',
                enrollmentdata: 'fa-user-plus',
                graduatesdata: 'fa-user-graduate',
                employee: 'fa-user-tie',
                pwd: 'fa-wheelchair',
                waterconsumption: 'fa-tint',
                electricityconsumption: 'fa-bolt',
                solidwaste: 'fa-dumpster'
            };
            const iconKey = String(tableName || '').toLowerCase().replace(/\s+/g,'');
            const iconClass = iconMap[iconKey] || 'fa-file';

            return `
                <div class="rt-card rt-appear">
                    <div class="rt-head">
                        <div class="rt-icon"><i class="fas ${iconClass}"></i></div>
                        <div>
                            <h4 class="rt-title">${displayName}</h4>
                        </div>
                    </div>
                    <div class="rt-body">
                        <div class="rt-metric">
                            <div class="value">${total}</div>
                            <div class="label">Submissions</div>
                        </div>
                        <div class="rt-meta"><i class="fas fa-calendar"></i> Latest: ${latestDate}</div>
                    </div>
                    <div class="rt-footer">
                        <button class="rt-cta" data-id="${latest ? (latest.id || latest.submission_id || latest.ID || '') : ''}" data-table-name="${this.escapeHtml(tableName)}"><i class="fas fa-eye"></i> View</button>
                    </div>
                </div>
            `;
        }).join('');

        container.innerHTML = cardsHtml;

        // Hook up the "View" action to open combined reports for that specific report type
        container.querySelectorAll('button[data-id]').forEach(btn => {
            btn.addEventListener('click', () => {
                const tableName = btn.getAttribute('data-table-name');
                if (tableName) {
                    this.viewSubmission(null, tableName);
                }
            });
        });
    }
    
    renderEmptySubmissions(message = 'No submissions found') {
        const tbody = document.getElementById('submissionsTableBody');
        if (!tbody) return;
        
        tbody.innerHTML = `
            <tr>
                <td colspan="6" style="text-align: center; padding: 40px;">
                    <i class="fas fa-exclamation-circle" style="font-size: 48px; color: #dc143c; margin-bottom: 15px; display: block;"></i>
                    <p style="color: #666; margin: 0;">${message}</p>
                </td>
            </tr>
        `;
    }
    
    async viewSubmission(submissionId, tableName = null) {
        try {
            console.log('Fetching combined reports for user', { submissionId, tableName });
            
            // Create and show loading overlay immediately
            let loadingOverlay = document.getElementById('loadingUserReports');
            if (!loadingOverlay) {
                loadingOverlay = document.createElement('div');
                loadingOverlay.id = 'loadingUserReports';
                loadingOverlay.style.cssText = 'position: fixed !important; top: 0 !important; left: 0 !important; width: 100% !important; height: 100% !important; background: rgba(0,0,0,0.7) !important; z-index: 999998 !important; display: flex !important; align-items: center !important; justify-content: center !important;';
                loadingOverlay.innerHTML = '<div style="background: white; padding: 30px; border-radius: 12px; text-align: center;"><i class="fas fa-spinner fa-spin" style="font-size: 32px; color: #dc143c; margin-bottom: 15px;"></i><p style="margin: 0; color: #333; font-size: 16px;">Loading reports...</p></div>';
                document.body.appendChild(loadingOverlay);
            } else {
                loadingOverlay.style.display = 'flex';
            }
            
            // Build API URL with optional table_name filter
            let apiUrl = `api/user_submissions.php?action=get_all_reports`;
            if (tableName) {
                apiUrl += `&table_name=${encodeURIComponent(tableName)}`;
            }
            
            const response = await fetch(apiUrl, {
                credentials: 'include'
            });
            console.log('Response status:', response.status);
            
            if (!response.ok) {
                const text = await response.text();
                console.error('API Error Response:', text);
                if (loadingOverlay) loadingOverlay.style.display = 'none';
                try {
                    const errorData = JSON.parse(text);
                    throw new Error(errorData.message || errorData.error || 'Failed to fetch combined reports');
                } catch (e) {
                    throw new Error('Failed to fetch combined reports: ' + response.status);
                }
            }
            
            const result = await response.json();
            console.log('View all reports result:', result);
            console.log('Combined reports count:', result.combined_reports?.length || 0);
            
            // Hide loading overlay
            if (loadingOverlay) loadingOverlay.style.display = 'none';
            
            if (!result.success) {
                throw new Error(result.message || result.error || 'Failed to fetch combined reports');
            }
            
            const combinedReports = result.combined_reports || [];
            const submissionCount = result.submission_count || 0;
            const totalRecords = result.total_records || 0;
            
            console.log('Processed data:', {
                combinedReports: combinedReports.length,
                submissionCount,
                totalRecords
            });
            
            if (combinedReports.length === 0) {
                this.showNotification('No reports found in your submission history.', 'info');
                return;
            }
            
            // Determine report title
            let reportTitle = 'All My Reports';
            if (tableName && combinedReports.length > 0) {
                reportTitle = this.formatReportName(tableName);
            } else if (combinedReports.length > 0 && combinedReports[0].__table_name) {
                reportTitle = this.formatReportName(combinedReports[0].__table_name);
            }
            
            // Create a summary object for the modal (without title to avoid showing counts)
            const summary = {
                submission_count: submissionCount,
                total_records: totalRecords
            };
            
            console.log('Calling showUserSubmissionDetailsModal with:', {
                dataRows: combinedReports.length,
                reportTitle: reportTitle,
                summary
            });
            
            // Small delay to ensure DOM is ready
            setTimeout(() => {
                this.showUserSubmissionDetailsModal(combinedReports, reportTitle, summary);
            }, 100);
            
        } catch (error) {
            console.error('View all reports error:', error);
            const loadingOverlay = document.getElementById('loadingUserReports');
            if (loadingOverlay) loadingOverlay.style.display = 'none';
            this.showNotification('Error loading combined reports: ' + error.message, 'error');
        }
    }
    
    showUserSubmissionDetailsModal(dataRows, reportTitle, submission) {
        console.log('showUserSubmissionDetailsModal called with:', {
            dataRowsLength: dataRows?.length || 0,
            reportTitle,
            submission
        });
        
        // Use admin-style modal structure
        let modal = document.getElementById('userSubmissionDetailsModal');
        if (!modal) {
            console.log('Creating new modal element');
            modal = document.createElement('div');
            modal.id = 'userSubmissionDetailsModal';
            modal.className = 'edit-modal';
            // Modern modal with backdrop blur and animations
            modal.style.cssText = `
                position: fixed !important;
                top: 0 !important;
                left: 0 !important;
                width: 100vw !important;
                height: 100vh !important;
                background: rgba(0, 0, 0, 0.65) !important;
                backdrop-filter: blur(8px) saturate(180%) !important;
                -webkit-backdrop-filter: blur(8px) saturate(180%) !important;
                z-index: 999999 !important;
                display: none !important;
                align-items: center !important;
                justify-content: center !important;
                padding: 20px !important;
                box-sizing: border-box !important;
                animation: fadeIn 0.3s ease !important;
            `;
            
            // Add animation keyframes if not exists
            if (!document.getElementById('modalAnimations')) {
                const style = document.createElement('style');
                style.id = 'modalAnimations';
                style.textContent = `
                    @keyframes fadeIn {
                        from { opacity: 0; }
                        to { opacity: 1; }
                    }
                    @keyframes slideUp {
                        from { 
                            opacity: 0;
                            transform: translateY(30px) scale(0.95);
                        }
                        to { 
                            opacity: 1;
                            transform: translateY(0) scale(1);
                        }
                    }
                `;
                document.head.appendChild(style);
            }
            
            modal.innerHTML = `
                <div class="modal-content-formal" style="
                    position: relative !important;
                    z-index: 1000000 !important;
                    background: linear-gradient(to bottom, #ffffff 0%, #fafbfc 100%) !important;
                    border-radius: 20px !important;
                    max-width: 95% !important;
                    width: 95% !important;
                    max-width: 1400px !important;
                    max-height: 92vh !important;
                    overflow: hidden !important;
                    box-shadow: 0 30px 60px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(220, 20, 60, 0.1) !important;
                    display: flex !important;
                    flex-direction: column !important;
                    animation: slideUp 0.4s cubic-bezier(0.34, 1.56, 0.64, 1) !important;
                ">
                    <div class="modal-header-formal" style="
                        padding: 28px 32px !important;
                        border-bottom: none !important;
                        display: flex !important;
                        justify-content: space-between !important;
                        align-items: center !important;
                        background: linear-gradient(135deg, #dc143c 0%, #a00000 100%) !important;
                        color: white !important;
                        border-radius: 20px 20px 0 0 !important;
                        box-shadow: 0 4px 12px rgba(220, 20, 60, 0.3) !important;
                        position: relative !important;
                        overflow: hidden !important;
                    ">
                        <div style="position: relative; z-index: 2;">
                            <h3 id="userSubmissionModalTitle" style="
                                margin: 0 !important;
                                font-size: 24px !important;
                                font-weight: 700 !important;
                                display: flex !important;
                                align-items: center !important;
                                gap: 14px !important;
                                color: white !important;
                                letter-spacing: -0.3px !important;
                                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2) !important;
                            "><i class="fas fa-file-alt" style="font-size: 26px;"></i> Report Details</h3>
                        </div>
                        <button class="modal-close" onclick="const m = document.getElementById('userSubmissionDetailsModal'); if(m) { m.classList.remove('active'); m.style.display = 'none'; }" style="
                            background: rgba(255, 255, 255, 0.25) !important;
                            border: 2px solid rgba(255, 255, 255, 0.3) !important;
                            color: white !important;
                            font-size: 20px !important;
                            cursor: pointer !important;
                            width: 44px !important;
                            height: 44px !important;
                            border-radius: 50% !important;
                            display: flex !important;
                            align-items: center !important;
                            justify-content: center !important;
                            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
                            position: relative !important;
                            z-index: 2 !important;
                            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15) !important;
                        " onmouseover="this.style.background='rgba(255,255,255,0.35)'; this.style.transform='rotate(90deg) scale(1.1)';" onmouseout="this.style.background='rgba(255,255,255,0.25)'; this.style.transform='rotate(0deg) scale(1)';">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="modal-body-formal" id="userSubmissionDetailsBody" style="
                        padding: 30px 32px !important;
                        flex: 1 !important;
                        overflow-y: auto !important;
                        overflow-x: hidden !important;
                        background: #ffffff !important;
                    "></div>
                    <div class="modal-footer-formal" style="
                        padding: 24px 32px !important;
                        border-top: 1px solid #e8eaed !important;
                        display: flex !important;
                        justify-content: flex-end !important;
                        gap: 14px !important;
                        background: linear-gradient(to top, #f8f9fa 0%, #ffffff 100%) !important;
                        border-radius: 0 0 20px 20px !important;
                        box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05) !important;
                    ">
                        <button class="btn-formal btn-primary" id="userSubmissionExportBtn" style="
                            display: flex !important;
                            align-items: center !important;
                            gap: 10px !important;
                            padding: 12px 24px !important;
                            border: none !important;
                            border-radius: 10px !important;
                            font-size: 15px !important;
                            font-weight: 600 !important;
                            cursor: pointer !important;
                            background: linear-gradient(135deg, #dc143c 0%, #a00000 100%) !important;
                            color: white !important;
                            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
                            box-shadow: 0 4px 12px rgba(220, 20, 60, 0.3) !important;
                            letter-spacing: 0.3px !important;
                        " onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 16px rgba(220, 20, 60, 0.4)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 12px rgba(220, 20, 60, 0.3)';">
                            <i class="fas fa-download"></i> Export CSV
                        </button>
                        <button class="btn-formal btn-secondary" onclick="const m = document.getElementById('userSubmissionDetailsModal'); if(m) { m.classList.remove('active'); m.style.display = 'none'; }" style="
                            padding: 12px 24px !important;
                            border: 2px solid #e0e0e0 !important;
                            border-radius: 10px !important;
                            font-size: 15px !important;
                            font-weight: 600 !important;
                            cursor: pointer !important;
                            background: white !important;
                            color: #495057 !important;
                            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
                            letter-spacing: 0.3px !important;
                        " onmouseover="this.style.background='#f8f9fa'; this.style.borderColor='#dc143c'; this.style.color='#dc143c'; this.style.transform='translateY(-2px)';" onmouseout="this.style.background='white'; this.style.borderColor='#e0e0e0'; this.style.color='#495057'; this.style.transform='translateY(0)';">
                            <i class="fas fa-times"></i> Close
                        </button>
                    </div>
                </div>
            `;
            document.body.appendChild(modal);
            console.log('Modal element created and appended');
            
            // Add custom scrollbar styles
            if (!document.getElementById('modalScrollbarStyles')) {
                const scrollbarStyle = document.createElement('style');
                scrollbarStyle.id = 'modalScrollbarStyles';
                scrollbarStyle.textContent = `
                    #userSubmissionDetailsModal .modal-body-formal::-webkit-scrollbar {
                        width: 10px !important;
                    }
                    #userSubmissionDetailsModal .modal-body-formal::-webkit-scrollbar-track {
                        background: #f1f1f1 !important;
                        border-radius: 10px !important;
                        margin: 8px 0 !important;
                    }
                    #userSubmissionDetailsModal .modal-body-formal::-webkit-scrollbar-thumb {
                        background: linear-gradient(135deg, #dc143c 0%, #a00000 100%) !important;
                        border-radius: 10px !important;
                        border: 2px solid #f1f1f1 !important;
                    }
                    #userSubmissionDetailsModal .modal-body-formal::-webkit-scrollbar-thumb:hover {
                        background: linear-gradient(135deg, #a00000 0%, #7a0000 100%) !important;
                    }
                `;
                document.head.appendChild(scrollbarStyle);
            }
        }

        // Get body element - make sure it exists (retry if needed)
        let body = document.getElementById('userSubmissionDetailsBody');
        if (!body) {
            // Retry after a brief delay
            setTimeout(() => {
                body = document.getElementById('userSubmissionDetailsBody');
                if (!body) {
                    console.error('Modal body element not found after retry! Modal HTML:', modal.innerHTML);
                    this.showNotification('Error: Modal body not found', 'error');
                    return;
                }
                this.populateModalBody(body, dataRows, reportTitle, submission, modal);
            }, 50);
            return;
        }
        this.populateModalBody(body, dataRows, reportTitle, submission, modal);
    }
    
    populateModalBody(body, dataRows, reportTitle, submission, modal) {
        console.log('populateModalBody called');
        const count = Array.isArray(dataRows) ? dataRows.length : 0;
        console.log('Data rows count:', count);

        // Determine report type from data or submission
        let tableName = reportTitle || 'Report';
        if (count > 0 && dataRows[0] && dataRows[0].__table_name) {
            tableName = this.formatReportName(dataRows[0].__table_name);
        } else if (reportTitle) {
            tableName = this.formatReportName(reportTitle);
        }

        // Update modal title with report name (without counts)
        const modalTitle = modal.querySelector('#userSubmissionModalTitle');
        if (modalTitle) {
            const displayTitle = this.formatReportName(tableName) || 'Report Details';
            modalTitle.innerHTML = `<i class="fas fa-file-alt"></i> ${this.escapeHtml(displayTitle)}`;
        }

        // Initialize html variable
        let html = '';
        let filteredDataRows = [];

        // No info section - just the table with filters

        if (count > 0) {
            // Filter out metadata columns (columns starting with __) and internal system columns
            const allColumns = Object.keys(dataRows[0]);
            const columnsToHide = [
                'id',
                'submission_id',
                'submission id',
                'batch_id',
                'batch id',
                'submitted_by',
                'submitted by',
                'submitted_at',
                'submitted at',
                'created_at',
                'created at',
                'updated_at',
                'updated at'
            ];
            let columns = allColumns.filter(col => {
                const colLower = col.toLowerCase().trim();
                return !col.startsWith('__') &&
                       !columnsToHide.some(hidden => colLower === hidden.toLowerCase());
            });
            
            // Sort columns: Campus first, then Office/Department, then Year, then others
            const columnPriority = {
                'campus': 1,
                'office': 2,
                'office_department': 2,
                'department': 2,
                'year': 3,
                'academic_year': 3,
                'semester': 4,
                'travel_date': 5,
                'traveldate': 5,
                'name_of_traveller': 6,
                'nameoftraveller': 6,
                'traveler': 6,
                'traveller': 6,
                'event_name': 7,
                'event_name_purpose_of_travel': 7,
                'purpose': 7,
                'domestic_international': 8,
                'domesticinternational': 8,
                'origin_info': 9,
                'origininfo': 9,
                'origin_info_or_iata_code': 9,
                'destination_info': 10,
                'destinationinfo': 10,
                'destination_info_or_iata_code': 10,
                'class': 11,
                'trip_type': 12,
                'triptype': 12,
                'trip_typ': 12,
                'one_way_round_trip': 13,
                'onewayroundtrip': 13,
                'kg_co2e': 14,
                'tco2e': 15
            };
            
            columns.sort((a, b) => {
                const aLower = a.toLowerCase().trim();
                const bLower = b.toLowerCase().trim();
                const aPriority = columnPriority[aLower] || 999;
                const bPriority = columnPriority[bLower] || 999;
                
                if (aPriority !== bPriority) {
                    return aPriority - bPriority;
                }
                
                // If same priority, sort alphabetically
                return a.localeCompare(b);
            });

            // Filter out completely empty rows (rows where all visible columns are empty, null, undefined, or just hyphens)
            filteredDataRows = dataRows.filter(row => {
                // Check if row has at least one non-empty value in visible columns
                return columns.some(col => {
                    const value = row[col];
                    if (value === null || value === undefined) return false;
                    const strValue = String(value).trim();
                    return strValue !== '' && strValue !== '-' && strValue !== 'null' && strValue !== 'undefined';
                });
            });

            // Build column filters - get unique values for each column (only from non-empty rows)
            const columnFilters = {};
            columns.forEach(col => {
                const uniqueValues = Array.from(new Set(
                    filteredDataRows.map(row => String(row[col] ?? '')).filter(v => v !== '' && v !== '-' && v !== 'null' && v !== 'undefined')
                )).sort((a, b) => a.localeCompare(b));
                columnFilters[col] = uniqueValues;
            });

            html += `
                <div style="
                    overflow-x: auto !important;
                    border-radius: 12px !important;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08) !important;
                    border: 1px solid #e8eaed !important;
                    background: white !important;
                ">
                    <table class="formal-table" id="userSubmissionDetailsTable" style="
                        width: 100% !important;
                        border-collapse: separate !important;
                        border-spacing: 0 !important;
                        background: white !important;
                        border-radius: 12px !important;
                        overflow: hidden !important;
                    ">
                        <thead style="
                            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%) !important;
                            border-bottom: 3px solid #dc143c !important;
                            position: sticky !important;
                            top: 0 !important;
                            z-index: 10 !important;
                        ">
                            <tr>${columns.map(col => {
                                const formattedColName = this.formatColumnName(col);
                                return `<th style="
                                padding: 20px 20px !important;
                                text-align: left !important;
                                font-weight: 700 !important;
                                color: #111827 !important;
                                font-size: 14px !important;
                                text-transform: none !important;
                                letter-spacing: 0.2px !important;
                                border-bottom: 3px solid #dc143c !important;
                                vertical-align: top !important;
                                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%) !important;
                                border-right: 1px solid #e0e0e0 !important;
                                min-width: 140px !important;
                            ">
                                <div style="display: flex; flex-direction: column; gap: 14px;">
                                    <div style="
                                        font-weight: 700 !important;
                                        color: #111827 !important;
                                        font-size: 14px !important;
                                        text-transform: none !important;
                                        letter-spacing: 0.2px !important;
                                        line-height: 1.4 !important;
                                        margin-bottom: 2px !important;
                                        font-family: 'Inter', 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif !important;
                                    ">${this.escapeHtml(formattedColName)}</div>
                                    <div style="position: relative; width: 100%;">
                                        <select class="column-filter" data-column="${this.escapeHtml(col)}" style="
                                            width: 100% !important;
                                            padding: 10px 42px 10px 14px !important;
                                            border: 2px solid #e0e0e0 !important;
                                            border-radius: 10px !important;
                                            font-size: 14px !important;
                                            background: white !important;
                                            cursor: pointer !important;
                                            box-sizing: border-box !important;
                                            min-height: 42px !important;
                                            font-weight: 500 !important;
                                            color: #374151 !important;
                                            transition: all 0.2s ease !important;
                                            appearance: none !important;
                                            -webkit-appearance: none !important;
                                            -moz-appearance: none !important;
                                            font-family: 'Inter', 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif !important;
                                            line-height: 1.5 !important;
                                        " onmouseover="this.style.borderColor='#dc143c'; this.style.boxShadow='0 0 0 3px rgba(220,20,60,0.1)';" onmouseout="this.style.borderColor='#e0e0e0'; this.style.boxShadow='none';" onfocus="this.style.borderColor='#dc143c'; this.style.boxShadow='0 0 0 3px rgba(220,20,60,0.15)';" onblur="this.style.borderColor='#e0e0e0'; this.style.boxShadow='none';">
                                            <option value="">All ${this.escapeHtml(formattedColName)}</option>
                                            ${columnFilters[col].map(val => `<option value="${this.escapeHtml(String(val).replace(/"/g, '&quot;'))}">${this.escapeHtml(String(val).length > 50 ? String(val).substring(0, 50) + '...' : String(val))}</option>`).join('')}
                                        </select>
                                        <i class="fas fa-chevron-down" style="
                                            position: absolute !important;
                                            right: 16px !important;
                                            top: 50% !important;
                                            transform: translateY(-50%) !important;
                                            pointer-events: none !important;
                                            color: #dc143c !important;
                                            font-size: 16px !important;
                                            transition: transform 0.2s ease !important;
                                            z-index: 5 !important;
                                            opacity: 0.8 !important;
                                        "></i>
                                    </div>
                                </div>
                            </th>`;
                            }).join('')}</tr>
                        </thead>
                        <tbody>
                            ${filteredDataRows.length > 0 ? filteredDataRows.map((row, idx) => `<tr class="data-row" data-row-index="${idx}" style="
                                border-bottom: 1px solid #f0f4f8 !important;
                                background: ${idx % 2 === 0 ? 'white' : '#fafbfc'} !important;
                                transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
                            " onmouseover="this.style.background='#f0f7ff'; this.style.transform='scale(1.01)'; this.style.boxShadow='0 2px 8px rgba(220,20,60,0.1)';" onmouseout="this.style.background='${idx % 2 === 0 ? 'white' : '#fafbfc'}'; this.style.transform='scale(1)'; this.style.boxShadow='none';">${columns.map(col => {
                                const cellValue = row[col];
                                const displayValue = (cellValue === null || cellValue === undefined || String(cellValue).trim() === '') ? '-' : String(cellValue);
                                return `<td style="
                                    padding: 14px 18px !important;
                                    color: #2d3748 !important;
                                    font-size: 14px !important;
                                    border-right: 1px solid #f0f4f8 !important;
                                    font-weight: 400 !important;
                                    line-height: 1.5 !important;
                                ">${this.escapeHtml(displayValue)}</td>`;
                            }).join('')}</tr>`).join('') : `<tr><td colspan="${columns.length}" style="text-align: center; padding: 40px; color: #6b7280;">No data available</td></tr>`}
                        </tbody>
                    </table>
                </div>
            `;
        } else {
            html += `
                <div style="
                    text-align: center !important;
                    padding: 60px 20px !important;
                    background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%) !important;
                    border-radius: 12px !important;
                    border: 2px dashed #e0e0e0 !important;
                ">
                    <i class="fas fa-inbox" style="
                        font-size: 64px !important;
                        color: #cbd5e0 !important;
                        margin-bottom: 20px !important;
                        display: block !important;
                    "></i>
                    <p style="
                        color: #718096 !important;
                        font-size: 16px !important;
                        font-weight: 500 !important;
                        margin: 0 !important;
                    ">No data records found</p>
                </div>
            `;
        }

        body.innerHTML = html;
        
        // Add filter functionality to dropdown selects
        const actualRowCount = filteredDataRows.length > 0 ? filteredDataRows.length : count;
        if (actualRowCount > 0) {
            const table = body.querySelector('#userSubmissionDetailsTable');
            const tbody = table ? table.querySelector('tbody') : null;
            const filterSelects = body.querySelectorAll('.column-filter');
            
            if (tbody && filterSelects.length > 0) {
                // Create filter function
                const applyFilters = () => {
                    const rows = Array.from(tbody.querySelectorAll('tr.data-row'));
                    const activeFilters = {};
                    
                    // Get all active filter values
                    filterSelects.forEach(select => {
                        const column = select.getAttribute('data-column');
                        const value = select.value.trim();
                        if (value) {
                            activeFilters[column] = value;
                        }
                    });
                    
                    // Apply filters to rows
                    rows.forEach(row => {
                        const cells = Array.from(row.querySelectorAll('td'));
                        let show = true;
                        
                        // Check each active filter
                        filterSelects.forEach((select, idx) => {
                            if (!show) return;
                            const filterValue = select.value.trim();
                            if (filterValue) {
                                const cellText = (cells[idx]?.textContent || '').trim();
                                if (cellText !== filterValue) {
                                    show = false;
                                }
                            }
                        });
                        
                        row.style.display = show ? '' : 'none';
                    });
                    
                    // Update visible row count
                    const visibleCount = rows.filter(r => r.style.display !== 'none').length;
                    console.log(`Filtered: ${visibleCount} of ${rows.length} rows visible`);
                };
                
                    // Attach event listeners to all filter selects
                    filterSelects.forEach(select => {
                        select.addEventListener('change', applyFilters);
                        
                        // Add animation to dropdown arrow on focus/open
                        const parentDiv = select.parentElement;
                        const arrowIcon = parentDiv ? parentDiv.querySelector('i.fa-chevron-down') : null;
                        
                        if (arrowIcon) {
                            select.addEventListener('focus', () => {
                                arrowIcon.style.transform = 'translateY(-50%) rotate(180deg)';
                                arrowIcon.style.color = '#a00000';
                            });
                            
                            select.addEventListener('blur', () => {
                                arrowIcon.style.transform = 'translateY(-50%) rotate(0deg)';
                                arrowIcon.style.color = '#dc143c';
                            });
                            
                            select.addEventListener('mousedown', () => {
                                arrowIcon.style.transform = 'translateY(-50%) rotate(180deg)';
                                arrowIcon.style.color = '#a00000';
                            });
                            
                            // Add hover effect to parent div
                            select.addEventListener('mouseenter', () => {
                                if (arrowIcon) {
                                    arrowIcon.style.color = '#a00000';
                                    arrowIcon.style.transform = 'translateY(-50%) scale(1.1)';
                                }
                            });
                            
                            select.addEventListener('mouseleave', () => {
                                if (arrowIcon && document.activeElement !== select) {
                                    arrowIcon.style.color = '#dc143c';
                                    arrowIcon.style.transform = 'translateY(-50%) scale(1)';
                                }
                            });
                        }
                    });
                
                // Initial filter application
                applyFilters();
            }
        }
        
        // Ensure modal is visible with proper positioning
        console.log('Setting modal to active, modal element:', modal);
        
        // Remove any existing active class first
        modal.classList.remove('active');
        
        // Force all styles with !important flags
        modal.style.cssText = `
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            width: 100vw !important;
            height: 100vh !important;
            background: rgba(0,0,0,0.6) !important;
            z-index: 999999 !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            margin: 0 !important;
            padding: 20px !important;
            box-sizing: border-box !important;
            overflow-y: auto !important;
        `;
        
        modal.classList.add('active');
        
        // Double check modal is shown after a brief delay
        setTimeout(() => {
            modal.style.display = 'flex';
            modal.style.zIndex = '999999';
            const computed = window.getComputedStyle(modal);
            console.log('Modal verification:', {
                display: computed.display,
                position: computed.position,
                zIndex: computed.zIndex,
                width: computed.width,
                height: computed.height
            });
            
            // Scroll to top if modal is far down the page
            window.scrollTo(0, 0);
        }, 50);

        // Export handler - attach after a short delay to ensure table is rendered
        setTimeout(() => {
            const exportBtn = document.getElementById('userSubmissionExportBtn');
            const table = document.getElementById('userSubmissionDetailsTable');
            if (exportBtn && table) {
                const rowCount = table.querySelectorAll('tbody tr:not([style*="display: none"])').length;
                if (rowCount > 0) {
                    exportBtn.onclick = async () => {
                        try {
                            let ok = true;
                            if (typeof window.showConfirm === 'function') {
                                ok = await window.showConfirm('Do you want to export all visible rows as CSV?', 'Export', { confirmText: 'Export', cancelText: 'Cancel', type: 'info' });
                            } else {
                                ok = window.confirm('Do you want to export all visible rows as CSV?');
                            }
                            if (!ok) return;
                            
                            const safeTitle = (this.formatReportName(tableName) || 'MyReports').replace(/[^a-z0-9]+/gi, '_');
                            const submissionId = (submission && submission.id) ? submission.id : 'all_reports';
                            const fileName = `${safeTitle}_${String(submissionId)}.csv`;
                            this.exportTableCSV('userSubmissionDetailsTable', fileName);
                        } catch (e) {
                            console.error('Export error:', e);
                            this.showNotification('Error exporting CSV: ' + e.message, 'error');
                        }
                    };
                    // Enable the button
                    exportBtn.disabled = false;
                    exportBtn.style.opacity = '1';
                    exportBtn.style.cursor = 'pointer';
                } else {
                    // Disable button if no data
                    exportBtn.disabled = true;
                    exportBtn.style.opacity = '0.5';
                    exportBtn.style.cursor = 'not-allowed';
                }
            } else {
                console.warn('Export button or table not found:', { exportBtn: !!exportBtn, table: !!table });
            }
        }, 100);

        // Close on overlay click
        const closeModal = () => {
            modal.classList.remove('active');
            modal.style.display = 'none';
        };
        
        // Add overlay click handler (only if clicking the backdrop, not the content)
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                closeModal();
            }
        });
        
        // Prevent modal content clicks from closing the modal
        const modalContent = modal.querySelector('.modal-content-formal');
        if (modalContent) {
            modalContent.addEventListener('click', (e) => {
                e.stopPropagation();
            });
        }
        
        // Update close buttons (but keep the body element reference)
        const closeBtn = modal.querySelector('.modal-close');
        const closeFooterBtn = modal.querySelector('.btn-formal.btn-secondary');
        if (closeBtn) {
            closeBtn.onclick = (e) => {
                e.preventDefault();
                closeModal();
            };
        }
        if (closeFooterBtn) {
            closeFooterBtn.onclick = (e) => {
                e.preventDefault();
                closeModal();
            };
        }
    }

    async downloadSubmission(submissionId) {
        try {
            const response = await fetch(`api/user_submissions.php?action=details&submission_id=${submissionId}`, {
                credentials: 'include'
            });
            
            if (!response.ok) {
                const text = await response.text();
                console.error('API Error:', text);
                throw new Error('Failed to fetch submission data: ' + response.status);
            }
            
            const result = await response.json();
            console.log('Submission details:', result);
            
            if (!result.success || !result.data) {
                throw new Error(result.error || 'Failed to fetch submission data');
            }
            
            const submission = result.data;
            const data = submission.data || [];
            
            if (data.length === 0) {
                alert('No data to export');
                return;
            }
            
            // Create CSV content
            let csvContent = [];
            
            // Add metadata
            csvContent.push(['Submission Information']);
            csvContent.push(['Submission ID', submission.id]);
            csvContent.push(['Report Type', this.formatReportName(submission.table_name)]);
            csvContent.push(['Campus', submission.campus || 'N/A']);
            csvContent.push(['Office', submission.office || 'N/A']);
            csvContent.push(['Submitted Date', new Date(submission.submission_date).toLocaleString()]);
            csvContent.push(['Status', submission.status ? submission.status.toUpperCase() : 'PENDING']);
            csvContent.push([]);
            csvContent.push(['Report Data']);
            csvContent.push([]);
            
            // Add headers and data
            if (data[0]) {
                const headers = Object.keys(data[0]);
                // Filter out internal metadata columns
                const columnsToHide = [
                    'id', 'submission_id', 'submission id', 'batch_id', 'batch id',
                    'submitted_by', 'submitted by', 'submitted_at', 'submitted at',
                    'created_at', 'created at', 'updated_at', 'updated at'
                ];
                const visibleHeaders = headers.filter(h => {
                    const hLower = h.toLowerCase().trim();
                    return !h.startsWith('__') &&
                           !columnsToHide.some(hidden => hLower === hidden.toLowerCase());
                });
                // Format column names for CSV headers
                const formattedHeaders = visibleHeaders.map(h => this.formatColumnName(h));
                csvContent.push(formattedHeaders);
                
                data.forEach(row => {
                    const rowData = visibleHeaders.map(header => {
                        let value = row[header] || '';
                        value = String(value).replace(/"/g, '""');
                        if (value.includes(',') || value.includes('"') || value.includes('\n')) {
                            value = `"${value}"`;
                        }
                        return value;
                    });
                    csvContent.push(rowData);
                });
            }
            
            // Convert to CSV string
            const csv = csvContent.map(row => row.join(',')).join('\n');
            
            // Download
            const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            const url = URL.createObjectURL(blob);
            const fileName = `${submission.table_name}_submission_${submissionId}_${new Date().toISOString().split('T')[0]}.csv`;
            
            link.setAttribute('href', url);
            link.setAttribute('download', fileName);
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            
            this.showNotification(`Exported submission #${submissionId} successfully`, 'success');
        } catch (error) {
            console.error('Export error:', error);
            this.showNotification('Error exporting submission: ' + error.message, 'error');
        }
    }
    
    exportTableCSV(tableId, fileName = 'export.csv') {
        try {
            const table = document.getElementById(tableId);
            if (!table) {
                console.warn('exportTableCSV: table not found:', tableId);
                this.showNotification('Error: Table not found for export', 'error');
                return;
            }
            const thead = table.querySelector('thead');
            const tbody = table.querySelector('tbody');
            if (!thead || !tbody) {
                console.warn('exportTableCSV: thead or tbody not found');
                this.showNotification('Error: Table structure not found', 'error');
                return;
            }
            const ths = Array.from(thead.querySelectorAll('tr:first-child th'));
            if (ths.length === 0) {
                console.warn('exportTableCSV: No header columns found');
                this.showNotification('Error: No columns found in table', 'error');
                return;
            }
            // Determine visible columns (in case of column hiding)
            const visibleIdx = ths.map((th, idx) => ({ th, idx }))
                .filter(x => (x.th.offsetParent !== null) && (getComputedStyle(x.th).display !== 'none'))
                .map(x => x.idx);
            
            if (visibleIdx.length === 0) {
                console.warn('exportTableCSV: No visible columns found');
                this.showNotification('Error: No visible columns to export', 'error');
                return;
            }
            
            // Build CSV rows
            const rows = [];
            // Headers - extract text from the first div (header label), not the filter dropdown
            const headerRow = visibleIdx.map(i => {
                const th = ths[i];
                // Try to find the header label div first
                const labelDiv = th?.querySelector('div > div:first-child');
                let txt = '';
                if (labelDiv) {
                    txt = labelDiv.textContent?.trim() || '';
                } else {
                    // Fallback to th textContent but remove filter dropdown text
                    txt = th?.textContent?.trim() || '';
                    // Remove "All [ColumnName]" text from filter dropdowns
                    txt = txt.replace(/\s*All\s+[^\n]*/g, '').trim();
                }
                // Clean up any remaining filter-related text
                txt = txt.replace(/\s*All\s*$/g, '').trim();
                return '"' + txt.replace(/"/g, '""') + '"';
            });
            rows.push(headerRow.join(','));
            // Body (only visible rows after filtering)
            Array.from(tbody.querySelectorAll('tr')).forEach(tr => {
                if (getComputedStyle(tr).display === 'none') return;
                const tds = Array.from(tr.children);
                const vals = visibleIdx.map(i => {
                    const txt = (tds[i]?.textContent || '').trim();
                    const safe = txt.replace(/"/g, '""');
                    return '"' + safe + '"';
                });
                rows.push(vals.join(','));
            });
            const csv = rows.join('\n');
            const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = fileName;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);
            this.showNotification('CSV exported: ' + fileName, 'success');
        } catch (e) {
            console.error('exportTableCSV error:', e);
            this.showNotification('Error exporting CSV: ' + e.message, 'error');
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
        // Statistics cards removed - function kept for compatibility
        // but elements no longer exist in DOM
        return;
    }

    submitReport(tableName, taskId, office) {
        // Open report form inside a modal iframe; dashboard stays intact
        const qp = new URLSearchParams({ table: String(tableName || ''), task_id: String(taskId || ''), office: String(office || ''), ts: String(Date.now()) });
        const url = `report.html?${qp.toString()}`;
        this.openReportModal(url);
    }

    openReportModal(url) {
        try {
            // If already open, just update src
            let overlay = document.getElementById('reportModalOverlay');
            if (overlay) {
                const iframe = overlay.querySelector('iframe');
                if (iframe) iframe.src = url;
                overlay.style.display = 'flex';
                document.body.style.overflow = 'hidden';
                return;
            }

            overlay = document.createElement('div');
            overlay.id = 'reportModalOverlay';
            overlay.setAttribute('role', 'dialog');
            overlay.setAttribute('aria-modal', 'true');
            overlay.style.cssText = [
                'position:fixed','inset:0','z-index:9999','background:rgba(0,0,0,0.4)',
                'display:flex','align-items:center','justify-content:center','padding:24px'
            ].join(';');

            const card = document.createElement('div');
            card.id = 'reportModalCard';
            card.style.cssText = [
                'width:min(1100px, 96vw)','height:min(88vh, 900px)','background:#fff','border-radius:16px',
                'box-shadow:0 20px 60px rgba(0,0,0,0.25)','display:flex','flex-direction:column','overflow:hidden',
                'border:1px solid #e5e7eb'
            ].join(';');

            const header = document.createElement('div');
            header.style.cssText = [
                'display:flex','align-items:center','justify-content:space-between','padding:12px 16px',
                'background:linear-gradient(90deg,#dc143c,#ef4444)','color:#fff'
            ].join(';');
            const title = document.createElement('div');
            title.textContent = 'Submit Report';
            title.style.fontWeight = '700';
            const closeBtn = document.createElement('button');
            closeBtn.type = 'button';
            closeBtn.innerHTML = '<i class="fas fa-times"></i>';
            closeBtn.style.cssText = [
                'background:transparent','border:0','color:#fff','font-size:18px','cursor:pointer'
            ].join(';');
            closeBtn.addEventListener('click', () => this.closeReportModal());
            header.appendChild(title);
            header.appendChild(closeBtn);

            const frame = document.createElement('iframe');
            frame.src = url;
            frame.title = 'Report Form';
            frame.style.cssText = ['flex:1','width:100%','border:0','background:#f9fafb'].join(';');

            card.appendChild(header);
            card.appendChild(frame);
            overlay.appendChild(card);
            document.body.appendChild(overlay);
            document.body.style.overflow = 'hidden';

            // Click outside to close
            overlay.addEventListener('click', (e) => {
                if (e.target === overlay) this.closeReportModal();
            });
            // ESC to close
            this._escHandler = (ev) => { if (ev.key === 'Escape') this.closeReportModal(); };
            window.addEventListener('keydown', this._escHandler);
        } catch(_) {}
    }

    closeReportModal() {
        try {
            const overlay = document.getElementById('reportModalOverlay');
            if (overlay && overlay.parentElement) overlay.parentElement.removeChild(overlay);
            document.body.style.overflow = '';
            if (this._escHandler) { window.removeEventListener('keydown', this._escHandler); this._escHandler = null; }
            
            // Check if a submission might have happened (check localStorage)
            const lastSubmitted = localStorage.getItem('lastSubmittedTask');
            if (lastSubmitted) {
                // A submission was made, refresh analytics after a delay
                setTimeout(async () => {
                    try {
                        await this.loadSubmissions(true); // Force refresh with cache busting
                        await this.refreshUserAnalyticsIfVisible(true);
                    } catch (err) {
                        console.error('Error refreshing after modal close:', err);
                    }
                }, 1000);
            }
        } catch(_) {}
    }

    formatReportName(tableName) {
        if (!tableName) return 'Unknown Report';
        
        // Map of table names to display names (handles both with and without underscores)
        const tableDisplayNames = {
            'admission': 'Admission Data',
            'enrollment': 'Enrollment Data',
            'enrollmentdata': 'Enrollment Data',
            'graduates': 'Graduates Data',
            'graduatesdata': 'Graduates Data',
            'employee': 'Employee Data',
            'leave_privilege': 'Leave Privilege',
            'leaveprivilege': 'Leave Privilege',
            'library_visitor': 'Library Visitor',
            'libraryvisitor': 'Library Visitor',
            'pwd': 'PWD',
            'water_consumption': 'Water Consumption',
            'waterconsumption': 'Water Consumption',
            'treated_waste_water': 'Treated Waste Water',
            'treated_wastewater': 'Treated Waste Water',
            'treatedwastewater': 'Treated Waste Water',
            'electricity_consumption': 'Electricity Consumption',
            'electricityconsumption': 'Electricity Consumption',
            'solid_waste': 'Solid Waste',
            'solidwaste': 'Solid Waste',
            'campus_population': 'Campus Population',
            'campuspopulation': 'Campus Population',
            'food_waste': 'Food Waste',
            'foodwaste': 'Food Waste',
            'fuel_consumption': 'Fuel Consumption',
            'fuelconsumption': 'Fuel Consumption',
            'distance_traveled': 'Distance Traveled',
            'distancetraveled': 'Distance Traveled',
            'budget_expenditure': 'Budget Expenditure',
            'budgetexpenditure': 'Budget Expenditure',
            'flight_accommodation': 'Flight Accommodation',
            'flightaccommodation': 'Flight Accommodation'
        };

        // Table configurations for form fields
        this.tableConfigs = {
            flightaccommodation: {
                columns: ['Campus', 'Office/Department', 'Year', 'Name of Traveller', 'Event Name/Purpose of Travel', 'Travel Date (mm/dd/yyyy)', 'Domestic/International', 'Origin Info or IATA code', 'Destination Info or IATA code', 'Class', 'One Way/Round Trip', 'kg CO2e', 'tCO2e'],
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
                            { value: 'Business Class', label: 'Business Class' }
                        ]
                    },
                    'One Way/Round Trip': {
                        type: 'select',
                        options: [
                            { value: 'One Way', label: 'One Way' },
                            { value: 'Round Trip', label: 'Round Trip' }
                        ]
                    }
                }
            }
        };
        
        // Convert to lowercase for matching
        const lowerTableName = tableName.toLowerCase();
        
        // Return mapped name if exists, otherwise format the name
        if (tableDisplayNames[lowerTableName]) {
            return tableDisplayNames[lowerTableName];
        }
        
        // Fallback formatting
        return tableName
            .replace(/([A-Z])/g, ' $1')
            .replace(/_/g, ' ')
            .split(' ')
            .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
            .join(' ')
            .trim();
    }

    formatColumnName(columnName) {
        if (!columnName) return '';
        
        // Special mappings for common column names
        const columnDisplayNames = {
            'campus': 'Campus',
            'department': 'Department',
            'office': 'Office',
            'office_department': 'Office/Department',
            'year': 'Year',
            'travel_date': 'Travel Date',
            'traveldate': 'Travel Date',
            'domestic_international': 'Domestic/International',
            'domesticinternational': 'Domestic/International',
            'traveler': 'Traveler',
            'traveller': 'Traveler',
            'name_of_traveller': 'Name of Traveller',
            'nameoftraveller': 'Name of Traveller',
            'purpose': 'Purpose',
            'event_name': 'Event Name',
            'event_name_purpose_of_travel': 'Event Name/Purpose of Travel',
            'origin_info': 'Origin Info',
            'origininfo': 'Origin Info',
            'origin_info_or_iata_code': 'Origin Info or IATA Code',
            'destination_info': 'Destination Info',
            'destinationinfo': 'Destination Info',
            'destination_info_or_iata_code': 'Destination Info or IATA Code',
            'class': 'Class',
            'trip_type': 'Trip Type',
            'triptype': 'Trip Type',
            'trip_typ': 'Trip Type',
            'one_way_round_trip': 'One Way/Round Trip',
            'onewayroundtrip': 'One Way/Round Trip',
            'kg_co2e': 'kg CO2e',
            'tco2e': 'tCO2e',
            'submission_date': 'Submission Date',
            'submitted_at': 'Submitted At',
            'created_at': 'Created At',
            'updated_at': 'Updated At',
            'status': 'Status',
            'records': 'Records',
            'record_count': 'Record Count'
        };
        
        // Convert to lowercase for matching
        const lowerColumnName = columnName.toLowerCase().trim();
        
        // Return mapped name if exists
        if (columnDisplayNames[lowerColumnName]) {
            return columnDisplayNames[lowerColumnName];
        }
        
        // Handle special cases
        let formatted = columnName;
        
        // Replace underscores with spaces
        formatted = formatted.replace(/_/g, ' ');
        
        // Handle camelCase - add space before capital letters
        formatted = formatted.replace(/([a-z])([A-Z])/g, '$1 $2');
        
        // Convert to title case (capitalize first letter of each word)
        formatted = formatted
            .toLowerCase()
            .split(' ')
            .map(word => {
                // Handle special abbreviations
                if (word === 'iata') return 'IATA';
                if (word === 'co2e') return 'CO2e';
                if (word === 'id') return 'ID';
                if (word === 'kg') return 'kg';
                if (word === 't') return 't';
                // Capitalize first letter
                return word.charAt(0).toUpperCase() + word.slice(1);
            })
            .join(' ');
        
        // Handle special patterns
        formatted = formatted.replace(/\bDomestic International\b/gi, 'Domestic/International');
        formatted = formatted.replace(/\bOne Way Round Trip\b/gi, 'One Way/Round Trip');
        formatted = formatted.replace(/\bOrigin Info Or Iata Code\b/gi, 'Origin Info or IATA Code');
        formatted = formatted.replace(/\bDestination Info Or Iata Code\b/gi, 'Destination Info or IATA Code');
        formatted = formatted.replace(/\bEvent Name Purpose Of Travel\b/gi, 'Event Name/Purpose of Travel');
        formatted = formatted.replace(/\bOffice Department\b/gi, 'Office/Department');
        
        return formatted.trim();
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

    formatDateToPhilippines(date) {
        if (!date) return '';
        try {
            // Format date to Philippines timezone (Asia/Manila)
            return date.toLocaleString('en-US', {
                timeZone: 'Asia/Manila',
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true
            });
        } catch (e) {
            // Fallback to default formatting
            return date.toLocaleString();
        }
    }
    
    formatSubmissionDate(submission) {
        // Try different possible date field names
        const dateValue = submission.submission_date || 
                         submission.submitted_at || 
                         submission.created_at || 
                         submission.submitted_at_formatted ||
                         null;
        
        if (!dateValue) return 'N/A';
        
        // If it's already formatted, return as is
        if (typeof dateValue === 'string' && dateValue.includes(',')) {
            return dateValue;
        }
        
        // Try to parse the date
        try {
            const date = new Date(dateValue);
            
            // Check if date is valid
            if (isNaN(date.getTime())) {
                return 'N/A';
            }
            
            // Format the date in Philippines timezone
            return date.toLocaleString('en-US', {
                timeZone: 'Asia/Manila',
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true
            });
        } catch (e) {
            console.error('Error formatting date:', e, dateValue);
            return 'N/A';
        }
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
        try {
            let container = document.getElementById('ud-toast-container');
            if (!container) {
                container = document.createElement('div');
                container.id = 'ud-toast-container';
                container.style.position = 'fixed';
                container.style.top = '16px';
                container.style.right = '16px';
                container.style.zIndex = '99999';
                container.style.display = 'flex';
                container.style.flexDirection = 'column';
                container.style.gap = '10px';
                document.body.appendChild(container);
            }

            const colors = {
                success: { bg: '#10b981', fg: '#ffffff', icon: 'fa-check-circle' },
                error: { bg: '#ef4444', fg: '#ffffff', icon: 'fa-times-circle' },
                info: { bg: '#3b82f6', fg: '#ffffff', icon: 'fa-info-circle' },
                warning: { bg: '#f59e0b', fg: '#111827', icon: 'fa-exclamation-triangle' }
            };
            const c = colors[type] || colors.info;

            const toast = document.createElement('div');
            toast.style.minWidth = '260px';
            toast.style.maxWidth = '420px';
            toast.style.padding = '12px 14px';
            toast.style.borderRadius = '10px';
            toast.style.boxShadow = '0 6px 20px rgba(0,0,0,0.15)';
            toast.style.background = c.bg;
            toast.style.color = c.fg;
            toast.style.display = 'flex';
            toast.style.alignItems = 'center';
            toast.style.gap = '10px';
            toast.style.opacity = '0';
            toast.style.transform = 'translateY(-8px)';
            toast.style.transition = 'opacity .2s ease, transform .2s ease';

            toast.innerHTML = `<i class="fas ${c.icon}" style="opacity:.9"></i><div style="flex:1; font-weight:600;">${this.escapeHtml(message)}</div>`;

            const closeBtn = document.createElement('button');
            closeBtn.innerHTML = '<i class="fas fa-times"></i>';
            closeBtn.style.background = 'transparent';
            closeBtn.style.border = 'none';
            closeBtn.style.color = c.fg;
            closeBtn.style.cursor = 'pointer';
            closeBtn.onclick = () => {
                toast.style.opacity = '0';
                toast.style.transform = 'translateY(-8px)';
                setTimeout(() => toast.remove(), 200);
            };
            toast.appendChild(closeBtn);

            container.appendChild(toast);
            requestAnimationFrame(() => {
                toast.style.opacity = '1';
                toast.style.transform = 'translateY(0)';
            });

            setTimeout(() => {
                if (!toast.isConnected) return;
                toast.style.opacity = '0';
                toast.style.transform = 'translateY(-8px)';
                setTimeout(() => toast.remove(), 220);
            }, type === 'error' ? 5000 : 3000);
        } catch (_) {
            try { alert(message); } catch(_) {}
        }
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

    async loadAnalytics() {
        // Ensure submissions and assigned reports are loaded
        if (!this.allSubmissions || this.allSubmissions.length === 0) {
            await this.loadSubmissions();
        }
        if (!this.assignedReports || this.assignedReports.length === 0) {
            await this.loadAssignedReports();
        }

        // Populate report type dropdown
        await this.populateUserAnalyticsReportTypeDropdown();
        
        // Load analytics visuals and KPIs
        await this.loadUserKPICards();
        await this.loadUserSubmissionsGrowthChart();
        await this.loadUserSubmissionsMonthlyChart();
        await this.loadUserReportsByType();
        await this.loadUserTopActiveReports();

        // Wire interactions once
        try { this.setupAnalyticsEventListeners(); } catch(_) {}
    }
    
    /**
     * Refresh analytics if dashboard section is currently visible
     * @param {boolean} forceRefresh - If true, refresh even if dashboard section check fails
     * @param {boolean} skipSubmissionsLoad - If true, skip loading submissions (already loaded)
     */
    async refreshUserAnalyticsIfVisible(forceRefresh = false, skipSubmissionsLoad = false) {
        // Prevent nested refresh calls
        if (this._refreshingAnalytics) {
            return;
        }
        
        try {
            this._refreshingAnalytics = true;
            
            // Check if dashboard section is visible (unless forced)
            if (!forceRefresh) {
                const dashboardSection = document.getElementById('dashboard');
                if (!dashboardSection || !dashboardSection.classList.contains('active')) {
                    this._refreshingAnalytics = false; // Reset flag before returning
                    return; // Dashboard not visible, skip refresh
                }
            }
            
            console.log('Refreshing user analytics...');
            
            // Reload submissions first to get latest data (unless already loaded)
            if (!skipSubmissionsLoad) {
                // Temporarily disable refresh call from loadSubmissions to avoid loop
                const originalRefresh = this._skipRefreshCall;
                this._skipRefreshCall = true;
                await this.loadSubmissions(true); // Force refresh with cache busting
                this._skipRefreshCall = originalRefresh;
                // After loading submissions, they will be available
            } else {
                // If skipping submissions load, still check if we have data
                if (!this.allSubmissions || this.allSubmissions.length === 0) {
                    const originalRefresh = this._skipRefreshCall;
                    this._skipRefreshCall = true;
                    await this.loadSubmissions(true); // Force refresh with cache busting
                    this._skipRefreshCall = originalRefresh;
                }
            }
            
            // Ensure assigned reports are loaded
            if (!this.assignedReports || this.assignedReports.length === 0) {
                await this.loadAssignedReports();
            }

            // Populate report type dropdown
            await this.populateUserAnalyticsReportTypeDropdown();
            
            // Load analytics visuals and KPIs
            await this.loadUserKPICards();
            await this.loadUserSubmissionsGrowthChart();
            await this.loadUserSubmissionsMonthlyChart();
            await this.loadUserReportsByType();
            await this.loadUserTopActiveReports();

            // Wire interactions once
            try { this.setupAnalyticsEventListeners(); } catch(_) {}
            
            console.log('User analytics refreshed successfully');
        } catch (error) {
            console.error('Error refreshing user analytics:', error);
            // Don't show error to user - this is a background refresh
        } finally {
            this._refreshingAnalytics = false;
        }
    }

    async populateUserAnalyticsReportTypeDropdown() {
        try {
            const select = document.getElementById('userAnalyticsReportTypeSelect');
            if (!select) return;
            
            // Get unique report types from user's submissions
            const submissions = this.allSubmissions || [];
            const reportTypes = [...new Set(submissions.map(s => 
                (s.table_name || s.report_type || '').trim()
            ).filter(Boolean))].sort();
            
            // Clear and populate dropdown
            select.innerHTML = '<option value="">All Report Types</option>';
            reportTypes.forEach(reportType => {
                const option = document.createElement('option');
                option.value = reportType;
                option.textContent = this.formatReportTypeName(reportType);
                select.appendChild(option);
            });
        } catch (error) {
            console.error('Error populating user analytics report type dropdown:', error);
        }
    }

    formatReportTypeName(reportType) {
        if (!reportType) return 'Unknown';
        return reportType.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
    }

    // Helper to filter analytics datasets by selected report type
    filterByUserAnalyticsType(list = []) {
        const t = (this.analyticsReportType || '').toString().trim().toLowerCase();
        if (!t) return list;
        return list.filter(x => {
            const key = ((x.table_name || x.report_type || '')+'').trim().toLowerCase();
            // Match exact or contains either way
            return key === t || key.includes(t) || t.includes(key);
        });
    }


    calculateUserColumnAnalytics(dataRows, columnName) {
        const values = [];
        const totalRows = dataRows.length;
        let filledCount = 0;
        let emptyCount = 0;
        let numericSum = 0;
        let hasNumericValues = false;
        
        // Detect date-like columns by name
        const columnNameLower = columnName.toLowerCase();
        const dateNameKeywords = ['date', 'dob', 'birth', 'month', 'day', 'year', 'academic year', 'ay', 'reviewed'];
        const isDateByName = dateNameKeywords.some(k => columnNameLower.includes(k));
        
        // Common date value patterns
        const datePatterns = [
            /^\d{4}[-/.]\d{1,2}[-/.]\d{1,2}$/,
            /^\d{1,2}[-/.]\d{1,2}[-/.]\d{2,4}$/,
            /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}/,
            /^[A-Za-z]{3,}\s+\d{1,2},\s*\d{2,4}$/
        ];
        
        dataRows.forEach(row => {
            if (row && typeof row === 'object') {
                if (row.hasOwnProperty(columnName)) {
                    const value = row[columnName];
                    if (value !== null && value !== '' && value !== undefined && String(value).trim() !== '') {
                        filledCount++;
                        const valueStr = String(value).trim();
                        values.push(valueStr);
                        const isDateByValue = datePatterns.some(rx => rx.test(valueStr));
                        const treatAsDate = isDateByName || isDateByValue;
                        if (!treatAsDate) {
                            const numericValue = parseFloat(valueStr.replace(/[^\d.-]/g, ''));
                            if (!isNaN(numericValue) && isFinite(numericValue)) {
                                const yearPattern = /^\d{4}$/;
                                const yearValue = parseInt(valueStr, 10);
                                const isYear = yearPattern.test(valueStr) && yearValue >= 1900 && yearValue <= 2100;
                                if (!isYear) {
                                    numericSum += numericValue;
                                    hasNumericValues = true;
                                }
                            }
                        }
                    } else {
                        emptyCount++;
                    }
                } else {
                    emptyCount++;
                }
            } else {
                emptyCount++;
            }
        });
        
        const totalCount = totalRows;
        const completionRate = totalCount > 0 ? (filledCount / totalCount) * 100 : 0;
        const uniqueValues = new Set(values);
        const uniqueCount = uniqueValues.size;
        const valueCounts = {};
        values.forEach(v => { valueCounts[v] = (valueCounts[v] || 0) + 1; });
        const mostCommon = Object.keys(valueCounts).length > 0
            ? Object.keys(valueCounts).reduce((a, b) => valueCounts[a] > valueCounts[b] ? a : b, null)
            : null;
        
        return {
            totalCount,
            filledCount,
            emptyCount,
            completionRate,
            uniqueCount,
            mostCommon,
            numericSum: hasNumericValues ? numericSum : null,
            hasNumericValues
        };
    }

    getUserRating(completionRate) {
        if (completionRate >= 90) return { label: 'Excellent', color: '#10b981' };
        if (completionRate >= 70) return { label: 'Good', color: '#3b82f6' };
        if (completionRate >= 50) return { label: 'Fair', color: '#f59e0b' };
        return { label: 'Poor', color: '#ef4444' };
    }

    setupAnalyticsEventListeners() {
        const reportTypeSelect = document.getElementById('userAnalyticsReportTypeSelect');

        // Handle report type filter change
        if (reportTypeSelect) {
            reportTypeSelect.addEventListener('change', async () => {
                this.analyticsReportType = reportTypeSelect.value || '';
                // Reload charts with filtered data
                await this.loadUserSubmissionsGrowthChart();
                await this.loadUserSubmissionsMonthlyChart();
                await this.loadUserReportsByType();
                await this.loadUserTopActiveReports();
                
                // Replace chart with column-based chart when report type is selected
                if (this.analyticsReportType) {
                    try {
                        await this.loadUserColumnBasedChart(this.analyticsReportType);
                    } catch (e) {
                        console.warn('User column-based chart load failed:', e);
                        // Fallback to regular chart if column chart fails
                        await this.loadUserSubmissionsGrowthChart();
                    }
                } else {
                    // Show regular submissions chart when no report type selected
                    await this.loadUserSubmissionsGrowthChart();
                }
            });
        }
    }
    
    async loadUserKPICards() {
        try {
            // Get user's submissions
            let submissions = this.allSubmissions || [];
            // Filter by report type if selected
            submissions = this.filterByUserAnalyticsType(submissions);
            
            // Get assigned reports
            const assignedReports = this.assignedReports || [];
            
            // Calculate KPI values
            const totalSubmissions = submissions.length;
            const totalAssigned = assignedReports.length;
            const completed = submissions.length;
            const pending = Math.max(0, totalAssigned - completed);
            
            // Calculate percentage changes (mock - you can make this dynamic)
            const submissionsChange = totalSubmissions > 0 ? 12 : 0;
            const assignedChange = totalAssigned > 0 ? 8 : 0;
            const completedChange = completed > 0 ? 10 : 0;
            const pendingChange = pending > 0 ? 5 : 0;
            
            // Update KPI Cards
            this.updateUserKPICard('userKpiTotalSubmissions', totalSubmissions, submissionsChange, 'userKpiSubmissionsChart');
            this.updateUserKPICard('userKpiAssignedReports', totalAssigned, assignedChange, 'userKpiAssignedChart');
            this.updateUserKPICard('userKpiCompletedReports', completed, completedChange, 'userKpiCompletedChart');
            this.updateUserKPICard('userKpiPendingReports', pending, pendingChange, 'userKpiPendingChart');
            
            // Update change indicators
            this.updateUserKPIChange('userKpiSubmissionsChange', submissionsChange);
            this.updateUserKPIChange('userKpiAssignedChange', assignedChange);
            this.updateUserKPIChange('userKpiCompletedChange', completedChange);
            this.updateUserKPIChange('userKpiPendingChange', pendingChange);
            
            // Create mini charts
            this.createUserMiniCharts(submissions);
        } catch (error) {
            console.error('Error loading user KPI cards:', error);
        }
    }
    
    updateUserKPICard(valueId, value, change, chartId) {
        const valueEl = document.getElementById(valueId);
        if (valueEl) {
            valueEl.textContent = typeof value === 'number' ? value.toLocaleString() : value;
        }
    }
    
    updateUserKPIChange(changeId, change) {
        const changeEl = document.getElementById(changeId);
        if (changeEl) {
            changeEl.className = `kpi-change ${change >= 0 ? 'positive' : 'negative'}`;
            const span = changeEl.querySelector('span');
            if (span) {
                span.textContent = Math.abs(change) + '%';
            }
            const icon = changeEl.querySelector('i');
            if (icon) {
                icon.className = change >= 0 ? 'fas fa-arrow-up' : 'fas fa-arrow-down';
            }
        }
    }
    
    createUserMiniCharts(submissions) {
        // Create mini sparkline charts for KPI cards
        const chartIds = ['userKpiSubmissionsChart', 'userKpiAssignedChart', 'userKpiCompletedChart', 'userKpiPendingChart'];
        
        chartIds.forEach((chartId, index) => {
            const container = document.getElementById(chartId);
            if (!container) return;
            
            // Get last 7 days of data for sparkline
            const last7Days = [];
            for (let i = 6; i >= 0; i--) {
                const date = new Date();
                date.setDate(date.getDate() - i);
                const dayStart = new Date(date);
                dayStart.setHours(0, 0, 0, 0);
                const dayEnd = new Date(date);
                dayEnd.setHours(23, 59, 59, 999);
                
                const count = submissions.filter(s => {
                    const subDate = new Date(s.submission_date || s.submitted_at || s.created_at);
                    return subDate >= dayStart && subDate <= dayEnd;
                }).length;
                last7Days.push(count);
            }
            
            // Create simple SVG sparkline
            const max = Math.max(...last7Days, 1);
            const width = 100;
            const height = 40;
            const points = last7Days.map((val, i) => {
                const x = (i / (last7Days.length - 1)) * width;
                const y = height - (val / max) * height;
                return `${x},${y}`;
            }).join(' ');
            
            const colors = ['#3b82f6', '#ef4444', '#10b981', '#3b82f6'];
            container.innerHTML = `
                <svg width="${width}" height="${height}" style="width: 100%; height: 100%;">
                    <polyline points="${points}" fill="none" stroke="${colors[index]}" stroke-width="2"/>
                </svg>
            `;
        });
    }
    
    async loadUserSubmissionsGrowthChart() {
        try {
            // Don't load if a report type is selected (will show column chart instead)
            if (this.analyticsReportType) {
                return;
            }
            let submissions = this.allSubmissions || [];
            this.createUserSubmissionsGrowthChart(submissions);
        } catch (error) {
            console.error('Error loading user growth chart:', error);
        }
    }

    async loadUserColumnBasedChart(reportType) {
        try {
            // Get user's submissions for this report type
            const submissions = (this.allSubmissions || []).filter(s => {
                const subReportType = (s.report_type || s.table_name || '').toLowerCase().replace(/\s+/g, '');
                const targetReportType = reportType.toLowerCase().replace(/\s+/g, '');
                return subReportType === targetReportType;
            });

            if (submissions.length === 0) {
                this.createUserColumnBasedChart([], []);
                return;
            }

            // Fetch actual data for each submission
            const allDataRows = [];
            for (const submission of submissions) {
                try {
                    const response = await fetch(`api/get_submission_details.php?submission_id=${submission.id}`, {
                        credentials: 'include'
                    });
                    const result = await response.json();
                    if (result.success && result.data && Array.isArray(result.data)) {
                        allDataRows.push(...result.data);
                    }
                } catch (error) {
                    console.error(`Error fetching submission ${submission.id} details:`, error);
                }
            }

            if (allDataRows.length === 0) {
                this.createUserColumnBasedChart([], []);
                return;
            }

            // Get all unique columns (excluding internal metadata)
            const columnsToHide = ['id', 'submission_id', 'batch_id', 'submitted_by', 'submitted_at', 'created_at', 'updated_at'];
            const allColumns = new Set();
            allDataRows.forEach(row => {
                if (row && typeof row === 'object') {
                    Object.keys(row).forEach(key => {
                        const lowerKey = key.toLowerCase();
                        if (!columnsToHide.includes(lowerKey) && !key.startsWith('__')) {
                            allColumns.add(key);
                        }
                    });
                }
            });

            const columns = Array.from(allColumns);
            if (columns.length === 0) {
                this.createUserColumnBasedChart([], []);
                return;
            }

            // Calculate ratings for each column
            const columnRatings = columns.map(column => {
                const analytics = this.calculateUserColumnAnalytics(allDataRows, column);
                const totalPossibleData = allDataRows.length;
                const filledData = analytics.filledCount;
                const rating = analytics.hasNumericValues && analytics.numericSum !== null ? analytics.numericSum : filledData;
                return { 
                    column, 
                    rating, 
                    filledCount: filledData, 
                    totalCount: totalPossibleData, 
                    emptyCount: totalPossibleData - filledData, 
                    isNumeric: analytics.hasNumericValues, 
                    numericSum: analytics.numericSum 
                };
            });

            columnRatings.sort((a, b) => b.rating - a.rating);
            const columnLabels = columnRatings.map(cr => this.formatColumnName(cr.column));
            const ratingData = columnRatings.map(cr => cr.rating);
            
            this.createUserColumnBasedChart(columnLabels, ratingData, columnRatings);
        } catch (error) {
            console.error('Error loading user column-based chart:', error);
            this.createUserColumnBasedChart([], []);
        }
    }

    createUserColumnBasedChart(columnLabels, ratingData, columnRatings = []) {
        const ctx = document.getElementById('userSubmissionsGrowthChart');
        if (!ctx) return;
        
        if (columnLabels.length === 0 || ratingData.length === 0) {
            const parent = ctx.parentElement;
            if (parent && !parent.querySelector('.no-data-message')) {
                const message = document.createElement('div');
                message.className = 'no-data-message';
                message.style.cssText = 'padding: 40px; text-align: center; color: #6b7280;';
                message.textContent = 'No data available for this report type';
                parent.insertBefore(message, ctx);
            }
            return;
        }

        const parent = ctx.parentElement;
        if (parent) {
            const existingMessage = parent.querySelector('.no-data-message');
            if (existingMessage) existingMessage.remove();
        }

        if (this.userSubmissionsGrowthChart) {
            this.userSubmissionsGrowthChart.destroy();
            this.userSubmissionsGrowthChart = null;
        }

        requestAnimationFrame(() => {
            this._createUserColumnChart(ctx, columnLabels, ratingData, columnRatings);
        });
    }

    _createUserColumnChart(ctx, columnLabels, ratingData, columnRatings) {
        const maxValue = Math.max(...ratingData, 1);
        let maxY;
        if (maxValue >= 1000) maxY = Math.ceil(maxValue / 1000) * 1000;
        else if (maxValue >= 100) maxY = Math.ceil(maxValue / 100) * 100;
        else if (maxValue >= 10) maxY = Math.ceil(maxValue / 10) * 10;
        else maxY = Math.ceil(maxValue);
        if (maxValue === 0) maxY = 10;

        const stepSize = maxY >= 10 ? Math.ceil(maxY / 10) : 1;

        const backgroundColors = ratingData.map((count, index) => {
            const cr = columnRatings[index];
            const total = cr?.totalCount || 1;
            const rate = total > 0 ? (count / total) * 100 : 0;
            if (rate >= 90) return 'rgba(16, 185, 129, 0.2)';
            if (rate >= 70) return 'rgba(59, 130, 246, 0.2)';
            if (rate >= 50) return 'rgba(245, 158, 11, 0.2)';
            return 'rgba(239, 68, 68, 0.2)';
        });

        const borderColors = ratingData.map((count, index) => {
            const cr = columnRatings[index];
            const total = cr?.totalCount || 1;
            const rate = total > 0 ? (count / total) * 100 : 0;
            if (rate >= 90) return '#10b981';
            if (rate >= 70) return '#3b82f6';
            if (rate >= 50) return '#f59e0b';
            return '#ef4444';
        });

        this.userSubmissionsGrowthChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: columnLabels,
                datasets: [{
                    label: 'Data Quality Rating',
                    data: ratingData,
                    backgroundColor: backgroundColors,
                    borderColor: borderColors,
                    borderWidth: 2,
                    borderRadius: 6,
                    barThickness: 'flex',
                    maxBarThickness: 50
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: '#1e293b',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        padding: 12,
                        borderRadius: 8,
                        displayColors: false,
                        titleFont: { size: 13, weight: '600' },
                        bodyFont: { size: 12 },
                        callbacks: {
                            title: (context) => context[0].label,
                            label: function(context) {
                                const value = context.parsed.y;
                                const cr = columnRatings[context.dataIndex];
                                const total = cr?.totalCount || 0;
                                const filled = cr?.filledCount || 0;
                                const isNumeric = cr?.isNumeric || false;
                                const completionRate = total > 0 ? (filled / total) * 100 : 0;
                                const rating = this.getUserRating(completionRate);
                                if (isNumeric) {
                                    return [
                                        `Total Sum: ${value.toLocaleString()}`,
                                        `Filled Rows: ${filled} / ${total}`,
                                        `Completion: ${completionRate.toFixed(1)}% (${rating.label})`
                                    ];
                                } else {
                                    return [
                                        `Total Data: ${filled}`,
                                        `Filled: ${filled} / ${total}`,
                                        `Completion: ${completionRate.toFixed(1)}% (${rating.label})`
                                    ];
                                }
                            }.bind(this)
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: maxY,
                        ticks: {
                            stepSize: stepSize,
                            font: { size: 11 },
                            color: '#6b7280',
                            callback: (value) => value >= 1000 ? value.toLocaleString() : value
                        },
                        grid: {
                            color: '#f3f4f6',
                            drawBorder: false
                        },
                        title: {
                            display: true,
                            text: 'Total Value / Count',
                            font: { size: 12, weight: '600' },
                            color: '#6b7280'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            font: { size: 11 },
                            color: '#6b7280',
                            maxRotation: 45,
                            minRotation: 45
                        },
                        title: {
                            display: true,
                            text: 'Columns',
                            font: { size: 12, weight: '600' },
                            color: '#6b7280'
                        }
                    }
                },
                interaction: {
                    intersect: false,
                    mode: 'index'
                }
            }
        });
    }
    
    createUserSubmissionsGrowthChart(submissions) {
        const ctx = document.getElementById('userSubmissionsGrowthChart');
        if (!ctx) return;
        
        if (this.userSubmissionsGrowthChart) {
            this.userSubmissionsGrowthChart.destroy();
        }
        
        // Group by month for yearly view
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        const monthlyData = months.map((month, index) => {
            return submissions.filter(s => {
                const date = new Date(s.submission_date || s.submitted_at || s.created_at);
                return date.getMonth() === index;
            }).length;
        });
        
        // Use actual data values
        const actualData = monthlyData;
        const maxValue = Math.max(...actualData, 1);
        
        // Calculate step size based on max value
        let maxY = Math.ceil(maxValue / 5) * 5;
        if (maxValue === 0) maxY = 5;
        const stepSize = Math.max(1, Math.ceil(maxY / 5));
        
        this.userSubmissionsGrowthChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: months,
                datasets: [{
                    label: 'Submissions',
                    data: actualData,
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    tension: 0.4,
                    fill: true,
                    pointRadius: 0,
                    pointHoverRadius: 6,
                    pointBackgroundColor: '#3b82f6',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: '#1e293b',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        padding: 12,
                        borderRadius: 8,
                        displayColors: false,
                        titleFont: {
                            size: 13,
                            weight: '600'
                        },
                        bodyFont: {
                            size: 12
                        },
                        callbacks: {
                            title: function(context) {
                                return context[0].label;
                            },
                            label: function(context) {
                                const value = context.parsed.y;
                                return `Submissions ${value}`;
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: maxY,
                        ticks: {
                            stepSize: stepSize,
                            font: {
                                size: 11
                            },
                            color: '#6b7280'
                        },
                        grid: {
                            color: '#f3f4f6',
                            drawBorder: false
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            font: {
                                size: 11
                            },
                            color: '#6b7280'
                        }
                    }
                },
                interaction: {
                    intersect: false,
                    mode: 'index'
                }
            }
        });
    }
    
    async loadUserSubmissionsMonthlyChart() {
        try {
            let submissions = this.allSubmissions || [];
            // Filter by report type if selected
            submissions = this.filterByUserAnalyticsType(submissions);
            this.createUserSubmissionsMonthlyChart(submissions);
        } catch (error) {
            console.error('Error loading user monthly chart:', error);
        }
    }
    
    createUserSubmissionsMonthlyChart(submissions) {
        const ctx = document.getElementById('userSubmissionsMonthlyChart');
        if (!ctx) return;
        
        if (this.userSubmissionsMonthlyChart) {
            this.userSubmissionsMonthlyChart.destroy();
        }
        
        // Group by month
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        const monthlyData = months.map((month, index) => {
            return submissions.filter(s => {
                const date = new Date(s.submission_date || s.submitted_at || s.created_at);
                return date.getMonth() === index;
            }).length;
        });
        
        // Calculate growth rate
        const currentMonth = new Date().getMonth();
        const previousMonth = currentMonth > 0 ? currentMonth - 1 : 11;
        const currentCount = monthlyData[currentMonth] || 0;
        const previousCount = monthlyData[previousMonth] || 0;
        const growthRate = previousCount > 0 
            ? Math.round(((currentCount - previousCount) / previousCount) * 100) 
            : 0;
        
        // Update growth indicator
        const growthEl = document.getElementById('userMonthlyReportGrowth');
        if (growthEl) {
            growthEl.className = `report-growth-indicator ${growthRate >= 0 ? 'positive' : 'negative'}`;
            const span = growthEl.querySelector('span');
            if (span) {
                span.textContent = Math.abs(growthRate) + '%';
            }
        }
        
        // Update footer metrics
        const impressionsEl = document.getElementById('userMonthlyImpressions');
        const growthEl2 = document.getElementById('userMonthlyGrowth');
        
        if (impressionsEl) impressionsEl.textContent = currentCount.toLocaleString();
        if (growthEl2) growthEl2.textContent = growthRate + '%';
        
        // Scale data for better visualization
        const maxData = Math.max(...monthlyData, 1);
        const scaledData = monthlyData.map(val => (val / maxData) * 100);
        
        this.userSubmissionsMonthlyChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: months,
                datasets: [{
                    label: 'Submissions',
                    data: scaledData,
                    backgroundColor: monthlyData.map((val, i) => 
                        i === currentMonth ? '#3b82f6' : '#e5e7eb'
                    ),
                    borderRadius: 8,
                    borderSkipped: false
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: '#1f2937',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        padding: 12,
                        borderRadius: 8
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100,
                        ticks: {
                            stepSize: 20
                        },
                        grid: {
                            color: '#f3f4f6'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });
    }
    
    async loadUserReportsByType() {
        try {
            let submissions = this.allSubmissions || [];
            // Filter by report type if selected
            submissions = this.filterByUserAnalyticsType(submissions);
            this.createUserReportsByTypeChart(submissions);
        } catch (error) {
            console.error('Error loading user reports by type:', error);
        }
    }
    
    createUserReportsByTypeChart(submissions) {
        const ctx = document.getElementById('userReportsByTypeChart');
        if (!ctx) return;
        
        if (this.userReportsByTypeChart) {
            this.userReportsByTypeChart.destroy();
        }
        
        // Group submissions by report type
        const reportTypeCounts = {};
        submissions.forEach(s => {
            const reportType = (s.table_name || s.report_type || 'Unknown').trim();
            if (!reportTypeCounts[reportType]) {
                reportTypeCounts[reportType] = 0;
            }
            reportTypeCounts[reportType]++;
        });
        
        // Get top report types
        const sortedTypes = Object.entries(reportTypeCounts)
            .sort((a, b) => b[1] - a[1])
            .slice(0, 6); // Top 6
        
        const totalReportTypes = Object.keys(reportTypeCounts).length;
        
        // Update center text
        const centerText = document.getElementById('userReportTypeChartCenterText');
        if (centerText) {
            centerText.textContent = totalReportTypes;
        }
        
        // Create donut chart
        const labels = sortedTypes.map(([type]) => this.formatReportTypeName(type));
        const data = sortedTypes.map(([type, count]) => count);
        const backgroundColors = [
            '#3b82f6', '#ef4444', '#10b981', '#f59e0b', '#8b5cf6', '#ec4899'
        ];
        
        this.userReportsByTypeChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: backgroundColors.slice(0, labels.length),
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: '#1f2937',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        padding: 12,
                        borderRadius: 8
                    }
                }
            }
        });
        
        // Create legend
        const legendEl = document.getElementById('userReportTypeChartLegend');
        if (legendEl) {
            legendEl.innerHTML = sortedTypes.map(([type, count], index) => {
                const percentage = ((count / submissions.length) * 100).toFixed(1);
                return `
                    <div class="legend-item">
                        <div class="legend-color" style="background: ${backgroundColors[index]}"></div>
                        <span class="legend-label">${this.formatReportTypeName(type)}</span>
                        <span class="legend-value">${count} (${percentage}%)</span>
                    </div>
                `;
            }).join('');
        }
    }
    
    async loadUserTopActiveReports() {
        try {
            let submissions = this.allSubmissions || [];
            // Filter by report type if selected
            submissions = this.filterByUserAnalyticsType(submissions);
            this.populateUserTopActiveReports(submissions);
        } catch (error) {
            console.error('Error loading user top active reports:', error);
        }
    }
    
    populateUserTopActiveReports(submissions) {
        const tbody = document.querySelector('#userTopReportsTable tbody');
        if (!tbody) return;
        
        // Group by report type
        const reportTypeCounts = {};
        submissions.forEach(s => {
            const reportType = (s.table_name || s.report_type || 'Unknown').trim();
            if (!reportTypeCounts[reportType]) {
                reportTypeCounts[reportType] = 0;
            }
            reportTypeCounts[reportType]++;
        });
        
        // Get top 5 report types
        const sortedTypes = Object.entries(reportTypeCounts)
            .sort((a, b) => b[1] - a[1])
            .slice(0, 5);
        
        if (sortedTypes.length === 0) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="2" style="text-align: center; padding: 40px; color: #9ca3af;">
                        No reports found
                    </td>
                </tr>
            `;
            return;
        }
        
        tbody.innerHTML = sortedTypes.map(([type, count]) => {
            return `
                <tr>
                    <td>
                        <div class="report-type-cell">
                            <i class="fas fa-file-alt report-type-icon"></i>
                            <span>${this.formatReportTypeName(type)}</span>
                        </div>
                    </td>
                    <td style="text-align: center; font-weight: 600; color: #1f2937;">${count}</td>
                </tr>
            `;
        }).join('');
    }
    
    formatReportTypeName(type) {
        if (!type) return 'Unknown';
        
        const formatted = type
            .replace(/([A-Z])/g, ' $1')
            .replace(/^./, str => str.toUpperCase())
            .trim();
        
        // Handle specific mappings
        const mappings = {
            'pwd': 'PWD',
            'pwddata': 'PWD Data',
            'employee': 'Employee',
            'employees': 'Employee',
            'graduatesdata': 'Graduates Data',
            'admissiondata': 'Admission Data',
            'enrollmentdata': 'Enrollment Data',
            'campuspopulation': 'Campus Population'
        };
        
        const lowerType = type.toLowerCase();
        if (mappings[lowerType]) {
            return mappings[lowerType];
        }
        
        // Split camelCase or lowercase words
        if (formatted === type && /[a-z][A-Z]/.test(type)) {
            return type.replace(/([a-z])([A-Z])/g, '$1 $2');
        }
        
        return formatted;
    }
    
    createSubmissionTrendChart() {
        const ctx = document.getElementById('submissionTrendChart');
        if (!ctx) return;
        
        // Get last 7 days of submissions
        const last7Days = [];
        const submissionCounts = [];
        const today = new Date();
        
        for (let i = 6; i >= 0; i--) {
            const date = new Date(today);
            date.setDate(date.getDate() - i);
            const dateStr = date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
            last7Days.push(dateStr);
            
            // Count submissions for this day
            const count = (this.allSubmissions || []).filter(sub => {
                const subDate = new Date(sub.submission_date);
                return subDate.toDateString() === date.toDateString();
            }).length;
            submissionCounts.push(count);
        }
        
        this.submissionTrendChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: last7Days,
                datasets: [{
                    label: 'Submissions',
                    data: submissionCounts,
                    borderColor: '#dc143c',
                    backgroundColor: 'rgba(220, 20, 60, 0.1)',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: '#dc143c',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointRadius: 5,
                    pointHoverRadius: 7
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        borderColor: '#dc143c',
                        borderWidth: 1
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1,
                            color: '#718096'
                        },
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    },
                    x: {
                        ticks: {
                            color: '#718096'
                        },
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });
    }
    
    createReportTypesChart() {
        const ctx = document.getElementById('reportTypesChart');
        if (!ctx) return;
        
        // Count submissions by report type
        const reportTypeCounts = {};
        (this.allSubmissions || []).forEach(sub => {
            const type = this.formatReportName(sub.table_name);
            reportTypeCounts[type] = (reportTypeCounts[type] || 0) + 1;
        });
        
        const labels = Object.keys(reportTypeCounts);
        const data = Object.values(reportTypeCounts);
        const colors = [
            '#dc143c', '#ff6384', '#36a2eb', '#ffce56', '#4bc0c0',
            '#9966ff', '#ff9f40', '#ff6384', '#c9cbcf', '#4bc0c0'
        ];
        
        this.reportTypesChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: colors.slice(0, labels.length),
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: {
                            padding: 15,
                            font: {
                                size: 12
                            },
                            color: '#2d3748'
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        titleColor: '#fff',
                        bodyColor: '#fff'
                    }
                }
            }
        });
    }
    
    createStatusChart() {
        const ctx = document.getElementById('statusChart');
        if (!ctx) return;
        
        // Count submissions by status
        const statusCounts = {
            pending: 0,
            approved: 0,
            rejected: 0
        };
        
        (this.allSubmissions || []).forEach(sub => {
            const status = (sub.status || 'pending').toLowerCase();
            if (statusCounts.hasOwnProperty(status)) {
                statusCounts[status]++;
            }
        });
        
        // Create the chart instance and assign it to this.statusChart
        this.statusChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Pending', 'Approved', 'Rejected'],
                datasets: [{
                    label: 'Submissions',
                    data: [statusCounts.pending, statusCounts.approved, statusCounts.rejected],
                    backgroundColor: [
                        'rgba(237, 137, 54, 0.8)',
                        'rgba(72, 187, 120, 0.8)',
                        'rgba(245, 101, 101, 0.8)'
                    ],
                    borderColor: [
                        '#ed8936',
                        '#48bb78',
                        '#f56565'
                    ],
                    borderWidth: 2,
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        titleColor: '#fff',
                        bodyColor: '#fff'
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1,
                            color: '#718096'
                        },
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    },
                    x: {
                        ticks: {
                            color: '#718096'
                        },
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });
    }

    /**
     * Load Profile section
     */
    async loadProfile() {
        const container = document.getElementById('profileContainer');
        if (!container) {
            console.warn('Profile container not found');
            return;
        }
        
        // Get current user data
        let user = this.currentUser || {
            username: document.getElementById('userName')?.textContent || 'User',
            name: document.getElementById('userName')?.textContent || 'User',
            role: document.getElementById('userRole')?.textContent || 'User',
            campus: '',
            office: ''
        };
        
        // Try to fetch full user data if not already loaded
        if (!user.campus || !user.office) {
            try {
                // Use simple_auth.php which uses the same session system
                const response = await fetch('api/simple_auth.php?action=get_user_data', {
                    credentials: 'include' // Include cookies for session
                });
                if (response.ok) {
                    const result = await response.json();
                    if (result.success && result.data && result.data.user) {
                        user = { ...user, ...result.data.user };
                        this.currentUser = user;
                    }
                }
            } catch (error) {
                console.log('Could not fetch full user data:', error);
                // Continue with available data
            }
        }
        
        // Get username, fallback to name if username not available
        const username = user.username || user.name || 'User';
        
        const profileHTML = `
            <div class="profile-container-new">
                <!-- Profile Header Card -->
                <div class="profile-header-card">
                    <div class="profile-avatar-section">
                        <div class="profile-avatar-new" id="profileAvatar">
                            <span class="avatar-initial-new" id="avatarInitial">${username.charAt(0).toUpperCase()}</span>
                        </div>
                        <div class="profile-status-dot"></div>
                    </div>
                    <div class="profile-info-section">
                        <h1 class="profile-name-new" id="profileName">${user.name || username}</h1>
                        <p class="profile-username-new" id="profileEmailText">@${username}</p>
                        <div class="profile-role-badge-new" id="profileRoleBadge">
                            <i class="fas fa-user-shield"></i>
                            <span id="profileRoleText">${user.role || 'User'}</span>
                        </div>
                    </div>
                </div>

                <!-- Profile Details Cards -->
                <div class="profile-details-grid-new">
                    <!-- Work Information Card -->
                    <div class="profile-detail-card-new">
                        <div class="detail-card-header">
                            <div class="detail-card-icon work-icon">
                                <i class="fas fa-briefcase"></i>
                            </div>
                            <h3 class="detail-card-title">Work Information</h3>
                        </div>
                        <div class="detail-card-content">
                            <div class="detail-row-new">
                                <div class="detail-label-new">
                                    <i class="fas fa-building"></i>
                                    <span>Campus</span>
                                </div>
                                <div class="detail-value-new" id="profileCampus">
                                    <span class="value-badge campus-badge">${user.campus || 'Not assigned'}</span>
                                </div>
                            </div>
                            <div class="detail-row-new">
                                <div class="detail-label-new">
                                    <i class="fas fa-door-open"></i>
                                    <span>Office</span>
                                </div>
                                <div class="detail-value-new" id="profileOffice">
                                    <span class="value-badge office-badge">${user.office || 'Not assigned'}</span>
                                </div>
                            </div>
                            <div class="detail-row-new">
                                <div class="detail-label-new">
                                    <i class="fas fa-check-circle"></i>
                                    <span>Status</span>
                                </div>
                                <div class="detail-value-new">
                                    <span class="value-badge status-badge-active" id="statusBadge">Active</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Account Information Card -->
                    <div class="profile-detail-card-new">
                        <div class="detail-card-header">
                            <div class="detail-card-icon account-icon">
                                <i class="fas fa-clock"></i>
                            </div>
                            <h3 class="detail-card-title">Account Information</h3>
                        </div>
                        <div class="detail-card-content">
                            <div class="detail-row-new">
                                <div class="detail-label-new">
                                    <i class="fas fa-sign-in-alt"></i>
                                    <span>Last Login</span>
                                </div>
                                <div class="detail-value-new" id="lastLogin">
                                    <span class="value-text">${user.last_login ? new Date(user.last_login).toLocaleString() : 'Never'}</span>
                                </div>
                            </div>
                            <div class="detail-row-new">
                                <div class="detail-label-new">
                                    <i class="fas fa-calendar-plus"></i>
                                    <span>Account Created</span>
                                </div>
                                <div class="detail-value-new" id="accountCreated">
                                    <span class="value-text">${user.created_at ? new Date(user.created_at).toLocaleDateString() : 'N/A'}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Action Button -->
                <div class="profile-actions-new">
                    <button class="btn-change-password" onclick="userDashboard.openChangePasswordModal()">
                        <i class="fas fa-key"></i>
                        <span>Change Password</span>
                    </button>
                </div>
            </div>
        `;
        
        container.innerHTML = profileHTML;
    }

    /**
     * Open Change Password Modal
     */
    openChangePasswordModal() {
        // Remove existing modal if any
        const existingModal = document.getElementById('changePasswordModal');
        if (existingModal) {
            existingModal.remove();
        }

        const modalHTML = `
            <div class="password-modal-overlay" id="changePasswordModal">
                <div class="password-modal-content">
                    <div class="password-modal-header">
                        <h2>
                            <i class="fas fa-key"></i>
                            Change Password
                        </h2>
                        <button class="password-modal-close" onclick="userDashboard.closeChangePasswordModal()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="password-modal-body">
                        <form id="changePasswordForm" onsubmit="userDashboard.handlePasswordChange(event)">
                            <div class="password-form-group">
                                <label for="currentPassword">
                                    <i class="fas fa-lock"></i>
                                    Current Password
                                </label>
                                <div class="password-input-wrapper">
                                    <input 
                                        type="password" 
                                        id="currentPassword" 
                                        name="currentPassword" 
                                        required 
                                        placeholder="Enter your current password"
                                        autocomplete="current-password"
                                    >
                                    <button 
                                        type="button" 
                                        class="password-toggle" 
                                        onclick="userDashboard.togglePasswordVisibility('currentPassword')"
                                    >
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <div class="password-form-group">
                                <label for="newPassword">
                                    <i class="fas fa-key"></i>
                                    New Password
                                </label>
                                <div class="password-input-wrapper">
                                    <input 
                                        type="password" 
                                        id="newPassword" 
                                        name="newPassword" 
                                        required 
                                        placeholder="Enter your new password"
                                        autocomplete="new-password"
                                        minlength="8"
                                        oninput="userDashboard.validatePassword()"
                                    >
                                    <button 
                                        type="button" 
                                        class="password-toggle" 
                                        onclick="userDashboard.togglePasswordVisibility('newPassword')"
                                    >
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div id="passwordStrength" class="password-strength"></div>
                                <div id="passwordRequirements" class="password-requirements">
                                    <div class="requirement-item" id="req-length">
                                        <i class="fas fa-times"></i>
                                        <span>At least 8 characters</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="password-form-group">
                                <label for="confirmPassword">
                                    <i class="fas fa-check-double"></i>
                                    Confirm New Password
                                </label>
                                <div class="password-input-wrapper">
                                    <input 
                                        type="password" 
                                        id="confirmPassword" 
                                        name="confirmPassword" 
                                        required 
                                        placeholder="Confirm your new password"
                                        autocomplete="new-password"
                                        oninput="userDashboard.validatePassword()"
                                    >
                                    <button 
                                        type="button" 
                                        class="password-toggle" 
                                        onclick="userDashboard.togglePasswordVisibility('confirmPassword')"
                                    >
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div id="passwordMatch" class="password-match"></div>
                            </div>
                            
                            <div class="password-form-actions">
                                <button 
                                    type="button" 
                                    class="btn-action-modern btn-secondary-modern" 
                                    onclick="userDashboard.closeChangePasswordModal()"
                                >
                                    Cancel
                                </button>
                                <button 
                                    type="submit" 
                                    class="btn-action-modern btn-primary-modern" 
                                    id="submitPasswordBtn"
                                    disabled
                                >
                                    <span id="submitPasswordText">Change Password</span>
                                    <span id="submitPasswordSpinner" style="display: none;">
                                        <i class="fas fa-spinner fa-spin"></i> Changing...
                                    </span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        `;

        // Append modal directly to body with highest priority
        document.body.appendChild(document.createRange().createContextualFragment(modalHTML));
        
        // Force modal to front - set inline styles for maximum priority
        const modal = document.getElementById('changePasswordModal');
        if (modal) {
            modal.style.cssText = `
                position: fixed !important;
                top: 0 !important;
                left: 0 !important;
                right: 0 !important;
                bottom: 0 !important;
                width: 100vw !important;
                height: 100vh !important;
                z-index: 9999999 !important;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
            `;
            
            // Close modal when clicking outside
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    this.closeChangePasswordModal();
                }
            });
        }
        
        // Close modal on Escape key
        const escapeHandler = (e) => {
            if (e.key === 'Escape') {
                this.closeChangePasswordModal();
                document.removeEventListener('keydown', escapeHandler);
            }
        };
        document.addEventListener('keydown', escapeHandler);
        
        // Focus on first input
        setTimeout(() => {
            document.getElementById('currentPassword')?.focus();
        }, 100);
    }

    /**
     * Close Change Password Modal
     */
    closeChangePasswordModal() {
        const modal = document.getElementById('changePasswordModal');
        if (modal) {
            modal.style.opacity = '0';
            setTimeout(() => {
                modal.remove();
            }, 300);
        }
    }

    /**
     * Toggle Password Visibility
     */
    togglePasswordVisibility(inputId) {
        const input = document.getElementById(inputId);
        const button = input?.nextElementSibling;
        const icon = button?.querySelector('i');

        if (input && button && icon) {
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
    }

    /**
     * Validate Password
     */
    validatePassword() {
        const newPassword = document.getElementById('newPassword')?.value || '';
        const confirmPassword = document.getElementById('confirmPassword')?.value || '';
        const submitBtn = document.getElementById('submitPasswordBtn');
        const passwordMatch = document.getElementById('passwordMatch');
        const passwordStrength = document.getElementById('passwordStrength');
        const reqLength = document.getElementById('req-length');

        let isValid = true;

        // Check password length
        const hasMinLength = newPassword.length >= 8;
        if (reqLength) {
            const icon = reqLength.querySelector('i');
            if (icon) {
                icon.className = hasMinLength ? 'fas fa-check' : 'fas fa-times';
                icon.style.color = hasMinLength ? '#10b981' : '#ef4444';
            }
        }

        // Check password match
        if (confirmPassword) {
            if (confirmPassword === newPassword) {
                passwordMatch.innerHTML = '<i class="fas fa-check"></i> Passwords match';
                passwordMatch.className = 'password-match success';
                isValid = isValid && hasMinLength;
            } else {
                passwordMatch.innerHTML = '<i class="fas fa-times"></i> Passwords do not match';
                passwordMatch.className = 'password-match error';
                isValid = false;
            }
        } else {
            passwordMatch.innerHTML = '';
            passwordMatch.className = 'password-match';
            isValid = false;
        }

        // Update submit button
        if (submitBtn) {
            submitBtn.disabled = !isValid || !newPassword || !hasMinLength;
        }

        // Update password strength indicator
        if (passwordStrength && newPassword) {
            let strength = 0;
            if (newPassword.length >= 8) strength++;
            if (newPassword.length >= 12) strength++;
            if (/[A-Z]/.test(newPassword)) strength++;
            if (/[0-9]/.test(newPassword)) strength++;
            if (/[^A-Za-z0-9]/.test(newPassword)) strength++;

            passwordStrength.className = 'password-strength';
            if (strength <= 2) {
                passwordStrength.innerHTML = '<div class="strength-bar weak"></div><span>Weak</span>';
            } else if (strength <= 3) {
                passwordStrength.innerHTML = '<div class="strength-bar medium"></div><span>Medium</span>';
            } else {
                passwordStrength.innerHTML = '<div class="strength-bar strong"></div><span>Strong</span>';
            }
        }
    }

    /**
     * Handle Password Change
     */
    async handlePasswordChange(event) {
        event.preventDefault();

        const currentPassword = document.getElementById('currentPassword')?.value || '';
        const newPassword = document.getElementById('newPassword')?.value || '';
        const confirmPassword = document.getElementById('confirmPassword')?.value || '';
        const submitBtn = document.getElementById('submitPasswordBtn');
        const submitText = document.getElementById('submitPasswordText');
        const submitSpinner = document.getElementById('submitPasswordSpinner');

        // Validation
        if (!currentPassword || !newPassword || !confirmPassword) {
            this.showNotification('Please fill in all fields', 'error');
            return;
        }

        if (newPassword.length < 8) {
            this.showNotification('Password must be at least 8 characters long', 'error');
            return;
        }

        if (newPassword !== confirmPassword) {
            this.showNotification('Passwords do not match', 'error');
            return;
        }

        if (currentPassword === newPassword) {
            this.showNotification('New password must be different from current password', 'error');
            return;
        }

        // Disable submit button
        if (submitBtn) submitBtn.disabled = true;
        if (submitText) submitText.style.display = 'none';
        if (submitSpinner) submitSpinner.style.display = 'inline-block';

        try {
            const response = await fetch('api/change_password.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'include',
                body: JSON.stringify({
                    currentPassword: currentPassword,
                    newPassword: newPassword
                })
            });

            const result = await response.json();

            if (result.success) {
                this.showNotification('Password changed successfully!', 'success');
                this.closeChangePasswordModal();
                
                // Reset form
                const form = document.getElementById('changePasswordForm');
                if (form) form.reset();
            } else {
                this.showNotification(result.message || 'Failed to change password', 'error');
            }
        } catch (error) {
            console.error('Password change error:', error);
            this.showNotification('An error occurred. Please try again.', 'error');
        } finally {
            // Re-enable submit button
            if (submitBtn) submitBtn.disabled = false;
            if (submitText) submitText.style.display = 'inline-block';
            if (submitSpinner) submitSpinner.style.display = 'none';
        }
    }

    async loadHelp() {
        const container = document.getElementById('helpContainer');
        if (!container) {
            console.warn('Help container not found');
            return;
        }
        
        // Show loading state
        container.innerHTML = `
            <div class="loading-state">
                <i class="fas fa-spinner fa-spin"></i>
                <p>Loading help content...</p>
            </div>
        `;
        
        // Fetch super admin contact information
        let superAdmins = [];
        try {
            const response = await fetch('api/get_super_admin.php', {
                credentials: 'include'
            });
            if (response.ok) {
                const result = await response.json();
                if (result.success && result.data) {
                    superAdmins = result.data;
                }
            }
        } catch (error) {
            console.error('Error fetching super admin info:', error);
        }
        
        const helpHTML = `
            <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 24px; margin-top: 24px;" class="help-content-grid">
                <!-- User Guide Section -->
                <div style="background: #fff; border-radius: 16px; padding: 32px; box-shadow: 0 2px 12px rgba(0,0,0,0.06);">
                    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 28px; padding-bottom: 20px; border-bottom: 2px solid #e5e7eb;">
                        <div style="width: 48px; height: 48px; background: linear-gradient(135deg, #dc143c 0%, #a00000 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-book" style="color: #fff; font-size: 24px;"></i>
                        </div>
                        <div>
                            <h2 style="margin: 0; font-size: 24px; font-weight: 800; color: #1a202c;">User Guide</h2>
                            <p style="margin: 4px 0 0; color: #64748b; font-size: 14px;">Complete guide to using the system</p>
                        </div>
                    </div>
                    
                    <!-- Getting Started -->
                    <div style="margin-bottom: 32px;">
                        <h3 style="display: flex; align-items: center; gap: 10px; font-size: 20px; font-weight: 700; color: #1a202c; margin-bottom: 16px;">
                            <i class="fas fa-rocket" style="color: #dc143c;"></i>
                            Getting Started
                        </h3>
                        <div style="background: #f8fafc; border-radius: 12px; padding: 20px; border-left: 4px solid #dc143c;">
                            <ol style="margin: 0; padding-left: 20px; color: #475569; line-height: 1.8;">
                                <li style="margin-bottom: 12px;"><strong style="color: #1a202c;">View Your Tasks:</strong> Go to "My Tasks" section to see all assigned reports with deadlines and priorities.</li>
                                <li style="margin-bottom: 12px;"><strong style="color: #1a202c;">Start a Task:</strong> Click "START TASK" button on any assigned report to begin data entry.</li>
                                <li style="margin-bottom: 12px;"><strong style="color: #1a202c;">Fill Required Fields:</strong> Complete all mandatory fields marked with red asterisks (*).</li>
                                <li style="margin-bottom: 12px;"><strong style="color: #1a202c;">Submit Report:</strong> Review your data and click "Submit Report" when ready.</li>
                                <li style="margin-bottom: 12px;"><strong style="color: #1a202c;">Track Progress:</strong> Check "Submissions History" to see the status of your submitted reports.</li>
                            </ol>
                        </div>
                    </div>
                    
                    <!-- Using the Calendar -->
                    <div style="margin-bottom: 32px;">
                        <h3 style="display: flex; align-items: center; gap: 10px; font-size: 20px; font-weight: 700; color: #1a202c; margin-bottom: 16px;">
                            <i class="fas fa-calendar-alt" style="color: #dc143c;"></i>
                            Using the Calendar
                        </h3>
                        <div style="background: #f8fafc; border-radius: 12px; padding: 20px; border-left: 4px solid #dc143c;">
                            <ul style="margin: 0; padding-left: 20px; color: #475569; line-height: 1.8;">
                                <li style="margin-bottom: 12px;">View all your deadlines in the <strong style="color: #1a202c;">Calendar</strong> section</li>
                                <li style="margin-bottom: 12px;">Days with deadlines show colored dots to indicate their status</li>
                                <li style="margin-bottom: 12px;">Check the <strong style="color: #1a202c;">Upcoming Deadlines</strong> sidebar for a quick list of approaching due dates</li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Submitting Reports -->
                    <div style="margin-bottom: 32px;">
                        <h3 style="display: flex; align-items: center; gap: 10px; font-size: 20px; font-weight: 700; color: #1a202c; margin-bottom: 16px;">
                            <i class="fas fa-file-upload" style="color: #dc143c;"></i>
                            Submitting Reports
                        </h3>
                        <div style="background: #f8fafc; border-radius: 12px; padding: 20px; border-left: 4px solid #dc143c;">
                            <ul style="margin: 0; padding-left: 20px; color: #475569; line-height: 1.8;">
                                <li style="margin-bottom: 12px;"><strong style="color: #1a202c;">Required Fields:</strong> All fields marked with (*) must be filled before submission</li>
                                <li style="margin-bottom: 12px;"><strong style="color: #1a202c;">Data Validation:</strong> The system will check for empty required columns and show an error if found</li>
                                <li style="margin-bottom: 12px;"><strong style="color: #1a202c;">Review Before Submit:</strong> Double-check all data entries before clicking "Submit Report"</li>
                                <li style="margin-bottom: 12px;"><strong style="color: #1a202c;">Cannot Edit After Submit:</strong> Once submitted, reports cannot be edited. Contact super admin if changes are needed</li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Tips & Best Practices -->
                    <div>
                        <h3 style="display: flex; align-items: center; gap: 10px; font-size: 20px; font-weight: 700; color: #1a202c; margin-bottom: 16px;">
                            <i class="fas fa-lightbulb" style="color: #dc143c;"></i>
                            Tips & Best Practices
                        </h3>
                        <div style="background: #f8fafc; border-radius: 12px; padding: 20px; border-left: 4px solid #dc143c;">
                            <ul style="margin: 0; padding-left: 20px; color: #475569; line-height: 1.8;">
                                <li style="margin-bottom: 12px;">Submit reports before the deadline to avoid overdue status</li>
                                <li style="margin-bottom: 12px;">Use the calendar to plan your work and prioritize tasks</li>
                                <li style="margin-bottom: 12px;">Check your activity log regularly to track your system usage</li>
                                <li style="margin-bottom: 12px;">Keep your profile information up to date</li>
                                <li style="margin-bottom: 12px;">Contact super admin immediately if you encounter any technical issues</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <!-- Super Admin Contact Section -->
                <div style="background: #fff; border-radius: 16px; padding: 32px; box-shadow: 0 2px 12px rgba(0,0,0,0.06); height: fit-content; position: sticky; top: 20px;">
                    <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 24px; padding-bottom: 20px; border-bottom: 2px solid #e5e7eb;">
                        <div style="width: 48px; height: 48px; background: linear-gradient(135deg, #dc143c 0%, #a00000 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-user-shield" style="color: #fff; font-size: 24px;"></i>
                        </div>
                        <div>
                            <h2 style="margin: 0; font-size: 20px; font-weight: 800; color: #1a202c;">Contact Super Admin</h2>
                            <p style="margin: 4px 0 0; color: #64748b; font-size: 13px;">Get assistance from administrators</p>
                        </div>
                    </div>
                    
                    <div style="display: flex; flex-direction: column; gap: 16px;">
                        ${superAdmins.length > 0 ? superAdmins.map(admin => `
                            <div style="background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%); border-radius: 12px; padding: 20px; border: 2px solid #fecaca; transition: all 0.3s ease;" 
                                 onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 4px 12px rgba(220,20,60,0.15)';" 
                                 onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
                                <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 12px;">
                                    <div style="width: 40px; height: 40px; background: #dc143c; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #fff; font-weight: 700; font-size: 16px;">
                                        ${(admin.name || 'A').charAt(0).toUpperCase()}
                                    </div>
                                    <div style="flex: 1;">
                                        <h4 style="margin: 0; font-size: 16px; font-weight: 700; color: #1a202c;">${this.escapeHtml(admin.name || 'Super Admin')}</h4>
                                        <p style="margin: 4px 0 0; font-size: 12px; color: #64748b;">${this.escapeHtml(admin.role === 'super_admin' ? 'Super Administrator' : 'Administrator')}</p>
                                    </div>
                                </div>
                                <div style="display: flex; flex-direction: column; gap: 10px;">
                                    ${admin.email && admin.email !== 'N/A' ? `
                                        <div style="display: flex; align-items: center; gap: 10px; padding: 10px; background: #fff; border-radius: 8px;">
                                            <i class="fas fa-envelope" style="color: #dc143c; font-size: 14px;"></i>
                                            <a href="mailto:${this.escapeHtml(admin.email)}" style="color: #1a202c; text-decoration: none; font-size: 13px; font-weight: 600; word-break: break-all;">
                                                ${this.escapeHtml(admin.email)}
                                            </a>
                                        </div>
                                    ` : ''}
                                    ${admin.office && admin.office !== 'N/A' ? `
                                        <div style="display: flex; align-items: center; gap: 10px; padding: 10px; background: #fff; border-radius: 8px;">
                                            <i class="fas fa-building" style="color: #dc143c; font-size: 14px;"></i>
                                            <span style="color: #475569; font-size: 13px;">${this.escapeHtml(admin.office)}</span>
                                        </div>
                                    ` : ''}
                                    ${admin.campus && admin.campus !== 'N/A' ? `
                                        <div style="display: flex; align-items: center; gap: 10px; padding: 10px; background: #fff; border-radius: 8px;">
                                            <i class="fas fa-map-marker-alt" style="color: #dc143c; font-size: 14px;"></i>
                                            <span style="color: #475569; font-size: 13px;">${this.escapeHtml(admin.campus)}</span>
                                        </div>
                                    ` : ''}
                                </div>
                            </div>
                        `).join('') : ''}
                        
                        <!-- Hardcoded Example Contact Information -->
                        <div style="background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%); border-radius: 12px; padding: 20px; border: 2px solid #fecaca; transition: all 0.3s ease;" 
                             onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 4px 12px rgba(220,20,60,0.15)';" 
                             onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
                            <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 12px;">
                                <div style="width: 40px; height: 40px; background: #dc143c; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #fff; font-weight: 700; font-size: 16px;">
                                    A
                                </div>
                                <div style="flex: 1;">
                                    <h4 style="margin: 0; font-size: 16px; font-weight: 700; color: #1a202c;">Super Administrator</h4>
                                    <p style="margin: 4px 0 0; font-size: 12px; color: #64748b;">System Administrator</p>
                                </div>
                            </div>
                            <div style="display: flex; flex-direction: column; gap: 10px;">
                                <div style="display: flex; align-items: center; gap: 10px; padding: 10px; background: #fff; border-radius: 8px;">
                                    <i class="fas fa-envelope" style="color: #dc143c; font-size: 14px;"></i>
                                    <a href="mailto:admin@spartandata.edu.ph" style="color: #1a202c; text-decoration: none; font-size: 13px; font-weight: 600; word-break: break-all;">
                                        admin@spartandata.edu.ph
                                    </a>
                                </div>
                                <div style="display: flex; align-items: center; gap: 10px; padding: 10px; background: #fff; border-radius: 8px;">
                                    <i class="fas fa-phone" style="color: #dc143c; font-size: 14px;"></i>
                                    <a href="tel:+63432345678" style="color: #1a202c; text-decoration: none; font-size: 13px; font-weight: 600;">
                                        +63 43 234 5678
                                    </a>
                                </div>
                                <div style="display: flex; align-items: center; gap: 10px; padding: 10px; background: #fff; border-radius: 8px;">
                                    <i class="fas fa-building" style="color: #dc143c; font-size: 14px;"></i>
                                    <span style="color: #475569; font-size: 13px;">IT Department</span>
                                </div>
                                <div style="display: flex; align-items: center; gap: 10px; padding: 10px; background: #fff; border-radius: 8px;">
                                    <i class="fas fa-map-marker-alt" style="color: #dc143c; font-size: 14px;"></i>
                                    <span style="color: #475569; font-size: 13px;">Main Campus</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div style="margin-top: 24px; padding-top: 24px; border-top: 2px solid #e5e7eb;">
                        <div style="background: #fef2f2; border-radius: 12px; padding: 16px; border-left: 4px solid #dc143c;">
                            <p style="margin: 0; font-size: 13px; color: #475569; line-height: 1.6;">
                                <strong style="color: #1a202c;">Need Help?</strong><br>
                                Contact a super admin for assistance with:
                            </p>
                            <ul style="margin: 12px 0 0; padding-left: 20px; font-size: 12px; color: #64748b; line-height: 1.8;">
                                <li>Technical issues</li>
                                <li>Account problems</li>
                                <li>Report submission errors</li>
                                <li>Access requests</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        container.innerHTML = helpHTML;
    }

    // ========== IMPORT DATA FUNCTIONALITY ==========
    
    // Manual trigger function for testing
    async forceLoadImportTables() {
        console.log('=== MANUAL TRIGGER: forceLoadImportTables ===');
        const select = document.getElementById('importTableSelect');
        if (!select) {
            this.showNotification('Select element not found!', 'error');
            return;
        }
        
        // Show loading notification
        this.showNotification('Refreshing available tables...', 'info');
        
        console.log('Select found, current options:', select.options.length);
        console.log('assignedReports:', this.assignedReports);
        
        // Clear and populate
        select.innerHTML = '<option value="">-- Select a table --</option>';
        
        let tablesAdded = 0;
        
        if (this.assignedReports && this.assignedReports.length > 0) {
            this.assignedReports.forEach((report) => {
                const tableName = report.table_name || report.tableName || report.table;
                if (tableName) {
                    const option = document.createElement('option');
                    option.value = tableName.toLowerCase();
                    option.textContent = this.formatReportName(tableName);
                    select.appendChild(option);
                    tablesAdded++;
                    console.log('Added:', tableName);
                }
            });
            
            if (tablesAdded > 0) {
                this.showNotification(`Successfully loaded ${tablesAdded} table(s) for import`, 'success');
            } else {
                this.showNotification('No table names found in assigned reports', 'warning');
            }
        } else {
            // Try loading from API
            this.showNotification('Loading assigned reports...', 'info');
            await this.loadAssignedReports();
            
            if (this.assignedReports && this.assignedReports.length > 0) {
                this.assignedReports.forEach((report) => {
                    const tableName = report.table_name || report.tableName || report.table;
                    if (tableName) {
                        const option = document.createElement('option');
                        option.value = tableName.toLowerCase();
                        option.textContent = this.formatReportName(tableName);
                        select.appendChild(option);
                        tablesAdded++;
                        console.log('Added after reload:', tableName);
                    }
                });
                
                if (tablesAdded > 0) {
                    this.showNotification(`Successfully loaded ${tablesAdded} table(s) for import`, 'success');
                } else {
                    this.showNotification('No table names found in assigned reports', 'warning');
                }
            } else {
                this.showNotification('No assigned reports found. Please contact your administrator.', 'warning');
            }
        }
    }
    
    async loadImportData() {
        try {
            console.log('=== loadImportData START ===');
            
            // First, ensure assigned reports are loaded
            if (!this.assignedReports || this.assignedReports.length === 0) {
                console.log('No assigned reports, loading them first...');
                await this.loadAssignedReports();
            }
            
            console.log('assignedReports available:', this.assignedReports?.length || 0);
            
            // DIRECT APPROACH: Populate dropdown immediately from assignedReports
            const select = document.getElementById('importTableSelect');
            if (!select) {
                console.error('SELECT ELEMENT NOT FOUND! Trying alternative selectors...');
                const altSelect = document.querySelector('#importTableSelect');
                console.log('Alternative selector result:', altSelect);
                return;
            }
            
            console.log('Found select element:', select);
            console.log('Select ID:', select.id);
            console.log('Current select innerHTML before clear:', select.innerHTML);
            
            // Clear it first
            select.innerHTML = '<option value="">-- Select a table --</option>';
            
            if (this.assignedReports && this.assignedReports.length > 0) {
                console.log('=== ASSIGNED REPORTS DATA ===');
                console.log('assignedReports:', JSON.stringify(this.assignedReports, null, 2));
                console.log('Number of reports:', this.assignedReports.length);
                
                this.assignedReports.forEach((report, index) => {
                    console.log(`\n--- Report ${index} ---`);
                    console.log('Full report object:', report);
                    console.log('report.table_name:', report.table_name);
                    console.log('report keys:', Object.keys(report || {}));
                    
                    // Try multiple possible field names
                    const tableName = report.table_name || report.tableName || report.table || report.name || report.id;
                    console.log('Extracted tableName:', tableName);
                    
                    if (tableName) {
                        const tableNameLower = String(tableName).toLowerCase();
                        const option = document.createElement('option');
                        option.value = tableNameLower;
                        option.textContent = this.formatReportName(String(tableName));
                        select.appendChild(option);
                        console.log(`✓✓✓ ADDED TO DROPDOWN: ${tableNameLower} -> ${this.formatReportName(String(tableName))}`);
                    } else {
                        console.warn(`Report ${index} has no table_name field!`);
                    }
                });
                
                console.log('\n=== DROPDOWN STATUS ===');
                console.log('Select options count:', select.options.length);
                console.log('Select innerHTML:', select.innerHTML);
                console.log('Select value:', select.value);
                
                // Force a visual update
                select.style.display = 'block';
                select.offsetHeight; // Force reflow
                
                // Also try setting a value to trigger change
                if (select.options.length > 1) {
                    console.log('Dropdown has options! First option value:', select.options[0].value);
                }
            } else {
                console.warn('No assignedReports or empty array!');
                console.log('this.assignedReports:', this.assignedReports);
            }
            
            // Also try the API method as backup
            await this.loadAvailableTablesForImport();
            
            // Setup form submission handler
            const form = document.getElementById('importDataForm');
            if (form && !form.hasAttribute('data-listener-attached')) {
                form.addEventListener('submit', (e) => {
                    e.preventDefault();
                    this.handleImportSubmit(e);
                });
                form.setAttribute('data-listener-attached', 'true');
            }
            
            console.log('=== loadImportData END ===');
        } catch (error) {
            console.error('Error loading import data section:', error);
        }
    }
    
    async loadAvailableTablesForImport() {
        try {
            console.log('=== loadAvailableTablesForImport START ===');
            const select = document.getElementById('importTableSelect');
            console.log('Select element:', select);
            const fileInput = document.getElementById('importFileInput');
            const importForm = document.getElementById('importDataForm');
            const submitButton = importForm?.querySelector('button[type="submit"]');
            
            if (!select) {
                console.error('importTableSelect element not found');
                return;
            }
            
            console.log('Found importTableSelect element');
            
            // Check if already populated
            const existingOptions = Array.from(select.options).map(opt => ({ value: opt.value, text: opt.textContent })).filter(opt => opt.value);
            console.log('Existing options in select:', existingOptions);
            
            const tables = [];
            
            // If already has options (more than just placeholder), use them
            if (existingOptions.length > 1) {
                console.log('Select already populated, preserving existing options');
                existingOptions.forEach(opt => {
                    if (opt.value && opt.value !== '') {
                        tables.push(opt.value);
                    }
                });
                console.log('Preserved existing options:', tables);
            } else {
                // Only clear and show loading if empty
                select.innerHTML = '<option value="">-- Select a table --</option>';
                
                // Show loading state
                const loadingOption = document.createElement('option');
                loadingOption.value = '';
                loadingOption.textContent = 'Loading assigned tables...';
                loadingOption.disabled = true;
                select.appendChild(loadingOption);
            }
            
            // Method 1: Try the dedicated API endpoint
            try {
                console.log('Fetching from get_import_tables.php...');
                const response = await fetch('api/get_import_tables.php', {
                    method: 'GET',
                    credentials: 'include',
                    headers: {
                        'Cache-Control': 'no-cache'
                    }
                });
                
                console.log('Response status:', response.status);
                
                if (response.ok) {
                    const result = await response.json();
                    console.log('API Response:', result);
                    
                    if (result.success && Array.isArray(result.tables) && result.tables.length > 0) {
                        console.log('Found', result.tables.length, 'tables from API:', result.tables);
                        result.tables.forEach(tableName => {
                            if (tableName && !tables.includes(tableName.toLowerCase())) {
                                tables.push(tableName.toLowerCase());
                            }
                        });
                    }
                }
            } catch (e) {
                console.warn('Error fetching from get_import_tables.php:', e);
            }
            
            // Method 2: Fallback - Use already loaded assignedReports (we know this works!)
            if (tables.length === 0 && this.assignedReports && Array.isArray(this.assignedReports) && this.assignedReports.length > 0) {
                console.log('Using fallback: assignedReports (', this.assignedReports.length, 'reports)');
                this.assignedReports.forEach((report, index) => {
                    console.log(`Report ${index}:`, report);
                    if (report && report.table_name) {
                        const tableName = report.table_name.toLowerCase();
                        if (!tables.includes(tableName)) {
                            tables.push(tableName);
                            console.log('✓ Added from assignedReports:', report.table_name);
                        }
                    }
                });
            }
            
            // Method 3: Fallback - Try user_tasks.php directly
            if (tables.length === 0) {
                try {
                    console.log('Trying fallback: user_tasks.php...');
                    const userTasksResponse = await fetch('api/user_tasks.php?action=get_assigned', {
                        credentials: 'include'
                    });
                    if (userTasksResponse.ok) {
                        const userTasksResult = await userTasksResponse.json();
                        console.log('user_tasks.php response:', userTasksResult);
                        if (userTasksResult.success && Array.isArray(userTasksResult.data) && userTasksResult.data.length > 0) {
                            userTasksResult.data.forEach(task => {
                                if (task && task.table_name) {
                                    const tableName = task.table_name.toLowerCase();
                                    if (!tables.includes(tableName)) {
                                        tables.push(tableName);
                                        console.log('✓ Added from user_tasks.php:', task.table_name);
                                    }
                                }
                            });
                        }
                    }
                } catch (e) {
                    console.warn('Error fetching from user_tasks.php:', e);
                }
            }
            
            console.log('Final tables array:', tables);
            
            // Populate dropdown
            if (tables.length > 0) {
                console.log('Populating dropdown with', tables.length, 'tables');
                tables.sort().forEach(tableName => {
                    const option = document.createElement('option');
                    option.value = tableName;
                    option.textContent = this.formatReportName(tableName);
                    select.appendChild(option);
                    console.log('✓ Added option:', tableName, '->', this.formatReportName(tableName));
                });
                
                console.log('Dropdown now has', select.options.length, 'options');
                console.log('Dropdown HTML:', select.innerHTML);
                
                // Enable form elements
                if (select) {
                    select.disabled = false;
                    console.log('Select element disabled:', select.disabled);
                }
                if (fileInput) fileInput.disabled = false;
                if (submitButton) {
                    submitButton.disabled = false;
                    submitButton.style.opacity = '1';
                    submitButton.style.cursor = 'pointer';
                }
            } else {
                console.warn('No tables found after all methods');
                
                // No assigned tables found - disable import functionality
                const option = document.createElement('option');
                option.value = '';
                option.textContent = 'No assigned tables - You cannot import data';
                option.disabled = true;
                select.appendChild(option);
                
                // Disable form elements
                if (select) select.disabled = true;
                if (fileInput) fileInput.disabled = true;
                if (submitButton) {
                    submitButton.disabled = true;
                    submitButton.style.opacity = '0.5';
                    submitButton.style.cursor = 'not-allowed';
                }
                
                // Show notification
                this.showNotification('You have no assigned tables. Please contact your administrator to assign tables for data import.', 'warning');
            }
        } catch (error) {
            console.error('Error loading available tables:', error);
            const select = document.getElementById('importTableSelect');
            const fileInput = document.getElementById('importFileInput');
            const importForm = document.getElementById('importDataForm');
            const submitButton = importForm?.querySelector('button[type="submit"]');
            
            if (select) {
                select.innerHTML = '<option value="">Error loading tables - Please refresh</option>';
                select.disabled = true;
            }
            if (fileInput) fileInput.disabled = true;
            if (submitButton) {
                submitButton.disabled = true;
                submitButton.style.opacity = '0.5';
                submitButton.style.cursor = 'not-allowed';
            }
        }
    }
    
    handleFileSelect(event) {
        const file = event.target.files[0];
        if (!file) return;
        
        // Validate file size (10MB max)
        const maxSize = 10 * 1024 * 1024; // 10MB
        if (file.size > maxSize) {
            this.showNotification('File size exceeds 10MB limit. Please choose a smaller file.', 'error');
            event.target.value = '';
            return;
        }
        
        // Validate file type
        const validTypes = ['text/csv', 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'];
        const validExtensions = ['.csv', '.xls', '.xlsx'];
        const fileExtension = '.' + file.name.split('.').pop().toLowerCase();
        
        if (!validTypes.includes(file.type) && !validExtensions.includes(fileExtension)) {
            this.showNotification('Invalid file type. Please select a CSV or Excel file.', 'error');
            event.target.value = '';
            return;
        }
        
        // Show file info
        const fileInfo = document.getElementById('fileInfo');
        const fileName = document.getElementById('fileName');
        const fileSize = document.getElementById('fileSize');
        
        if (fileInfo && fileName && fileSize) {
            fileName.textContent = file.name;
            fileSize.textContent = `(${(file.size / 1024).toFixed(2)} KB)`;
            fileInfo.style.display = 'block';
        }
    }
    
    clearFileSelection() {
        const fileInput = document.getElementById('importFileInput');
        const fileInfo = document.getElementById('fileInfo');
        
        if (fileInput) {
            fileInput.value = '';
        }
        if (fileInfo) {
            fileInfo.style.display = 'none';
        }
    }
    
    async handleImportSubmit(event) {
        event.preventDefault();
        
        const tableSelect = document.getElementById('importTableSelect');
        const fileInput = document.getElementById('importFileInput');
        const skipHeaderRow = document.getElementById('skipHeaderRow')?.checked ?? true;
        const validateData = document.getElementById('validateData')?.checked ?? true;
        
        if (!tableSelect || !fileInput) {
            this.showNotification('Import form elements not found', 'error');
            return;
        }
        
        // Check if form is disabled (no assigned tables)
        if (tableSelect.disabled || fileInput.disabled) {
            this.showNotification('You have no assigned tables. Please contact your administrator to assign tables for data import.', 'warning');
            return;
        }
        
        const tableName = tableSelect.value;
        const file = fileInput.files[0];
        
        if (!tableName || tableName === '') {
            this.showNotification('Please select a table to import to', 'error');
            return;
        }
        
        if (!file) {
            this.showNotification('Please select a file to import', 'error');
            return;
        }
        
        // Show confirmation with reminder BEFORE import
        const confirmed = await this.showImportConfirmation(tableName, file.name, file.size);
        if (!confirmed) {
            this.showNotification('Import cancelled by user', 'info');
            return;
        }
        
        // Show progress
        const progressDiv = document.getElementById('importProgress');
        const progressBar = document.getElementById('importProgressBar');
        const statusText = document.getElementById('importStatus');
        
        if (progressDiv) {
            progressDiv.style.display = 'block';
        }
        if (progressBar) {
            progressBar.style.width = '10%';
        }
        if (statusText) {
            statusText.textContent = 'Uploading file...';
        }
        
        try {
            // Prepare form data
            const formData = new FormData();
            formData.append('table_name', tableName);
            formData.append('file', file);
            formData.append('skip_header_row', skipHeaderRow ? '1' : '0');
            formData.append('validate_data', validateData ? '1' : '0');
            
            if (progressBar) progressBar.style.width = '30%';
            if (statusText) statusText.textContent = 'Processing file...';
            
            // Submit to API
            const response = await fetch('api/import_data.php', {
                method: 'POST',
                body: formData,
                credentials: 'include'
            });
            
            if (progressBar) progressBar.style.width = '60%';
            if (statusText) statusText.textContent = 'Importing data...';
            
            const result = await response.json();
            
            if (progressBar) progressBar.style.width = '100%';
            
            if (result.success) {
                if (statusText) {
                    statusText.textContent = `Import completed! ${result.imported_rows || 0} rows imported successfully.`;
                }
                this.showNotification(
                    `Data imported successfully! ${result.imported_rows || 0} rows imported. ${result.skipped_rows || 0} rows skipped.`,
                    'success'
                );
                
                // Reset form after delay
                setTimeout(() => {
                    if (progressDiv) progressDiv.style.display = 'none';
                    document.getElementById('importDataForm')?.reset();
                    this.clearFileSelection();
                    if (progressBar) progressBar.style.width = '0%';
                }, 3000);
            } else {
                throw new Error(result.error || result.message || 'Import failed');
            }
        } catch (error) {
            console.error('Import error:', error);
            if (progressDiv) progressDiv.style.display = 'none';
            if (statusText) {
                statusText.textContent = 'Import failed. Please try again.';
            }
            this.showNotification('Error importing data: ' + error.message, 'error');
        }
    }
    
    async showImportConfirmation(tableName, fileName, fileSize = 0) {
        return new Promise((resolve) => {
            const modal = document.createElement('div');
            modal.className = 'custom-modal-overlay';
            modal.style.cssText = 'position: fixed !important; inset: 0 !important; z-index: 9999999 !important; background: rgba(0, 0, 0, 0.6) !important; backdrop-filter: blur(4px) !important; display: flex !important; align-items: center !important; justify-content: center !important;';
            
            const fileSizeText = fileSize > 0 ? ` (${(fileSize / 1024).toFixed(2)} KB)` : '';
            
            modal.innerHTML = `
                <div class="custom-modal-content custom-modal-confirm" style="max-width: 550px; width: 90%; animation: slideIn 0.3s ease-out;">
                    <div class="custom-modal-icon" style="color: #f59e0b; background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%); width: 80px; height: 80px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);">
                        <i class="fas fa-exclamation-triangle" style="font-size: 36px;"></i>
                    </div>
                    <div class="custom-modal-header" style="text-align: center; margin-bottom: 20px;">
                        <h3 style="margin: 0; font-size: 24px; font-weight: 700; color: #1a202c;">Confirm Data Import</h3>
                        <p style="margin: 8px 0 0; color: #6b7280; font-size: 14px;">Please review the import details before proceeding</p>
                    </div>
                    <div class="custom-modal-body" style="background: #f9fafb; border-radius: 8px; padding: 20px; margin-bottom: 24px;">
                        <div style="display: flex; flex-direction: column; gap: 16px;">
                            <div style="display: flex; align-items: flex-start; gap: 12px; padding: 12px; background: white; border-radius: 6px; border-left: 4px solid #dc143c;">
                                <i class="fas fa-table" style="color: #dc143c; font-size: 18px; margin-top: 2px;"></i>
                                <div style="flex: 1;">
                                    <div style="font-size: 12px; color: #6b7280; margin-bottom: 4px;">Target Table</div>
                                    <div style="font-weight: 600; color: #1a202c; font-size: 16px;">${this.escapeHtml(this.formatReportName(tableName))}</div>
                                </div>
                            </div>
                            <div style="display: flex; align-items: flex-start; gap: 12px; padding: 12px; background: white; border-radius: 6px; border-left: 4px solid #3b82f6;">
                                <i class="fas fa-file" style="color: #3b82f6; font-size: 18px; margin-top: 2px;"></i>
                                <div style="flex: 1;">
                                    <div style="font-size: 12px; color: #6b7280; margin-bottom: 4px;">Source File</div>
                                    <div style="font-weight: 600; color: #1a202c; font-size: 16px; word-break: break-all;">${this.escapeHtml(fileName)}${fileSizeText}</div>
                                </div>
                            </div>
                        </div>
                        <div style="background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%); border: 2px solid #f59e0b; border-radius: 8px; padding: 16px; margin-top: 20px;">
                            <div style="display: flex; align-items: flex-start; gap: 12px;">
                                <i class="fas fa-info-circle" style="color: #f59e0b; font-size: 20px; margin-top: 2px;"></i>
                                <div>
                                    <div style="font-weight: 700; color: #92400e; margin-bottom: 8px; font-size: 14px;">Important Reminders</div>
                                    <ul style="margin: 0; padding-left: 20px; color: #78350f; font-size: 13px; line-height: 1.8;">
                                        <li>Ensure your file format matches the table structure</li>
                                        <li>Column names should match the table columns</li>
                                        <li>Invalid data will be skipped during import</li>
                                        <li>This action cannot be undone</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="custom-modal-footer" style="display: flex; gap: 12px; justify-content: flex-end;">
                        <button class="custom-modal-btn custom-modal-btn-secondary" data-action="cancel" style="
                            padding: 12px 24px;
                            background: white;
                            color: #6b7280;
                            border: 2px solid #e5e7eb;
                            border-radius: 8px;
                            font-weight: 600;
                            cursor: pointer;
                            transition: all 0.2s;
                        " onmouseover="this.style.background='#f9fafb'; this.style.borderColor='#d1d5db';" onmouseout="this.style.background='white'; this.style.borderColor='#e5e7eb';">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button class="custom-modal-btn custom-modal-btn-primary" data-action="confirm" style="
                            padding: 12px 24px;
                            background: linear-gradient(135deg, #dc143c 0%, #a00000 100%);
                            color: white;
                            border: none;
                            border-radius: 8px;
                            font-weight: 600;
                            cursor: pointer;
                            box-shadow: 0 4px 12px rgba(220, 20, 60, 0.3);
                            transition: all 0.2s;
                        " onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 16px rgba(220, 20, 60, 0.4)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 12px rgba(220, 20, 60, 0.3)';">
                            <i class="fas fa-check"></i> Confirm & Import
                        </button>
                    </div>
                </div>
            `;
            
            // Add animation
            const style = document.createElement('style');
            style.textContent = `
                @keyframes slideIn {
                    from {
                        opacity: 0;
                        transform: translateY(-20px) scale(0.95);
                    }
                    to {
                        opacity: 1;
                        transform: translateY(0) scale(1);
                    }
                }
            `;
            document.head.appendChild(style);
            
            document.body.appendChild(modal);
            
            modal.querySelectorAll('.custom-modal-btn').forEach(btn => {
                btn.addEventListener('click', (e) => {
                    const action = e.currentTarget.dataset.action;
                    modal.style.opacity = '0';
                    modal.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        modal.remove();
                        style.remove();
                    }, 200);
                    resolve(action === 'confirm');
                });
            });
            
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    modal.style.opacity = '0';
                    modal.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        modal.remove();
                        style.remove();
                    }, 200);
                    resolve(false);
                }
            });
        });
    }

    // ========== NEW FEATURES ==========

    /**
     * Load My Tasks section
     */
    async loadMyTasks(filter = 'all') {
        // Disabled legacy My Tasks (v2) to prevent design switch
        return;
    }

    /**
     * Render tasks in the grid
     */
    renderTasks(tasks, stats) {
        // Disabled legacy My Tasks (v2) UI
        return;
    }

    /**
     * Load Notifications
     */
    async loadNotifications() {
        const container = document.getElementById('notificationsContainer');
        if (!container) return;

        // Show loading state
        container.innerHTML = `
            <div class="loading-state">
                <i class="fas fa-spinner fa-spin"></i>
                <p>Loading notifications...</p>
            </div>
        `;

        try {
            // Use relative path - works in both local and production
            const apiUrl = 'api/user_notifications.php?action=get_notifications';
            
            console.log('Fetching notifications from:', apiUrl);
            
            // Try to fetch from API first
            const response = await fetch(apiUrl, {
                method: 'GET',
                credentials: 'include'
            });

            let notifications = [];

            if (response.ok) {
                const contentType = response.headers.get('content-type');
                if (contentType && contentType.includes('application/json')) {
                    try {
                        const result = await response.json();
                        console.log('Notifications API response:', result);
                        
                        if (result.success && result.data && Array.isArray(result.data)) {
                            notifications = result.data;
                            console.log(`Loaded ${notifications.length} real notifications`);
                        } else {
                            console.warn('API returned no data or invalid format:', result);
                            // Don't use demo data - show empty state instead
                            notifications = [];
                        }
                    } catch (jsonError) {
                        console.error('Error parsing JSON response:', jsonError);
                        const errorText = await response.text();
                        console.error('Response text:', errorText.substring(0, 200));
                        notifications = [];
                    }
                } else {
                    console.error('API returned non-JSON response. Content-Type:', contentType);
                    const errorText = await response.text();
                    console.error('Response text:', errorText.substring(0, 200));
                    notifications = [];
                }
            } else {
                console.error('API error:', response.status, response.statusText);
                try {
                    const errorText = await response.text();
                    console.error('Error response:', errorText.substring(0, 200));
                } catch (e) {
                    console.error('Could not read error response');
                }
                // Don't use demo data - show empty state instead
                notifications = [];
            }

            this.renderNotifications(notifications);
        } catch (error) {
            console.error('Error loading notifications:', error);
            // Show empty state on error instead of demo data
            this.renderNotifications([]);
        }
    }

    /**
     * Get demo notifications (fallback)
     */
    getDemoNotifications() {
        return [
            {
                id: 1,
                type: 'success',
                title: 'Report Approved',
                message: 'Your Graduates Data report has been approved by the admin.',
                time: '2 hours ago',
                read: false,
                created_at: new Date(Date.now() - 2 * 60 * 60 * 1000).toISOString()
            },
            {
                id: 2,
                type: 'warning',
                title: 'Deadline Approaching',
                message: 'Campus Population Report is due in 6 days.',
                time: '5 hours ago',
                read: false,
                created_at: new Date(Date.now() - 5 * 60 * 60 * 1000).toISOString()
            },
            {
                id: 3,
                type: 'info',
                title: 'New Task Assigned',
                message: 'Enrollment Data report has been assigned to you.',
                time: '1 day ago',
                read: true,
                created_at: new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString()
            },
            {
                id: 4,
                type: 'error',
                title: 'Submission Rejected',
                message: 'Employee Data report needs corrections. Please review the feedback.',
                time: '2 days ago',
                read: true,
                created_at: new Date(Date.now() - 48 * 60 * 60 * 1000).toISOString()
            },
            {
                id: 5,
                type: 'info',
                title: 'Report Submitted',
                message: 'Your Distance Traveled report has been successfully submitted and is pending review.',
                time: '3 days ago',
                read: true,
                created_at: new Date(Date.now() - 72 * 60 * 60 * 1000).toISOString()
            }
        ];
    }

    /**
     * Render notifications
     */
    renderNotifications(notifications) {
        const container = document.getElementById('notificationsContainer');
        if (!container) return;

        // Store notifications in instance for later use
        this.notifications = notifications;

        if (notifications.length === 0) {
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-bell-slash" style="font-size: 48px; color: #ccc; margin-bottom: 16px;"></i>
                    <h3>No Notifications</h3>
                    <p>You're all caught up! No new notifications at this time.</p>
                </div>
            `;
            
            // Update badge
            const notifBadge = document.getElementById('notifBadge');
            const notificationDot = document.getElementById('notificationDot');
            if (notifBadge) {
                notifBadge.textContent = '0';
            }
            if (notificationDot) {
                notificationDot.style.display = 'none';
            }
            return;
        }

        const notifHTML = `
            <div class="notifications-header-actions">
                <div class="notification-filters">
                    <button class="filter-btn active" data-filter="all" onclick="userDashboard.filterNotifications('all')">
                        All
                    </button>
                    <button class="filter-btn" data-filter="unread" onclick="userDashboard.filterNotifications('unread')">
                        Unread
                    </button>
                    <button class="filter-btn" data-filter="read" onclick="userDashboard.filterNotifications('read')">
                        Read
                    </button>
                </div>
                <button class="btn-icon" onclick="userDashboard.refreshNotifications()" title="Refresh">
                    <i class="fas fa-sync-alt"></i>
                </button>
            </div>
            <div class="notifications-list" id="notificationsList">
                ${notifications.map(notif => `
                    <div class="notification-item ${notif.read ? 'read' : 'unread'} ${notif.type}" 
                         data-notification-id="${notif.id}" 
                         onclick="userDashboard.markNotificationRead(${notif.id})">
                        <div class="notification-icon ${notif.type}">
                            <i class="fas fa-${notif.type === 'success' ? 'check-circle' : notif.type === 'warning' ? 'exclamation-triangle' : notif.type === 'error' ? 'times-circle' : 'info-circle'}"></i>
                        </div>
                        <div class="notification-content">
                            <h4>${notif.title}</h4>
                            <p>${notif.message}</p>
                            <span class="notification-time">${notif.time}</span>
                        </div>
                        ${!notif.read ? '<div class="unread-indicator"></div>' : ''}
                        <button class="notification-close" onclick="event.stopPropagation(); userDashboard.dismissNotification(${notif.id})" title="Dismiss">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                `).join('')}
            </div>
        `;

        container.innerHTML = notifHTML;

        // Update badge
        const unreadCount = notifications.filter(n => !n.read).length;
        const notifBadge = document.getElementById('notifBadge');
        const notificationDot = document.getElementById('notificationDot');
        
        if (notifBadge) {
            notifBadge.textContent = unreadCount;
        }
        if (notificationDot) {
            notificationDot.style.display = unreadCount > 0 ? 'block' : 'none';
        }
    }

    /**
     * Filter notifications
     */
    filterNotifications(filter) {
        if (!this.notifications) return;

        // Update filter buttons
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.classList.remove('active');
            if (btn.dataset.filter === filter) {
                btn.classList.add('active');
            }
        });

        // Filter notifications
        let filteredNotifications = this.notifications;
        if (filter === 'unread') {
            filteredNotifications = this.notifications.filter(n => !n.read);
        } else if (filter === 'read') {
            filteredNotifications = this.notifications.filter(n => n.read);
        }

        // Re-render filtered list
        const list = document.getElementById('notificationsList');
        if (list) {
            if (filteredNotifications.length === 0) {
                list.innerHTML = `
                    <div class="empty-state" style="padding: 40px; text-align: center;">
                        <i class="fas fa-inbox" style="font-size: 48px; color: #ccc; margin-bottom: 16px;"></i>
                        <p>No ${filter === 'all' ? '' : filter} notifications found.</p>
                    </div>
                `;
            } else {
                list.innerHTML = filteredNotifications.map(notif => `
                    <div class="notification-item ${notif.read ? 'read' : 'unread'} ${notif.type}" 
                         data-notification-id="${notif.id}" 
                         onclick="userDashboard.markNotificationRead(${notif.id})">
                        <div class="notification-icon ${notif.type}">
                            <i class="fas fa-${notif.type === 'success' ? 'check-circle' : notif.type === 'warning' ? 'exclamation-triangle' : notif.type === 'error' ? 'times-circle' : 'info-circle'}"></i>
                        </div>
                        <div class="notification-content">
                            <h4>${notif.title}</h4>
                            <p>${notif.message}</p>
                            <span class="notification-time">${notif.time}</span>
                        </div>
                        ${!notif.read ? '<div class="unread-indicator"></div>' : ''}
                        <button class="notification-close" onclick="event.stopPropagation(); userDashboard.dismissNotification(${notif.id})" title="Dismiss">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                `).join('');
            }
        }
    }

    /**
     * Refresh notifications
     */
    async refreshNotifications() {
        this.showNotification('Refreshing notifications...', 'info');
        await this.loadNotifications();
        this.showNotification('Notifications updated', 'success');
    }

    /**
     * Update notification badge count without loading full list
     */
    async updateNotificationBadge() {
        try {
            // Use relative path - works in both local and production
            const apiUrl = 'api/user_notifications.php?action=get_notifications';
            
            const response = await fetch(apiUrl, {
                method: 'GET',
                credentials: 'include'
            });

            if (response.ok) {
                const contentType = response.headers.get('content-type');
                if (contentType && contentType.includes('application/json')) {
                    try {
                        const result = await response.json();
                        if (result.success && result.data) {
                            const unreadCount = result.data.filter(n => !n.read).length;
                            const notifBadge = document.getElementById('notifBadge');
                            const notificationDot = document.getElementById('notificationDot');
                            
                            if (notifBadge) {
                                notifBadge.textContent = unreadCount;
                            }
                            if (notificationDot) {
                                notificationDot.style.display = unreadCount > 0 ? 'block' : 'none';
                            }
                        }
                    } catch (jsonError) {
                        console.error('Error parsing JSON in updateNotificationBadge:', jsonError);
                        // Silently fail - badge will remain unchanged
                    }
                } else {
                    console.warn('updateNotificationBadge: Non-JSON response received');
                }
            }
        } catch (error) {
            console.error('Error updating notification badge:', error);
            // On error, just hide the badge indicators
            const notifBadge = document.getElementById('notifBadge');
            const notificationDot = document.getElementById('notificationDot');
            if (notifBadge) notifBadge.textContent = '0';
            if (notificationDot) notificationDot.style.display = 'none';
        }
    }

    /**
     * Mark notification as read
     */
    async markNotificationRead(id) {
        const notificationItem = document.querySelector(`[data-notification-id="${id}"]`);
        if (!notificationItem) return;

        // Check if already read
        if (notificationItem.classList.contains('read')) {
            return; // Already read, don't do anything
        }

        // Mark as read visually
        notificationItem.classList.remove('unread');
        notificationItem.classList.add('read');
        const unreadIndicator = notificationItem.querySelector('.unread-indicator');
        if (unreadIndicator) {
            unreadIndicator.remove();
        }

        // Update notification in array
        if (this.notifications) {
            const notif = this.notifications.find(n => n.id === id);
            if (notif) {
                notif.read = true;
            }
        }

        // Update badge
        const unreadCount = this.notifications ? this.notifications.filter(n => !n.read).length : 0;
        const notifBadge = document.getElementById('notifBadge');
        const notificationDot = document.getElementById('notificationDot');
        
        if (notifBadge) {
            notifBadge.textContent = unreadCount;
        }
        if (notificationDot) {
            notificationDot.style.display = unreadCount > 0 ? 'block' : 'none';
        }

        // Try to update on server
        try {
            await fetch(`api/user_notifications.php?action=mark_read&id=${id}`, {
                method: 'POST',
                credentials: 'include'
            });
        } catch (error) {
            console.error('Error marking notification as read:', error);
        }
    }

    /**
     * Load Calendar with real data
     */
    async loadCalendar() {
        const container = document.getElementById('calendarContainer');
        if (!container) return;

        // Show loading state
        container.innerHTML = `
            <div class="loading-state">
                <i class="fas fa-spinner fa-spin"></i>
                <p>Loading calendar...</p>
            </div>
        `;

        try {
            // Load calendar events (deadlines, tasks)
            await this.loadCalendarEvents();
            this.renderCalendar();
        } catch (error) {
            console.error('Error loading calendar:', error);
            container.innerHTML = `
                <div class="error-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <p>Error loading calendar. Please refresh.</p>
                </div>
            `;
        }
    }

    /**
     * Load calendar events from API
     */
    async loadCalendarEvents() {
        try {
            const response = await fetch('api/user_calendar.php?action=get_events', {
                method: 'GET',
                credentials: 'include'
            });

            if (response.ok) {
                const result = await response.json();
                console.log('Calendar API response:', result);
                if (result.success && result.data && Array.isArray(result.data) && result.data.length > 0) {
                    this.calendarEvents = result.data;
                    console.log('Loaded calendar events:', this.calendarEvents.length);
                } else {
                    console.log('Calendar API returned empty data, trying tasks API fallback');
                    // Fallback: load from tasks API
                    await this.loadEventsFromTasks();
                }
            } else {
                console.log('Calendar API error, trying tasks API fallback');
                // Fallback: load from tasks API
                await this.loadEventsFromTasks();
            }
        } catch (error) {
            console.error('Error loading calendar events:', error);
            // Fallback: load from tasks API
            await this.loadEventsFromTasks();
        }
    }

    /**
     * Load events from tasks API as fallback
     */
    async loadEventsFromTasks() {
        try {
            const response = await fetch('api/user_tasks_list_v2.php', {
                method: 'GET',
                credentials: 'include'
            });

            if (response.ok) {
                const result = await response.json();
                console.log('Tasks API response:', result);
                if (result.success && result.tasks && Array.isArray(result.tasks)) {
                    // Convert tasks to calendar events
                    this.calendarEvents = result.tasks
                        .filter(task => task.deadline && task.status !== 'completed')
                        .map(task => {
                            const eventType = this.getEventType(task);
                            return {
                                id: task.id,
                                title: task.title || this.formatReportName(task.table_name),
                                date: task.deadline,
                                type: eventType,
                                priority: task.priority || 'medium',
                                table_name: task.table_name
                            };
                        });
                    console.log('Converted tasks to calendar events:', this.calendarEvents.length);
                } else {
                    this.calendarEvents = [];
                }
            } else {
                console.error('Tasks API error:', response.status);
                this.calendarEvents = [];
            }
        } catch (error) {
            console.error('Error loading events from tasks:', error);
            this.calendarEvents = [];
        }
    }

    /**
     * Get event type based on task status
     */
    getEventType(task) {
        if (!task.deadline) return 'upcoming';
        
        const deadline = new Date(task.deadline);
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        deadline.setHours(0, 0, 0, 0);
        
        const diffTime = deadline - today;
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        
        if (task.status === 'completed' || task.submission_id) {
            return 'completed';
        } else if (diffDays < 0) {
            return 'overdue';
        } else if (diffDays <= 7) {
            return 'due-soon';
        } else {
            return 'upcoming';
        }
    }

    /**
     * Render calendar with events
     */
    renderCalendar() {
        const container = document.getElementById('calendarContainer');
        if (!container) return;

        const currentMonth = new Date(this.currentCalendarYear, this.currentCalendarMonth, 1);
        const monthName = currentMonth.toLocaleString('default', { month: 'long', year: 'numeric' });
        const today = new Date();

        container.innerHTML = `
            <div class="calendar-wrapper">
                <div class="calendar-header">
                    <button class="btn-icon" onclick="userDashboard.previousMonth()" title="Previous month">
                        <i class="fas fa-chevron-left"></i>
                    </button>
                    <h3>${monthName}</h3>
                    <button class="btn-icon" onclick="userDashboard.nextMonth()" title="Next month">
                        <i class="fas fa-chevron-right"></i>
                    </button>
                    <button class="btn-icon" onclick="userDashboard.todayMonth()" title="Today">
                        <i class="fas fa-calendar-day"></i>
                    </button>
                </div>
                
                <div class="calendar-grid">
                    <div class="calendar-day-header">Sun</div>
                    <div class="calendar-day-header">Mon</div>
                    <div class="calendar-day-header">Tue</div>
                    <div class="calendar-day-header">Wed</div>
                    <div class="calendar-day-header">Thu</div>
                    <div class="calendar-day-header">Fri</div>
                    <div class="calendar-day-header">Sat</div>
                    
                    ${this.generateCalendarDays()}
                </div>

                <div class="calendar-legend">
                    <div class="legend-item">
                        <span class="legend-color overdue"></span>
                        <span>Overdue</span>
                    </div>
                    <div class="legend-item">
                        <span class="legend-color due-soon"></span>
                        <span>Due Soon</span>
                    </div>
                    <div class="legend-item">
                        <span class="legend-color completed"></span>
                        <span>Completed</span>
                    </div>
                    <div class="legend-item">
                        <span class="legend-color upcoming"></span>
                        <span>Upcoming</span>
                    </div>
                </div>

                ${this.renderUpcomingDeadlines()}
            </div>
        `;
    }

    /**
     * Generate calendar days with events
     */
    generateCalendarDays() {
        const firstDay = new Date(this.currentCalendarYear, this.currentCalendarMonth, 1);
        const lastDay = new Date(this.currentCalendarYear, this.currentCalendarMonth + 1, 0);
        const daysInMonth = lastDay.getDate();
        const startingDayOfWeek = firstDay.getDay();
        const today = new Date();

        let daysHTML = '';

        // Empty cells before month starts
        for (let i = 0; i < startingDayOfWeek; i++) {
            daysHTML += '<div class="calendar-day empty"></div>';
        }

        // Days of the month
        for (let day = 1; day <= daysInMonth; day++) {
            const currentDate = new Date(this.currentCalendarYear, this.currentCalendarMonth, day);
            const isToday = currentDate.toDateString() === today.toDateString();
            
            // Find events for this day
            const dayEvents = this.getEventsForDay(currentDate);
            const hasEvent = dayEvents.length > 0;
            const eventTypes = dayEvents.map(e => e.type);
            const hasOverdue = eventTypes.includes('overdue');
            const hasDueSoon = eventTypes.includes('due-soon');
            
            let eventClass = '';
            if (hasOverdue) {
                eventClass = 'has-event overdue-event';
            } else if (hasDueSoon) {
                eventClass = 'has-event due-soon-event';
            } else if (hasEvent) {
                eventClass = 'has-event upcoming-event';
            }
            
            daysHTML += `
                <div class="calendar-day ${isToday ? 'today' : ''} ${eventClass}" 
                     onclick="userDashboard.showDayDetails(${day}, ${this.currentCalendarMonth}, ${this.currentCalendarYear})"
                     title="${hasEvent ? `${dayEvents.length} event(s)` : ''}">
                    <span class="day-number">${day}</span>
                    ${hasEvent ? `<div class="event-indicator" data-count="${dayEvents.length}"></div>` : ''}
                </div>
            `;
        }

        return daysHTML;
    }

    /**
     * Get events for a specific day
     */
    getEventsForDay(date) {
        if (!this.calendarEvents || this.calendarEvents.length === 0) return [];
        
        const targetDate = new Date(date);
        targetDate.setHours(0, 0, 0, 0);
        const dateStr = targetDate.toISOString().split('T')[0];
        
        return this.calendarEvents.filter(event => {
            if (!event.date) return false;
            try {
                const eventDate = new Date(event.date);
                eventDate.setHours(0, 0, 0, 0);
                const eventDateStr = eventDate.toISOString().split('T')[0];
                return eventDateStr === dateStr;
            } catch (e) {
                console.error('Error parsing event date:', event.date, e);
                return false;
            }
        });
    }

    /**
     * Render upcoming deadlines list
     */
    renderUpcomingDeadlines() {
        console.log('Rendering upcoming deadlines. Total events:', this.calendarEvents?.length || 0);
        
        if (!this.calendarEvents || this.calendarEvents.length === 0) {
            return `
                <div class="upcoming-deadlines">
                    <h4><i class="fas fa-clock"></i> Upcoming Deadlines</h4>
                    <div class="deadline-list">
                        <div class="empty-state" style="padding: 20px; text-align: center; color: #999;">
                            <i class="fas fa-calendar-check"></i>
                            <p>No upcoming deadlines</p>
                        </div>
                    </div>
                </div>
            `;
        }

        // Filter and sort events by date - exclude completed events
        const sortedEvents = [...this.calendarEvents]
            .filter(event => {
                // Must have a date and not be completed
                if (!event.date) {
                    console.log('Event missing date:', event);
                    return false;
                }
                if (event.type === 'completed') {
                    return false;
                }
                // Also check if status is completed (for tasks API)
                if (event.status === 'completed') {
                    return false;
                }
                return true;
            })
            .sort((a, b) => {
                const dateA = new Date(a.date);
                const dateB = new Date(b.date);
                return dateA - dateB;
            })
            .slice(0, 10);
        
        console.log('Filtered upcoming events:', sortedEvents.length);

        if (sortedEvents.length === 0) {
            return `
                <div class="upcoming-deadlines">
                    <h4><i class="fas fa-clock"></i> Upcoming Deadlines</h4>
                    <div class="deadline-list">
                        <div class="empty-state" style="padding: 20px; text-align: center; color: #999;">
                            <i class="fas fa-calendar-check"></i>
                            <p>No upcoming deadlines</p>
                        </div>
                    </div>
                </div>
            `;
        }

        const deadlineItems = sortedEvents.map(event => {
            const deadlineDate = new Date(event.date);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            deadlineDate.setHours(0, 0, 0, 0);
            
            const diffTime = deadlineDate - today;
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            
            let badgeClass = 'upcoming';
            let badgeText = '';
            
            if (diffDays < 0) {
                badgeClass = 'overdue';
                badgeText = `${Math.abs(diffDays)} day${Math.abs(diffDays) !== 1 ? 's' : ''} overdue`;
            } else if (diffDays === 0) {
                badgeClass = 'due-soon';
                badgeText = 'Today';
            } else if (diffDays <= 7) {
                badgeClass = 'due-soon';
                badgeText = `${diffDays} day${diffDays !== 1 ? 's' : ''}`;
            } else {
                badgeClass = 'upcoming';
                badgeText = `${diffDays} days`;
            }
            
            const dateStr = deadlineDate.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
            
            return `
                <div class="deadline-item" onclick="userDashboard.viewTask('${event.table_name}')">
                    <span class="deadline-date">${dateStr}</span>
                    <span class="deadline-title">${event.title}</span>
                    <span class="deadline-badge ${badgeClass}">${badgeText}</span>
                </div>
            `;
        }).join('');

        return `
            <div class="upcoming-deadlines">
                <h4><i class="fas fa-clock"></i> Upcoming Deadlines</h4>
                <div class="deadline-list">
                    ${deadlineItems}
                </div>
            </div>
        `;
    }

    /**
     * Export data functionality
     */
    exportData() {
        const options = `
            <div class="export-modal">
                <h3><i class="fas fa-download"></i> Export Data</h3>
                <p>Choose export format:</p>
                <div class="export-options">
                    <button class="export-btn" onclick="userDashboard.downloadCSV()">
                        <i class="fas fa-file-csv"></i>
                        <span>CSV</span>
                    </button>
                    <button class="export-btn" onclick="userDashboard.downloadExcel()">
                        <i class="fas fa-file-excel"></i>
                        <span>Excel</span>
                    </button>
                    <button class="export-btn" onclick="userDashboard.downloadPDF()">
                        <i class="fas fa-file-pdf"></i>
                        <span>PDF</span>
                    </button>
                </div>
            </div>
        `;
        
        this.showModal('Export Data', options);
    }

    downloadCSV() {
        const csvContent = this.generateCSV();
        const blob = new Blob([csvContent], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `submissions_${new Date().toISOString().split('T')[0]}.csv`;
        a.click();
        this.showNotification('CSV file downloaded successfully!', 'success');
    }

    generateCSV() {
        const headers = ['ID', 'Report Name', 'Status', 'Submitted Date'];
        const rows = this.submissions.map(sub => [
            sub.id,
            sub.table_name,
            sub.status,
            sub.submitted_at
        ]);
        
        return [headers, ...rows].map(row => row.join(',')).join('\n');
    }

    /**
     * Refresh dashboard
     */
    async refreshDashboard() {
        const refreshBtn = event.target.closest('button');
        const icon = refreshBtn.querySelector('i');
        
        icon.classList.add('fa-spin');
        refreshBtn.disabled = true;

        try {
            await this.loadDashboardData();
            await this.loadSubmissions();
            this.showNotification('Dashboard refreshed successfully!', 'success');
        } catch (error) {
            this.showNotification('Failed to refresh dashboard', 'error');
        } finally {
            icon.classList.remove('fa-spin');
            refreshBtn.disabled = false;
        }
    }

    /**
     * Toggle notifications panel
     */

    /**
     * Filter tasks
     */
    filterTasks(filter) {
        console.log('Filtering tasks by:', filter);
        this.loadMyTasks(filter);
        this.showNotification(`Showing ${filter} tasks`, 'info');
    }

    /**
     * Mark all notifications as read
     */
    async markAllAsRead() {
        if (!this.notifications || this.notifications.length === 0) {
            this.showNotification('No notifications to mark as read', 'info');
            return;
        }

        // Mark all as read visually
        document.querySelectorAll('.notification-item.unread').forEach(item => {
            item.classList.remove('unread');
            item.classList.add('read');
            const unreadIndicator = item.querySelector('.unread-indicator');
            if (unreadIndicator) {
                unreadIndicator.remove();
            }
        });

        // Update notifications array
        this.notifications.forEach(notif => {
            notif.read = true;
        });

        // Update badge
        document.getElementById('notifBadge').textContent = '0';
        const notificationDot = document.getElementById('notificationDot');
        if (notificationDot) {
            notificationDot.style.display = 'none';
        }

        // Try to update on server
        try {
            await fetch('api/user_notifications.php?action=mark_all_read', {
                method: 'POST',
                credentials: 'include'
            });
        } catch (error) {
            console.error('Error marking all notifications as read:', error);
        }

        this.showNotification('All notifications marked as read', 'success');
    }

    /**
     * Dismiss notification
     */
    async dismissNotification(id) {
        const notif = event.target.closest('.notification-item');
        if (!notif) return;

        // Animate removal
        notif.style.animation = 'slideOut 0.3s ease';
        setTimeout(async () => {
            notif.remove();

            // Remove from array
            if (this.notifications) {
                this.notifications = this.notifications.filter(n => n.id !== id);
            }

            // Update badge
            const unreadCount = this.notifications ? this.notifications.filter(n => !n.read).length : 0;
            const notifBadge = document.getElementById('notifBadge');
            const notificationDot = document.getElementById('notificationDot');
            
            if (notifBadge) {
                notifBadge.textContent = unreadCount;
            }
            if (notificationDot) {
                notificationDot.style.display = unreadCount > 0 ? 'block' : 'none';
            }

            // Show empty state if no notifications left
            const list = document.getElementById('notificationsList');
            if (list && list.children.length === 0) {
                const container = document.getElementById('notificationsContainer');
                if (container) {
                    container.innerHTML = `
                        <div class="empty-state">
                            <i class="fas fa-bell-slash" style="font-size: 48px; color: #ccc; margin-bottom: 16px;"></i>
                            <h3>No Notifications</h3>
                            <p>You're all caught up! No new notifications at this time.</p>
                        </div>
                    `;
                }
            }

            // Try to delete on server
            try {
                await fetch(`api/user_notifications.php?action=delete&id=${id}`, {
                    method: 'POST',
                    credentials: 'include'
                });
            } catch (error) {
                console.error('Error deleting notification:', error);
            }
        }, 300);
    }

    /**
     * Start task - Opens report modal
     */
    startTask(tableName, taskId) {
        console.log('Starting task:', tableName, taskId);
        this.showNotification('Opening report form...', 'info');
        
        // Ensure consistent table name (convert to lowercase)
        const normalizedTableName = tableName.toLowerCase();
        console.log('Normalized table name:', normalizedTableName);
        
        // Open the modal with the report form
        this.openReportModal(normalizedTableName, taskId);
    }

    /**
     * Open report submission modal
     */
    openReportModal(tableName, taskId) {
        console.log('Opening report modal for table:', tableName);
        const modal = document.getElementById('reportModal');
        const modalBody = document.getElementById('reportModalBody');
        
        if (!modal || !modalBody) {
            console.error('Required modal elements not found');
            return;
        }
        
        // Modal now shows "Spartan Data" with logo instead of "Submit Report: [Table Name]"
        // No need to update title anymore
        
        // Show loading state
        modalBody.innerHTML = `
            <div style="display: flex; justify-content: center; align-items: center; height: 300px;">
                <div style="text-align: center;">
                    <i class="fas fa-spinner fa-spin" style="font-size: 24px; margin-bottom: 10px;"></i>
                    <p>Loading report form...</p>
                </div>
            </div>
        `;
        
        // Show modal
        modal.style.display = 'flex';
        document.body.style.overflow = 'hidden';
        
        // Load report form via iframe after a short delay to allow modal to render
        setTimeout(() => {
            const urlParams = new URLSearchParams(window.location.search);
            const campus = urlParams.get('campus');
            const office = urlParams.get('office');
            
            let iframeUrl = `report.html?table=${encodeURIComponent(tableName)}`;
            if (campus) iframeUrl += `&campus=${encodeURIComponent(campus)}`;
            if (office) iframeUrl += `&office=${encodeURIComponent(office)}`;
            if (taskId) iframeUrl += `&task_id=${encodeURIComponent(taskId)}`;
            
            console.log('Loading iframe with URL:', iframeUrl);
            
            const iframe = document.createElement('iframe');
            iframe.src = iframeUrl;
            iframe.style.width = '100%';
            iframe.style.height = '100%';
            iframe.style.minHeight = '600px';
            iframe.style.border = 'none';
            iframe.style.borderRadius = '8px';
            iframe.onload = function() {
                console.log('Iframe loaded successfully');
            };
            iframe.onerror = function() {
                console.error('Error loading iframe');
                modalBody.innerHTML = `
                    <div style="text-align: center; padding: 20px;">
                        <i class="fas fa-exclamation-triangle" style="color: #e53e3e; font-size: 48px; margin-bottom: 20px;"></i>
                        <h3>Error Loading Report</h3>
                        <p>Could not load the report form. Please try again.</p>
                        <button onclick="userDashboard.openReportModal('${tableName}', ${taskId || 'null'})" class="btn-primary" style="margin-top: 20px;">
                            <i class="fas fa-sync-alt"></i> Retry
                        </button>
                    </div>
                `;
            };
            
            // Clear previous content and append new iframe
            modalBody.innerHTML = '';
            modalBody.appendChild(iframe);
        }, 100);
    }

    /**
     * Close report modal
     */
    closeReportModal() {
        const modal = document.getElementById('reportModal');
        modal.style.display = 'none';
        document.body.style.overflow = ''; // Restore scrolling
        this.loadAssignedReports();
        if (this.loadSubmissions) this.loadSubmissions();
    }

    setupMessageListener() {
        window.addEventListener('message', (event) => {
            const data = event.data;
            if (data && data.type === 'reportSubmitted' && data.success) {
                this.showNotification('Report submitted successfully!', 'success');
                this.closeReportModal();
                this.loadAssignedReports();
                if (this.loadSubmissions) this.loadSubmissions();
                
                // Refresh analytics after successful submission with retry logic
                const refreshAnalytics = async (attempt = 1) => {
                    try {
                        // Force reload submissions to get latest data (with cache busting)
                        if (this.loadSubmissions) {
                            await this.loadSubmissions(true);
                        }
                        // Then refresh analytics (force refresh even if dashboard not visible)
                        await this.refreshUserAnalyticsIfVisible(true);
                        
                        // If still no data and we haven't tried too many times, retry
                        if (attempt < 3 && (!this.allSubmissions || this.allSubmissions.length === 0)) {
                            setTimeout(() => refreshAnalytics(attempt + 1), 2000);
                        }
                    } catch (err) {
                        console.error(`Error refreshing after submission (attempt ${attempt}):`, err);
                        // Retry on error
                        if (attempt < 3) {
                            setTimeout(() => refreshAnalytics(attempt + 1), 2000);
                        }
                    }
                };
                
                // Start refresh after initial delay
                setTimeout(() => refreshAnalytics(1), 1500);
            } else if (data && data.type === 'reportSubmitted' && data.success === false) {
                const msg = data.message || 'Report submission failed';
                this.showNotification(msg, 'error');
            }
        });
    }

    showNotification(message, type = 'info') {
        try {
            let container = document.getElementById('ud-toast-container');
            if (!container) {
                container = document.createElement('div');
                container.id = 'ud-toast-container';
                container.style.position = 'fixed';
                container.style.top = '16px';
                container.style.right = '16px';
                container.style.zIndex = '99999';
                container.style.display = 'flex';
                container.style.flexDirection = 'column';
                container.style.gap = '10px';
                document.body.appendChild(container);
            }

            const colors = {
                success: { bg: '#10b981', fg: '#ffffff', icon: 'fa-check-circle' },
                error: { bg: '#ef4444', fg: '#ffffff', icon: 'fa-times-circle' },
                info: { bg: '#3b82f6', fg: '#ffffff', icon: 'fa-info-circle' },
                warning: { bg: '#f59e0b', fg: '#111827', icon: 'fa-exclamation-triangle' }
            };
            const c = colors[type] || colors.info;

            const toast = document.createElement('div');
            toast.style.minWidth = '260px';
            toast.style.maxWidth = '420px';
            toast.style.padding = '12px 14px';
            toast.style.borderRadius = '10px';
            toast.style.boxShadow = '0 6px 20px rgba(0,0,0,0.15)';
            toast.style.background = c.bg;
            toast.style.color = c.fg;
            toast.style.display = 'flex';
            toast.style.alignItems = 'center';
            toast.style.gap = '10px';
            toast.style.opacity = '0';
            toast.style.transform = 'translateY(-8px)';
            toast.style.transition = 'opacity .2s ease, transform .2s ease';

            toast.innerHTML = `<i class="fas ${c.icon}" style="opacity:.9"></i><div style="flex:1; font-weight:600;">${this.escapeHtml(message)}</div>`;

            const closeBtn = document.createElement('button');
            closeBtn.innerHTML = '<i class="fas fa-times"></i>';
            closeBtn.style.background = 'transparent';
            closeBtn.style.border = 'none';
            closeBtn.style.color = c.fg;
            closeBtn.style.cursor = 'pointer';
            closeBtn.onclick = () => {
                toast.style.opacity = '0';
                toast.style.transform = 'translateY(-8px)';
                setTimeout(() => toast.remove(), 200);
            };
            toast.appendChild(closeBtn);

            container.appendChild(toast);
            requestAnimationFrame(() => {
                toast.style.opacity = '1';
                toast.style.transform = 'translateY(0)';
            });

            setTimeout(() => {
                if (!toast.isConnected) return;
                toast.style.opacity = '0';
                toast.style.transform = 'translateY(-8px)';
                setTimeout(() => toast.remove(), 220);
            }, type === 'error' ? 5000 : 3000);
        } catch (_) {
            // Fallback
            try { alert(message); } catch(_) {}
        }
    }

    /**
     * Minimize modal (placeholder for future feature)
     */
    minimizeModal() {
        this.showNotification('Minimize feature coming soon!', 'info');
    }

    /**
     * View task details - show admin notes
     */
    async viewTaskDetails(taskId) {
        try {
            console.log('Fetching task details for ID:', taskId);
            
            const response = await fetch(`api/user_tasks_list.php?action=details&task_id=${taskId}`, {
                credentials: 'include'
            });
            
            let result;
            try {
                result = await response.json();
            } catch (jsonError) {
                const text = await response.text();
                console.error('Response text:', text);
                throw new Error(`Server returned invalid JSON. Status: ${response.status}`);
            }
            
            if (!response.ok) {
                const errorMsg = result?.message || `HTTP ${response.status}: ${response.statusText}`;
                console.error('API Error:', result);
                throw new Error(errorMsg);
            }
            
            if (!result.success) {
                const errorMsg = result?.message || 'Failed to fetch task details';
                console.error('API returned error:', result);
                throw new Error(errorMsg);
            }
            
            const task = result.task;
            const notes = task.notes || task.description || null;
            const taskName = this.formatReportName(task.table_name) || task.table_name || 'Task';
            
            // Create and show modal
            this.showTaskNotesModal(taskName, notes);
            
        } catch (error) {
            console.error('Error fetching task details:', error);
            const errorMessage = error.message || 'Failed to load task details';
            this.showNotification(errorMessage, 'error');
        }
    }
    
    /**
     * Show task notes modal
     */
    showTaskNotesModal(taskName, notes) {
        // Remove existing modal if any
        const existingModal = document.getElementById('taskNotesModal');
        if (existingModal) {
            existingModal.remove();
        }
        
        // Create modal HTML
        const modalHTML = `
            <div class="custom-modal-overlay show" id="taskNotesModal" style="z-index: 10000;">
                <div class="custom-modal-content" style="max-width: 600px; position: relative;">
                    <div class="custom-modal-header">
                        <h3><i class="fas fa-sticky-note"></i> Task Notes - ${taskName}</h3>
                        <button class="modal-close-btn" onclick="document.getElementById('taskNotesModal').remove()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="custom-modal-body" style="padding: 24px;">
                        ${notes && notes.trim() ? `
                            <div class="task-notes-content" style="background: #f8f9fa; border-radius: 12px; padding: 20px; border-left: 4px solid #dc143c;">
                                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 12px;">
                                    <i class="fas fa-info-circle" style="color: #dc143c; font-size: 18px;"></i>
                                    <h4 style="margin: 0; color: #333; font-size: 16px; font-weight: 600;">Admin Notes</h4>
                                </div>
                                <p style="margin: 0; color: #495057; line-height: 1.6; white-space: pre-wrap; font-size: 14px;">${notes}</p>
                            </div>
                        ` : `
                            <div class="task-notes-empty" style="text-align: center; padding: 40px;">
                                <i class="fas fa-sticky-note" style="font-size: 48px; color: #cbd5e0; margin-bottom: 16px; display: block;"></i>
                                <p style="color: #6c757d; font-size: 16px; font-weight: 500; margin: 0;">No Notes</p>
                                <p style="color: #9ca3af; font-size: 14px; margin: 8px 0 0 0;">The admin has not added any notes for this task.</p>
                            </div>
                        `}
                    </div>
                </div>
            </div>
        `;
        
        // Insert modal into body
        document.body.insertAdjacentHTML('beforeend', modalHTML);
        
        // Close modal on overlay click
        const modal = document.getElementById('taskNotesModal');
        const overlay = modal.querySelector('.custom-modal-overlay');
        if (overlay) {
            overlay.addEventListener('click', (e) => {
                if (e.target === overlay) {
                    modal.remove();
                }
            });
        }
        
        // Close modal on ESC key
        const closeModal = () => {
            modal.remove();
            document.removeEventListener('keydown', handleEsc);
        };
        
        const handleEsc = (e) => {
            if (e.key === 'Escape') {
                closeModal();
            }
        };
        
        document.addEventListener('keydown', handleEsc);
    }


    /**
     * Calendar navigation
     */
    previousMonth() {
        this.currentCalendarMonth--;
        if (this.currentCalendarMonth < 0) {
            this.currentCalendarMonth = 11;
            this.currentCalendarYear--;
        }
        this.renderCalendar();
    }

    nextMonth() {
        this.currentCalendarMonth++;
        if (this.currentCalendarMonth > 11) {
            this.currentCalendarMonth = 0;
            this.currentCalendarYear++;
        }
        this.renderCalendar();
    }

    todayMonth() {
        const today = new Date();
        this.currentCalendarMonth = today.getMonth();
        this.currentCalendarYear = today.getFullYear();
        this.renderCalendar();
    }

    /**
     * Show day details modal
     */
    async showDayDetails(day, month, year) {
        const date = new Date(year, month, day);
        const events = this.getEventsForDay(date);
        
        if (events.length === 0) {
            this.showNotification(`No events on ${date.toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' })}`, 'info');
            return;
        }

        const dateStr = date.toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' });
        
        const eventsHTML = events.map(event => {
            const deadlineDate = new Date(event.date);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            deadlineDate.setHours(0, 0, 0, 0);
            
            const diffTime = deadlineDate - today;
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            
            let statusBadge = '';
            if (event.type === 'completed') {
                statusBadge = '<span class="badge badge-success">Completed</span>';
            } else if (event.type === 'overdue') {
                statusBadge = `<span class="badge badge-danger">${Math.abs(diffDays)} days overdue</span>`;
            } else if (event.type === 'due-soon') {
                statusBadge = `<span class="badge badge-warning">Due in ${diffDays} days</span>`;
            } else {
                statusBadge = `<span class="badge badge-info">Due in ${diffDays} days</span>`;
            }
            
            const priorityBadge = event.priority ? 
                `<span class="badge priority-${event.priority}">${event.priority}</span>` : '';
            
            return `
                <div class="day-event-item" onclick="userDashboard.viewTask('${event.table_name}')">
                    <div class="event-title">
                        <i class="fas fa-tasks"></i>
                        ${event.title}
                    </div>
                    <div class="event-meta">
                        ${statusBadge}
                        ${priorityBadge}
                    </div>
                    <div class="event-date">
                        <i class="fas fa-calendar"></i>
                        ${deadlineDate.toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' })}
                    </div>
                </div>
            `;
        }).join('');

        const modalContent = `
            <div class="day-details-modal">
                <h3><i class="fas fa-calendar-day"></i> ${dateStr}</h3>
                <div class="events-list">
                    ${eventsHTML}
                </div>
                <div class="modal-actions">
                    <button class="btn-secondary" onclick="this.closest('.modal-overlay').remove()">
                        Close
                    </button>
                </div>
            </div>
        `;

        this.showModal(`Events for ${dateStr}`, modalContent);
    }

    /**
     * View task from calendar
     */
    viewTask(tableName) {
        // Close modal if open
        const modal = document.querySelector('.modal-overlay');
        if (modal) modal.remove();
        
        // Navigate to tasks section and highlight the task
        this.showSection('my-tasks');
        this.showNotification(`Viewing task: ${this.formatReportName(tableName)}`, 'info');
        
        // Scroll to the task if possible
        setTimeout(() => {
            const taskCards = document.querySelectorAll('.task-card');
            taskCards.forEach(card => {
                const title = card.querySelector('.task-title');
                if (title && title.textContent.includes(this.formatReportName(tableName))) {
                    card.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    card.style.border = '2px solid #dc143c';
                    setTimeout(() => {
                        card.style.border = '';
                    }, 2000);
                }
            });
        }, 500);
    }

    /**
     * Show modal
     */
    showModal(title, content) {
        const modal = document.createElement('div');
        modal.className = 'modal-overlay';
        modal.innerHTML = `
            <div class="modal-content">
                <div class="modal-header">
                    <h3>${title}</h3>
                    <button class="modal-close" onclick="this.closest('.modal-overlay').remove()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    ${content}
                </div>
            </div>
        `;
        document.body.appendChild(modal);
    }

    /**
     * Show modern alert dialog
     */
    showAlert(message, title = 'Notice', type = 'info') {
        return new Promise((resolve) => {
            const modal = document.createElement('div');
            modal.className = 'custom-modal-overlay';
            
            const iconMap = {
                'success': 'check-circle',
                'error': 'exclamation-circle',
                'warning': 'exclamation-triangle',
                'info': 'info-circle'
            };
            
            const colorMap = {
                'success': 'var(--success)',
                'error': 'var(--error)',
                'warning': 'var(--warning)',
                'info': 'var(--info)'
            };
            
            modal.innerHTML = `
                <div class="custom-modal-content custom-modal-alert">
                    <div class="custom-modal-icon" style="color: ${colorMap[type]}">
                        <i class="fas fa-${iconMap[type]}"></i>
                    </div>
                    <div class="custom-modal-header">
                        <h3>${title}</h3>
                    </div>
                    <div class="custom-modal-body">
                        <p>${message}</p>
                    </div>
                    <div class="custom-modal-footer">
                        <button class="custom-modal-btn custom-modal-btn-primary" onclick="this.closest('.custom-modal-overlay').remove()">
                            <i class="fas fa-check"></i> OK
                        </button>
                    </div>
                </div>
            `;
            
            document.body.appendChild(modal);
            
            // Add click event to resolve promise
            modal.querySelector('.custom-modal-btn').addEventListener('click', () => {
                resolve(true);
            });
            
            // Animate in
            setTimeout(() => modal.classList.add('show'), 10);
        });
    }

    /**
     * Show modern confirm dialog
     */
    showConfirm(message, title = 'Confirm', options = {}) {
        return new Promise((resolve) => {
            const modal = document.createElement('div');
            modal.className = 'custom-modal-overlay';
            modal.style.cssText = 'position: fixed !important; inset: 0 !important; z-index: 9999999 !important; background: rgba(0, 0, 0, 0.6) !important; backdrop-filter: blur(4px) !important; display: flex !important; align-items: center !important; justify-content: center !important;';
            
            const confirmText = options.confirmText || 'Confirm';
            const cancelText = options.cancelText || 'Cancel';
            const type = options.type || 'warning';
            
            const iconMap = {
                'success': 'check-circle',
                'error': 'exclamation-circle',
                'warning': 'exclamation-triangle',
                'info': 'question-circle'
            };
            
            const colorMap = {
                'success': 'var(--success)',
                'error': 'var(--error)',
                'warning': 'var(--warning)',
                'info': 'var(--info)'
            };
            
            modal.innerHTML = `
                <div class="custom-modal-content custom-modal-confirm">
                    <div class="custom-modal-icon" style="color: ${colorMap[type]}">
                        <i class="fas fa-${iconMap[type]}"></i>
                    </div>
                    <div class="custom-modal-header">
                        <h3>${title}</h3>
                    </div>
                    <div class="custom-modal-body">
                        <p>${message}</p>
                    </div>
                    <div class="custom-modal-footer">
                        <button class="custom-modal-btn custom-modal-btn-secondary" data-action="cancel">
                            <i class="fas fa-times"></i> ${cancelText}
                        </button>
                        <button class="custom-modal-btn custom-modal-btn-primary" data-action="confirm">
                            <i class="fas fa-check"></i> ${confirmText}
                        </button>
                    </div>
                </div>
            `;
            
            document.body.appendChild(modal);
            
            // Add click events
            modal.querySelectorAll('.custom-modal-btn').forEach(btn => {
                btn.addEventListener('click', (e) => {
                    const action = e.currentTarget.dataset.action;
                    modal.classList.remove('show');
                    setTimeout(() => modal.remove(), 300);
                    resolve(action === 'confirm');
                });
            });
            
            // Animate in
            setTimeout(() => modal.classList.add('show'), 10);
        });
    }

    /**
     * Show notification toast
     */
    showNotification(message, type = 'info') {
        const toast = document.createElement('div');
        toast.className = `toast toast-${type}`;
        toast.innerHTML = `
            <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle'}"></i>
            <span>${message}</span>
        `;
        
        document.body.appendChild(toast);
        
        setTimeout(() => {
            toast.classList.add('show');
        }, 100);
        
        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => toast.remove(), 300);
        }, 3000);
    }

    /**
     * Update section titles
     */
    showSection(sectionId) {
        // Update page title
        const titles = {
            'dashboard': { title: 'Dashboard', subtitle: 'Welcome back! Here\'s your overview' },
            'my-tasks': { title: 'My Tasks', subtitle: 'Manage your assigned tasks and deadlines' },
            'submissions': { title: 'Submissions History', subtitle: 'View all your submitted reports' },
            'notifications': { title: 'Notifications', subtitle: 'Stay updated with important alerts' },
            'calendar': { title: 'Calendar', subtitle: 'Track deadlines and important dates' },
            'profile': { title: 'My Profile', subtitle: 'View and update your profile information' },
            'help': { title: 'Help & Support', subtitle: 'Get help with using the system' }
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
        if (sectionId === 'my-tasks') {
            this.loadMyTasks();
        } else if (sectionId === 'submissions') {
            this.loadSubmissions();
        } else if (sectionId === 'calendar') {
            console.log('Calendar section clicked (second showSection), loading calendar...');
            // Small delay to ensure DOM is ready
            setTimeout(() => {
                const calendarSection = document.getElementById('calendar');
                console.log('Calendar section element:', calendarSection);
                if (calendarSection) {
                    console.log('Calendar section classes:', calendarSection.className);
                }
                this.loadCalendar();
            }, 50);
        } else if (sectionId === 'profile') {
            this.loadProfile();
        } else if (sectionId === 'help') {
            this.loadHelp();
        }
    }

    async loadCalendar() {
        console.log('Loading calendar...');
        
        // Show loading state
        const grid = document.getElementById('calendarGrid');
        if (grid) {
            grid.innerHTML = '<div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #64748b;"><i class="fas fa-spinner fa-spin"></i> Loading calendar...</div>';
        }
        
        try {
            const response = await fetch('api/user_calendar.php?action=get_events', {
                credentials: 'include'
            });
            
            if (!response.ok) {
                throw new Error('Failed to load calendar events');
            }
            
            const result = await response.json();
            console.log('Calendar API response:', result);
            if (result.success) {
                this.calendarEvents = result.data || [];
                console.log('Calendar events loaded:', this.calendarEvents.length);
                console.log('Calendar events data:', JSON.stringify(this.calendarEvents, null, 2));
                if (this.calendarEvents.length > 0) {
                    console.log('First event:', this.calendarEvents[0]);
                    console.log('First event date:', this.calendarEvents[0].date, 'Type:', typeof this.calendarEvents[0].date);
                } else {
                    console.warn('No events in API response. Debug info:', result.debug);
                    console.warn('Full API response:', JSON.stringify(result, null, 2));
                }
            } else {
                this.calendarEvents = [];
                console.warn('Calendar API returned success=false:', result);
            }
        } catch (error) {
            console.error('Error loading calendar:', error);
            this.calendarEvents = [];
        }
        
        // Always render calendar, even if API fails or returns no events
        console.log('About to render calendar with', this.calendarEvents.length, 'events');
        this.renderCalendar();
        this.renderUpcomingDeadlines();
        
        // Force a re-render after a short delay to ensure DOM is ready
        setTimeout(() => {
            console.log('Re-rendering calendar after delay...');
            this.renderCalendar();
            this.renderUpcomingDeadlines();
        }, 200);
    }

    renderCalendar() {
        const grid = document.getElementById('calendarGrid');
        const monthYear = document.getElementById('calendarMonthYear');
        if (!grid || !monthYear) {
            console.error('Calendar elements not found:', { grid: !!grid, monthYear: !!monthYear });
            // Try again after a short delay in case DOM isn't ready
            setTimeout(() => {
                const retryGrid = document.getElementById('calendarGrid');
                const retryMonthYear = document.getElementById('calendarMonthYear');
                if (retryGrid && retryMonthYear) {
                    console.log('Retrying calendar render...');
                    this.renderCalendar();
                }
            }, 100);
            return;
        }
        
        console.log('Rendering calendar for month:', this.currentMonth);

        const year = this.currentMonth.getFullYear();
        const month = this.currentMonth.getMonth();
        
        // Update month/year display
        const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 
                          'July', 'August', 'September', 'October', 'November', 'December'];
        monthYear.textContent = `${monthNames[month]} ${year}`;

        // Get first day of month and number of days
        const firstDay = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);
        const daysInMonth = lastDay.getDate();
        const startingDayOfWeek = firstDay.getDay();

        // Clear grid
        grid.innerHTML = '';

        // Add empty cells for days before month starts
        for (let i = 0; i < startingDayOfWeek; i++) {
            const emptyCell = document.createElement('div');
            emptyCell.className = 'calendar-day empty';
            grid.appendChild(emptyCell);
        }

        // Add cells for each day of the month
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        console.log('Calendar events to match:', this.calendarEvents.length);
        if (this.calendarEvents.length > 0) {
            console.log('Sample event dates:', this.calendarEvents.slice(0, 3).map(e => ({ date: e.date, title: e.title, type: e.type })));
            console.log('All event dates:', this.calendarEvents.map(e => e.date));
        } else {
            console.warn('No calendar events found! Check API response.');
        }

        for (let day = 1; day <= daysInMonth; day++) {
            const date = new Date(year, month, day);
            // Use local date format to avoid timezone issues
            const yearStr = date.getFullYear();
            const monthStr = String(date.getMonth() + 1).padStart(2, '0');
            const dayStr = String(date.getDate()).padStart(2, '0');
            const dateStr = `${yearStr}-${monthStr}-${dayStr}`;
            
            const dayCell = document.createElement('div');
            dayCell.className = 'calendar-day';
            dayCell.dataset.date = dateStr;
            
            // Check if today
            if (date.getTime() === today.getTime()) {
                dayCell.classList.add('today');
            }

            // Get events for this day
            const dayEvents = this.calendarEvents.filter(event => {
                if (!event.date) return false;
                try {
                    // Handle different date formats from API
                    let eventDate;
                    if (typeof event.date === 'string') {
                        // If it's already in YYYY-MM-DD format, use it directly
                        if (event.date.match(/^\d{4}-\d{2}-\d{2}$/)) {
                            eventDate = event.date;
                        } else {
                            // Parse the date and format it
                            const parsed = new Date(event.date);
                            // Use local date to avoid timezone issues
                            const year = parsed.getFullYear();
                            const month = String(parsed.getMonth() + 1).padStart(2, '0');
                            const day = String(parsed.getDate()).padStart(2, '0');
                            eventDate = `${year}-${month}-${day}`;
                        }
                    } else {
                        const parsed = new Date(event.date);
                        const year = parsed.getFullYear();
                        const month = String(parsed.getMonth() + 1).padStart(2, '0');
                        const day = String(parsed.getDate()).padStart(2, '0');
                        eventDate = `${year}-${month}-${day}`;
                    }
                    return eventDate === dateStr;
                } catch (e) {
                    console.error('Error parsing event date:', event.date, e);
                    return false;
                }
            });

            // Day number
            const dayNumber = document.createElement('div');
            dayNumber.className = 'day-number';
            dayNumber.textContent = day;
            dayCell.appendChild(dayNumber);

            // Event indicators
            if (dayEvents.length > 0) {
                console.log(`Found ${dayEvents.length} event(s) for ${dateStr}:`, dayEvents);
                const eventsContainer = document.createElement('div');
                eventsContainer.className = 'day-events';
                
                dayEvents.forEach(event => {
                    const eventDot = document.createElement('div');
                    eventDot.className = `event-dot ${event.type}`;
                    eventDot.title = event.title;
                    eventsContainer.appendChild(eventDot);
                });
                
                dayCell.appendChild(eventsContainer);
                dayCell.style.cursor = 'pointer';
                dayCell.onclick = () => this.showDayEvents(dateStr, dayEvents);
            }

            grid.appendChild(dayCell);
        }
    }

    renderUpcomingDeadlines() {
        const container = document.getElementById('upcomingDeadlinesList');
        const noDeadlines = document.getElementById('noDeadlines');
        if (!container) return;

        const now = new Date();
        now.setHours(0, 0, 0, 0);

        // Filter and sort upcoming deadlines
        const upcoming = this.calendarEvents
            .filter(event => {
                if (!event.date) return false;
                try {
                    // Parse date using same logic as calendar rendering
                    let eventDate;
                    if (typeof event.date === 'string' && event.date.match(/^\d{4}-\d{2}-\d{2}$/)) {
                        eventDate = new Date(event.date + 'T00:00:00');
                    } else {
                        eventDate = new Date(event.date);
                    }
                    eventDate.setHours(0, 0, 0, 0);
                    const isUpcoming = eventDate >= now && event.type !== 'completed';
                    if (isUpcoming) {
                        console.log('Upcoming deadline found:', event.title, 'on', event.date);
                    }
                    return isUpcoming;
                } catch (e) {
                    console.error('Error parsing event date in upcoming deadlines:', event.date, e);
                    return false;
                }
            })
            .sort((a, b) => {
                const dateA = new Date(a.date);
                const dateB = new Date(b.date);
                return dateA - dateB;
            })
            .slice(0, 10);
        
        console.log('Filtered upcoming deadlines:', upcoming.length);

        container.innerHTML = '';

        if (upcoming.length === 0) {
            if (noDeadlines) noDeadlines.style.display = 'block';
            return;
        }

        if (noDeadlines) noDeadlines.style.display = 'none';

        upcoming.forEach(event => {
            const eventDate = new Date(event.date);
            const daysUntil = Math.ceil((eventDate - now) / (1000 * 60 * 60 * 24));
            
            const eventItem = document.createElement('div');
            eventItem.className = 'deadline-item';
            eventItem.style.cssText = `
                padding: 12px;
                border-left: 4px solid ${this.getEventColor(event.type)};
                background: ${this.getEventBgColor(event.type)};
                border-radius: 8px;
                margin-bottom: 8px;
            `;
            
            eventItem.innerHTML = `
                <div style="font-weight: 700; color: #1a202c; margin-bottom: 4px; font-size: 14px;">
                    ${event.title}
                </div>
                <div style="font-size: 12px; color: #64748b; display: flex; align-items: center; gap: 6px;">
                    <i class="fas fa-calendar" style="font-size: 10px;"></i>
                    ${eventDate.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}
                    ${daysUntil === 0 ? '<span style="color: #f59e0b; font-weight: 600;">(Today)</span>' : 
                      daysUntil === 1 ? '<span style="color: #f59e0b; font-weight: 600;">(Tomorrow)</span>' : 
                      `<span style="color: #64748b;">(${daysUntil} days)</span>`}
                </div>
            `;
            
            container.appendChild(eventItem);
        });
    }

    getEventColor(type) {
        const colors = {
            'overdue': '#ef4444',
            'due-soon': '#f59e0b',
            'upcoming': '#3b82f6',
            'completed': '#10b981'
        };
        return colors[type] || '#64748b';
    }

    getEventBgColor(type) {
        const colors = {
            'overdue': '#fee2e2',
            'due-soon': '#fef3c7',
            'upcoming': '#dbeafe',
            'completed': '#d1fae5'
        };
        return colors[type] || '#f3f4f6';
    }

    showDayEvents(dateStr, events) {
        if (!events || events.length === 0) return;
        
        const date = new Date(dateStr);
        const dateFormatted = date.toLocaleDateString('en-US', { 
            weekday: 'long', 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric' 
        });
        
        let eventsHTML = events.map(event => `
            <div style="padding: 12px; border-left: 4px solid ${this.getEventColor(event.type)}; 
                        background: ${this.getEventBgColor(event.type)}; border-radius: 8px; margin-bottom: 8px;">
                <div style="font-weight: 700; color: #1a202c; margin-bottom: 4px;">${event.title}</div>
                ${event.description ? `<div style="font-size: 12px; color: #64748b; margin-top: 4px;">${event.description}</div>` : ''}
                <div style="font-size: 11px; color: #94a3b8; margin-top: 6px; text-transform: uppercase; font-weight: 600;">
                    ${event.type.replace('-', ' ')}
                </div>
            </div>
        `).join('');
        
        this.showNotification(`Events on ${dateFormatted}`, eventsHTML, 'info', 5000);
    }

    previousMonth() {
        this.currentMonth.setMonth(this.currentMonth.getMonth() - 1);
        this.renderCalendar();
    }

    nextMonth() {
        this.currentMonth.setMonth(this.currentMonth.getMonth() + 1);
        this.renderCalendar();
    }

    goToToday() {
        this.currentMonth = new Date();
        this.renderCalendar();
    }
}

// Logout function
async function logout() {
    const confirmed = await userDashboard.showConfirm(
        'Are you sure you want to logout?',
        'Confirm Logout',
        { confirmText: 'Logout', cancelText: 'Cancel', type: 'warning' }
    );
    
    if (confirmed) {
        localStorage.removeItem('userSession');
        fetch('api/simple_auth.php?action=logout')
            .then(() => {
                window.location.href = 'login.html';
            })
            .catch(() => {
                window.location.href = 'login.html';
            });
    }
}

// Initialize dashboard and make it globally accessible
window.userDashboard = new UserDashboard();
