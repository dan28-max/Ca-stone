// Admin Dashboard JavaScript

console.log('AdminDashboard script loaded');

window.AdminDashboard = window.AdminDashboard || class AdminDashboard {
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
        this.allActivities = [];
        this.filteredActivities = [];
        // Dashboard sync
        this.sync = window.dashboardSync || null;
        // Campus code -> friendly name mapping for activity logs and filters
        this.campusMap = {
            'AL': 'Alangilan',
            'PB': 'Pablo Borbon',
            'LM': 'Lemery',
            'MN': 'Mabini',
            'NL': 'Nasugbu',
            'BP': 'Balayan',
            'LJ': 'Lipa',
            'ML': 'Malvar',
            'SR': 'San Juan',
            'ROS': 'Rosario',
            'AR': 'ARASOF Nasugbu',
            'MAIN': 'Main Campus',
            'MAIN-I': 'Main Campus I',
            'MAIN-II': 'Main Campus II'
        };
    }

    startEditCampus(index) {
        try {
            if (!Array.isArray(this.campusSettings)) return;
            if (index < 0 || index >= this.campusSettings.length) return;

            const target = this.campusSettings[index];
            const nameInput = document.getElementById('newCampusName');
            const parentSelect = document.getElementById('newCampusParent');
            const label = document.getElementById('campusFormSubmitLabel');
            const cancelEditBtn = document.getElementById('cancelEditCampus');

            if (!nameInput || !parentSelect) return;

            // Reset form first
            this.cancelEditCampus();

            this.editCampusIndex = index;

            // Lock name (we are only editing parent campus as requested)
            nameInput.value = (target.name || '').toString();
            nameInput.disabled = true;

            const parentValue = (target.parent || '').toString();
            parentSelect.value = parentValue;

            if (label) {
                label.textContent = 'Update Campus';
            }
            
            if (cancelEditBtn) {
                cancelEditBtn.style.display = 'inline-block';
            }

            this.showNotification(`Editing parent campus for "${nameInput.value}"`, 'info');
        } catch (e) {
            console.error('Error starting campus edit:', e);
            this.showNotification('Error starting edit mode', 'error');
        }
    }

    escapeHtml(text) {
        if (text === null || text === undefined) return '';
        const div = document.createElement('div');
        div.textContent = String(text);
        return div.innerHTML;
    }

    sanitizeDeleteButtons(scopeSelector) {
        try {
            const root = scopeSelector ? document.querySelector(scopeSelector) : document;
            if (!root) return;
            const buttons = root.querySelectorAll('button');
            buttons.forEach(btn => {
                const oc = btn.getAttribute && btn.getAttribute('onclick');
                if (!oc) return;
                const m = oc.match(/adminDashboard\.deleteSubmission\((\d+)/);
                if (!m) return;
                const id = parseInt(m[1], 10);
                if (!Number.isFinite(id) || id <= 0) {
                    btn.removeAttribute('onclick');
                    btn.disabled = true;
                }
            });
        } catch (e) {
            console.warn('sanitizeDeleteButtons failed:', e);
        }
    }

    lockCombinedColumnWidths() {
        const table = document.getElementById('combinedDataTable');
        if (!table) return;
        const thead = table.querySelector('thead');
        if (!thead) return;
        const headerRow = thead.querySelectorAll('tr')[0];
        if (!headerRow) return;
        const ths = headerRow.querySelectorAll('th');
        if (!ths || ths.length === 0) return;

        // Compute current widths
        const widths = Array.from(ths).map(th => th.getBoundingClientRect().width);

        // Remove existing colgroup if any
        const old = table.querySelector('colgroup[data-lock]');
        if (old) old.remove();

        // Build new colgroup
        const cg = document.createElement('colgroup');
        cg.setAttribute('data-lock', '1');
        widths.forEach(w => {
            const col = document.createElement('col');
            col.style.width = `${Math.max(80, Math.round(w))}px`;
            cg.appendChild(col);
        });
        table.insertBefore(cg, table.firstChild);
    }

    // Fallback: Known report schemas (column display names) copied from user-dashboard-simple.js
    getReportSchema(reportTypeKey = '') {
        const key = (reportTypeKey || '').toString().trim().toLowerCase();
        const schemas = {
            employee: ["Campus", "Date Generated", "Category", "Faculty Rank", "Sex", "Status", "Date Hired"],
            admissiondata: ["Campus", "Semester", "Academic Year", "Category", "Program", "Male", "Female"],
            enrollmentdata: ["Campus", "Academic Year", "Semester", "College", "Graduate/Undergrad", "Program/Course", "Male", "Female"],
            graduatesdata: ["Campus", "Academic Year", "Semester", "Degree Level", "Subject Area", "Course", "Category/Total No. of Applicants", "Male", "Female"],
            leaveprivilege: ["Campus", "Leave Type", "Employee Name", "Duration Days", "Equivalent Pay"],
            libraryvisitor: ["Campus", "Visit Date", "Category", "Sex", "Total Visitors"],
            pwd: ["Campus", "Year", "No. of PWD Students", "No. of PWD Employees", "Type of Disability", "Sex"],
            campuspopulation: ["Campus", "Academic Year", "Semester", "Category", "Male", "Female"],
            waterconsumption: ["Campus", "Month", "Year", "Water Type", "Consumption"],
            treatedwastewater: ["Campus", "Date", "Treated Volume", "Reused Volume", "Effluent Volume"],
            electricityconsumption: ["Campus", "Category", "Month", "Year", "Prev Reading", "Current Reading", "Actual Consumption", "Multiplier", "Total Consumption", "Total Amount", "Price/kWh", "Remarks"],
            solidwaste: ["Campus", "Month", "Year", "Waste Type", "Quantity", "Remarks"],
            foodwaste: ["Campus", "Date", "Quantity (kg)", "Remarks"],
            fuelconsumption: ["Campus", "Date", "Driver", "Vehicle", "Plate No", "Fuel Type", "Description", "Transaction No", "Odometer", "Qty", "Total Amount"],
            distancetraveled: ["Campus", "Travel Date", "Plate No", "Vehicle", "Fuel Type", "Start Mileage", "End Mileage", "Total KM"],
            budgetexpenditure: ["Campus", "Year", "Particulars", "Category", "Budget Allocation", "Actual Expenditure", "Utilization Rate"],
            flightaccommodation: ["Campus", "Office/Department", "Year", "Name of Traveller", "Event Name/Purpose of Travel", "Travel Date (mm/dd/yyyy)", "Domestic/International", "Origin Info or IATA code", "Destination Info or IATA code", "Class", "One Way/Round Trip", "kg CO2e", "tCO2e"]
        };
        // Direct match
        if (schemas[key]) return schemas[key];
        // Loose match
        const found = Object.keys(schemas).find(k => k.includes(key) || key.includes(k));
        return found ? schemas[found] : null;
    }

    // Populate analytics dropdown above the growth chart
    async populateAnalyticsReportTypeDropdown() {
        try {
            const select = document.getElementById('analyticsReportTypeSelect');
            if (!select) return;
            let subs = Array.isArray(this.submissions) && this.submissions.length > 0 ? this.submissions : [];
            if (subs.length === 0) {
                const res = await fetch('api/get_all_submissions.php', { credentials: 'include' });
                const json = await res.json();
                if (json && json.success) subs = json.data || [];
            }
            const types = Array.from(new Set(
                subs.map(s => (s.table_name || s.report_type || '').toString().trim()).filter(Boolean)
            )).sort((a,b)=>this.formatReportTypeName(a).localeCompare(this.formatReportTypeName(b)));
            const current = select.value;
            select.innerHTML = '<option value="">All Report Types</option>';
            types.forEach(t => {
                const opt = document.createElement('option');
                opt.value = t; opt.textContent = this.formatReportTypeName(t); select.appendChild(opt);
            });
            if (current) select.value = current;
        } catch (e) { console.warn('populateAnalyticsReportTypeDropdown failed:', e); }
    }

    attachAnalyticsReportTypeEvents() {
        const select = document.getElementById('analyticsReportTypeSelect');
        if (!select) return;
        select.onchange = async () => {
            this.analyticsReportType = select.value || '';
            await this.loadSubmissionsGrowthChart('current');
            await this.loadSubmissionsMonthlyChart();
            await this.loadTopActiveReports('monthly');

            // Show only the chart, not the cards
            const colContainer = document.getElementById('columnAnalyticsContainer');
            if (this.analyticsReportType) {
                // Hide the cards container
                if (colContainer) colContainer.style.display = 'none';
                try {
                    // Only load the chart, not the cards
                    await this.loadColumnBasedChart(this.analyticsReportType);
                } catch (e) {
                    console.warn('Column analytics load failed:', e);
                }
            } else {
                if (colContainer) colContainer.style.display = 'none';
            }
        };
    }

    // Simple skeleton for column analytics
    renderColumnSkeleton() {
        return `
            <style>
                .skeleton { position: relative; overflow: hidden; background: #f3f4f6; border-radius: 12px; }
                .shimmer { position: absolute; inset: 0; background: linear-gradient(90deg, rgba(255,255,255,0) 0%, rgba(255,255,255,.6) 50%, rgba(255,255,255,0) 100%); transform: translateX(-100%); animation: shimmer 1.2s infinite; }
                @keyframes shimmer { 100% { transform: translateX(100%); } }
                .sk-row { display: grid; grid-template-columns: 1fr 80px; gap: 12px; align-items: center; margin-bottom: 10px; }
                .sk-bar { height: 12px; border-radius: 999px; background: #e5e7eb; }
                .sk-chip { width: 60px; height: 20px; border-radius: 999px; background: #e5e7eb; }
            </style>
            <div class="skeleton" style="padding:16px;">
                <div class="sk-row"><div class="sk-bar" style="width: 50%;"></div><div class="sk-chip"></div></div>
                <div class="sk-row"><div class="sk-bar" style="width: 70%;"></div><div class="sk-chip"></div></div>
                <div class="sk-row"><div class="sk-bar" style="width: 40%;"></div><div class="sk-chip"></div></div>
                <div class="sk-row"><div class="sk-bar" style="width: 65%;"></div><div class="sk-chip"></div></div>
                <div class="sk-row"><div class="sk-bar" style="width: 55%;"></div><div class="sk-chip"></div></div>
                <div class="shimmer"></div>
            </div>
        `;
    }

    // Helper to filter analytics datasets by selected report type
    filterByAnalyticsType(list = []) {
        const t = (this.analyticsReportType || '').toString().trim().toLowerCase();
        if (!t) return list;
        return list.filter(x => {
            const key = ((x.table_name || x.report_type || '')+'').trim().toLowerCase();
            // Match exact or contains either way
            return key === t || key.includes(t) || t.includes(key);
        });
    }

    // Fetch a full submission for the selected report type to derive real columns/rows
    async fetchSampleSubmissionForType(reportTypeKey) {
        try {
            // 1) Find latest submission id for this type
            const listRes = await fetch('api/get_all_submissions.php', { credentials: 'include' });
            const listJson = await listRes.json();
            if (!listJson || !listJson.success) return null;
            let items = (listJson.data || []).filter(s => {
                const key = ((s.table_name || s.report_type || '')+'').trim().toLowerCase();
                const t = (reportTypeKey||'').toString().trim().toLowerCase();
                return key === t || key.includes(t) || t.includes(key);
            });
            // Fallback: if no items match the report type, use the most recent submissions overall
            if (!items.length) items = (listJson.data || []);
            if (!items.length) return null;
            items.sort((a,b)=> new Date(b.submitted_at||b.created_at||0) - new Date(a.submitted_at||a.created_at||0));
            // Try multiple latest submissions in case some IDs are unavailable in the detail endpoint
            const candidates = items.slice(0, 10);
            for (const it of candidates) {
                const sid = it.submission_id || it.id || it.ID || it.SubmissionID || it.submissionId;
                if (!sid) continue;
                // 2) Try detail endpoints (prefer admin and confirmed ones)
                const endpoints = [
                    `api/get_submission_details.php?submission_id=${encodeURIComponent(sid)}`,
                    `api/admin_submissions.php?action=details&submission_id=${encodeURIComponent(sid)}`,
                    `api/user_submissions.php?action=details&submission_id=${encodeURIComponent(sid)}`,
                    `api/submissions.php?action=details&id=${encodeURIComponent(sid)}`,
                    `api/get_submission.php?id=${encodeURIComponent(sid)}`
                ];
                for (const url of endpoints) {
                    try {
                        const r = await fetch(url, { credentials: 'include' });
                        if (!r.ok) continue;
                        const j = await r.json();
                        const norm = this.normalizeSubmissionPayload(j);
                        if (norm && norm.columns && norm.rows && norm.rows.length) return norm;
                    } catch (_) { /* try next */ }
                }
            }
        } catch (e) {
            console.warn('fetchSampleSubmissionForType error:', e);
        }
        return null;
    }

    // Normalize various detail payload shapes into {columns:[names], rows:[object or array]}
    normalizeSubmissionPayload(payload) {
        if (!payload) return null;
        const tryData = (obj) => (obj && (obj.data || obj.submission || obj.result || obj.payload)) || obj;
        let p = payload;
        if (p.success === true && p.submission) p = p.submission;
        p = tryData(p);
        // Case: { columns:[], rows:[] }
        if (p && Array.isArray(p.columns) && Array.isArray(p.rows)) {
            const cols = p.columns.map(c => (c && c.name) ? c.name : c);
            return { columns: cols, rows: p.rows };
        }
        // Case: data is array of objects
        if (Array.isArray(p) && p.length && typeof p[0] === 'object' && !Array.isArray(p[0])) {
            const cols = Array.from(new Set(p.flatMap(o => Object.keys(o))));
            return { columns: cols, rows: p };
        }
        // Case: data is object (single row)
        if (p && typeof p === 'object' && !Array.isArray(p)) {
            // Some APIs wrap rows inside submission_data
            const sd = p.submission_data || p.data;
            if (sd) {
                let d = sd;
                if (typeof d === 'string') { try { d = JSON.parse(d); } catch(_){} }
                if (Array.isArray(d) && d.length) {
                    if (typeof d[0] === 'object' && !Array.isArray(d[0])) {
                        const cols = Array.from(new Set(d.flatMap(o => Object.keys(o))));
                        return { columns: cols, rows: d };
                    }
                } else if (d && typeof d === 'object') {
                    const cols = Object.keys(d);
                    return { columns: cols, rows: [d] };
                }
            }
            const cols = Object.keys(p);
            return { columns: cols, rows: [p] };
        }
        return null;
    }

    // Populate analytics dropdown above the growth chart
    async populateAnalyticsReportTypeDropdown() {
        try {
            const select = document.getElementById('analyticsReportTypeSelect');
            if (!select) return;

            // Prefer already loaded submissions if present
            let subs = Array.isArray(this.submissions) && this.submissions.length > 0
                ? this.submissions
                : [];
            if (subs.length === 0) {
                const res = await fetch('api/get_all_submissions.php');
                const json = await res.json();
                if (json && json.success) subs = json.data || [];
            }

            const types = Array.from(new Set(
                subs.map(s => (s.table_name || s.report_type || '').toString().trim()).filter(Boolean)
            )).sort((a,b)=>this.formatReportTypeName(a).localeCompare(this.formatReportTypeName(b)));

            const current = select.value;
            select.innerHTML = '<option value="">All Report Types</option>';
            types.forEach(t => {
                const opt = document.createElement('option');
                opt.value = t; opt.textContent = this.formatReportTypeName(t); select.appendChild(opt);
            });
            if (current) select.value = current;
        } catch (e) {
            console.warn('populateAnalyticsReportTypeDropdown failed:', e);
        }
    }

    attachAnalyticsReportTypeEvents() {
        const select = document.getElementById('analyticsReportTypeSelect');
        if (!select) return;
        select.onchange = async () => {
            this.analyticsReportType = select.value || '';
            // Reload analytics views with filter
            await this.loadSubmissionsGrowthChart('current');
            await this.loadSubmissionsMonthlyChart();
            await this.loadReportsByType();
            await this.loadTopActiveReports('monthly');
            // Only load column-based chart, not the cards
            if (this.analyticsReportType) {
                await this.loadColumnBasedChart(this.analyticsReportType);
                // Hide cards container
                const colContainer = document.getElementById('columnAnalyticsContainer');
                if (colContainer) colContainer.style.display = 'none';
            }
        };
    }

    // Helper: filter datasets by analytics report type
    filterByAnalyticsType(list = []) {
        const t = (this.analyticsReportType || '').toString().trim();
        if (!t) return list;
        return list.filter(x => {
            const key = (x.table_name || x.report_type || '').toString().trim();
            const norm = (s) => s.toLowerCase().replace(/[^a-z0-9]/g, '');
            const nk = norm(key);
            const nt = norm(t);
            return nk === nt || nk.includes(nt) || nt.includes(nk);
        });
    }

    async viewAllReportsCombined() {
        try {
            // Create lightweight loading overlay
            let loadingModal = document.getElementById('loadingCombinedModal');
            if (!loadingModal) {
                loadingModal = document.createElement('div');
                loadingModal.id = 'loadingCombinedModal';
                loadingModal.style.cssText = 'position: fixed; inset: 0; background: rgba(0,0,0,0.4); display: flex; align-items: center; justify-content: center; z-index: 9999; color: white; font-weight: 600;';
                loadingModal.innerHTML = '<div style="background: rgba(0,0,0,0.6); padding: 16px 20px; border-radius: 8px; display: flex; align-items: center; gap: 10px;"><i class="fas fa-spinner fa-spin"></i><span>Loading all combined data...</span></div>';
                document.body.appendChild(loadingModal);
            } else {
                loadingModal.style.display = 'flex';
            }

            // Fetch all submissions
            const subsRes = await fetch('api/get_all_submissions.php');
            const subsJson = await subsRes.json();
            if (!subsJson.success) {
                loadingModal.style.display = 'none';
                this.showNotification('Failed to load submissions list.', 'error');
                return;
            }

            // Respect campus access for non-super admins
            let submissions = subsJson.data || [];
            if (!this.isSuperAdmin) {
                const norm = (s) => (s || '').toString().trim().toLowerCase().replace(/\s*campus\s*$/,'').replace(/[^a-z0-9]/g,'');
                const allowed = (this.getAccessibleCampuses() || []).map(norm);
                submissions = submissions.filter(s => {
                    const k = norm(s.campus);
                    return allowed.some(a => k.includes(a) || a.includes(k));
                });
            }

            if (!submissions || submissions.length === 0) {
                loadingModal.style.display = 'none';
                this.showNotification('No submissions available to combine.', 'info');
                return;
            }

            // Fetch details and combine - with better error handling
            const allDataPromises = submissions.map(async (sub) => {
                try {
                    const response = await fetch(`api/get_submission_details.php?submission_id=${sub.id}`);
                    const text = await response.text();
                    
                    if (!response.ok) {
                        console.warn(`Failed to fetch details for submission ${sub.id}: ${response.status} ${response.statusText}`);
                        // Try to still include submission ID even if fetch fails
                        // by returning an empty array with metadata at least
                        return [];
                    }
                    
                    let res;
                    try {
                        res = JSON.parse(text);
                    } catch (parseError) {
                        console.error(`Failed to parse response for submission ${sub.id}:`, parseError, 'Response:', text.substring(0, 200));
                        return [];
                    }
                    
                    if (res.success && Array.isArray(res.data)) {
                        const tbl = sub.table_name || sub.report_type || '';
                        // Ensure __submission_id is ALWAYS added
                        return res.data.map(row => {
                            // Ensure submission ID is preserved
                            const enrichedRow = { ...row };
                            enrichedRow.__submission_id = sub.id;
                            enrichedRow.__table_name = tbl;
                            enrichedRow.__submission_date = sub.submission_date || sub.submitted_at || null;
                            enrichedRow.__office = sub.office || null;
                            enrichedRow.__campus = sub.campus || null;
                            return enrichedRow;
                        });
                    } else if (res.success && res.data) {
                        // Handle case where data might not be an array
                        console.warn(`Submission ${sub.id} returned non-array data:`, typeof res.data);
                        return [];
                    } else {
                        console.warn(`Submission ${sub.id} returned unsuccessful response:`, res.error || res.message || 'Unknown error');
                        return [];
                    }
                } catch (error) {
                    console.error(`Error fetching submission ${sub.id} details:`, error);
                    return [];
                }
            });
            const dataArrays = await Promise.all(allDataPromises);
            const combinedData = dataArrays.flat();
            
            console.log('Combined data loaded:', combinedData.length, 'rows from', submissions.length, 'submissions');
            if (combinedData.length > 0) {
                console.log('Sample combined row (first):', combinedData[0]);
                console.log('Has __submission_id:', combinedData[0].hasOwnProperty('__submission_id'), 'Value:', combinedData[0].__submission_id);
            }

            loadingModal.style.display = 'none';
            this.showCombinedDataModal(combinedData, 'All Reports', submissions.length, combinedData.length);
        } catch (error) {
            console.error('Error loading all combined data:', error);
            const loadingModal = document.getElementById('loadingCombinedModal');
            if (loadingModal) loadingModal.style.display = 'none';
            this.showNotification('Error loading all combined data.', 'error');
        }
    }

    renderReportTypeCards() {
        const container = document.getElementById('reportTypeCards');
        if (!container) return;

        const submissions = Array.isArray(this.submissions) ? this.submissions : [];
        if (submissions.length === 0) { container.innerHTML = ''; return; }

        // Group by report type
        const grouped = {};
        let totalRecordsAll = 0;
        const campusesAll = new Set();
        submissions.forEach(s => {
            const type = (s.table_name || s.report_type || 'Unknown').trim();
            const recordCount = Number(s.record_count || 0);
            
            // Only include submissions that have records (exclude submissions with 0 records)
            // This ensures cards don't show for submissions where all data was deleted
            if (recordCount > 0) {
                if (!grouped[type]) grouped[type] = { count: 0, totalRecords: 0, campuses: new Set() };
                grouped[type].count++;
                grouped[type].totalRecords += recordCount;
                if (s.campus) grouped[type].campuses.add(String(s.campus).trim());
                totalRecordsAll += recordCount;
                if (s.campus) campusesAll.add(String(s.campus).trim());
            }
        });

        // Icon map per type (fallback to file icon)
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

        const typeCards = Object.keys(grouped)
            .sort((a,b) => this.formatReportTypeName(a).localeCompare(this.formatReportTypeName(b)))
            .map(key => {
                const g = grouped[key];
                const title = this.formatReportTypeName(key);
                const reportsText = `${g.count} ${g.count === 1 ? 'report' : 'reports'}`;
                const icon = iconMap[key.toLowerCase()] || 'fa-file';
                return `
                    <div class="rt-card rt-appear">
                        <div class="rt-head">
                            <div class="rt-icon"><i class="fas ${icon}"></i></div>
                            <div>
                                <h4 class="rt-title">${title}</h4>
                                <div class="rt-sub">${reportsText}</div>
                            </div>
                        </div>
                        <div class="rt-stats">
                            <div class="rt-stat"><div class="label">TOTAL RECORDS</div><div class="value">${g.totalRecords.toLocaleString()}</div></div>
                            <div class="rt-stat"><div class="label">CAMPUSES</div><div class="value">${g.campuses.size}</div></div>
                        </div>
                        <button class="rt-cta" onclick="adminDashboard.viewCombinedData('${key}')"><i class="fas fa-eye"></i> View All Reports</button>
                    </div>
                `;
            });

        container.innerHTML = typeCards.join('');
        this.attachCardInteractions();
    }

    attachCardInteractions() {
        try {
            // Ripple position for CTA buttons
            document.querySelectorAll('.rt-cta').forEach(btn => {
                btn.addEventListener('pointerdown', (e) => {
                    const rect = btn.getBoundingClientRect();
                    const x = ((e.clientX - rect.left) / rect.width) * 100;
                    const y = ((e.clientY - rect.top) / rect.height) * 100;
                    btn.style.setProperty('--x', x + '%');
                    btn.style.setProperty('--y', y + '%');
                }, { passive: true });
            });
        } catch (_) {
            // no-op
        }
    }

    ensureCombinedViewControls() {
        // Avoid duplicating controls
        if (document.getElementById('combinedViewControls')) return;

        // Locate a reasonable container to inject the controls
        let container = document.getElementById('submissions');
        if (!container) {
            const tbody = document.getElementById('submissionsTableBody');
            if (tbody && tbody.parentElement) {
                container = tbody.parentElement.parentElement || tbody.parentElement;
            }
        }
        if (!container) {
            container = document.querySelector('.submissions-table-container')
                || document.querySelector('.content-area')
                || document.body;
        }

        const wrapper = document.createElement('div');
        wrapper.id = 'combinedViewControls';
        wrapper.style.cssText = 'display:flex; gap:10px; align-items:center; margin:10px 0; flex-wrap: wrap;';
        wrapper.innerHTML = `
            <div class="filter-group" style="display:flex; gap:8px; align-items:center;">
                <label for="reportTypeDropdown" style="font-size: 12px; color: #6b7280;">Report Type</label>
                <select id="reportTypeDropdown" style="padding:6px 10px; border:1px solid #e5e7eb; border-radius:6px;">
                    <option value="">-- Select Report Type --</option>
                </select>
                <button id="viewCombinedByTypeBtn" class="btn-formal" style="padding:8px 12px; border-radius:6px; background:#3b82f6; color:#fff; border:none; cursor:pointer;">View Combined</button>
                <button id="viewAllReportsBtn" class="btn-formal" style="padding:8px 12px; border-radius:6px; background:#10b981; color:#fff; border:none; cursor:pointer;">View All Reports</button>
            </div>
        `;

        // Insert at top of the container
        if (container.firstChild) {
            container.insertBefore(wrapper, container.firstChild);
        } else {
            container.appendChild(wrapper);
        }

        // Populate dropdown and wire events
        this.initializeReportTypeDropdown();
        const viewAllBtn = document.getElementById('viewAllReportsBtn');
        if (viewAllBtn) viewAllBtn.addEventListener('click', () => this.viewAllReportsCombined());
        const viewCombinedBtn = document.getElementById('viewCombinedByTypeBtn');
        if (viewCombinedBtn) viewCombinedBtn.addEventListener('click', () => this.viewCombinedData());
    }

    // Get user session and campus info
    getUserSession() {
        const sessionData = localStorage.getItem('spartan_session');
        if (sessionData) {
            try {
                const session = JSON.parse(sessionData);
                this.userCampus = session.campus;
                this.userRole = session.role;
                // Main Campus users are treated as super admins OR if role is super_admin
                this.isSuperAdmin = session.role === 'super_admin' || session.campus === 'Main Campus';
                
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

    /**
     * Get accessible campuses for the current admin using dynamic hierarchy.
     * - Super admin: all campuses from hierarchy (or static fallback).
     * - Campus admin: their own campus + campuses whose parent is their campus.
     */
    getAccessibleCampuses() {
        const hierarchy = Array.isArray(this.campusSettings)
            ? this.campusSettings
            : null;

        const extractFromHierarchy = () => {
            if (!hierarchy || hierarchy.length === 0) return null;

            // Build list of all campus names
            const allNames = Array.from(
                new Set(
                    hierarchy
                        .map(c => (c.name || '').toString().trim())
                        .filter(Boolean)
                )
            );

            if (this.isSuperAdmin) {
                return allNames.sort((a, b) => a.localeCompare(b));
            }

            if (!this.userCampus) return [];

            const campus = this.userCampus.toString().trim();
            const children = hierarchy
                .filter(c => (c.parent || '').toString().trim() === campus)
                .map(c => (c.name || '').toString().trim())
                .filter(Boolean);

            return Array.from(new Set([campus, ...children]));
        };

        // Prefer dynamic hierarchy
        const fromHierarchy = extractFromHierarchy();
        if (fromHierarchy && fromHierarchy.length > 0) {
            return fromHierarchy;
        }

        // Fallback to original static mapping
        if (this.isSuperAdmin) {
            return [
                'Alangilan', 'Pablo Borbon', 'Rosario', 'San Juan', 'Lemery',
                'Lipa', 'Malvar', 'Nasugbu', 'Lobo', 'Balayan', 'Mabini'
            ];
        }

        if (!this.userCampus) {
            return [];
        }

        const campus = this.userCampus.trim();
        if (campus === 'Pablo Borbon') {
            return ['Pablo Borbon', 'Rosario', 'San Juan', 'Lemery'];
        }
        if (campus === 'Alangilan') {
            return ['Alangilan', 'Lobo', 'Balayan', 'Mabini'];
        }
        if (['Lipa', 'Malvar', 'Nasugbu'].includes(campus)) {
            return [campus];
        }
        return [campus];
    }

    /**
     * Check if admin should see campus dropdown (has multiple campuses)
     * Super admins: do NOT show campus dropdown (requested behavior)
     * Campus admins: show only if they have multiple accessible campuses
     */
    shouldShowCampusDropdown() {
        const accessibleCampuses = this.getAccessibleCampuses();
        return !this.isSuperAdmin && accessibleCampuses.length > 1;
    }

    // Authentication check - just verify user is logged in (no role restriction)
    async checkAuth() {
        try {
            // First get local session
            this.getUserSession();
            
            // Verify with server that user is logged in - get full user data
            const response = await fetch('api/simple_auth.php?action=get_user_data', {
                method: 'GET',
                credentials: 'include'
            });
            
            if (!response.ok) {
                console.error('Authentication check failed');
                window.location.href = 'login.html';
                return false;
            }
            
            const result = await response.json();
            
            if (!result.success || !result.data || !result.data.user) {
                console.error('Invalid user data');
                window.location.href = 'login.html';
                return false;
            }
            
            const user = result.data.user;
            const userRole = user.role?.toLowerCase() || '';
            
            // Update role from server response (for display purposes only)
            this.userRole = user.role;
            this.userCampus = user.campus || this.userCampus;
            this.isSuperAdmin = userRole === 'super_admin' || user.campus === 'Main Campus';
            
            // No role restriction - anyone logged in can access
            return true;
        } catch (error) {
            console.error('Auth check error:', error);
            window.location.href = 'login.html';
            return false;
        }
    }

    async init() {
        console.log('Initializing admin dashboard...');
        
        try {
            const isAuthenticated = await this.checkAuth();
            if (!isAuthenticated) {
                return;
            }

            // Load dynamic campus hierarchy (for access & filters) for all roles
            try {
                const response = await fetch('api/campus_settings.php', {
                    method: 'GET',
                    credentials: 'include'
                });
                const result = await response.json();
                if (result && result.success && result.data && Array.isArray(result.data.campuses)) {
                    this.campusSettings = result.data.campuses;
                }
            } catch (e) {
                console.error('Failed to load campus hierarchy for access logic:', e);
            }
            // Fallback: if no session campus, infer from URL (?campus=Lipa)
            if (!this.userCampus) {
                const urlCampus = this.getQueryParam('campus');
                if (urlCampus) {
                    this.userCampus = decodeURIComponent(urlCampus);
                }
                if (labels.length === 0) {
                    this.showNotification('No column data available for this report type yet. Please open a submission to populate schema.', 'info');
                    return; // Skip rendering bars with meta-only columns
                }
            }
            
            // Display campus restriction info
            this.displayCampusInfo();
            
            this.setupEventListeners();
            this.loadDashboardData();
            this.loadSystemSettings();
            await this.initCampusManagement();
            await this.loadAvailableReports();
            await this.loadAvailableOffices();
            // Ensure combined view controls appear if starting on submissions section
            setTimeout(() => {
                this.ensureCombinedViewControls();
            }, 150);
            
            // Register with global sync manager
            window.adminDashboard = this;
            
            console.log('Admin dashboard initialized successfully');
        } catch (error) {
            console.error('Error initializing admin dashboard:', error);
        }
    }

    // Helper to read URL query params
    getQueryParam(name) {
        const params = new URLSearchParams(window.location.search);
        const value = params.get(name);
        return value && value.trim() !== '' ? value : '';
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
        
        // Update navigation visibility based on user role
        this.updateNavigationVisibility();
    }
    
    updateNavigationVisibility() {
        const systemSettingsNavItem = document.getElementById('systemSettingsNavItem');
        
        if (systemSettingsNavItem) {
            // Show System Settings only for super admins
            if (this.isSuperAdmin) {
                systemSettingsNavItem.style.display = 'flex';
            } else {
                systemSettingsNavItem.style.display = 'none';
                
                // If currently viewing system settings, switch to dashboard
                if (this.currentSection === 'system') {
                    this.showSection('dashboard');
                    // Update active nav item
                    document.querySelectorAll('.nav-item').forEach(item => {
                        item.classList.remove('active');
                        if (item.dataset.section === 'dashboard') {
                            item.classList.add('active');
                        }
                    });
                }
            }
        }
    }
    
    addCampusFilterNotice() {
        // Disabled: no longer show the campus filter banner
        return;
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
        const campusFilter = document.getElementById('campusFilter');
        if (campusFilter) {
            campusFilter.addEventListener('change', () => this.filterSubmissions());
        }

        // Combined data controls (if present in DOM)
        const viewAllReportsBtn = document.getElementById('viewAllReportsBtn');
        if (viewAllReportsBtn) {
            viewAllReportsBtn.addEventListener('click', () => this.viewAllReportsCombined());
        }
        const viewCombinedByTypeBtn = document.getElementById('viewCombinedByTypeBtn');
        if (viewCombinedByTypeBtn) {
            viewCombinedByTypeBtn.addEventListener('click', () => this.viewCombinedData());
        }
    }

    showSection(sectionId) {
        console.log('Showing section:', sectionId);
        
        // Prevent non-super admins from accessing system settings
        if (sectionId === 'system' && !this.isSuperAdmin) {
            console.warn('Access denied: System Settings is only available for Super Admins');
            this.showNotification('Access denied: System Settings is only available for Super Admins', 'error');
            sectionId = 'dashboard'; // Redirect to dashboard
        }
        
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
        if (sectionId === 'dashboard') {
            // Refresh analytics when dashboard section is shown
            // Use setTimeout to ensure section is marked as active first
            setTimeout(() => {
                this.refreshAnalyticsIfVisible(true);
            }, 100);
        } else if (sectionId === 'submissions') {
            // Ensure submissions table container is visible
            const submissionsContainer = document.querySelector('.submissions-table-container');
            if (submissionsContainer) {
                submissionsContainer.style.display = 'block';
                submissionsContainer.style.pointerEvents = 'auto';
                console.log('Made submissions table container visible');
            }
            
            this.getUserSession(); // Ensure session is loaded
            // Wait a bit for DOM to be ready, then setup filter
            setTimeout(() => {
                this.setupSubmissionsCampusFilter();
                this.ensureCombinedViewControls();
            }, 100);
            this.loadSubmissions();
        } else if (sectionId === 'users') {
            this.getUserSession(); // Ensure session is loaded
            // Wait a bit for DOM to be ready, then setup filter
            setTimeout(() => {
                this.setupUsersCampusFilter();
            }, 100);
            this.loadUsers();
        // Analytics section removed - analytics are now in dashboard
        } else if (sectionId === 'userActivity') {
            this.loadUserActivity();
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
            const result = await response.json();
            if (!result || !result.success) throw new Error('Failed to load offices');
            if (result.success) {
                const normalize = (s) => (s || '').toString().trim().toLowerCase();
                const norm = normalize;
                const accessible = (this.getAccessibleCampuses() || []).map(norm);
                // Filter offices by accessible campuses (normalized)
                let offices = Array.isArray(result.offices) ? result.offices : [];
                offices = offices.map(o => ({
                    ...o,
                    __campusKey: norm(o.campus),
                    __campusLabel: (o.campus || '').toString().trim()
                }));
                if (this.isSuperAdmin) {
                    this.availableOffices = offices;
                    console.log('Super Admin - Loaded all offices:', this.availableOffices.length);
                } else {
                    this.availableOffices = offices.filter(office => accessible.includes(office.__campusKey));
                    console.log(`Campus Admin (${this.userCampus}) - Loaded ${this.availableOffices.length} offices from campuses:`, accessible);
                }
                this.renderOfficesList();
                this.populateOfficeDropdown();
            }
 else {
                console.error('Failed to load offices:', result.error);
            }
        } catch (error) {
            console.error('Error loading offices:', error);
        }
    }

    populateOfficeDropdown() {
        const officeSelect = document.getElementById('userOffice');
        if (!officeSelect) return;
        // Preserve current value if any
        const current = officeSelect.value;
        officeSelect.innerHTML = '<option value="">Select office</option>';

        // Offices from API (scoped by campus unless super admin)
        const normalize = (s) => (s || '').toString().trim().toLowerCase();
        const normUserCampus = normalize(this.userCampus);
        const officesFromApi = (this.availableOffices || [])
            .filter(o => this.isSuperAdmin || (o && (o.__campusKey === normUserCampus || normalize(o.campus) === normUserCampus)))
            .map(o => o.office_name);

        // Default offices list
        const defaultOffices = [
            'Office of the Chancellor',
            'Internal Audit',
            'Quality Assurance Management',
            'Sustainable Development',
            'Sustainable Development Office',
            'Central Sustainable Development',
            'Vice Chancellor for Development and External Affairs',
            'Planning and Development',
            'External Affairs',
            'Resource Generation',
            'ICT Services',
            'Vice Chancellor for Academic Affairs',
            'College of Arts and Sciences',
            'College of Accountancy, Business and Economics',
            'College of Informatics and Computing Sciences',
            'College of Engineering Technology',
            'College of Teacher Education',
            'College of Engineering',
            'Culture and Arts',
            'Testing and Admission',
            'Registration Services',
            'Scholarship and Financial Assistance',
            'Guidance and Counseling',
            'Library Services',
            'Student Organization and Activities',
            'Student Discipline',
            'Sports and Development',
            'OJT',
            'National Service Training Program',
            'Vice Chancellor for Administration and Finance',
            'Human Resource Management',
            'Records Management',
            'Procurement',
            'Cashiering/Disbursing',
            'Project Facilities and Management',
            'Environment Management Unit',
            'Property and Supply Management',
            'General Services',
            'Vice Chancellor for Research, Development and Extension Services',
            'Extension',
            'Research',
            'HRMO',
            'TAO',
            'Registrar',
            'Library',
            'Health Services',
            'GSO',
            'RGO',
            'Budget office'
        ];

        // Merge, dedupe (case-insensitive), preserve order with API first
        const seen = new Set();
        const combined = [...officesFromApi, ...defaultOffices].filter(name => {
            const key = (name || '').trim();
            if (!key) return false;
            const k = key.toLowerCase();
            if (seen.has(k)) return false;
            seen.add(k);
            return true;
        });

        // Exclude blocked offices (case-insensitive substring) with an allow-list
        const allow = ['registrar office', 'library services', 'sustainable development office', 'central sustainable development'];
        const blocked = [
            'office of the chancellor',
            'office of chancellor',
            'sustainable development',
            'vice chancellor for development and external affairs',
            'vice chancellor for academic affairs',
            'vice chancellor for administration and finance',
            'vice chancellor for research, development and extension services',
            'vice chancellor for research, development and extention services',
            'vice chancellor for research, development and extention serveces',
            'rgo',
            'library',
            'gso',
            'tao',
            'hrmo',
            'registrar',
            'development and external affairs',
            'academic affairs',
            'budget',
            'accounting'
        ];
        const filteredCombined = combined.filter(name => {
            const n = (name || '').toLowerCase();
            if (!n) return false;
            if (allow.some(term => term && n.includes(term))) return true;
            return !blocked.some(term => term && n.includes(term));
        });

        filteredCombined.forEach(name => {
            const opt = document.createElement('option');
            opt.value = name;
            opt.textContent = name;
            officeSelect.appendChild(opt);
        });

        if (current) officeSelect.value = current;
    }

    renderOfficesList() {
        const container = document.querySelector('.campuses-container');
        if (!container) return;
        
        // Group offices by campus (normalized key, keep label for display)
        const officesByCampus = {};
        const normalize = (s) => (s || '').toString().trim().toLowerCase();
        this.availableOffices.forEach(office => {
            const label = (office.__campusLabel || office.campus || 'Unknown').toString().trim();
            const key = normalize(label);
            if (!officesByCampus[label]) officesByCampus[label] = [];
            officesByCampus[label].push(office);
        });
        
        // Build campuses HTML separately. Search bar will be rendered in header mount.
        let html = '';
        
        const campuses = Object.keys(officesByCampus).filter(c => normalize(c) !== 'main campus');
        campuses.forEach(campus => {
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
        // Render search bar into header mount
        const mount = document.getElementById('officeFilterMount');
        if (mount) {
            mount.innerHTML = `
                <div class="office-filter-bar" style="display:flex; justify-content:flex-end;">
                    <div class="filter-group" style="min-width:260px;">
                        <label style="font-weight:700; font-size:12px; display:block; margin-bottom:6px; color:#0f172a; letter-spacing:.01em;">
                            <i class="fas fa-search"></i> Office Filter
                        </label>
                        <input type="text" id="officeFilterInput" class="formal-input" placeholder="Search office..." oninput="adminDashboard.filterOffices(this.value)" />
                    </div>
                </div>
            `;
        }
        // Apply current filter if any after mount render
        const qEl = document.getElementById('officeFilterInput');
        const q = (qEl && qEl.value) || '';
        this.filterOffices(q);
    }

    filterOffices(query) {
        const q = (query || '').toString().toLowerCase().trim();
        const groups = document.querySelectorAll('.campuses-container .campus-group');
        groups.forEach(group => {
            let visible = 0;
            const labels = group.querySelectorAll('.office-checkbox');
            labels.forEach(label => {
                const name = ((label.querySelector('span') || {}).textContent || '').toLowerCase();
                const match = !q || name.includes(q);
                label.style.display = match ? '' : 'none';
                if (match) visible++;
            });
            group.style.display = visible > 0 ? '' : 'none';
        });
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

        // Get deadline and priority settings
        const hasDeadline = document.getElementById('hasDeadlineCheck')?.checked || false;
        const deadline = document.getElementById('deadlineInput')?.value || null;
        const priority = document.querySelector('input[name="priorityLevel"]:checked')?.value || 'medium';
        const notes = document.getElementById('assignmentNotes')?.value || '';

        // Validate deadline if checkbox is checked
        if (hasDeadline && !deadline) {
            alert('Please select a deadline date');
            return;
        }

        // Show modern confirmation dialog
        if (window.showConfirmDialog) {
            const confirmed = await showConfirmDialog({
                title: 'Confirm Assignment',
                message: `Are you sure you want to assign ${this.selectedReports.length} report(s) to ${this.selectedOffices.length} office(s)?`,
                subtitle: 'This action cannot be undone',
                confirmText: 'Confirm Assignment',
                cancelText: 'Cancel',
                type: 'success',
                icon: 'check-circle'
            });

            if (!confirmed) {
                return; // User cancelled
            }
        } else {
            // Fallback to browser confirm
            if (!confirm(`Are you sure you want to assign ${this.selectedReports.length} report(s) to ${this.selectedOffices.length} office(s)?`)) {
                return;
            }
        }

        try {
            const payload = {
                reports: this.selectedReports,
                offices: this.selectedOffices,
                hasDeadline: hasDeadline,
                deadline: hasDeadline ? deadline : null,
                priority: priority,
                notes: notes
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
                this.showNotification('Reports assigned successfully!', 'success');
                this.selectedReports = [];
                this.selectedOffices = [];
                this.goToStep(1);
                this.renderReportsList();
                this.renderOfficesList();
                
                // Sync: Notify user dashboard about new task assignments
                if (this.sync) {
                    this.sync.broadcast('task_assigned', { timestamp: Date.now() });
                }
            } else {
                this.showNotification('Failed to assign reports: ' + (result.error || result.message), 'error');
            }
        } catch (error) {
            console.error('Error assigning reports:', error);
            this.showNotification('Error assigning reports: ' + error.message, 'error');
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
                    // Filter by accessible campuses (normalized)
                    const norm = (s) => (s || '').toString().trim().toLowerCase().replace(/\s*campus\s*$/,'').replace(/[^a-z0-9]/g,'');
                    const accessible = (this.getAccessibleCampuses() || []).map(norm);
                    this.submissions = (result.data || []).filter(sub => {
                        const k = norm(sub.campus);
                        return accessible.some(a => k.includes(a) || a.includes(k));
                    });
                    console.log(`Campus Admin (${this.userCampus}) - Loaded ${this.submissions.length} submissions from accessible campuses:`, accessible);
                }
                
                // Store all submissions before filtering
                console.log('Sample submission data:', this.submissions.length > 0 ? {
                    id: this.submissions[0].id,
                    campus: this.submissions[0].campus,
                    status: this.submissions[0].status,
                    table_name: this.submissions[0].table_name,
                    record_count: this.submissions[0].record_count
                } : 'No submissions');
                
                // Setup campus filter dropdown after loading
                setTimeout(() => {
                    this.setupSubmissionsCampusFilter();
                }, 100);
                
                // Initialize filtered submissions with all accessible submissions
                this.filteredSubmissions = [...this.submissions];
                this.updateSubmissionStats();
                // Apply default date sorting (newest first)
                this.sortSubmissionsByDate();
                // Render the submissions table
                console.log('About to render submissions, count:', this.filteredSubmissions.length);
                this.renderSubmissions();
                console.log('Submissions rendered, checking buttons...');
                // Render report-type cards summary
                this.renderReportTypeCards();
                
                // Refresh analytics if dashboard section is visible
                this.refreshAnalyticsIfVisible();
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
        const totalCountEl = document.getElementById('totalCount');
        if (totalCountEl) totalCountEl.textContent = this.submissions.length;
    }

    renderSubmissions() {
        // Check if submissions table exists (may have been removed)
        const tbody = document.getElementById('submissionsTableBody');
        if (!tbody) {
            // Table doesn't exist - submissions are shown in cards instead
            // This is expected since we removed the table HTML from admin-dashboard.html
            return;
        }
        
        // Ensure table container is visible and clickable
        const tableContainer = tbody.closest('.submissions-table-container') || tbody.closest('.table-wrapper');
        if (tableContainer) {
            tableContainer.style.display = 'block';
            tableContainer.style.pointerEvents = 'auto';
            tableContainer.style.visibility = 'visible';
            console.log('Made table container visible and clickable');
        }
        
        // Ensure table itself is clickable
        const table = tbody.closest('table');
        if (table) {
            table.style.pointerEvents = 'auto';
            console.log('Made table clickable');
        }
        
        console.log('renderSubmissions called, filteredSubmissions count:', this.filteredSubmissions.length);

        if (this.filteredSubmissions.length === 0) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="7" style="text-align: center; padding: 40px;">
                        <i class="fas fa-inbox" style="font-size: 48px; color: #ccc; margin-bottom: 15px; display: block;"></i>
                        <p style="color: #666; margin: 0;">No submissions found</p>
                    </td>
                </tr>
            `;
            return;
        }

        // Clear existing content
        tbody.innerHTML = '';

        console.log('Starting to render submissions, isSuperAdmin:', this.isSuperAdmin, 'userRole:', this.userRole);
        
        this.filteredSubmissions.forEach((submission, index) => {
            const row = document.createElement('tr');
            row.setAttribute('data-row-index', index);

            const canDelete = !!(this.isSuperAdmin || (this.userRole && this.userRole.toLowerCase && this.userRole.toLowerCase().includes('admin')));
            // Try multiple ways to get submission ID
            const rawId = submission.id || submission.submission_id || submission.ID || submission.SubmissionID || submission.submissionId || 0;
            const subId = Number.parseInt(rawId, 10);
            const hasId = Number.isFinite(subId) && subId > 0;
            const reportName = this.formatTableName(submission.table_name);
            
            if (index === 0) {
                console.log('First submission - canDelete:', canDelete, 'hasId:', hasId, 'subId:', subId, 'rawId:', rawId, 'submission object:', {
                    id: submission.id,
                    submission_id: submission.submission_id,
                    ID: submission.ID,
                    SubmissionID: submission.SubmissionID,
                    submissionId: submission.submissionId
                });
            }
            
            // Log if ID is missing
            if (!hasId) {
                console.warn('Submission at index', index, 'has no valid ID. Submission:', submission);
            }

            // Create action buttons as separate elements
            const actionsDiv = document.createElement('div');
            actionsDiv.className = 'submission-actions';
            actionsDiv.style.cssText = 'display: flex; gap: 8px; align-items: center;';

            // View button
            const viewBtn = document.createElement('button');
            viewBtn.className = 'btn-sm btn-view';
            viewBtn.innerHTML = '<i class="fas fa-eye"></i> View';
            viewBtn.type = 'button';
            if (hasId) {
                viewBtn.addEventListener('click', (e) => {
                    e.preventDefault();
                    e.stopPropagation();
                    if (window.adminDashboard) {
                        window.adminDashboard.viewSubmissionDetails(submission.table_name, subId);
                    }
                });
            } else {
                viewBtn.disabled = true;
            }
            actionsDiv.appendChild(viewBtn);

            // Export button
            const exportBtn = document.createElement('button');
            exportBtn.className = 'btn-sm btn-download';
            exportBtn.innerHTML = '<i class="fas fa-download"></i> Export';
            exportBtn.type = 'button';
            if (hasId) {
                exportBtn.addEventListener('click', (e) => {
                    e.preventDefault();
                    e.stopPropagation();
                    if (window.adminDashboard) {
                        window.adminDashboard.downloadSubmission(subId);
                    }
                });
            } else {
                exportBtn.disabled = true;
            }
            actionsDiv.appendChild(exportBtn);

            // Delete button - Use clickable div to completely avoid restrictions
            if (canDelete && hasId) {
                // Use div with onclick - most reliable, can't be disabled
                const deleteBtn = document.createElement('div');
                deleteBtn.className = 'btn-sm btn-danger delete-submission-btn';
                deleteBtn.innerHTML = '<i class="fas fa-trash"></i> Delete';
                // Ensure subId is a valid number string
                deleteBtn.setAttribute('data-submission-id', String(subId));
                deleteBtn.setAttribute('data-report-name', String(reportName));
                deleteBtn.setAttribute('data-action', 'delete');
                deleteBtn.setAttribute('role', 'button');
                deleteBtn.setAttribute('tabindex', '0');
                deleteBtn.title = `Delete submission #${subId}`;
                
                // Also store in dataset for easy access
                deleteBtn.dataset.submissionId = String(subId);
                deleteBtn.dataset.reportName = String(reportName);
                
                // Remove any existing onclick to avoid conflicts
                deleteBtn.removeAttribute('onclick');
                deleteBtn.removeAttribute('disabled'); // Ensure not disabled
                
                // Debug log
                console.log('Created delete button with subId:', subId, 'hasId:', hasId, 'element:', deleteBtn);
                
                // Force ALL clickable styles with maximum priority - DIV STYLE
                Object.assign(deleteBtn.style, {
                    pointerEvents: 'auto',
                    cursor: 'pointer',
                    position: 'relative',
                    zIndex: '99999',
                    userSelect: 'none',
                    WebkitUserSelect: 'none',
                    MozUserSelect: 'none',
                    msUserSelect: 'none',
                    opacity: '1',
                    visibility: 'visible',
                    display: 'inline-flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    gap: '6px',
                    touchAction: 'manipulation',
                    background: 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)',
                    color: 'white',
                    border: 'none',
                    borderRadius: '8px',
                    padding: '10px 16px',
                    fontSize: '13px',
                    fontWeight: '600',
                    boxShadow: '0 4px 12px rgba(239, 68, 68, 0.3)',
                    transition: 'all 0.3s ease',
                    textDecoration: 'none',
                    outline: 'none'
                });
                
                // Ensure parent elements don't block
                if (actionsDiv) {
                    Object.assign(actionsDiv.style, {
                        display: 'flex',
                        gap: '8px',
                        alignItems: 'center',
                        pointerEvents: 'auto',
                        position: 'relative',
                        zIndex: '99998'
                    });
                }
                
                // Ensure table cell doesn't block
                const cell = row.querySelector('td:last-child');
                if (cell) {
                    Object.assign(cell.style, {
                        pointerEvents: 'auto',
                        position: 'relative',
                        zIndex: '99997'
                    });
                }
                
                // Ensure row doesn't block
                Object.assign(row.style, {
                    pointerEvents: 'auto',
                    position: 'relative'
                });
                
                if (hasId) {
                    // Create a direct, simple click handler that can't be blocked
                    const deleteHandler = function(e) {
                        // Prevent any default behavior
                        if (e) {
                            e.preventDefault();
                            e.stopPropagation();
                            e.stopImmediatePropagation();
                        }
                        
                        // Get submission ID from multiple sources
                        let btnSubId = parseInt(this.getAttribute('data-submission-id'), 10);
                        if (!btnSubId && this.dataset && this.dataset.submissionId) {
                            btnSubId = parseInt(this.dataset.submissionId, 10);
                        }
                        // Also get from closure if available
                        if (!btnSubId || btnSubId <= 0) {
                            btnSubId = subId; // Use the subId from the outer scope
                        }
                        
                        const btnReportName = this.getAttribute('data-report-name') || 
                                             this.dataset?.reportName || 
                                             reportName || 
                                             'Report';
                        
                        console.log('DELETE BUTTON CLICKED - Submission ID:', btnSubId, 'Report:', btnReportName, 'from attribute:', this.getAttribute('data-submission-id'), 'from dataset:', this.dataset?.submissionId, 'from closure:', subId);
                        
                        // Only proceed if we have a valid ID
                        if (!btnSubId || btnSubId <= 0) {
                            console.error('Cannot delete - invalid submission ID:', btnSubId);
                            alert('Error: Invalid submission ID. Please refresh the page.');
                            return;
                        }
                        
                        // Use the modal confirmation
                        if (window.adminDashboard && typeof window.adminDashboard.deleteSubmission === 'function') {
                            try {
                                console.log('Calling deleteSubmission with ID:', btnSubId, 'Report:', btnReportName);
                                window.adminDashboard.deleteSubmission(btnSubId, btnReportName);
                            } catch (err) {
                                console.error('Error calling deleteSubmission:', err);
                                alert('Error deleting submission: ' + err.message);
                            }
                        } else {
                            console.error('Cannot delete - adminDashboard:', !!window.adminDashboard, 'function exists:', typeof window.adminDashboard?.deleteSubmission);
                            alert('Error: Delete function not available');
                        }
                        
                        return false;
                    };
                    
                    // Bind handler directly - MULTIPLE METHODS for anchor tag
                    deleteBtn.onclick = deleteHandler;
                    deleteBtn.addEventListener('click', deleteHandler, true); // Capture
                    deleteBtn.addEventListener('click', deleteHandler, false); // Bubble
                    
                    // Also handle mousedown
                    deleteBtn.addEventListener('mousedown', function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        console.log('Delete anchor mousedown for submission', subId);
                    }, true);
                    
                    // Handle touch events for mobile
                    deleteBtn.addEventListener('touchend', function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        deleteHandler.call(this, e);
                    }, true);
                    
                    // FORCE anchor to be interactive
                    deleteBtn.setAttribute('tabindex', '0');
                    deleteBtn.setAttribute('role', 'button');
                    deleteBtn.setAttribute('aria-label', `Delete submission ${subId}`);
                    
                    // Test hover immediately after creation
                    setTimeout(() => {
                        const testHover = () => {
                            console.log('Test: Delete anchor is hoverable for submission', subId);
                            const rect = deleteBtn.getBoundingClientRect();
                            console.log('Anchor position:', rect, 'visible:', rect.width > 0 && rect.height > 0);
                        };
                        deleteBtn.addEventListener('mouseenter', testHover, { once: true });
                    }, 100);
                    
                    console.log('Delete div created and bound for submission', subId, 'Element:', deleteBtn.tagName, deleteBtn);
                    
                    // IMMEDIATE CLICK TEST - Add a visible test
                    deleteBtn.addEventListener('mouseenter', function() {
                        console.log('MOUSE ENTERED delete div for submission', subId);
                        this.style.background = 'linear-gradient(135deg, #dc2626 0%, #b91c1c 100%)';
                    });
                    deleteBtn.addEventListener('mouseleave', function() {
                        this.style.background = 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)';
                    });
                } else {
                    // For divs, we can't use disabled, so use visual styling instead
                    deleteBtn.style.opacity = '0.5';
                    deleteBtn.style.cursor = 'not-allowed';
                    deleteBtn.style.pointerEvents = 'none';
                    deleteBtn.title = 'Cannot delete: Invalid submission ID';
                    deleteBtn.setAttribute('data-disabled', 'true');
                }
                actionsDiv.appendChild(deleteBtn);
            }

            // Build row cells - create cells manually to avoid innerHTML removing our buttons
            const cells = [
                { content: reportName },
                { content: submission.campus || '-' },
                { content: submission.office || '-' },
                { content: submission.user_name || '-' },
                { content: submission.record_count || 0, style: 'text-align: center;' },
                { content: new Date(submission.submitted_at).toLocaleString() },
                { content: null } // Actions cell - will append actionsDiv
            ];
            
            cells.forEach((cell, idx) => {
                const td = document.createElement('td');
                if (cell.style) {
                    td.style.cssText = cell.style;
                }
                if (cell.content !== null) {
                    td.textContent = cell.content;
                }
                // Last cell gets the actions div
                if (idx === cells.length - 1) {
                    // Ensure Actions cell is vertically aligned
                    td.style.verticalAlign = 'middle';
                    td.style.textAlign = 'center';
                    td.appendChild(actionsDiv);
                }
                row.appendChild(td);
            });

            tbody.appendChild(row);
        });

        // DON'T call sanitizeDeleteButtons - it might disable our divs
        // this.sanitizeDeleteButtons('#submissionsTableBody');
        
        // Also set up event delegation on the tbody as a backup - works with divs
        if (!tbody.hasAttribute('data-delete-listener')) {
            tbody.setAttribute('data-delete-listener', 'true');
            
            // Multiple delegation strategies - works with div, button, or anchor
            const handleDelegation = (e) => {
                // Try to find delete element from clicked element
                let deleteBtn = e.target;
                
                // If clicking icon, find parent
                if (deleteBtn.tagName === 'I' || deleteBtn.tagName === 'SPAN') {
                    deleteBtn = deleteBtn.closest('.btn-danger') || deleteBtn.closest('[data-submission-id]');
                }
                
                // If still not found, use closest
                if (!deleteBtn || (!deleteBtn.classList.contains('btn-danger') && !deleteBtn.hasAttribute('data-submission-id'))) {
                    deleteBtn = e.target.closest('.btn-danger[data-submission-id]') || e.target.closest('[data-submission-id]');
                }
                
                // Check if it's a delete element (div, button, or anchor)
                if (deleteBtn && deleteBtn.hasAttribute('data-submission-id')) {
                    // Divs don't have disabled, but check for buttons/anchors
                    if (deleteBtn.disabled) {
                        return;
                    }
                    
                    e.preventDefault();
                    e.stopPropagation();
                    e.stopImmediatePropagation();
                    
                    const subId = parseInt(deleteBtn.getAttribute('data-submission-id'), 10);
                    const reportName = deleteBtn.getAttribute('data-report-name') || 'Report';
                    
                    if (subId && window.adminDashboard && typeof window.adminDashboard.deleteSubmission === 'function') {
                        console.log('Delete via delegation for submission:', subId, 'Element type:', deleteBtn.tagName);
                        window.adminDashboard.deleteSubmission(subId, reportName);
                        return false;
                    }
                }
            };
            
            tbody.addEventListener('click', handleDelegation, true); // Capture phase
            tbody.addEventListener('click', handleDelegation, false); // Bubble phase
            tbody.addEventListener('mousedown', (e) => {
                if (e.target.closest('.btn-danger[data-submission-id]') || e.target.closest('[data-action="delete"]')) {
                    e.stopPropagation();
                }
            }, true);
        }
        
        // Add CSS to override any blocking styles - MAXIMUM PRIORITY
        if (!document.getElementById('delete-button-override-styles')) {
            const style = document.createElement('style');
            style.id = 'delete-button-override-styles';
            style.textContent = `
                /* Force delete buttons/anchors/divs to be clickable - override everything */
                #submissionsTableBody .btn-danger,
                #submissionsTableBody .delete-submission-btn,
                #submissionsTableBody button[data-action="delete"],
                #submissionsTableBody a.btn-danger,
                #submissionsTableBody a.delete-submission-btn,
                #submissionsTableBody a[data-action="delete"],
                #submissionsTableBody div.btn-danger,
                #submissionsTableBody div.delete-submission-btn,
                #submissionsTableBody div[data-action="delete"],
                #submissionsTableBody [data-submission-id] {
                    pointer-events: auto !important;
                    cursor: pointer !important;
                    position: relative !important;
                    z-index: 99999 !important;
                    opacity: 1 !important;
                    visibility: visible !important;
                    touch-action: manipulation !important;
                    user-select: none !important;
                    -webkit-user-select: none !important;
                    -moz-user-select: none !important;
                    -ms-user-select: none !important;
                    display: inline-flex !important;
                    text-decoration: none !important;
                }
                /* Disabled state for divs */
                #submissionsTableBody [data-disabled="true"] {
                    pointer-events: none !important;
                    cursor: not-allowed !important;
                    opacity: 0.5 !important;
                }
                #submissionsTableBody .btn-danger:disabled,
                #submissionsTableBody .delete-submission-btn:disabled {
                    pointer-events: none !important;
                    cursor: not-allowed !important;
                    opacity: 0.5 !important;
                }
                #submissionsTableBody .submission-actions,
                #submissionsTableBody .submission-actions * {
                    pointer-events: auto !important;
                    position: relative !important;
                    z-index: 99998 !important;
                }
                #submissionsTableBody tr td:last-child,
                #submissionsTableBody tr td:last-child * {
                    pointer-events: auto !important;
                    position: relative !important;
                    z-index: 99997 !important;
                }
                #submissionsTableBody tr {
                    pointer-events: auto !important;
                    position: relative !important;
                }
                /* Ensure table and wrapper don't block */
                table.formal-table,
                .table-wrapper,
                .submissions-table-container {
                    pointer-events: auto !important;
                }
                table.formal-table tbody,
                table.formal-table tbody tr,
                table.formal-table tbody td {
                    pointer-events: auto !important;
                }
            `;
            document.head.appendChild(style);
            console.log('Added delete button override styles with maximum priority');
        }
        
        // Also check for any overlays that might be blocking
        setTimeout(() => {
            // Check ALL elements that might be blocking
            const allElements = document.querySelectorAll('*');
            const blockingElements = [];
            
            allElements.forEach(el => {
                const style = window.getComputedStyle(el);
                const rect = el.getBoundingClientRect();
                const tbody = document.getElementById('submissionsTableBody');
                const tbodyRect = tbody ? tbody.getBoundingClientRect() : null;
                
                // Check if element overlaps with table and blocks clicks
                if (tbodyRect && rect.width > 0 && rect.height > 0) {
                    const overlaps = !(rect.right < tbodyRect.left || rect.left > tbodyRect.right || rect.bottom < tbodyRect.top || rect.top > tbodyRect.bottom);
                    
                    if (overlaps && (
                        style.pointerEvents === 'none' ||
                        style.zIndex > 1000 ||
                        (el.id && (el.id.includes('overlay') || el.id.includes('modal') || el.id.includes('loading'))) ||
                        (el.className && (el.className.includes('overlay') || el.className.includes('modal') || el.className.includes('loading')))
                    )) {
                        blockingElements.push({
                            element: el,
                            id: el.id,
                            className: el.className,
                            zIndex: style.zIndex,
                            pointerEvents: style.pointerEvents,
                            display: style.display,
                            position: style.position
                        });
                    }
                }
            });
            
            if (blockingElements.length > 0) {
                console.warn('Found potentially blocking elements:', blockingElements);
                // Try to fix them
                blockingElements.forEach(item => {
                    if (item.element.id && (item.element.id.includes('overlay') || item.element.id.includes('modal'))) {
                        const display = window.getComputedStyle(item.element).display;
                        if (display !== 'none') {
                            console.warn('Found visible overlay/modal that might be blocking:', item.element.id);
                        }
                    }
                });
            }
            
            const overlays = document.querySelectorAll('[class*="overlay"], [class*="modal"], [id*="overlay"], [id*="modal"], [class*="loading"]');
            overlays.forEach(overlay => {
                const style = window.getComputedStyle(overlay);
                if (style.display !== 'none') {
                    console.warn('Found visible overlay/modal:', overlay.id || overlay.className, 'display:', style.display, 'z-index:', style.zIndex, 'pointer-events:', style.pointerEvents);
                }
            });
            
            // Test if buttons/anchors/divs are actually clickable and FORCE them to be clickable
            const testButtons = document.querySelectorAll('#submissionsTableBody .btn-danger, #submissionsTableBody .delete-submission-btn, #submissionsTableBody button[data-action="delete"], #submissionsTableBody a.btn-danger, #submissionsTableBody a[data-action="delete"], #submissionsTableBody div.btn-danger, #submissionsTableBody div[data-action="delete"], #submissionsTableBody [data-submission-id]');
            console.log(`Found ${testButtons.length} delete elements (buttons/anchors/divs) in table`);
            testButtons.forEach((btn, idx) => {
                const computed = window.getComputedStyle(btn);
                const rect = btn.getBoundingClientRect();
                const subId = btn.getAttribute('data-submission-id');
                console.log(`Button ${idx} (ID: ${subId}) - pointer-events: ${computed.pointerEvents}, cursor: ${computed.cursor}, z-index: ${computed.zIndex}, visible: ${rect.width > 0 && rect.height > 0}, disabled: ${btn.disabled}`);
                
                // FORCE make it clickable - override any blocking styles
                btn.style.setProperty('pointer-events', 'auto', 'important');
                btn.style.setProperty('cursor', 'pointer', 'important');
                btn.style.setProperty('z-index', '99999', 'important');
                btn.style.setProperty('position', 'relative', 'important');
                
                // Remove any disabled attribute if it shouldn't be disabled
                if (!subId || btn.disabled) {
                    if (!subId) {
                        console.warn(`Button ${idx} has no submission ID`);
                    }
                } else {
                    // Re-attach click handler as absolute backup
                    const reportName = btn.getAttribute('data-report-name') || 'Report';
                    const finalSubId = parseInt(subId, 10);
                    
                    // Don't clone - just re-attach handlers directly
                    // Remove all event listeners by cloning (but keep the element)
                    const handlers = ['click', 'mousedown', 'mouseup', 'touchend'];
                    handlers.forEach(eventType => {
                        // Get new element reference
                        const newElement = document.querySelector(`[data-submission-id="${finalSubId}"]`);
                        if (newElement) {
                            // Remove old listeners by cloning
                            const clone = newElement.cloneNode(true);
                            newElement.parentNode.replaceChild(clone, newElement);
                            
                            // Add fresh handlers to clone
                            clone.onclick = function(e) {
                                e?.preventDefault();
                                e?.stopPropagation();
                                e?.stopImmediatePropagation();
                                console.log('FORCED CLICK HANDLER FIRED - Deleting submission:', finalSubId);
                                if (window.adminDashboard && typeof window.adminDashboard.deleteSubmission === 'function') {
                                    window.adminDashboard.deleteSubmission(finalSubId, reportName);
                                } else {
                                    console.error('adminDashboard.deleteSubmission not available');
                                    alert('Delete function not available. Please refresh the page.');
                                }
                                return false;
                            };
                            
                            clone.addEventListener('click', function(e) {
                                e?.preventDefault();
                                e?.stopPropagation();
                                console.log('AddEventListener handler fired for submission:', finalSubId);
                            }, true);
                            
                            // Force styles again
                            clone.style.setProperty('pointer-events', 'auto', 'important');
                            clone.style.setProperty('cursor', 'pointer', 'important');
                            clone.style.setProperty('z-index', '99999', 'important');
                            
                            console.log(`Element ${idx} (ID: ${finalSubId}) - FORCED TO BE CLICKABLE, type: ${clone.tagName}`);
                        }
                    });
                }
            });
        }, 1000);
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

    /**
     * Show delete confirmation modal
     */
    showDeleteConfirmModal(reportName, submissionId) {
        return new Promise((resolve) => {
            // Create modal overlay
            const modal = document.createElement('div');
            modal.id = 'deleteConfirmModal';
            modal.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                backdrop-filter: blur(4px);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 100000;
                opacity: 0;
                transition: opacity 0.3s ease;
            `;
            
            // Create modal content
            modal.innerHTML = `
                <div style="
                    background: white;
                    border-radius: 16px;
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                    max-width: 480px;
                    width: 90%;
                    padding: 0;
                    overflow: hidden;
                    transform: scale(0.9);
                    transition: transform 0.3s ease;
                ">
                    <!-- Header -->
                    <div style="
                        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                        padding: 24px 30px;
                        display: flex;
                        align-items: center;
                        gap: 15px;
                    ">
                        <div style="
                            width: 48px;
                            height: 48px;
                            background: rgba(255, 255, 255, 0.2);
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 24px;
                            color: white;
                        ">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div>
                            <h3 style="
                                margin: 0;
                                color: white;
                                font-size: 20px;
                                font-weight: 700;
                                font-family: 'Inter', sans-serif;
                            ">Delete Submission</h3>
                            <p style="
                                margin: 4px 0 0 0;
                                color: rgba(255, 255, 255, 0.9);
                                font-size: 14px;
                            ">This action cannot be undone</p>
                        </div>
                    </div>
                    
                    <!-- Body -->
                    <div style="padding: 30px;">
                        <p style="
                            margin: 0 0 20px 0;
                            color: #374151;
                            font-size: 16px;
                            line-height: 1.6;
                            font-family: 'Inter', sans-serif;
                        ">
                            Are you sure you want to delete <strong style="color: #dc2626;">${reportName}</strong> submission <strong style="color: #dc2626;">#${submissionId}</strong>?
                        </p>
                        <div style="
                            background: #fef2f2;
                            border: 1px solid #fecaca;
                            border-radius: 8px;
                            padding: 12px 16px;
                            margin-bottom: 20px;
                        ">
                            <p style="
                                margin: 0;
                                color: #991b1b;
                                font-size: 14px;
                                display: flex;
                                align-items: center;
                                gap: 8px;
                            ">
                                <i class="fas fa-info-circle"></i>
                                <span>All associated data will be permanently deleted and cannot be recovered.</span>
                            </p>
                        </div>
                    </div>
                    
                    <!-- Footer -->
                    <div style="
                        padding: 20px 30px;
                        background: #f9fafb;
                        border-top: 1px solid #e5e7eb;
                        display: flex;
                        gap: 12px;
                        justify-content: flex-end;
                    ">
                        <button id="deleteConfirmCancel" style="
                            padding: 10px 24px;
                            background: white;
                            border: 2px solid #d1d5db;
                            border-radius: 8px;
                            color: #374151;
                            font-size: 14px;
                            font-weight: 600;
                            cursor: pointer;
                            transition: all 0.2s ease;
                            font-family: 'Inter', sans-serif;
                        " onmouseover="this.style.background='#f9fafb'; this.style.borderColor='#9ca3af';" onmouseout="this.style.background='white'; this.style.borderColor='#d1d5db';">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button id="deleteConfirmDelete" style="
                            padding: 10px 24px;
                            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                            border: none;
                            border-radius: 8px;
                            color: white;
                            font-size: 14px;
                            font-weight: 600;
                            cursor: pointer;
                            transition: all 0.2s ease;
                            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
                            font-family: 'Inter', sans-serif;
                        " onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 16px rgba(239, 68, 68, 0.4)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 12px rgba(239, 68, 68, 0.3)';">
                            <i class="fas fa-trash"></i> Delete Submission
                        </button>
                    </div>
                </div>
            `;
            
            document.body.appendChild(modal);
            
            // Animate in
            setTimeout(() => {
                modal.style.opacity = '1';
                const content = modal.querySelector('div > div');
                if (content) content.style.transform = 'scale(1)';
            }, 10);
            
            // Handle cancel
            const cancelBtn = document.getElementById('deleteConfirmCancel');
            const cancelHandler = () => {
                modal.style.opacity = '0';
                const content = modal.querySelector('div > div');
                if (content) content.style.transform = 'scale(0.9)';
                setTimeout(() => {
                    modal.remove();
                    resolve(false);
                }, 300);
            };
            cancelBtn.addEventListener('click', cancelHandler);
            
            // Handle delete
            const deleteBtn = document.getElementById('deleteConfirmDelete');
            const deleteHandler = () => {
                // Show loading state
                deleteBtn.disabled = true;
                deleteBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Deleting...';
                
                // Resolve with true after a brief delay to allow UI update
                setTimeout(() => {
                    modal.style.opacity = '0';
                    const content = modal.querySelector('div > div');
                    if (content) content.style.transform = 'scale(0.9)';
                    setTimeout(() => {
                        modal.remove();
                        resolve(true);
                    }, 300);
                }, 100);
            };
            deleteBtn.addEventListener('click', deleteHandler);
            
            // Close on backdrop click
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    cancelHandler();
                }
            });
            
            // Close on Escape key
            const escapeHandler = (e) => {
                if (e.key === 'Escape') {
                    e.preventDefault();
                    cancelHandler();
                    document.removeEventListener('keydown', escapeHandler);
                }
            };
            document.addEventListener('keydown', escapeHandler);
        });
    }

    /**
     * Delete a specific row from target table
     */
    async deleteRow(rowId, tableName, rowElement = null) {
        try {
            const rid = Number.parseInt(rowId, 10);
            if (!Number.isFinite(rid) || rid <= 0) {
                console.warn('deleteRow called with invalid id:', rowId);
                this.showNotification('Unable to delete: missing row ID.', 'error');
                return;
            }

            if (!tableName || tableName === 'unknown') {
                this.showNotification('Unable to delete: missing table name.', 'error');
                return;
            }

            // Call API to delete the row
            const response = await fetch('api/admin_submissions.php?action=delete_row', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'include',
                body: JSON.stringify({ 
                    row_id: rid,
                    table_name: tableName
                })
            });

            const result = await response.json();

            if (!response.ok || !result.success) {
                throw new Error(result.error || 'Failed to delete row');
            }

            // Remove the row from DOM if element is provided
            if (rowElement) {
                rowElement.style.transition = 'opacity 0.3s ease';
                rowElement.style.opacity = '0';
                setTimeout(() => {
                    rowElement.remove();
                    // Update row count display if exists
                    const tbody = document.getElementById('combinedDataTableBody');
                    if (tbody) {
                        const remainingRows = tbody.querySelectorAll('.data-row:not([style*="display: none"])').length;
                        if (remainingRows === 0) {
                            // All rows deleted, close the modal
                            const modal = document.getElementById('combinedDataModal');
                            if (modal) {
                                modal.style.display = 'none';
                            }
                        }
                    }
                }, 300);
            } else {
                // If no element provided, reload the modal data
                const modal = document.getElementById('combinedDataModal');
                if (modal && modal.dataset.reportTypeName) {
                    // Reload the combined data to refresh the view
                    const reportTypeName = modal.dataset.reportTypeName;
                    if (this.viewCombinedData) {
                        await this.viewCombinedData(reportTypeName);
                    }
                }
            }

            this.showNotification(`Row deleted successfully`, 'success');
            
            // Refresh submissions and report type cards to update record counts
            // This ensures the cards show the correct total records after deletion
            try {
                await this.loadSubmissions();
                // Re-render report type cards with updated counts
                this.renderReportTypeCards();
                // Analytics will be refreshed automatically by loadSubmissions -> refreshAnalyticsIfVisible
            } catch (refreshError) {
                console.error('Error refreshing submissions after row deletion:', refreshError);
                // Don't show error to user - deletion was successful
            }
        } catch (error) {
            console.error('Delete row error:', error);
            this.showNotification(`Error deleting row: ${error.message}`, 'error');
        }
    }

    async deleteSubmission(submissionId, reportName = 'Report') {
        try {
            const sid = Number.parseInt(submissionId, 10);
            if (!Number.isFinite(sid) || sid <= 0) {
                console.warn('deleteSubmission called with invalid id:', submissionId);
                if (typeof window.showAlert === 'function') window.showAlert('Unable to delete: missing submission ID.', 'error');
                else alert('Unable to delete: missing submission ID.');
                return;
            }
            
            // Show custom confirmation modal
            const confirmed = await this.showDeleteConfirmModal(reportName, sid);
            if (!confirmed) return;

            // First attempt: send JSON body AND query param for robustness
            let res = await fetch(`api/admin_submissions.php?action=delete&submission_id=${encodeURIComponent(sid)}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'include',
                body: JSON.stringify({ submission_id: sid })
            });
            let text = await res.text();
            let json; try { json = JSON.parse(text); } catch { json = { success:false, error:'Invalid JSON', detail:text.slice(0,300) }; }

            // If backend still says ID missing, retry with URL-encoded form (some proxies strip JSON bodies)
            if ((!res.ok && res.status === 400) && /submission id required/i.test(json.error || json.message || '')) {
                const form = new URLSearchParams();
                form.set('submission_id', String(sid));
                res = await fetch(`api/admin_submissions.php?action=delete&submission_id=${encodeURIComponent(sid)}`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    credentials: 'include',
                    body: form.toString()
                });
                text = await res.text();
                try { json = JSON.parse(text); } catch { json = { success:false, error:'Invalid JSON', detail:text.slice(0,300) }; }
            }

            if (!res.ok || !json.success) {
                const msg = json && (json.error || json.message) ? (json.error || json.message) : `Failed with status ${res.status}`;
                throw new Error(msg + (json.detail ? `\n${json.detail}` : ''));
            }
            if (typeof window.showAlert === 'function') {
                window.showAlert('Submission deleted', 'success');
            } else {
                alert('Submission deleted');
            }
            // Refresh list
            try {
            if (typeof this.loadSubmissions === 'function') {
                await this.loadSubmissions();
                } else {
                    console.warn('loadSubmissions function not found, reloading page...');
                    window.location.reload();
                }
            } catch (refreshError) {
                console.error('Error refreshing submissions list:', refreshError);
                // Still show success but reload page as fallback
                window.location.reload();
            }
        } catch (e) {
            console.error('Delete submission error:', e);
            if (typeof window.showAlert === 'function') {
                window.showAlert('Delete failed: ' + e.message, 'error');
            } else {
                alert('Delete failed: ' + e.message);
            }
        }
    }

    formatTableName(tableName) {
        const tableNames = {
            'admissiondata': 'Admission Data',
            'enrollmentdata': 'Enrollment Data',
            'graduatesdata': 'Graduates Data',
            'employee': 'Employee Data',
            'leaveprivilege': 'Leave Privilege',
            'libraryvisitor': 'Library Visitor',
            'pwd': 'PWD',
            'waterconsumption': 'Water Consumption',
            'treatedwastewater': 'Treated Waste Water',
            'electricityconsumption': 'Electricity Consumption',
            'solidwaste': 'Solid Waste',
            'campuspopulation': 'Campus Population',
            'foodwaste': 'Food Waste',
            'fuelconsumption': 'Fuel Consumption',
            'distancetraveled': 'Distance Traveled',
            'budgetexpenditure': 'Budget Expenditure',
            'flightaccommodation': 'Flight Accommodation'
        };
        // Make lookup case-insensitive
        const tableNameLower = (tableName || '').toLowerCase();
        return tableNames[tableNameLower] || tableName;
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

    /**
     * Setup campus dropdown for submissions section
     */
    setupSubmissionsCampusFilter() {
        // Ensure session is loaded
        if (!this.userCampus && !this.isSuperAdmin) {
            this.getUserSession();
        }
        
        const campusFilter = document.getElementById('campusFilter');
        if (!campusFilter) {
            console.warn('campusFilter element not found');
            return;
        }
        
        const filterGroup = campusFilter.closest('.filter-group');
        if (!filterGroup) {
            console.warn('campusFilter filter-group not found');
            return;
        }
        
        const accessibleCampuses = this.getAccessibleCampuses();
        console.log('Setting up submissions campus filter. Accessible campuses:', accessibleCampuses, 'Should show dropdown:', this.shouldShowCampusDropdown());
        
        if (!this.shouldShowCampusDropdown()) {
            // Hide campus dropdown for solo campuses
            filterGroup.style.display = 'none';
            console.log('Hiding campus dropdown for solo campus');
            return;
        }
        
        // Show dropdown and populate with accessible campuses
        filterGroup.style.display = '';
        campusFilter.innerHTML = '<option value="">All Campus</option>';
        
        accessibleCampuses.forEach(campus => {
            const option = document.createElement('option');
            option.value = campus;
            option.textContent = campus;
            campusFilter.appendChild(option);
        });
        
        // Re-attach event listener after repopulating dropdown
        campusFilter.removeEventListener('change', this.filterSubmissions.bind(this));
        campusFilter.addEventListener('change', () => {
            console.log('Campus filter changed to:', campusFilter.value);
            this.filterSubmissions();
        });
        
        console.log('Populated campus dropdown with', accessibleCampuses.length, 'campuses');
    }

    sortSubmissionsByDate() {
        const sortOrder = document.getElementById('dateSortFilter')?.value || 'newest';
        
        // Sort the filtered submissions by date
        this.filteredSubmissions.sort((a, b) => {
            const dateA = new Date(a.submitted_at || a.submission_date || 0);
            const dateB = new Date(b.submitted_at || b.submission_date || 0);
            
            if (sortOrder === 'newest') {
                return dateB - dateA; // Newest first (descending)
            } else {
                return dateA - dateB; // Oldest first (ascending)
            }
        });
        
        this.renderSubmissions();
    }

    filterSubmissions() {
        const campusFilter = document.getElementById('campusFilter')?.value || '';
        const reportTypeFilter = document.getElementById('reportTypeFilter')?.value || '';
        
        console.log('=== Filtering Submissions ===');
        console.log('Filter values:', {
            campusFilter,
            reportTypeFilter,
            totalSubmissions: this.submissions.length
        });
        
        // Get accessible campuses for filtering
        const accessibleCampuses = this.getAccessibleCampuses();
        console.log('Accessible campuses:', accessibleCampuses);
        
        if (this.submissions.length > 0) {
            console.log('Sample submission campuses:', 
                [...new Set(this.submissions.slice(0, 10).map(s => s.campus || 'NULL'))]
            );
        }
        
        this.filteredSubmissions = this.submissions.filter(submission => {
            // Normalize campus comparison (trim and handle null/undefined)
            const subCampus = (submission.campus || '').toString().trim();
            const filterCampus = (campusFilter || '').toString().trim();
            const campusMatch = !campusFilter || subCampus.toLowerCase() === filterCampus.toLowerCase();
            
            const reportMatch = !reportTypeFilter || submission.table_name === reportTypeFilter;
            
            // Additional check: ensure submission campus is in accessible campuses (only if not super admin)
            let accessibleMatch = true;
            if (!this.isSuperAdmin && accessibleCampuses.length > 0) {
                accessibleMatch = accessibleCampuses.some(ac => 
                    ac.trim().toLowerCase() === subCampus.toLowerCase()
                );
            }
            
            const matches = campusMatch && reportMatch && accessibleMatch;
            
            if (campusFilter && matches) {
                console.log('✓ Match found:', {
                    submissionId: submission.id,
                    submissionCampus: subCampus,
                    filterCampus: filterCampus
                });
            }
            
            return matches;
        });
        
        console.log('=== Filter Results ===');
        console.log({
            filteredCount: this.filteredSubmissions.length,
            originalCount: this.submissions.length,
            filterActive: [
                campusFilter ? `Campus: "${campusFilter}"` : null,
                officeFilter ? `Office: "${officeFilter}"` : null
            ].filter(Boolean).join(' | ') || 'No filters'
        });
        
        if (this.filteredSubmissions.length === 0 && this.submissions.length > 0 && campusFilter) {
            console.warn('⚠️ No submissions matched the filter!');
            console.warn('Available campuses in data:', [...new Set(this.submissions.map(s => (s.campus || 'NULL').toString().trim()))]);
            console.warn('Trying to filter by:', campusFilter);
        }
        
        // Apply date sorting after filtering
        this.sortSubmissionsByDate();
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


    async downloadSubmission(submissionId) {
        try {
            // Fetch the CSV with credentials to ensure session is sent
            const exportUrl = `api/admin_submissions.php?action=export&submission_id=${submissionId}`;
            
            const response = await fetch(exportUrl, {
                method: 'GET',
                credentials: 'include',
                headers: {
                    'Accept': 'text/csv'
                }
            });
            
            // Check if response is ok
            if (!response.ok) {
                // Try to get error message from response
                const contentType = response.headers.get('content-type');
                if (contentType && contentType.includes('application/json')) {
                    const errorData = await response.json();
                    throw new Error(errorData.error || `HTTP error! status: ${response.status}`);
                } else {
                    const errorText = await response.text();
                    throw new Error(errorText || `HTTP error! status: ${response.status}`);
                }
            }
            
            // Get the CSV blob
            const blob = await response.blob();
            
            // Create download link
            const url = window.URL.createObjectURL(blob);
            const link = document.createElement('a');
            
            // Get filename from response headers or create default
            const contentDisposition = response.headers.get('content-disposition');
            let filename = `submission_${submissionId}_${new Date().toISOString().split('T')[0]}.csv`;
            
            if (contentDisposition) {
                const filenameMatch = contentDisposition.match(/filename="?([^"]+)"?/i);
                if (filenameMatch) {
                    filename = filenameMatch[1];
                }
            }
            
            link.href = url;
            link.download = filename;
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            
            // Cleanup
            setTimeout(() => {
                document.body.removeChild(link);
                window.URL.revokeObjectURL(url);
            }, 100);
            
            // Show success notification
            this.showNotification(`Exported submission #${submissionId} successfully`, 'success');
        } catch (error) {
            console.error('Export error:', error);
            this.showNotification(`Error exporting submission: ${error.message}`, 'error');
        }
    }

    /**
     * Export submissions table to CSV
     */
    exportSubmissionsToCSV() {
        const table = document.querySelector('.submissions-table-container table');
        if (!table) {
            alert('No submissions table found');
            return;
        }

        const rows = table.querySelectorAll('tbody tr');
        if (rows.length === 0) {
            alert('No submissions to export');
            return;
        }

        let csvContent = [];
        
        // Get headers
        const headers = ['ID', 'Report Type', 'Campus', 'Office', 'Submitted By', 'Date', 'Status'];
        csvContent.push(headers.join(','));

        // Get data rows
        rows.forEach(row => {
            const cells = row.querySelectorAll('td');
            if (cells.length >= 7) {
                const rowData = [];
                
                // ID
                rowData.push(cells[0].textContent.trim());
                
                // Report Type
                rowData.push(this.escapeCSV(cells[1].textContent.trim()));
                
                // Campus
                rowData.push(this.escapeCSV(cells[2].textContent.trim()));
                
                // Office
                rowData.push(this.escapeCSV(cells[3].textContent.trim()));
                
                // Submitted By
                rowData.push(this.escapeCSV(cells[4].textContent.trim()));
                
                // Date
                rowData.push(cells[5].textContent.trim());
                
                // Status (extract from badge)
                const statusBadge = cells[6].querySelector('.status-badge');
                const status = statusBadge ? statusBadge.textContent.trim() : cells[6].textContent.trim();
                rowData.push(status);
                
                csvContent.push(rowData.join(','));
            }
        });

        // Create blob and download
        const csv = csvContent.join('\n');
        const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement('a');
        
        if (link.download !== undefined) {
            const url = URL.createObjectURL(blob);
            const fileName = `report_submissions_${new Date().toISOString().split('T')[0]}.csv`;
            
            link.setAttribute('href', url);
            link.setAttribute('download', fileName);
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            
            // Show success notification
            this.showNotification(`Exported ${rows.length} submissions to ${fileName}`, 'success');
        }
    }

    /**
     * Escape CSV special characters
     */
    escapeCSV(value) {
        if (typeof value !== 'string') return value;
        
        // Escape quotes and wrap in quotes if contains comma, quote, or newline
        value = value.replace(/"/g, '""');
        if (value.includes(',') || value.includes('"') || value.includes('\n')) {
            value = `"${value}"`;
        }
        return value;
    }

    // Show combined data modal with per-column filters and CSV/PDF export
    showCombinedDataModal(data, reportTypeName, submissionCount, totalRecords) {
        // Log admin status and data info for debugging
        const canDelete = !!(this.isSuperAdmin || (this.userRole && this.userRole.toLowerCase && this.userRole.toLowerCase().includes('admin')));
        console.log('showCombinedDataModal called - isSuperAdmin:', this.isSuperAdmin, 'userRole:', this.userRole, 'canDelete:', canDelete);
        
        // Log sample data to check for submission IDs
        if (data && data.length > 0) {
            console.log('Combined modal - Total rows:', data.length);
            console.log('Sample data row (first):', data[0]);
            console.log('Has __submission_id:', data[0].hasOwnProperty('__submission_id'), 'Value:', data[0].__submission_id);
            if (data[0].__submission_id) {
                console.log('First row submission ID:', data[0].__submission_id, 'Type:', typeof data[0].__submission_id);
            } else {
                console.warn('First row missing __submission_id. Available fields:', Object.keys(data[0]));
            }
        } else {
            console.warn('showCombinedDataModal called with empty or null data');
        }
        
        let modal = document.getElementById('combinedDataModal');
        if (!modal) {
            modal = document.createElement('div');
            modal.id = 'combinedDataModal';
            modal.className = 'edit-modal';
            modal.style.cssText = 'display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.7); z-index: 10000; align-items: center; justify-content: center;';
            document.body.appendChild(modal);
        }
        
        modal.innerHTML = `
            <div class="modal-content-formal" style="max-width: 95%; max-height: 95vh; width: 1600px; background: white; border-radius: 16px; overflow: hidden; display: flex; flex-direction: column; box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);">
                <div class="modal-header-formal" style="padding: 20px 30px; background: linear-gradient(135deg, #dc143c 0%, #a00000 100%); color: white; display: flex; align-items: center; justify-content: space-between;">
                    <div style="display: flex; justify-content: flex-start; align-items: center;">
                        <h3 style="margin: 0; font-size: 24px; font-weight: 700; color: white;">
                            <i class="fas fa-database" style="margin-right: 10px;"></i> All Combined Data - ${reportTypeName}
                        </h3>
                    </div>
                    <div style="margin-top: 15px; display: flex; gap: 20px; font-size: 14px; opacity: 0.9;">
                        <span><i class="fas fa-file"></i> ${submissionCount} ${submissionCount === 1 ? 'Report' : 'Reports'} Combined</span>
                        <span><i class="fas fa-database"></i> ${totalRecords} Total Records</span>
                    </div>
                </div>
                <div class="modal-body-formal" id="combinedDataBody" style="padding: 30px; overflow-y: auto; flex: 1; background: #f8f9fa;"></div>
                <div class="modal-footer-formal" style="padding: 20px 30px; background: #f8f9fa; border-top: 1px solid #e0e0e0; display: flex; justify-content: space-between; align-items: center;">
                    <div style="display: flex; gap: 10px;">
                        <button class="btn-formal btn-success" id="exportCSVBtn" style="padding: 12px 30px; background: #28a745; border: none; color: white; cursor: pointer; border-radius: 6px; font-weight: 600; display: flex; align-items: center; gap: 8px;">
                            <i class="fas fa-file-csv"></i> Export to CSV
                        </button>
                    </div>
                    <button class="btn-formal btn-secondary" onclick="document.getElementById('combinedDataModal').style.display='none'" style="padding: 12px 30px;">
                        <i class="fas fa-times"></i> Close
                    </button>
                </div>
            </div>
        `;
        
        // Close on overlay click
        modal.onclick = (e) => {
            if (e.target === modal) {
                modal.style.display = 'none';
            }
        };
        
        const body = document.getElementById('combinedDataBody');
        let html = '';
        
        if (data && data.length > 0) {
            // Normalize column names to prevent duplicates (case-insensitive, handle display names)
            const columnNameMap = {}; // Maps normalized name to actual display name
            const normalizedColumns = new Set();
            
            // First pass: collect all columns and normalize them
            data.forEach(row => {
                if (row && typeof row === 'object') {
                    Object.keys(row).forEach(key => { 
                        // Exclude internal markers (__prefix), batch_id, and id
                        const lowerKey = key.toLowerCase().trim();
                        if (!key.startsWith('__') && 
                            lowerKey !== 'batch_id' && 
                            lowerKey !== 'batchid' &&
                            !lowerKey.includes('batch_id') &&
                            !lowerKey.includes('batch id') &&
                            lowerKey !== 'id') {
                            
                            // Use normalized key to prevent duplicates
                            if (!normalizedColumns.has(lowerKey)) {
                                normalizedColumns.add(lowerKey);
                                // Store the original key as the display name (prefer capitalized version)
                                if (!columnNameMap[lowerKey] || key.charAt(0).toUpperCase() === key.charAt(0)) {
                                    columnNameMap[lowerKey] = key;
                                }
                            }
                        }
                    });
                }
            });
            
            // Convert to array using normalized names but keep original display names
            let columns = Array.from(normalizedColumns).map(normKey => columnNameMap[normKey] || normKey);
            
            // Sort columns: Campus first, then Office/Department, then Year, then others (same as renderDataTable)
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
            
            // Create a mapping from display column names to all possible variations in data
            const columnVariations = {};
            columns.forEach(col => {
                const lowerCol = col.toLowerCase().trim();
                columnVariations[col] = [col, lowerCol, col.toUpperCase(), col.charAt(0).toUpperCase() + col.slice(1).toLowerCase()];
            });
            
            // Unique values per column for filters (check all variations)
            const columnFilters = {};
            columns.forEach(col => {
                const uniqueValues = new Set();
                const variations = columnVariations[col];
                data.forEach(row => {
                    if (row && typeof row === 'object') {
                        // Try all variations of the column name
                        let value = null;
                        for (const variant of variations) {
                            if (row.hasOwnProperty(variant) && row[variant] !== null && row[variant] !== undefined) {
                                value = row[variant];
                                break;
                            }
                        }
                        // Also try case-insensitive search
                        if (value === null) {
                            const rowKeys = Object.keys(row);
                            const matchingKey = rowKeys.find(key => key.toLowerCase().trim() === col.toLowerCase().trim());
                            if (matchingKey) {
                                value = row[matchingKey];
                            }
                        }
                        if (value !== null && value !== undefined) {
                            const strValue = String(value).trim();
                            if (strValue && strValue !== '-') uniqueValues.add(strValue);
                        }
                    }
                });
                columnFilters[col] = Array.from(uniqueValues).sort();
            });
            
            html += `
                <style>
                    /* Enhanced dropdown styling inside modal */
                    #filterContainer .column-filter { 
                        width: 100%; padding: 10px 12px; border: 2px solid #f1a2b2; border-radius: 10px; font-size: 12px; background: #fff; cursor: pointer; min-width: 140px; 
                        outline: none; transition: border-color .2s ease, box-shadow .2s ease; appearance: none;
                        background-image: linear-gradient(45deg, transparent 50%, #dc143c 50%), linear-gradient(135deg, #dc143c 50%, transparent 50%);
                        background-position: calc(100% - 16px) calc(1em + 2px), calc(100% - 11px) calc(1em + 2px);
                        background-size: 5px 5px, 5px 5px; background-repeat: no-repeat;
                    }
                    #filterContainer .column-filter:hover { border-color: #ea6f89; }
                    #filterContainer .column-filter:focus { border-color: #dc143c; box-shadow: 0 0 0 3px rgba(220,20,60,0.15); }
                    #filterContainer { border: 1px solid #e7e9ee; }
                    #combinedDataTable thead th { 
                        border-bottom: 3px solid #dc143c !important; 
                        padding: 0 !important;
                        position: relative !important;
                        height: 110px !important;
                        max-height: 110px !important;
                        overflow: visible !important;
                        box-sizing: border-box !important;
                    }
                    #combinedDataTable { table-layout: auto; width: 100%; }
                    #combinedDataTable thead tr { display: table-row !important; }
                    #combinedDataTable thead th { 
                        display: table-cell !important; 
                        vertical-align: top !important; 
                        min-width: 140px !important;
                    }
                    #combinedDataTable thead th > div { 
                        height: 100% !important;
                        min-height: 110px !important;
                        max-height: 110px !important;
                        position: relative !important;
                        display: flex !important;
                        flex-direction: column !important;
                        box-sizing: border-box !important;
                    }
                    #combinedDataTable thead .filter-row th { padding: 6px 8px !important; }
                    #combinedDataTable thead .filter-row select { width: 100% !important; box-sizing: border-box; }
                    #combinedDataTable thead th > div > div:first-child,
                    #combinedDataTable thead th .column-header-label { 
                        font-size: 14px !important; 
                        font-weight: 700 !important; 
                        color: #111827 !important; 
                        line-height: 1.4 !important;
                        white-space: nowrap !important;
                        overflow: hidden !important;
                        text-overflow: ellipsis !important;
                        margin-bottom: 0 !important;
                        padding-bottom: 0 !important;
                        flex: 1 1 auto !important;
                        display: flex !important;
                        align-items: center !important;
                        min-height: 0 !important;
                        max-height: calc(110px - 58px) !important;
                        position: relative !important;
                        top: 0 !important;
                        cursor: help !important;
                    }
                    #combinedDataTable thead th > div > div:last-child {
                        position: absolute !important;
                        bottom: 16px !important;
                        left: 18px !important;
                        right: 18px !important;
                        height: 42px !important;
                        top: auto !important;
                    }
                    #combinedDataTable thead th .column-filter {
                        width: 100% !important;
                        box-sizing: border-box !important;
                        height: 42px !important;
                        min-height: 42px !important;
                        max-height: 42px !important;
                        position: absolute !important;
                        bottom: 0 !important;
                        left: 0 !important;
                        right: 0 !important;
                        top: auto !important;
                        transform: none !important;
                        margin: 0 !important;
                    }
                    #combinedDataTable tbody td { 
                        white-space: normal !important; 
                        word-wrap: break-word !important;
                        max-width: 200px !important;
                    }
                </style>
                <div style="position: relative; margin-bottom: 15px;">
                    <div style="border: 2px solid #e0e0e0; border-radius: 8px; background: white; box-shadow: 0 2px 10px rgba(0,0,0,0.1); overflow-x: auto; overflow-y: visible;">
                        <table class="formal-table" id="combinedDataTable" style="margin: 0; width: 100%; border-collapse: separate; border-spacing: 0; min-width: 100%;">
                            <thead style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); position: sticky; top: 0; z-index: 10;">
                                <tr>
                                    ${columns.map((col, colIndex) => {
                                        const formattedColName = this.formatColumnName(col);
                                        return `
                                        <th style=\"padding: 0 !important; color: #111827; border-bottom: 3px solid #dc143c; text-align: left; min-width: 140px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); position: relative !important; height: 110px !important; max-height: 110px !important; overflow: visible !important; box-sizing: border-box !important;\">
                                            <div style=\"padding: 16px 18px; height: 100% !important; min-height: 110px !important; max-height: 110px !important; display: flex !important; flex-direction: column !important; position: relative !important; box-sizing: border-box !important;\">
                                                <div class=\"column-header-label\" style=\"font-weight: 700; font-size: 14px; color: #111827; line-height: 1.4; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; flex: 1 1 auto; display: flex; align-items: center; min-height: 0; max-height: calc(110px - 58px); position: relative; top: 0; margin-bottom: 0; padding-bottom: 0; cursor: help;\" title=\"${this.escapeHtml(formattedColName)}\">${this.escapeHtml(formattedColName)}</div>
                                                <div style=\"position: absolute !important; bottom: 16px !important; left: 18px !important; right: 18px !important; height: 42px !important; top: auto !important;\">
                                                    <select class=\"column-filter\" data-column=\"${col}\" data-column-index=\"${colIndex}\" style=\"width: 100% !important; box-sizing: border-box !important; padding: 10px 42px 10px 14px !important; border: 2px solid #e0e0e0 !important; border-radius: 10px !important; font-size: 14px !important; background: white !important; cursor: pointer !important; height: 42px !important; min-height: 42px !important; max-height: 42px !important; font-weight: 500 !important; color: #374151 !important; appearance: none !important; -webkit-appearance: none !important; -moz-appearance: none !important; background-image: url('data:image/svg+xml,%3Csvg xmlns=\\'http://www.w3.org/2000/svg\\' width=\\'20\\' height=\\'20\\' viewBox=\\'0 0 24 24\\' fill=\\'none\\' stroke=\\'%23dc143c\\' stroke-width=\\'2.5\\' stroke-linecap=\\'round\\' stroke-linejoin=\\'round\\'%3E%3Cpolyline points=\\'6 9 12 15 18 9\\'%3E%3C/polyline%3E%3C/svg%3E'); background-repeat: no-repeat !important; background-position: right 16px center !important; background-size: 18px 18px !important; margin: 0 !important; position: absolute !important; bottom: 0 !important; left: 0 !important; right: 0 !important; top: auto !important; transform: none !important;\">
                                                        <option value=\"\">All ${this.escapeHtml(formattedColName)}</option>
                                                        ${columnFilters[col].map(val => `
                                                            <option value=\"${this.escapeHtml(String(val).replace(/\"/g, '&quot;'))}\">${this.escapeHtml(String(val).length > 50 ? String(val).substring(0, 50) + '...' : String(val))}</option>
                                                        `).join('')}
                                                    </select>
                                                </div>
                                            </div>
                                        </th>
                                    `;
                                    }).join('')}
                                    <th style=\"padding: 0 !important; color: #111827; border-bottom: 3px solid #dc143c; text-align: left; min-width: 120px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); position: relative !important; height: 110px !important; max-height: 110px !important; overflow: visible !important; box-sizing: border-box !important;\">
                                        <div style=\"padding: 16px 18px; height: 100% !important; min-height: 110px !important; max-height: 110px !important; display: flex !important; flex-direction: column !important; position: relative !important; box-sizing: border-box !important;\">
                                            <div class=\"column-header-label\" style=\"font-weight: 700; font-size: 14px; color: #111827; line-height: 1.4; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; flex: 1 1 auto; display: flex; align-items: center; min-height: 0; max-height: calc(110px - 58px); position: relative; top: 0; margin-bottom: 0; padding-bottom: 0; cursor: help;\" title=\"Actions\">Actions</div>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="combinedDataTableBody">
                                ${data.map((row, rowIndex) => {
                                    const cells = columns.map(col => {
                                        // Try to get value using all possible column name variations
                                        let value = null;
                                        const variations = columnVariations[col] || [col];
                                        
                                        // First try exact match
                                        if (row && row.hasOwnProperty(col)) {
                                            value = row[col];
                                        } else {
                                            // Try variations
                                            for (const variant of variations) {
                                                if (row && row.hasOwnProperty(variant)) {
                                                    value = row[variant];
                                                    break;
                                                }
                                            }
                                            // If still not found, try case-insensitive search
                                            if (value === null || value === undefined) {
                                                const rowKeys = Object.keys(row || {});
                                                const matchingKey = rowKeys.find(key => key.toLowerCase().trim() === col.toLowerCase().trim());
                                                if (matchingKey) {
                                                    value = row[matchingKey];
                                                }
                                            }
                                        }
                                        
                                        // Format the value
                                        if (value === null || value === undefined || value === '') {
                                            value = '-';
                                        } else {
                                            value = String(value).trim();
                                        }
                                        
                                        return `<td data-column=\"${col}\" style=\"padding: 14px 18px; white-space: normal; word-wrap: break-word; border-bottom: 1px solid #f0f4f8; color: #2d3748; font-size: 14px; line-height: 1.5; max-width: 200px;\">${this.escapeHtml(value)}</td>`;
                                    }).join('');
                                    
                                    // Get row ID from the target table (this is the primary key 'id' from admissiondata, enrollmentdata, etc.)
                                    // This is different from submission_id - it's the actual row ID in the target table
                                    // Try multiple ways to get the ID
                                    let rowId = 0;
                                    if (row && typeof row === 'object') {
                                        rowId = row.id || row.ID || row.Id || row['id'] || parseInt(row.id, 10) || 0;
                                    }
                                    
                                    // Get table name
                                    let tableName = row.__table_name || row.table_name || 'unknown';
                                    // Make sure table name is lowercase (database tables are typically lowercase)
                                    if (tableName && tableName !== 'unknown') {
                                        tableName = tableName.toLowerCase();
                                    }
                                    
                                    // Debug ALL rows to see what's available (limit to first 3)
                                    if (rowIndex < 3) {
                                        console.log(`Combined modal - Row ${rowIndex} data:`, {
                                            row: row,
                                            rowId: rowId,
                                            tableName: tableName,
                                            hasId: !!row.id,
                                            id: row.id,
                                            ID: row.ID,
                                            Id: row.Id,
                                            allKeys: Object.keys(row),
                                            canDelete: !!(this.isSuperAdmin || (this.userRole && this.userRole.toLowerCase && this.userRole.toLowerCase().includes('admin')))
                                        });
                                    }
                                    
                                    // Check if user can delete (same logic as renderSubmissions)
                                    const canDelete = !!(this.isSuperAdmin || (this.userRole && this.userRole.toLowerCase && this.userRole.toLowerCase().includes('admin')));
                                    
                                    // Debug delete permission for first row
                                    if (rowIndex === 0) {
                                        console.log('Combined modal - Delete permission check:', {
                                            canDelete: canDelete,
                                            isSuperAdmin: this.isSuperAdmin,
                                            userRole: this.userRole,
                                            rowId: rowId,
                                            rowIdValid: (rowId && rowId > 0),
                                            tableName: tableName,
                                            tableNameValid: (tableName && tableName !== 'unknown'),
                                            willShowButton: (canDelete && rowId && rowId > 0 && tableName !== 'unknown')
                                        });
                                    }
                                    
                                    // ALWAYS show delete button if user has permission - let's see what happens
                                    // Show delete button if user has permission AND has valid row ID
                                    const shouldShowDelete = canDelete && rowId && rowId > 0 && tableName !== 'unknown';
                                    
                                    if (!shouldShowDelete && rowIndex === 0) {
                                        console.warn('Delete button will NOT show because:', {
                                            canDelete: canDelete,
                                            hasRowId: !!(rowId && rowId > 0),
                                            hasTableName: !!(tableName && tableName !== 'unknown'),
                                            rowId: rowId,
                                            tableName: tableName
                                        });
                                    }
                                    
                                    const actionsTd = shouldShowDelete ? 
                                        `<td style=\"padding: 12px; white-space: nowrap; border-bottom: 1px solid #e0e0e0; pointer-events: auto !important;\">
                                            <div class=\"btn-sm btn-danger delete-row-btn\" 
                                                 data-row-id=\"${rowId}\" 
                                                 data-table-name=\"${tableName}\" 
                                                 data-row-index=\"${rowIndex}\"
                                                 data-action=\"delete-row\" 
                                                 style=\"pointer-events: auto !important; cursor: pointer !important; z-index: 99999 !important; display: inline-flex !important; align-items: center !important; justify-content: center !important; gap: 6px !important; background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%) !important; color: white !important; border: none !important; border-radius: 8px !important; padding: 10px 16px !important; font-size: 13px !important; font-weight: 600 !important; box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3) !important;\" 
                                                 role=\"button\" 
                                                 tabindex=\"0\">
                                                <i class=\"fas fa-trash\"></i> Delete
                                            </div>
                                        </td>` : 
                                        `<td style=\"padding: 12px; white-space: nowrap; border-bottom: 1px solid #e0e0e0;\">-</td>`;
                                    
                                    return `<tr class=\"data-row\" data-row-index=\"${rowIndex}\" data-row-id=\"${rowId || ''}\" data-table-name=\"${tableName}\">${cells}${actionsTd}</tr>`;
                                }).join('')}
                            </tbody>
                        </table>
                    </div>
                </div>
            `;
        } else {
            // No data - close the modal instead of showing empty state
            modal.style.display = 'none';
            this.showNotification('No data records found for this report type.', 'info');
            return;
        }
        
        body.innerHTML = html;
        
        // Attach delete handlers to combined data modal delete buttons (for individual rows)
        setTimeout(() => {
            const deleteElements = body.querySelectorAll('[data-action="delete-row"]');
            console.log(`Found ${deleteElements.length} delete row elements in combined data modal`);
            deleteElements.forEach(deleteEl => {
                // Get row ID and table name from button attributes
                let rowId = parseInt(deleteEl.getAttribute('data-row-id'), 10);
                let tableName = deleteEl.getAttribute('data-table-name') || '';
                
                // If still 0, try getting from parent row
                if (!rowId || rowId <= 0) {
                    const row = deleteEl.closest('tr[data-row-id]');
                    if (row) {
                        const rowIdAttr = parseInt(row.getAttribute('data-row-id'), 10);
                        if (rowIdAttr && rowIdAttr > 0) {
                            rowId = rowIdAttr;
                            deleteEl.setAttribute('data-row-id', String(rowId));
                        }
                        if (!tableName || tableName === 'unknown') {
                            const tableNameAttr = row.getAttribute('data-table-name');
                            if (tableNameAttr) {
                                tableName = tableNameAttr;
                                deleteEl.setAttribute('data-table-name', tableName);
                            }
                        }
                    }
                }
                
                // Only attach handler if we have a valid row ID and table name
                if (!rowId || rowId <= 0 || !tableName || tableName === 'unknown') {
                    console.warn('Combined modal delete element missing row ID or table name:', {
                        rowId: rowId,
                        tableName: tableName,
                        element: deleteEl,
                        row: deleteEl.closest('tr')
                    });
                    // Hide or disable the delete button
                    deleteEl.style.display = 'none';
                    return;
                }
                
                // Force clickable
                deleteEl.style.setProperty('pointer-events', 'auto', 'important');
                deleteEl.style.setProperty('cursor', 'pointer', 'important');
                deleteEl.style.setProperty('z-index', '99999', 'important');
                
                // Add click handler to delete individual row
                const deleteHandler = async function(e) {
                    e?.preventDefault();
                    e?.stopPropagation();
                    e?.stopImmediatePropagation();
                    
                    const finalRowId = parseInt(this.getAttribute('data-row-id'), 10);
                    const finalTableName = this.getAttribute('data-table-name') || '';
                    const rowElement = this.closest('tr');
                    
                    if (!finalRowId || finalRowId <= 0 || !finalTableName) {
                        console.error('Cannot delete row - invalid ID or table:', { rowId: finalRowId, tableName: finalTableName });
                        alert('Error: Invalid row ID or table name');
                        return false;
                    }
                    
                    // Show confirmation modal
                    if (window.adminDashboard && typeof window.adminDashboard.showDeleteConfirmModal === 'function') {
                        const confirmed = await window.adminDashboard.showDeleteConfirmModal(
                            `Delete Row from ${window.adminDashboard.formatTableName(finalTableName)}`,
                            finalRowId
                        );
                        
                        if (!confirmed) {
                            return false;
                        }
                    } else if (!confirm(`Are you sure you want to delete this row (ID: ${finalRowId})?`)) {
                        return false;
                    }
                    
                    // Call delete row function
                    if (window.adminDashboard && typeof window.adminDashboard.deleteRow === 'function') {
                        await window.adminDashboard.deleteRow(finalRowId, finalTableName, rowElement);
                    } else {
                        console.error('deleteRow function not available');
                        alert('Error: Delete function not available');
                    }
                    
                    return false;
                };
                
                deleteEl.onclick = deleteHandler;
                deleteEl.addEventListener('click', deleteHandler, true);
                deleteEl.addEventListener('click', deleteHandler, false);
                
                console.log('Attached delete row handler for row ID:', rowId, 'Table:', tableName);
            });
        }, 100);
        
        // Persist data for exports
        modal.dataset.combinedData = JSON.stringify(data || []);
        modal.dataset.reportTypeName = reportTypeName || '';
        
        // Filters (now inside header)
        const filterSelects = document.querySelectorAll('#combinedDataTable thead .column-filter');
        filterSelects.forEach(select => {
            select.addEventListener('change', () => this.filterCombinedDataTable());
        });
        // No separate alignment needed when filters live inside each header cell
        
        // Disable any Delete buttons in the modal that don't have a valid numeric ID
        // DON'T call sanitizeDeleteButtons - it disables our divs
        // this.sanitizeDeleteButtons('#combinedDataTableBody');
        
        // Export handlers
        const exportCSVBtn = document.getElementById('exportCSVBtn');
        if (exportCSVBtn) exportCSVBtn.onclick = () => this.exportCombinedDataToCSV(reportTypeName || 'Data');
        
        modal.style.display = 'flex';
    }

    exportCombinedDataToCSV(reportTypeName) {
        const modal = document.getElementById('combinedDataModal');
        if (!modal || !modal.dataset.combinedData) {
            this.showNotification('No data available to export', 'error');
            return;
        }
        try {
            let data = JSON.parse(modal.dataset.combinedData);
            if (!data || data.length === 0) {
                this.showNotification('No data to export', 'error');
                return;
            }
            const tbody = document.getElementById('combinedDataTableBody');
            if (tbody) {
                const visibleRows = Array.from(tbody.querySelectorAll('.data-row')).filter(row => row.style.display !== 'none');
                if (visibleRows.length > 0) {
                    const visibleIndices = visibleRows.map(row => parseInt(row.dataset.rowIndex));
                    data = data.filter((row, index) => visibleIndices.includes(index));
                } else {
                    this.showNotification('No filtered data to export', 'error');
                    return;
                }
            }
            const allColumns = new Set();
            data.forEach(row => { 
                if (row && typeof row === 'object') {
                    Object.keys(row).forEach(key => {
                        // Exclude internal markers (__prefix) and batch_id
                        const lowerKey = key.toLowerCase();
                        if (!key.startsWith('__') && 
                            lowerKey !== 'batch_id' && 
                            lowerKey !== 'batchid' &&
                            !lowerKey.includes('batch_id') &&
                            !lowerKey.includes('batch id')) {
                            allColumns.add(key);
                        }
                    });
                }
            });
            const columns = Array.from(allColumns);
            const csvContent = [];
            csvContent.push(columns.map(col => `"${this.formatColumnName(col)}"`).join(','));
            data.forEach(row => {
                const rowData = columns.map(col => {
                    const value = row && row[col] !== null && row[col] !== undefined ? row[col] : '';
                    const stringValue = String(value).replace(/\"/g, '""');
                    return `"${stringValue}"`;
                });
                csvContent.push(rowData.join(','));
            });
            const csvText = csvContent.join('\n');
            const blob = new Blob([csvText], { type: 'text/csv;charset=utf-8;' });
            const url = window.URL.createObjectURL(blob);
            const link = document.createElement('a');
            const filename = `Combined_Data_${(reportTypeName || 'Data').replace(/\s+/g, '_')}_${new Date().toISOString().split('T')[0]}.csv`;
            link.href = url;
            link.download = filename;
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            setTimeout(() => { document.body.removeChild(link); window.URL.revokeObjectURL(url); }, 100);
            this.showNotification('Data exported to CSV successfully', 'success');
        } catch (error) {
            console.error('Export to CSV error:', error);
            this.showNotification(`Error exporting to CSV: ${error.message}`, 'error');
        }
    }

    exportCombinedDataToPDF(reportTypeName) {
        const modal = document.getElementById('combinedDataModal');
        if (!modal || !modal.dataset.combinedData) {
            this.showNotification('No data available to export', 'error');
            return;
        }
        try {
            let data = JSON.parse(modal.dataset.combinedData);
            if (!data || data.length === 0) {
                this.showNotification('No data to export', 'error');
                return;
            }
            const tbody = document.getElementById('combinedDataTableBody');
            if (tbody) {
                const visibleRows = Array.from(tbody.querySelectorAll('.data-row')).filter(row => row.style.display !== 'none');
                if (visibleRows.length > 0) {
                    const visibleIndices = visibleRows.map(row => parseInt(row.dataset.rowIndex));
                    data = data.filter((row, index) => visibleIndices.includes(index));
                } else {
                    this.showNotification('No filtered data to export', 'error');
                    return;
                }
            }
            if (typeof window.jspdf === 'undefined') {
                this.showNotification('PDF export library not loaded. Please refresh the page.', 'error');
                return;
            }
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            const allColumns = new Set();
            data.forEach(row => { if (row && typeof row === 'object') Object.keys(row).forEach(key => allColumns.add(key)); });
            const columns = Array.from(allColumns);
            const tableData = data.map(row => columns.map(col => String(row && row[col] !== null && row[col] !== undefined ? row[col] : '-')));
            const headers = columns.map(col => this.formatColumnName(col));
            doc.setFontSize(16);
            doc.text(`All Combined Data - ${(reportTypeName || 'Data')}`, 14, 15);
            if (typeof doc.autoTable !== 'function') {
                this.showNotification('PDF export plugin not available.', 'error');
                return;
            }
            doc.autoTable({
                head: [headers],
                body: tableData,
                startY: 25,
                styles: { fontSize: 8, cellPadding: 2 },
                headStyles: { fillColor: [220, 20, 60], textColor: [255, 255, 255], fontStyle: 'bold' },
                alternateRowStyles: { fillColor: [248, 249, 250] }
            });
            const filename = `Combined_Data_${(reportTypeName || 'Data').replace(/\s+/g, '_')}_${new Date().toISOString().split('T')[0]}.pdf`;
            doc.save(filename);
            this.showNotification('Data exported to PDF successfully', 'success');
        } catch (error) {
            console.error('Export to PDF error:', error);
            this.showNotification(`Error exporting to PDF: ${error.message}`, 'error');
        }
    }

    async viewCombinedData(reportTypeName) {
        try {
            // Determine target report type
            let targetType = reportTypeName;
            if (!targetType) {
                const dropdown = document.getElementById('reportTypeDropdown');
                targetType = dropdown ? dropdown.value : '';
            }
            if (!targetType) {
                this.showNotification('Please select a report type to view combined data.', 'error');
                return;
            }

            const formattedReportType = this.formatReportTypeName(targetType);

            // Create lightweight loading overlay
            let loadingModal = document.getElementById('loadingCombinedModal');
            if (!loadingModal) {
                loadingModal = document.createElement('div');
                loadingModal.id = 'loadingCombinedModal';
                loadingModal.style.cssText = 'position: fixed; inset: 0; background: rgba(0,0,0,0.4); display: flex; align-items: center; justify-content: center; z-index: 9999; color: white; font-weight: 600;';
                loadingModal.innerHTML = `<div style="background: rgba(0,0,0,0.6); padding: 16px 20px; border-radius: 8px; display: flex; align-items: center; gap: 10px;"><i class="fas fa-spinner fa-spin"></i><span>Loading combined data for ${formattedReportType}...</span></div>`;
                document.body.appendChild(loadingModal);
            } else {
                loadingModal.style.display = 'flex';
            }

            // Fetch all submissions
            const subsRes = await fetch('api/get_all_submissions.php');
            const subsJson = await subsRes.json();
            if (!subsJson.success) {
                loadingModal.style.display = 'none';
                this.showNotification('Failed to load submissions list.', 'error');
                return;
            }

            const allSubmissions = subsJson.data || [];
            const submissions = allSubmissions.filter(s => (s.report_type || s.table_name) === targetType);

            // Fetch details for each submission and combine rows - with better error handling
            const allDataPromises = submissions.map(async (sub) => {
                try {
                    const response = await fetch(`api/get_submission_details.php?submission_id=${sub.id}`);
                    const text = await response.text();
                    
                    if (!response.ok) {
                        console.warn(`Failed to fetch details for submission ${sub.id}: ${response.status} ${response.statusText}`);
                        return [];
                    }
                    
                    let res;
                    try {
                        res = JSON.parse(text);
                    } catch (parseError) {
                        console.error(`Failed to parse response for submission ${sub.id}:`, parseError);
                        return [];
                    }
                    
                    if (res.success) {
                        if (Array.isArray(res.data)) {
                            const tbl = sub.table_name || sub.report_type || '';
                            // Ensure __submission_id is ALWAYS added
                            return res.data.map(row => {
                                const enrichedRow = { ...row };
                                enrichedRow.__submission_id = sub.id;
                                enrichedRow.__table_name = tbl;
                                enrichedRow.__submission_date = sub.submission_date || sub.submitted_at || null;
                                enrichedRow.__office = sub.office || null;
                                enrichedRow.__campus = sub.campus || null;
                                return enrichedRow;
                            });
                        } else if (res.data && typeof res.data === 'object') {
                            // Handle case where data might be an object instead of array
                            console.warn(`Submission ${sub.id} returned object data instead of array:`, res.data);
                            return [];
                        } else {
                            console.warn(`Submission ${sub.id} returned success but no data array:`, res);
                            return [];
                        }
                    } else {
                        console.warn(`Submission ${sub.id} returned unsuccessful response:`, res.error || res.message || 'Unknown error');
                        return [];
                    }
                } catch (error) {
                    console.error(`Error fetching submission ${sub.id} details:`, error);
                    return [];
                }
            });

            const dataArrays = await Promise.all(allDataPromises);
            const combinedData = dataArrays.flat();
            
            console.log('Combined data loaded for', targetType, ':', combinedData.length, 'rows from', submissions.length, 'submissions');
            if (combinedData.length > 0) {
                console.log('Sample combined row (first):', combinedData[0]);
                console.log('Has __submission_id:', combinedData[0].hasOwnProperty('__submission_id'), 'Value:', combinedData[0].__submission_id);
                console.log('Has id field:', combinedData[0].hasOwnProperty('id'), 'Value:', combinedData[0].id);
                console.log('Has __table_name:', combinedData[0].hasOwnProperty('__table_name'), 'Value:', combinedData[0].__table_name);
                console.log('All keys in first row:', Object.keys(combinedData[0]));
            }

            // Remove loading overlay
            loadingModal.style.display = 'none';
            
            // If no data, close modal if it's open, otherwise show empty state
            if (combinedData.length === 0) {
                const modal = document.getElementById('combinedDataModal');
                if (modal) {
                    modal.style.display = 'none';
                }
                this.showNotification('No data records found for this report type.', 'info');
            } else {
                this.showCombinedDataModal(combinedData, formattedReportType, submissions.length, combinedData.length);
            }
        } catch (error) {
            console.error('Error loading combined data:', error);
            const loadingModal = document.getElementById('loadingCombinedModal');
            if (loadingModal) loadingModal.style.display = 'none';
            this.showNotification('Error loading combined data.', 'error');
        }
    }

    filterCombinedDataTable() {
        const table = document.getElementById('combinedDataTable');
        const tbody = document.getElementById('combinedDataTableBody');
        if (!table || !tbody) return;
        const filters = Array.from(document.querySelectorAll('.column-filter'))
            .map(sel => ({ col: sel.getAttribute('data-column'), val: sel.value.toLowerCase() }));
        const rows = Array.from(tbody.querySelectorAll('.data-row'));
        rows.forEach(row => {
            const cells = Array.from(row.querySelectorAll('td'));
            let visible = true;
            filters.forEach(f => {
                if (!visible || !f.val) return;
                const cell = cells.find(td => td.getAttribute('data-column') === f.col);
                const text = (cell ? cell.textContent : '').toLowerCase();
                if (!text.includes(f.val)) visible = false;
            });
            row.style.display = visible ? '' : 'none';
        });
    }

    alignCombinedFilterRow() {
        const doAlign = () => {
            const thead = document.querySelector('#combinedDataTable thead');
            if (!thead) return;
            const rows = thead.querySelectorAll('tr');
            if (rows.length < 2) return;
            const headerCells = rows[0].querySelectorAll('th');
            const filterCells = rows[1].querySelectorAll('th');
            const n = Math.min(headerCells.length, filterCells.length);
            for (let i = 0; i < n; i++) {
                const w = headerCells[i].getBoundingClientRect().width;
                filterCells[i].style.width = `${w}px`;
            }
        };
        // Align now and on next frame to account for layout settling
        doAlign();
        if (typeof requestAnimationFrame === 'function') {
            requestAnimationFrame(() => doAlign());
        } else {
            setTimeout(doAlign, 0);
        }
    }

    async viewSubmission(submissionId) {
        try {
            const adminUrl = `api/admin_submissions.php?action=details&submission_id=${submissionId}`;
            let response = await fetch(adminUrl, { credentials: 'include' });
            if (!response.ok && [401,403,404].includes(response.status)) {
                const publicUrl = `api/get_submission_details.php?submission_id=${submissionId}`;
                const alt = await fetch(publicUrl, { credentials: 'include' });
                if (alt.ok) {
                    const altJson = await alt.json();
                    if (altJson && altJson.success) {
                        this.showSubmissionModal(altJson.submission || altJson.data);
                        return;
                    }
                }
            }
            const result = await response.json();
            if (result && result.success) {
                this.showSubmissionModal(result.data);
            } else {
                alert('Failed to load submission details');
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
            const allColumns = Object.keys(submission.data[0]);
            // Filter out Submission ID column if it exists
            const columns = allColumns.filter(col => 
                col.toLowerCase() !== 'submission_id' && 
                col.toLowerCase() !== 'submission id' &&
                col !== 'id'
            );
            
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
                this.loadModernDashboard(),
                // User Activity removed from dashboard, now in separate section
            ]);
        } catch (error) {
            console.error('Error loading dashboard data:', error);
        }
    }
    
    async loadModernDashboard() {
        // Load real system data
        await this.loadSystemStats();
        
        // Load KPI cards with mini charts
        await this.loadKPICards();
        
        // Load large report charts
        await this.loadSubmissionsGrowthChart('current');
        await this.loadSubmissionsMonthlyChart();
        await this.initializeReportTypeDropdown();

        // Analytics report-type dropdown (growth/monthly/top charts)
        this.analyticsReportType = this.analyticsReportType || '';
        await this.populateAnalyticsReportTypeDropdown();
        this.attachAnalyticsReportTypeEvents();
        
        // Load detailed reports
        await this.loadReportsByType();
        
        // Load top active reports with monthly filter (default)
        await this.loadTopActiveReports('monthly');
    }

    async initializeReportTypeDropdown() {
        try {
            const response = await fetch('api/get_all_submissions.php');
            const result = await response.json();
            if (result.success) {
                const submissions = result.data || [];
                const reportTypes = [...new Set(submissions.map(s => s.report_type || s.table_name).filter(Boolean))];
                const dropdown = document.getElementById('reportTypeDropdown');
                if (dropdown) {
                    dropdown.innerHTML = '<option value="">-- Select Report Type --</option>';
                    reportTypes.forEach(reportType => {
                        const option = document.createElement('option');
                        option.value = reportType;
                        option.textContent = this.formatReportTypeName(reportType);
                        dropdown.appendChild(option);
                    });
                    let chartTimeout;
                    dropdown.addEventListener('change', () => {
                        const selectedType = dropdown.value;
                        if (chartTimeout) clearTimeout(chartTimeout);
                        chartTimeout = setTimeout(() => {
                            if (selectedType) {
                                // Only load chart, not cards
                                this.loadColumnBasedChart(selectedType);
                                const container = document.getElementById('columnAnalyticsContainer');
                                if (container) container.style.display = 'none';
                            } else {
                                const container = document.getElementById('columnAnalyticsContainer');
                                if (container) container.style.display = 'none';
                                this.loadSubmissionsGrowthChart('current');
                            }
                        }, 100);
                    });
                }
            }
        } catch (error) {
            console.error('Error initializing report type dropdown:', error);
        }
    }

    formatReportTypeName(reportType) {
        if (!reportType) return 'Unknown';
        return reportType.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
    }

    async loadColumnAnalytics(reportType) {
        // Disabled - cards are no longer shown, only chart is displayed
        // This function is kept for compatibility but does nothing
        const container = document.getElementById('columnAnalyticsContainer');
        if (container) container.style.display = 'none';
        return;
    }

    calculateColumnAnalytics(dataRows, columnName) {
        const values = [];
        const totalRows = dataRows.length;
        let filledCount = 0;
        let emptyCount = 0;
        let numericSum = 0;
        let hasNumericValues = false;
        
        // Normalize column name for matching (case-insensitive, remove spaces/special chars)
        const normalizeColName = (name) => {
            if (!name) return '';
            return name.toString().trim().toLowerCase().replace(/[^a-z0-9]/g, '');
        };
        const targetColNormalized = normalizeColName(columnName);
        
        // Detect date-like columns by name
        const columnNameLower = columnName.toLowerCase();
        const dateNameKeywords = ['date', 'dob', 'birth', 'month', 'day', 'year', 'academic year', 'ay', 'reviewed'];
        const isDateByName = dateNameKeywords.some(k => columnNameLower.includes(k));
        // Common date value patterns (YYYY-MM-DD, DD/MM/YYYY, MM/DD/YYYY, YYYY/MM/DD, ISO, etc.)
        const datePatterns = [
            /^\d{4}[-/.]\d{1,2}[-/.]\d{1,2}$/,          // 2025-11-09 or 2025/11/09 or 2025.11.09
            /^\d{1,2}[-/.]\d{1,2}[-/.]\d{2,4}$/,        // 09/11/2025 or 9-11-25
            /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}/,          // ISO-like 2025-11-09T10:20
            /^[A-Za-z]{3,}\s+\d{1,2},\s*\d{2,4}$/      // Nov 9, 2025
        ];
        
        dataRows.forEach(row => {
            if (row && typeof row === 'object') {
                // Try exact match first
                let value = row[columnName];
                let found = row.hasOwnProperty(columnName);
                
                // If not found, try case-insensitive match
                if (!found) {
                    const keys = Object.keys(row);
                    for (const key of keys) {
                        if (normalizeColName(key) === targetColNormalized) {
                            value = row[key];
                            found = true;
                            break;
                        }
                    }
                }
                
                if (found) {
                    if (value !== null && value !== '' && value !== undefined && String(value).trim() !== '') {
                        filledCount++;
                        const valueStr = String(value).trim();
                        values.push(valueStr);
                        const isDateByValue = datePatterns.some(rx => rx.test(valueStr));
                        const treatAsDate = isDateByName || isDateByValue;
                        if (!treatAsDate) {
                            const numericValue = parseFloat(valueStr.replace(/[^\d.-]/g, ''));
                            if (!isNaN(numericValue) && isFinite(numericValue)) {
                                // If it looks like a 4-digit year, don't treat as numeric sum
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
            totalSubmissions: totalRows,
            numericSum: hasNumericValues ? numericSum : null,
            hasNumericValues
        };
    }

    createColumnAnalyticsCard(columnName, analytics) {
        const card = document.createElement('div');
        card.style.cssText = `background: white; border: 1px solid #e5e7eb; border-radius: 12px; padding: 20px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); transition: all 0.3s ease;`;
        card.onmouseenter = () => { card.style.transform = 'translateY(-2px)'; card.style.boxShadow = '0 4px 12px rgba(0, 0, 0, 0.1)'; };
        card.onmouseleave = () => { card.style.transform = 'translateY(0)'; card.style.boxShadow = '0 2px 8px rgba(0, 0, 0, 0.05)'; };
        const rating = this.getRating(analytics.completionRate);
        card.innerHTML = `
            <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 12px;">
                <h5 style="margin: 0; font-size: 16px; font-weight: 600; color: #111827;">${this.formatColumnName(columnName)}</h5>
                <span style="background: ${rating.color}; color: white; padding: 4px 12px; border-radius: 12px; font-size: 12px; font-weight: 600;">${rating.label}</span>
            </div>
            <div style="margin-bottom: 12px;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 4px;">
                    <span style="font-size: 12px; color: #6b7280;">Completion Rate</span>
                    <span style="font-size: 14px; font-weight: 600; color: #111827;">${analytics.completionRate.toFixed(1)}%</span>
                </div>
                <div style="background: #f3f4f6; border-radius: 8px; height: 8px; overflow: hidden;">
                    <div style="background: ${rating.color}; height: 100%; width: ${analytics.completionRate}%; transition: width 0.3s ease;"></div>
                </div>
            </div>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px; font-size: 12px;">
                <div><div style="color: #6b7280; margin-bottom: 4px;">Filled</div><div style="font-weight: 600; color: #111827;">${analytics.filledCount}</div></div>
                <div><div style="color: #6b7280; margin-bottom: 4px;">Empty</div><div style="font-weight: 600; color: #111827;">${analytics.emptyCount}</div></div>
                <div><div style="color: #6b7280; margin-bottom: 4px;">Unique Values</div><div style="font-weight: 600; color: #111827;">${analytics.uniqueCount}</div></div>
                <div><div style="color: #6b7280; margin-bottom: 4px;">Most Common</div><div style="font-weight: 600; color: #111827; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="${analytics.mostCommon || 'N/A'}">${(analytics.mostCommon || 'N/A').substring(0, 15)}${analytics.mostCommon && analytics.mostCommon.length > 15 ? '...' : ''}</div></div>
            </div>`;
        return card;
    }

    getRating(completionRate) {
        if (completionRate >= 90) return { label: 'Excellent', color: '#10b981' };
        if (completionRate >= 70) return { label: 'Good', color: '#3b82f6' };
        if (completionRate >= 50) return { label: 'Fair', color: '#f59e0b' };
        return { label: 'Poor', color: '#ef4444' };
    }

    async getReportColumns(reportType) {
        const normalizedReportType = reportType.toLowerCase().replace(/\s+/g, '');
        const tableName = normalizedReportType;
        try {
            if (window.ReportApp && window.ReportApp.tables && window.ReportApp.tables[tableName]) {
                const tableConfig = window.ReportApp.tables[tableName];
                if (tableConfig && tableConfig.columns) {
                    return tableConfig.columns.filter(col => col !== 'ID' && col !== 'id');
                }
            }
            if (!this._configCache) {
                try {
                    const configResponse = await fetch('js/report.js');
                    this._configCache = await configResponse.text();
                } catch (fetchError) {
                    return null;
                }
            }
            const escapedTableName = tableName.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
            const tablePattern = new RegExp(`${escapedTableName}\\s*:\\s*\\{([\\s\\S]*?)\\}(?=\\s*[,}])`, 'i');
            const tableMatch = this._configCache.match(tablePattern);
            if (tableMatch) {
                const tableConfig = tableMatch[1];
                const columnsMatch = tableConfig.match(/columns\s*:\s*\[([\s\S]*?)\]/);
                if (columnsMatch) {
                    const columnsStr = columnsMatch[1];
                    const columnMatches = columnsStr.match(/['"]([^'"]+)['"]/g);
                    if (columnMatches) {
                        const columns = columnMatches.map(m => m.replace(/['"]/g, ''));
                        return columns.filter(col => col !== 'ID' && col !== 'id');
                    }
                }
            }
        } catch (error) {
            // ignore
        }
        return null;
    }

    async loadColumnBasedChart(reportType) {
        try {
            console.log('Loading column-based chart for report type:', reportType);
            const submissionsResponse = await fetch('api/get_all_submissions.php', { credentials: 'include' });
            const submissionsResult = await submissionsResponse.json();
            if (!submissionsResult.success) { 
                console.warn('Failed to fetch submissions:', submissionsResult);
                this.createColumnBasedChart([], []); 
                return; 
            }
            let allSubmissions = submissionsResult.data || [];
            console.log('Total submissions fetched:', allSubmissions.length);
            
            // Filter by campus if not super admin
            if (!this.isSuperAdmin && this.userCampus) {
                const norm = (x) => (x || '').toString().trim().toLowerCase();
                const allowed = (this.getAccessibleCampuses() || []).map(norm);
                allSubmissions = allSubmissions.filter(s => {
                    const subCampus = norm(s.campus);
                    return allowed.some(a => subCampus.includes(a) || a.includes(subCampus));
                });
                console.log('After campus filtering:', allSubmissions.length, 'submissions');
            }
            
            // Normalize function for better matching
            const normalize = (str) => {
                if (!str) return '';
                return str.toString().trim().toLowerCase().replace(/[^a-z0-9]/g, '');
            };
            
            const targetReportType = normalize(reportType);
            console.log('Target report type (normalized):', targetReportType);
            
            // Filter submissions by report type - use more flexible matching
            const submissionIds = allSubmissions
                .filter(s => {
                    const subReportType = normalize(s.report_type || s.table_name || '');
                    const matches = subReportType === targetReportType || 
                                   subReportType.includes(targetReportType) || 
                                   targetReportType.includes(subReportType);
                    if (matches) {
                        console.log('Matched submission:', s.id, 'with type:', s.report_type || s.table_name);
                    }
                    return matches;
                })
                .map(s => s.id);
            
            console.log('Filtered submission IDs:', submissionIds.length);
            if (submissionIds.length === 0) { 
                console.warn('No submissions found for report type:', reportType);
                console.log('Available report types:', [...new Set(allSubmissions.map(s => s.report_type || s.table_name).filter(Boolean))]);
                this.createColumnBasedChart([], []); 
                return; 
            }
            console.log('Fetching submission details for', submissionIds.length, 'submissions...');
            const dataPromises = submissionIds.map(id => 
                fetch(`api/get_submission_details.php?submission_id=${id}`, { credentials: 'include' })
                    .then(res => {
                        if (!res.ok) {
                            console.warn(`Failed to fetch details for submission ${id}:`, res.status);
                            return null;
                        }
                        return res.json();
                    })
                    .then(result => {
                        if (result && result.success && result.data && Array.isArray(result.data)) {
                            console.log(`Fetched ${result.data.length} rows for submission ${id}`);
                            return result.data;
                        }
                        console.warn(`No data returned for submission ${id}:`, result);
                        return null;
                    })
                    .catch(err => {
                        console.error(`Error fetching submission ${id}:`, err);
                        return null;
                    })
            );
            const submissionDataResults = await Promise.all(dataPromises);
            const allDataRows = submissionDataResults.filter(d => d !== null && Array.isArray(d)).flat();
            console.log('Total data rows extracted:', allDataRows.length);
            if (allDataRows.length === 0) { 
                console.warn('No data rows found after fetching submission details');
                this.createColumnBasedChart([], []); 
                return; 
            }
            let columns = await this.getReportColumns(reportType);
            if (!columns || columns.length === 0) {
                console.log('No columns from config, extracting from data...');
                const allColumns = new Set();
                allDataRows.forEach(row => { 
                    if (row && typeof row === 'object') {
                        Object.keys(row).forEach(key => { 
                            // Exclude metadata columns
                            const keyLower = key.toLowerCase();
                            if (key !== 'ID' && key !== 'id' && 
                                !keyLower.includes('submission') && 
                                !keyLower.includes('batch') && 
                                !keyLower.includes('assignment') &&
                                key !== '_row' && key !== '_index') {
                                allColumns.add(key); 
                            }
                        }); 
                    }
                });
                columns = Array.from(allColumns);
                console.log('Extracted columns from data:', columns);
            }
            if (columns.length === 0) { 
                console.warn('No columns found for chart');
                this.createColumnBasedChart([], []); 
                return; 
            }
            
            console.log('Calculating analytics for', columns.length, 'columns...');
            const columnRatings = columns.map(column => {
                const analytics = this.calculateColumnAnalytics(allDataRows, column);
                const totalPossibleData = allDataRows.length;
                const filledData = analytics.filledCount;
                // Use numeric sum if available, otherwise use filled count
                const rating = analytics.hasNumericValues && analytics.numericSum !== null && analytics.numericSum > 0 
                    ? analytics.numericSum 
                    : filledData;
                console.log(`Column "${column}": filled=${filledData}, total=${totalPossibleData}, numericSum=${analytics.numericSum}, rating=${rating}`);
                return { column, rating, filledCount: filledData, totalCount: totalPossibleData, emptyCount: totalPossibleData - filledData, isNumeric: analytics.hasNumericValues, numericSum: analytics.numericSum };
            });
            columnRatings.sort((a, b) => b.rating - a.rating);
            const columnLabels = columnRatings.map(cr => this.formatColumnName(cr.column));
            const ratingData = columnRatings.map(cr => cr.rating);
            this.createColumnBasedChart(columnLabels, ratingData, columnRatings);
        } catch (error) {
            console.error('Error loading column-based chart:', error);
            this.createColumnBasedChart([], []);
        }
    }

    createColumnBasedChart(columnLabels, ratingData, columnRatings = []) {
        const ctx = document.getElementById('submissionsGrowthChart');
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
        if (this.submissionsGrowthChart) { this.submissionsGrowthChart.destroy(); this.submissionsGrowthChart = null; }
        requestAnimationFrame(() => { this._createChart(ctx, columnLabels, ratingData, columnRatings); });
    }

    _createChart(ctx, columnLabels, ratingData, columnRatings) {
        const maxValue = Math.max(...ratingData, 1);
        let maxY;
        if (maxValue >= 1000) maxY = Math.ceil(maxValue / 1000) * 1000;
        else if (maxValue >= 100) maxY = Math.ceil(maxValue / 100) * 100;
        else if (maxValue >= 10) maxY = Math.ceil(maxValue / 10) * 10;
        else maxY = Math.ceil(maxValue);
        if (maxValue === 0) maxY = 10;
        const stepSize = maxY >= 10 ? Math.ceil(maxY / 10) : 1;
        const backgroundColors = ratingData.map((count, index) => {
            const cr = columnRatings[index]; const total = cr?.totalCount || 1; const rate = total > 0 ? (count / total) * 100 : 0;
            if (rate >= 90) return 'rgba(16, 185, 129, 0.2)';
            if (rate >= 70) return 'rgba(59, 130, 246, 0.2)';
            if (rate >= 50) return 'rgba(245, 158, 11, 0.2)';
            return 'rgba(239, 68, 68, 0.2)';
        });
        const borderColors = ratingData.map((count, index) => {
            const cr = columnRatings[index]; const total = cr?.totalCount || 1; const rate = total > 0 ? (count / total) * 100 : 0;
            if (rate >= 90) return '#10b981';
            if (rate >= 70) return '#3b82f6';
            if (rate >= 50) return '#f59e0b';
            return '#ef4444';
        });
        this.submissionsGrowthChart = new Chart(ctx, {
            type: 'bar',
            data: { labels: columnLabels, datasets: [{ label: 'Data Quality Rating', data: ratingData, backgroundColor: backgroundColors, borderColor: borderColors, borderWidth: 2, borderRadius: 6, barThickness: 'flex', maxBarThickness: 50 }] },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false }, tooltip: { backgroundColor: '#1e293b', titleColor: '#fff', bodyColor: '#fff', padding: 12, borderRadius: 8, displayColors: false, titleFont: { size: 13, weight: '600' }, bodyFont: { size: 12 }, callbacks: { title: (context) => context[0].label, label: function(context) { const value = context.parsed.y; const cr = columnRatings[context.dataIndex]; const total = cr?.totalCount || 0; const filled = cr?.filledCount || 0; const isNumeric = cr?.isNumeric || false; const completionRate = total > 0 ? (filled / total) * 100 : 0; const rating = this.getRating(completionRate); if (isNumeric) { return [`Total Sum: ${value.toLocaleString()}`, `Filled Rows: ${filled} / ${total}`, `Completion: ${completionRate.toFixed(1)}% (${rating.label})`]; } else { return [`Total Data: ${filled}`, `Filled: ${filled} / ${total}`, `Completion: ${completionRate.toFixed(1)}% (${rating.label})`]; } }.bind(this) } } },
                scales: { y: { beginAtZero: true, max: maxY, ticks: { stepSize: stepSize, font: { size: 11 }, color: '#6b7280', callback: (value) => value >= 1000 ? value.toLocaleString() : value }, grid: { color: '#f3f4f6', drawBorder: false }, title: { display: true, text: 'Total Value / Count', font: { size: 12, weight: '600' }, color: '#6b7280' } }, x: { grid: { display: false }, ticks: { font: { size: 11 }, color: '#6b7280', maxRotation: 45, minRotation: 45 }, title: { display: true, text: 'Columns', font: { size: 12, weight: '600' }, color: '#6b7280' } } },
                interaction: { intersect: false, mode: 'index' }
            }
        });
    }
    
    async loadSystemStats() {
        try {
            console.log('Fetching system statistics...');
            
            // Fetch users data
            const usersUrl = this.isSuperAdmin || !this.userCampus
                ? 'api/users.php?action=list'
                : `api/users.php?action=list&campus=${encodeURIComponent(this.userCampus)}`;
            
            console.log('Fetching users from:', usersUrl);
            const usersResponse = await fetch(usersUrl);
            
            if (!usersResponse.ok) {
                throw new Error(`Users API returned ${usersResponse.status}: ${usersResponse.statusText}`);
            }
            
            const usersResult = await usersResponse.json();
            console.log('Users API response:', usersResult);
            
            // Fetch submissions data
            console.log('Fetching submissions from: api/get_all_submissions.php');
            const submissionsResponse = await fetch('api/get_all_submissions.php');
            
            if (!submissionsResponse.ok) {
                throw new Error(`Submissions API returned ${submissionsResponse.status}: ${submissionsResponse.statusText}`);
            }
            
            const submissionsResult = await submissionsResponse.json();
            console.log('Submissions API response:', submissionsResult);
            
            // Handle API responses
            let users = usersResult.success ? (usersResult.users || []) : [];
            let submissions = submissionsResult.success ? (submissionsResult.data || []) : [];
            
            // Filter by campus if not super admin
            if (!this.isSuperAdmin && this.userCampus) {
                const norm = (x) => (x || '').toString().trim().toLowerCase();
                const allowed = (this.getAccessibleCampuses() || []).map(norm);
                
                // Filter users by campus
                users = users.filter(u => {
                    const userCampus = norm(u.campus);
                    return allowed.includes(userCampus) || 
                           u.role === 'super_admin' || 
                           u.campus === 'All Campuses';
                });
                
                // Filter submissions by accessible campuses
                submissions = submissions.filter(s => {
                    const subCampus = norm(s.campus);
                    return allowed.includes(subCampus);
                });
                
                console.log(`Filtered system stats for ${this.userCampus}: ${users.length} users, ${submissions.length} submissions`);
            }
            
            console.log(`Loaded ${users.length} users and ${submissions.length} submissions`);
            
            // Calculate statistics
            const totalUsers = users.length;
            const activeUsers = users.filter(u => u.status === 'active').length;
            const usersProgress = totalUsers > 0 ? Math.round((activeUsers / totalUsers) * 100) : 0;
            
            console.log(`Users: ${totalUsers} total, ${activeUsers} active (${usersProgress}%)`);
            
            // Count unique report types (different table_name values)
            const reportTypeValues = submissions
                .map(s => (s.table_name || s.report_type || '').trim())
                .filter(Boolean);
            const uniqueReportTypes = new Set(reportTypeValues);
            const totalReports = uniqueReportTypes.size;
            
            const approvedReports = submissions.filter(s => 
                s.status && s.status.toLowerCase() === 'approved'
            ).length;
            const reportsProgress = submissions.length > 0 
                ? Math.round((approvedReports / submissions.length) * 100) 
                : 0;
            
            console.log(`Reports: ${totalReports} unique types, ${approvedReports} approved (${reportsProgress}%)`);
            
            const totalSubmissions = submissions.length;
            const completedSubmissions = submissions.filter(s => {
                const status = (s.status || '').toLowerCase();
                return status === 'approved' || status === 'rejected';
            }).length;
            const submissionsProgress = totalSubmissions > 0 
                ? Math.round((completedSubmissions / totalSubmissions) * 100) 
                : 0;
            
            console.log(`Submissions: ${totalSubmissions} total, ${completedSubmissions} completed (${submissionsProgress}%)`);
            
            // Update Users Card
            const usersValueEl = document.getElementById('totalUsersValue');
            const usersProgressBar = document.getElementById('usersProgressBar');
            const usersProgressValue = document.getElementById('usersProgressValue');
            
            if (usersValueEl) {
                usersValueEl.textContent = totalUsers > 0 ? totalUsers + '+' : '0';
            }
            if (usersProgressBar && usersProgressValue) {
                usersProgressBar.setAttribute('data-progress', usersProgress);
                this.animateProgressBar(usersProgressBar, usersProgress, usersProgressValue);
            }
            
            // Update Reports Card
            const reportsValueEl = document.getElementById('totalReportsValue');
            const reportsProgressBar = document.getElementById('reportsProgressBar');
            const reportsProgressValue = document.getElementById('reportsProgressValue');
            
            if (reportsValueEl) {
                reportsValueEl.textContent = totalReports > 0 ? totalReports + '+' : '0';
            }
            if (reportsProgressBar && reportsProgressValue) {
                reportsProgressBar.setAttribute('data-progress', reportsProgress);
                this.animateProgressBar(reportsProgressBar, reportsProgress, reportsProgressValue);
            }
            
            // Update Submissions Card
            const submissionsValueEl = document.getElementById('totalSubmissionsValue');
            const submissionsProgressBar = document.getElementById('submissionsProgressBar');
            const submissionsProgressValue = document.getElementById('submissionsProgressValue');
            
            if (submissionsValueEl) {
                submissionsValueEl.textContent = totalSubmissions > 0 ? totalSubmissions + '+' : '0';
            }
            if (submissionsProgressBar && submissionsProgressValue) {
                submissionsProgressBar.setAttribute('data-progress', submissionsProgress);
                this.animateProgressBar(submissionsProgressBar, submissionsProgress, submissionsProgressValue);
            }
            
            console.log('System stats updated successfully');
        } catch (error) {
            console.error('Error loading system stats:', error);
            // Show error message to user
            this.showNotification('Failed to load dashboard statistics. Please refresh the page.', 'error');
        }
    }
    
    animateProgressBar(progressBar, progress, progressValueEl) {
        const circumference = 2 * Math.PI * 45; // radius = 45
        const offset = circumference - (progress / 100) * circumference;
        
        setTimeout(() => {
            progressBar.style.strokeDashoffset = offset;
            if (progressValueEl) {
                let current = 0;
                const interval = setInterval(() => {
                    current += 2;
                    if (current >= progress) {
                        current = progress;
                        clearInterval(interval);
                    }
                    progressValueEl.textContent = current + '%';
                }, 20);
            }
        }, 100);
    }
    
    async loadSalesReportsChart() {
        try {
            console.log('Fetching submissions for line chart...');
            const response = await fetch('api/get_all_submissions.php');
            
            if (!response.ok) {
                throw new Error(`Submissions API returned ${response.status}`);
            }
            
            const result = await response.json();
            console.log('Line chart data loaded:', result);
            
            if (result.success) {
                const submissions = result.data || [];
                console.log(`Creating line chart with ${submissions.length} submissions`);
                this.createSalesReportsLineChart(submissions);
            } else {
                console.error('API returned error:', result.error || 'Unknown error');
            }
        } catch (error) {
            console.error('Error loading sales reports chart:', error);
            this.showNotification('Failed to load submissions chart', 'error');
        }
    }
    
    createSalesReportsLineChart(submissions) {
        const ctx = document.getElementById('salesReportsChart');
        if (!ctx) return;
        
        // Destroy existing chart if any
        if (this.salesReportsChart) {
            this.salesReportsChart.destroy();
        }
        
        // Group submissions by hour (simulate sales over time)
        const hourlyData = Array.from({length: 24}, (_, i) => {
            const hour = i;
            const filtered = submissions.filter(s => {
                const date = new Date(s.submitted_at);
                return date.getHours() === hour;
            });
            return filtered.length * 3.5; // Scale for demo
        });
        
        // Labels for 10am to 7am (next day)
        const labels = [];
        for (let i = 10; i < 24; i++) {
            labels.push((i > 12 ? i - 12 : i) + (i >= 12 ? 'pm' : 'am'));
        }
        for (let i = 0; i <= 7; i++) {
            labels.push((i === 0 ? 12 : i) + (i >= 12 ? 'pm' : 'am'));
        }
        
        const data = [...hourlyData.slice(10), ...hourlyData.slice(0, 8)];
        
        this.salesReportsChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                    datasets: [{
                        label: 'Submissions',
                        data: data,
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    tension: 0.4,
                    fill: true,
                    pointRadius: 5,
                    pointBackgroundColor: '#3b82f6',
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
    
    async loadSalesReportsDonutChart() {
        try {
            console.log('Fetching submissions for donut chart...');
            const response = await fetch('api/get_all_submissions.php');
            
            if (!response.ok) {
                throw new Error(`Submissions API returned ${response.status}`);
            }
            
            const result = await response.json();
            console.log('Donut chart data loaded:', result);
            
            if (result.success) {
                const submissions = result.data || [];
                console.log(`Creating donut chart with ${submissions.length} submissions`);
                this.createSalesReportsDonutChart(submissions);
            } else {
                console.error('API returned error:', result.error || 'Unknown error');
            }
        } catch (error) {
            console.error('Error loading sales reports donut chart:', error);
            this.showNotification('Failed to load status chart', 'error');
        }
    }
    
    createSalesReportsDonutChart(submissions) {
        const ctx = document.getElementById('salesReportsDonutChart');
        if (!ctx) return;
        
        if (this.salesReportsDonutChart) {
            this.salesReportsDonutChart.destroy();
        }
        
        // Group by status
        const approved = submissions.filter(s => s.status === 'approved').length;
        const pending = submissions.filter(s => s.status === 'pending').length;
        const rejected = submissions.filter(s => s.status === 'rejected').length;
        
        const statusCounts = {
            'Approved': approved,
            'Pending': pending,
            'Rejected': rejected
        };
        
        const total = Object.values(statusCounts).reduce((a, b) => a + b, 0);
        const percentage = total > 0 ? Math.round((approved / total) * 100) : 0;
        
        this.salesReportsDonutChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Approved', 'Pending', 'Rejected'],
                datasets: [{
                    data: [approved, pending, rejected],
                    backgroundColor: ['#3b82f6', '#10b981', '#ef4444'],
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
            },
            plugins: [{
                id: 'centerText',
                beforeDraw: function(chart) {
                    const ctx = chart.ctx;
                    ctx.save();
                    ctx.font = 'bold 24px Inter';
                    ctx.fillStyle = '#1f2937';
                    ctx.textAlign = 'center';
                    ctx.textBaseline = 'middle';
                    ctx.fillText(percentage + '%', chart.chartArea.left + (chart.chartArea.right - chart.chartArea.left) / 2,
                                 chart.chartArea.top + (chart.chartArea.bottom - chart.chartArea.top) / 2);
                    ctx.restore();
                }
            }]
        });
        
        // Create legend
        const legend = document.getElementById('donutChartLegend');
        if (legend) {
            legend.innerHTML = `
                <div class="legend-item">
                    <div class="legend-dot" style="background: #3b82f6;"></div>
                    <span>Approved</span>
                </div>
                <div class="legend-item">
                    <div class="legend-dot" style="background: #10b981;"></div>
                    <span>Pending</span>
                </div>
                <div class="legend-item">
                    <div class="legend-dot" style="background: #ef4444;"></div>
                    <span>Rejected</span>
                </div>
            `;
        }
    }
    
    async loadAnalyticsBarChart() {
        try {
            console.log('Fetching submissions for bar chart...');
            const response = await fetch('api/get_all_submissions.php');
            
            if (!response.ok) {
                throw new Error(`Submissions API returned ${response.status}`);
            }
            
            const result = await response.json();
            console.log('Bar chart data loaded:', result);
            
            if (result.success) {
                let submissions = result.data || [];
                
                // Filter by campus if not super admin
                if (!this.isSuperAdmin && this.userCampus) {
                    const norm = (x) => (x || '').toString().trim().toLowerCase();
                    const allowed = (this.getAccessibleCampuses() || []).map(norm);
                    submissions = submissions.filter(s => {
                        const subCampus = norm(s.campus);
                        return allowed.includes(subCampus);
                    });
                    console.log(`Filtered bar chart data for ${this.userCampus}: ${submissions.length} submissions`);
                }
                
                console.log(`Creating bar chart with ${submissions.length} submissions`);
                this.createAnalyticsBarChart(submissions);
            } else {
                console.error('API returned error:', result.error || 'Unknown error');
            }
        } catch (error) {
            console.error('Error loading analytics bar chart:', error);
            this.showNotification('Failed to load analytics chart', 'error');
        }
    }
    
    createAnalyticsBarChart(submissions) {
        const ctx = document.getElementById('analyticsBarChart');
        if (!ctx) return;
        
        if (this.analyticsBarChart) {
            this.analyticsBarChart.destroy();
        }
        
        // Group by day of week - use real data (submissions already filtered in loadAnalyticsBarChart)
        const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        const dayData = days.map(day => {
            const dayIndex = days.indexOf(day);
            return submissions.filter(s => {
                const date = new Date(s.submitted_at || s.submission_date || s.created_at);
                return date.getDay() === dayIndex;
            }).length; // Use real count, no scaling
        });
        
        this.analyticsBarChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: days,
                datasets: [{
                    label: 'Analytics',
                    data: dayData,
                    backgroundColor: ['#3b82f6', '#2563eb', '#1d4ed8', '#1e40af', '#1e3a8a', '#1e3a8a', '#3b82f6'],
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
    
    async loadRecentOrdersTable() {
        try {
            console.log('Fetching recent submissions for table...');
            const response = await fetch('api/get_all_submissions.php');
            
            if (!response.ok) {
                throw new Error(`Submissions API returned ${response.status}`);
            }
            
            const result = await response.json();
            console.log('Recent submissions data loaded:', result);
            
            if (result.success) {
                const submissions = result.data || [];
                // Sort by submitted_at or created_at descending to get most recent first
                const sortedSubmissions = submissions.sort((a, b) => {
                    const dateA = new Date(a.submitted_at || a.created_at || 0);
                    const dateB = new Date(b.submitted_at || b.created_at || 0);
                    return dateB - dateA;
                });
                
                console.log(`Populating table with ${Math.min(sortedSubmissions.length, 4)} recent submissions`);
                this.populateRecentOrdersTable(sortedSubmissions.slice(0, 4)); // Get first 4 most recent
            } else {
                console.error('API returned error:', result.error || 'Unknown error');
                const tbody = document.querySelector('#recentOrdersTable tbody');
                if (tbody) {
                    tbody.innerHTML = `
                        <tr>
                            <td colspan="4" style="text-align: center; padding: 40px; color: #ef4444;">
                                Failed to load recent submissions
                            </td>
                        </tr>
                    `;
                }
            }
        } catch (error) {
            console.error('Error loading recent orders:', error);
            this.showNotification('Failed to load recent submissions', 'error');
            const tbody = document.querySelector('#recentOrdersTable tbody');
            if (tbody) {
                tbody.innerHTML = `
                    <tr>
                        <td colspan="4" style="text-align: center; padding: 40px; color: #ef4444;">
                            Error loading data. Please refresh the page.
                        </td>
                    </tr>
                `;
            }
        }
    }
    
    populateRecentOrdersTable(submissions) {
        const tbody = document.querySelector('#recentOrdersTable tbody');
        if (!tbody) return;
        
        if (submissions.length === 0) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="4" style="text-align: center; padding: 40px; color: #9ca3af;">
                        No recent orders
                    </td>
                </tr>
            `;
            return;
        }
        
        const getProductIcon = (index) => {
            const icons = ['shoe', 'camera', 'backpack', 'phone'];
            return icons[index % icons.length];
        };
        
        const getProductName = (submission) => {
            // Extract a meaningful name from submission data
            return submission.report_type || `Report #${submission.id}`;
        };
        
        tbody.innerHTML = submissions.map((submission, index) => {
            const trackingId = `#${String(submission.id).padStart(7, '0')}`;
            const reportType = submission.table_name || submission.report_type || `Report #${submission.id}`;
            const status = submission.status || 'pending';
            const submittedDate = new Date(submission.submitted_at || submission.created_at);
            const formattedDate = submittedDate.toLocaleDateString('en-US', { 
                month: 'short', 
                day: 'numeric', 
                year: 'numeric' 
            });
            const reportTypeIcons = {
                'campuspopulation': 'building',
                'admissiondata': 'user-graduate',
                'enrollmentdata': 'user-plus',
                'graduatesdata': 'user-graduate',
                'employee': 'user-tie',
                'leaveprivilege': 'calendar-alt',
                'disabilitydata': 'wheelchair',
                'wastedata': 'trash',
                'vehicledata': 'car',
                'fueldata': 'gas-pump',
                'waterdata': 'tint',
                'electricitydata': 'bolt'
            };
            const iconName = reportTypeIcons[reportType.toLowerCase()] || 'file-alt';
            
            return `
                <tr>
                    <td>${trackingId}</td>
                    <td>
                        <span class="product-icon" style="background: #e0e7ff; color: #3b82f6;">
                            <i class="fas fa-${iconName}"></i>
                        </span>
                        ${reportType}
                    </td>
                    <td>
                        <span class="status-badge-modern ${status}">${status}</span>
                    </td>
                    <td class="price-value">${formattedDate}</td>
                </tr>
            `;
        }).join('');
    }
    
    // New Advanced Dashboard Functions
    async loadKPICards() {
        try {
            console.log('Loading KPI cards...');
            const [usersResponse, submissionsResponse] = await Promise.all([
                fetch(this.isSuperAdmin || !this.userCampus
                    ? 'api/users.php?action=list'
                    : `api/users.php?action=list&campus=${encodeURIComponent(this.userCampus)}`),
                fetch('api/get_all_submissions.php')
            ]);
            
            const usersResult = await usersResponse.json();
            const submissionsResult = await submissionsResponse.json();
            
            if (usersResult.success && submissionsResult.success) {
                let users = usersResult.users || [];
                let submissions = submissionsResult.data || [];
                
                // Filter by campus if not super admin
                if (!this.isSuperAdmin && this.userCampus) {
                    const norm = (x) => (x || '').toString().trim().toLowerCase();
                    const allowed = (this.getAccessibleCampuses() || []).map(norm);
                    
                    // Filter users by campus
                    users = users.filter(u => {
                        const userCampus = norm(u.campus);
                        return allowed.includes(userCampus) || 
                               u.role === 'super_admin' || 
                               u.campus === 'All Campuses';
                    });
                    
                    // Filter submissions by accessible campuses
                    submissions = submissions.filter(s => {
                        const subCampus = norm(s.campus);
                        return allowed.includes(subCampus);
                    });
                    
                    console.log(`Filtered KPI data for ${this.userCampus}: ${users.length} users, ${submissions.length} submissions`);
                }
                
                // Calculate KPI values from real data
                const totalSubmissions = submissions.length;
                const activeUsers = users.filter(u => u.status === 'active').length;
                const totalUsers = users.length;
                // Calculate total records (sum of all record_count from submissions)
                const totalRecords = submissions.reduce((sum, s) => {
                    const recordCount = parseInt(s.record_count || 0, 10);
                    return sum + (isNaN(recordCount) ? 0 : recordCount);
                }, 0);
                
                // Calculate percentage changes by comparing current month vs previous month
                const now = new Date();
                const currentMonth = new Date(now.getFullYear(), now.getMonth(), 1);
                const lastMonth = new Date(now.getFullYear(), now.getMonth() - 1, 1);
                const twoMonthsAgo = new Date(now.getFullYear(), now.getMonth() - 2, 1);
                
                const currentMonthSubmissions = submissions.filter(s => {
                    const subDate = new Date(s.submitted_at || s.submission_date || s.created_at);
                    return subDate >= currentMonth;
                }).length;
                
                const lastMonthSubmissions = submissions.filter(s => {
                    const subDate = new Date(s.submitted_at || s.submission_date || s.created_at);
                    return subDate >= lastMonth && subDate < currentMonth;
                }).length;
                
                const submissionsChange = lastMonthSubmissions > 0 
                    ? Math.round(((currentMonthSubmissions - lastMonthSubmissions) / lastMonthSubmissions) * 100)
                    : (currentMonthSubmissions > 0 ? 100 : 0);
                
                // Calculate user changes (current vs previous month)
                const currentMonthUsers = users.filter(u => {
                    const userDate = new Date(u.created_at || u.registered_at || '2000-01-01');
                    return userDate >= currentMonth;
                }).length;
                
                const lastMonthUsers = users.filter(u => {
                    const userDate = new Date(u.created_at || u.registered_at || '2000-01-01');
                    return userDate >= lastMonth && userDate < currentMonth;
                }).length;
                
                const totalUsersChange = lastMonthUsers > 0
                    ? Math.round(((currentMonthUsers - lastMonthUsers) / lastMonthUsers) * 100)
                    : (currentMonthUsers > 0 ? 100 : 0);
                
                const activeUsersChange = totalUsersChange; // Use same calculation for active users
                
                // Calculate total records changes (current month vs last month)
                const currentMonthRecords = submissions.filter(s => {
                    const subDate = new Date(s.submitted_at || s.submission_date || s.created_at);
                    return subDate >= currentMonth;
                }).reduce((sum, s) => {
                    const recordCount = parseInt(s.record_count || 0, 10);
                    return sum + (isNaN(recordCount) ? 0 : recordCount);
                }, 0);
                
                const lastMonthRecords = submissions.filter(s => {
                    const subDate = new Date(s.submitted_at || s.submission_date || s.created_at);
                    return subDate >= lastMonth && subDate < currentMonth;
                }).reduce((sum, s) => {
                    const recordCount = parseInt(s.record_count || 0, 10);
                    return sum + (isNaN(recordCount) ? 0 : recordCount);
                }, 0);
                
                const reportsChange = lastMonthRecords > 0
                    ? Math.round(((currentMonthRecords - lastMonthRecords) / lastMonthRecords) * 100)
                    : (currentMonthRecords > 0 ? 100 : 0);
                
                // Update KPI Cards
                this.updateKPICard('kpiTotalSubmissions', totalSubmissions, submissionsChange, 'kpiSubmissionsChart');
                this.updateKPICard('kpiActiveUsers', activeUsers, activeUsersChange, 'kpiActiveUsersChart');
                this.updateKPICard('kpiTotalUsers', totalUsers, totalUsersChange, 'kpiTotalUsersChart');
                this.updateKPICard('kpiTotalReports', totalRecords, reportsChange, 'kpiReportsChart');
                
                // Update change indicators
                this.updateKPIChange('kpiSubmissionsChange', submissionsChange);
                this.updateKPIChange('kpiActiveUsersChange', activeUsersChange);
                this.updateKPIChange('kpiTotalUsersChange', totalUsersChange);
                this.updateKPIChange('kpiReportsChange', reportsChange);
                
                // Create mini charts
                this.createMiniCharts(submissions);
            }
        } catch (error) {
            console.error('Error loading KPI cards:', error);
        }
    }
    
    updateKPICard(valueId, value, change, chartId, isPercentage = false) {
        const valueEl = document.getElementById(valueId);
        if (valueEl) {
            if (isPercentage) {
                valueEl.textContent = value;
            } else {
                valueEl.textContent = typeof value === 'number' ? value.toLocaleString() : value;
            }
        }
    }
    
    updateKPIChange(changeId, change) {
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
    
    createMiniCharts(submissions) {
        // Create mini sparkline charts for KPI cards
        const chartIds = ['kpiSubmissionsChart', 'kpiActiveUsersChart', 'kpiTotalUsersChart', 'kpiReportsChart'];
        
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
                    const subDate = new Date(s.submitted_at || s.created_at);
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
            
            const colors = ['#3b82f6', '#ef4444', '#10b981', '#3b82f6', '#8b5cf6'];
            container.innerHTML = `
                <svg width="${width}" height="${height}" style="width: 100%; height: 100%;">
                    <polyline points="${points}" fill="none" stroke="${colors[index]}" stroke-width="2"/>
                </svg>
            `;
        });
    }
    
    async loadSubmissionsGrowthChart(monthFilter = 'current') {
        try {
            const response = await fetch('api/get_all_submissions.php', { credentials: 'include' });
            const result = await response.json();
            
            if (result.success) {
                let submissions = this.filterByAnalyticsType(result.data || []);
                
                // Filter by month if specified
                if (monthFilter === 'current') {
                    const now = new Date();
                    const currentMonth = now.getMonth();
                    const currentYear = now.getFullYear();
                    submissions = submissions.filter(s => {
                        const date = new Date(s.submitted_at || s.created_at);
                        return date.getMonth() === currentMonth && date.getFullYear() === currentYear;
                    });
                } else if (monthFilter === 'last') {
                    const now = new Date();
                    const lastMonth = now.getMonth() === 0 ? 11 : now.getMonth() - 1;
                    const lastMonthYear = now.getMonth() === 0 ? now.getFullYear() - 1 : now.getFullYear();
                    submissions = submissions.filter(s => {
                        const date = new Date(s.submitted_at || s.created_at);
                        return date.getMonth() === lastMonth && date.getFullYear() === lastMonthYear;
                    });
                }
                
                await this.createSubmissionsGrowthChart(submissions);
            }
        } catch (error) {
            console.error('Error loading growth chart:', error);
        }
    }
    
    async createSubmissionsGrowthChart(submissions) {
        const canvas = document.getElementById('submissionsGrowthChart');
        if (!canvas) return;
        // Hard-destroy any existing chart bound to this canvas (defensive for double inits)
        try {
            const existing = (window.Chart && Chart.getChart) ? Chart.getChart(canvas) : null;
            if (existing) { existing.destroy(); }
        } catch(_) {}
        if (this.submissionsGrowthChart && typeof this.submissionsGrowthChart.destroy === 'function') {
            try { this.submissionsGrowthChart.destroy(); } catch(_) {}
            this.submissionsGrowthChart = null;
        }
        const ctx = canvas.getContext('2d');
        
        const isBar = !!(this.analyticsReportType && this.analyticsReportType.trim());
        const chartType = isBar ? 'bar' : 'line';

        let labels = [];
        let actualData = [];
        let maxY = 0;
        let stepSize = 1;

        if (!isBar) {
            // Group by month for yearly view (line chart)
            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            const monthlyData = months.map((_, index) => {
                return submissions.filter(s => {
                    const date = new Date(s.submitted_at || s.created_at);
                    return date.getMonth() === index;
                }).length;
            });
            labels = months;
            actualData = monthlyData;
            const maxValue = Math.max(...actualData, 1);
            maxY = Math.ceil(maxValue / 5) * 5 || 5;
            stepSize = Math.max(1, Math.ceil(maxY / 5));
        } else {
            // Bar mode: show per-column completeness for the selected report type
            const completeness = new Map(); // col -> {filled,total}
            let extractedRows = 0;
            const isMeta = (col) => {
                const raw = (col || '').toString().trim();
                const k = raw.toLowerCase();
                if ([
                    'id','submission_id','assignment_id','batch_id','status','campus','office','table_name','report_type',
                    'user_name','user_email','record_count','submission_data','created_at','updated_at','submitted_at','submittedat',
                    'submitted_by','reviewed_by','reviewed_at','review_notes','review_note','review_date','_row','_index'
                ].includes(k)) return true;
                const patterns = [
                    /submission\s*_?id/i,
                    /assignment\s*_?id/i,
                    /batch\s*_?id/i,
                    /^(submitted|reviewed)\s*_?by$/i,
                    /^(submitted|reviewed)\s*_?at$/i,
                    /review(\s*_)?notes?/i,
                    /review(\s*_)?date/i,
                    /record(\s*_)?count/i,
                    /report(\s*_)?type/i,
                    /submission(\s*_)?data/i,
                    /^_.+/
                ];
                return patterns.some(p => p.test(raw));
            };
            submissions.forEach(s => {
                let d = (s.data !== undefined && s.data !== null) ? s.data : s.submission_data;
                // If data is a JSON string, try to parse
                if (typeof d === 'string') {
                    try { d = JSON.parse(d); } catch (_) { /* ignore */ }
                }
                if (Array.isArray(d)) {
                    d.forEach(row => {
                        if (row && typeof row === 'object') {
                            extractedRows++;
                            Object.keys(row).forEach(col => {
                                if (isMeta(col)) return;
                                const key = col.toString();
                                const val = row[col];
                                const entry = completeness.get(key) || { filled: 0, total: 0 };
                                entry.total += 1;
                                if (val !== null && val !== undefined && String(val).trim() !== '') entry.filled += 1;
                                completeness.set(key, entry);
                            });
                        }
                    });
                } else if (d && typeof d === 'object') {
                    extractedRows++;
                    // Support shape: { columns: [...], rows: [...] }
                    if (Array.isArray(d.columns) && Array.isArray(d.rows)) {
                        const cols = d.columns.map(c => c && c.name ? c.name : c).map(String).filter(c => !isMeta(c));
                        d.rows.forEach(row => {
                            extractedRows++;
                            cols.forEach((colName, idx) => {
                                const val = Array.isArray(row) ? row[idx] : (row ? row[colName] : undefined);
                                const entry = completeness.get(colName) || { filled: 0, total: 0 };
                                entry.total += 1;
                                if (val !== null && val !== undefined && String(val).trim() !== '') entry.filled += 1;
                                completeness.set(colName, entry);
                            });
                        });
                    } else {
                        // Treat as plain object record
                        Object.keys(d).forEach(col => {
                            if (isMeta(col)) return;
                            const key = col.toString();
                            const val = d[col];
                            const entry = completeness.get(key) || { filled: 0, total: 0 };
                            entry.total += 1;
                            if (val !== null && val !== undefined && String(val).trim() !== '') entry.filled += 1;
                            completeness.set(key, entry);
                        });
                    }
                }
            });

            // If still empty, support array-of-arrays with columns on submission root
            if (completeness.size === 0) {
                submissions.forEach(s => {
                    let d = (s.data !== undefined && s.data !== null) ? s.data : s.submission_data;
                    if (typeof d === 'string') { try { d = JSON.parse(d); } catch(_){} }
                    if (Array.isArray(d) && d.length && Array.isArray(d[0]) && Array.isArray(s.columns)) {
                        const cols = s.columns.map(String).filter(c => !isMeta(c));
                        d.forEach(row => {
                            extractedRows++;
                            cols.forEach((colName, idx) => {
                                const val = row[idx];
                                const entry = completeness.get(colName) || { filled: 0, total: 0 };
                                entry.total += 1;
                                if (val !== null && val !== undefined && String(val).trim() !== '') entry.filled += 1;
                                completeness.set(colName, entry);
                            });
                        });
                    }
                });
            }

            // Compute % per column and sort by highest completeness
            const items = Array.from(completeness.entries()).map(([col, stats]) => {
                const pct = stats.total > 0 ? Math.round((stats.filled / stats.total) * 100) : 0;
                return { col, pct };
            }).sort((a,b) => b.pct - a.pct);

            // Show all columns discovered (could be many). Preserve declared order if available
            const declaredCols = (() => {
                for (const s of submissions) {
                    let d = (s.data !== undefined && s.data !== null) ? s.data : s.submission_data;
                    if (typeof d === 'string') { try { d = JSON.parse(d); } catch(_){} }
                    if (d && typeof d === 'object') {
                        if (Array.isArray(d.columns)) {
                            return d.columns.map(c => c && c.name ? c.name : c).map(String).filter(c => !isMeta(c));
                        }
                        if (Array.isArray(s.columns)) {
                            return s.columns.map(String).filter(c => !isMeta(c));
                        }
                        if (!Array.isArray(d) && Object.keys(d).length) {
                            return Object.keys(d).filter(c => !isMeta(c));
                        }
                    }
                }
                return null;
            })();
            if (declaredCols && declaredCols.length) {
                // Order items by declared column order
                const map = new Map(items.map(i => [i.col, i.pct]));
                labels = declaredCols.map(c => this.formatColumnName(c));
                actualData = declaredCols.map(c => map.has(c) ? map.get(c) : 0);
            } else {
                labels = items.map(x => this.formatColumnName(x.col));
                actualData = items.map(x => x.pct);
            }
            maxY = 100;
            stepSize = 20;
            if (labels.length === 0) {
                console.warn('No real table columns found in list data. Rows examined:', extractedRows, 'Submissions:', submissions.length, '— attempting to fetch a sample submission for detailed schema...');
                // Fallback: fetch a single full submission for this report type and derive columns
                try {
                    const sample = await this.fetchSampleSubmissionForType(this.analyticsReportType);
                    if (sample && sample.columns && sample.rows) {
                        // Filter out meta/system columns from the sample as well
                        const cols = sample.columns.map(String).filter(c => !isMeta(c));
                        const comp = cols.map(colName => {
                            let filled = 0, total = 0;
                            sample.rows.forEach(row => {
                                const val = row && (Array.isArray(row) ? row[cols.indexOf(colName)] : row[colName]);
                                total += 1;
                                if (val !== null && val !== undefined && String(val).trim() !== '') filled += 1;
                            });
                            return { col: colName, pct: total > 0 ? Math.round((filled/total)*100) : 0 };
                        });
                        labels = cols.map(c => this.formatColumnName(c));
                        actualData = comp.map(x => x.pct);
                        maxY = 100; stepSize = 20;
                    }
                } catch (e) {
                    console.warn('Sample submission fetch failed:', e);
                }
            }
        }

        this.submissionsGrowthChart = new Chart(ctx, {
            type: chartType,
            data: {
                labels: labels,
                datasets: [{
                    label: isBar ? 'Completeness' : 'Submissions',
                    data: actualData,
                    borderColor: '#3b82f6',
                    backgroundColor: isBar ? '#3b82f6' : 'rgba(59, 130, 246, 0.1)',
                    borderWidth: 2,
                    tension: isBar ? 0 : 0.4,
                    fill: isBar ? false : true,
                    pointRadius: isBar ? 0 : 0,
                    pointHoverRadius: isBar ? 0 : 6,
                    pointBackgroundColor: '#3b82f6',
                    pointBorderColor: '#fff',
                    pointBorderWidth: isBar ? 0 : 2,
                    borderSkipped: isBar ? false : undefined,
                    borderRadius: isBar ? 6 : 0
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
                            label: (context) => {
                                const value = context.parsed.y;
                                return isBar ? `Completeness ${value}%` : `Submissions ${value}`;
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
                            color: '#6b7280',
                            callback: (value) => isBar ? `${value}%` : value
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
                            font: { size: 10 },
                            color: '#6b7280',
                            autoSkip: false,
                            maxRotation: 25,
                            minRotation: 0
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
    
    async loadSubmissionsMonthlyChart() {
        try {
            const response = await fetch('api/get_all_submissions.php', { credentials: 'include' });
            const result = await response.json();
            
            if (result.success) {
                const submissions = this.filterByAnalyticsType(result.data || []);
                this.createSubmissionsMonthlyChart(submissions);
            }
        } catch (error) {
            console.error('Error loading monthly chart:', error);
        }
    }
    
    createSubmissionsMonthlyChart(submissions) {
        const canvas = document.getElementById('submissionsMonthlyChart');
        if (!canvas) return;
        // Hard-destroy any existing chart bound to this canvas (defensive)
        try {
            const existing = (window.Chart && Chart.getChart) ? Chart.getChart(canvas) : null;
            if (existing) { existing.destroy(); }
        } catch(_) {}
        if (this.submissionsMonthlyChart && typeof this.submissionsMonthlyChart.destroy === 'function') {
            try { this.submissionsMonthlyChart.destroy(); } catch(_) {}
            this.submissionsMonthlyChart = null;
        }
        const ctx = canvas.getContext('2d');
        
        // Group by month
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        const monthlyData = months.map((month, index) => {
            return submissions.filter(s => {
                const date = new Date(s.submitted_at || s.created_at);
                return date.getMonth() === index;
            }).length;
        });
        
        // Calculate total submissions across all months
        const totalSubmissions = monthlyData.reduce((sum, count) => sum + count, 0);
        
        const currentMonth = new Date().getMonth();
        const currentCount = monthlyData[currentMonth] || 0;
        // Hide growth badge and Approved/Growth Rate metric blocks
        const growthBadge = document.getElementById('monthlyReportGrowth');
        if (growthBadge) growthBadge.style.display = 'none';
        const hideMetricBlock = (valueElId) => {
            const el = document.getElementById(valueElId);
            if (!el) return;
            const block = el.closest && el.closest('.report-metric');
            if (block) block.style.display = 'none'; else el.style.display = 'none';
        };
        hideMetricBlock('monthlyReach');
        hideMetricBlock('monthlyGrowth');
        // Only show/update Submissions metric - use total, not just current month
        const impressionsEl = document.getElementById('monthlyImpressions');
        if (impressionsEl) impressionsEl.textContent = totalSubmissions.toLocaleString();
        
        // Use actual data, not scaled percentages
        const chartData = monthlyData;
        
        // Calculate max Y value for proper scaling
        const maxValue = Math.max(...chartData, 1);
        let maxY;
        if (maxValue >= 1000) maxY = Math.ceil(maxValue / 1000) * 1000;
        else if (maxValue >= 100) maxY = Math.ceil(maxValue / 100) * 100;
        else if (maxValue >= 10) maxY = Math.ceil(maxValue / 10) * 10;
        else maxY = Math.ceil(maxValue);
        if (maxValue === 0) maxY = 10;
        const stepSize = maxY >= 10 ? Math.ceil(maxY / 10) : 1;
        
        this.submissionsMonthlyChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: months,
                datasets: [{
                    label: 'Submissions',
                    data: chartData,
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
                        borderRadius: 8,
                        callbacks: {
                            label: function(context) {
                                return `${context.parsed.y} submissions`;
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
                            callback: function(value) {
                                return value;
                            }
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
    
    async loadUserStatusList() {
        try {
            const usersUrl = this.isSuperAdmin || !this.userCampus
                ? 'api/users.php?action=list'
                : `api/users.php?action=list&campus=${encodeURIComponent(this.userCampus)}`;
            
            const response = await fetch(usersUrl);
            const result = await response.json();
            
            if (result.success) {
                const users = result.users || [];
                this.populateUserStatusList(users.slice(0, 5)); // Get top 5
            }
        } catch (error) {
            console.error('Error loading user status list:', error);
        }
    }
    
    populateUserStatusList(users) {
        const container = document.getElementById('userStatusList');
        if (!container) return;
        
        if (users.length === 0) {
            container.innerHTML = '<p style="text-align: center; color: #9ca3af; padding: 40px;">No users found</p>';
            return;
        }
        
        const avatarColors = ['blue', 'red', 'green', 'purple', 'orange'];
        const progressColors = ['#3b82f6', '#ef4444', '#10b981', '#8b5cf6', '#f59e0b'];
        
        container.innerHTML = users.map((user, index) => {
            const avatarColor = avatarColors[index % avatarColors.length];
            const progressColor = progressColors[index % progressColors.length];
            const initials = (user.name || user.username || 'U').split(' ').map(n => n[0]).join('').toUpperCase().substring(0, 2);
            
            // Calculate user activity percentage (based on status or submissions)
            const activityPercentage = user.status === 'active' ? 
                (70 + Math.random() * 30) : // Active users: 70-100%
                (Math.random() * 40); // Inactive users: 0-40%
            
            return `
                <div class="user-status-item">
                    <div class="user-avatar ${avatarColor}">${initials}</div>
                    <div class="user-info">
                        <div class="user-name">${user.name || user.username || 'Unknown'}</div>
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <div class="user-progress-bar">
                                <div class="user-progress-fill" style="width: ${activityPercentage}%; background: ${progressColor};"></div>
                            </div>
                            <span class="user-progress-value">${Math.round(activityPercentage)}%</span>
                        </div>
                    </div>
                    <i class="fas fa-chevron-right user-action-arrow"></i>
                </div>
            `;
        }).join('');
    }
    
    async loadReportsByType() {
        try {
            const response = await fetch('api/get_all_submissions.php');
            const result = await response.json();
            
            if (result.success) {
                const submissions = this.filterByAnalyticsType(result.data || []);
                this.createReportsByTypeChart(submissions);
            }
        } catch (error) {
            console.error('Error loading reports by type:', error);
        }
    }
    
    createReportsByTypeChart(submissions) {
        const canvas = document.getElementById('reportsByTypeChart');
        if (!canvas) return;
        // Hard-destroy any existing chart bound to this canvas (defensive)
        try {
            const existing = (window.Chart && Chart.getChart) ? Chart.getChart(canvas) : null;
            if (existing) { existing.destroy(); }
        } catch(_) {}
        if (this.reportsByTypeChart && typeof this.reportsByTypeChart.destroy === 'function') {
            try { this.reportsByTypeChart.destroy(); } catch(_) {}
            this.reportsByTypeChart = null;
        }
        const ctx = canvas.getContext('2d');
        
        // Group submissions by report type (table_name)
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
            .sort((a, b) => b[1] - a[1]);
        
        const total = Object.values(reportTypeCounts).reduce((a, b) => a + b, 0);
        const totalReportTypes = Object.keys(reportTypeCounts).length;
        
        // Update center text - show total report types
        const centerText = document.getElementById('reportTypeChartCenterText');
        if (centerText) {
            centerText.textContent = totalReportTypes;
            centerText.style.fontSize = '20px';
            centerText.style.fontWeight = '700';
            centerText.style.lineHeight = '1.2';
        }
        
        // Prepare data for chart - use all report types or top 5
        const topTypes = sortedTypes.slice(0, 5);
        const labels = topTypes.map(([type]) => this.formatReportTypeName(type));
        const data = topTypes.map(([, count]) => count);
        const colors = ['#8b5cf6', '#f59e0b', '#10b981', '#ef4444', '#ec4899'];
        
        this.reportsByTypeChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: colors.slice(0, data.length),
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
                        borderRadius: 8,
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.parsed || 0;
                                const percentage = total > 0 ? Math.round((value / total) * 100) : 0;
                                return `${label}: ${value} (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        });
        
        // Create legend
        const legend = document.getElementById('reportTypeChartLegend');
        if (legend) {
            legend.innerHTML = topTypes.map(([type, count], index) => {
                const percentage = total > 0 ? Math.round((count / total) * 100) : 0;
                const color = colors[index % colors.length];
                const formattedName = this.formatReportTypeName(type);
                return `
                    <div class="donut-legend-item">
                        <div class="donut-legend-dot" style="background: ${color};"></div>
                        <span class="donut-legend-label">${formattedName}</span>
                        <span class="donut-legend-value">${percentage}%</span>
                    </div>
                `;
            }).join('');
        }
    }
    
    formatReportTypeName(type) {
        if (!type) return 'Unknown';
        
        // Format report type names for better display
        const nameMap = {
            'campuspopulation': 'Campus Population',
            'admissiondata': 'Admission Data',
            'enrollmentdata': 'Enrollment Data',
            'graduatesdata': 'Graduates Data',
            'employee': 'Employee',
            'pwd': 'PWD',
            'leaveprivilege': 'Leave Privilege',
            'disabilitydata': 'Disability Data',
            'wastedata': 'Waste Data',
            'vehicledata': 'Vehicle Data',
            'fueldata': 'Fuel Data',
            'waterdata': 'Water Data',
            'electricitydata': 'Electricity Data',
            'budgetexpenditure': 'Budget Expenditure',
            'foodwaste': 'Food Waste',
            'fuelconsumption': 'Fuel Consumption',
            'distancetraveled': 'Distance Traveled',
            'flightaccommodation': 'Flight Accommodation',
            'waterconsumption': 'Water Consumption',
            'treatedwastewater': 'Treated Waste Water',
            'electricityconsumption': 'Electricity Consumption',
            'solidwaste': 'Solid Waste',
            'libraryvisitor': 'Library Visitor'
        };
        
        const lowerType = type.toLowerCase().trim();
        if (nameMap[lowerType]) {
            return nameMap[lowerType];
        }
        
        // Handle acronyms (like PWD) - check if all uppercase or all lowercase short words
        if (type.length <= 5 && (type === type.toUpperCase() || type === type.toLowerCase())) {
            // If it's a short acronym-like string, check common acronyms
            const acronymMap = {
                'pwd': 'PWD',
                'pwddata': 'PWD Data'
            };
            if (acronymMap[lowerType]) {
                return acronymMap[lowerType];
            }
            // If it's uppercase or looks like an acronym, return uppercase
            if (lowerType.length <= 4) {
                return type.toUpperCase();
            }
        }
        
        // Convert camelCase or snake_case to readable format
        let formatted = type
            .replace(/([A-Z])/g, ' $1')
            .replace(/_/g, ' ')
            .replace(/\b\w/g, l => l.toUpperCase())
            .trim();
        
        // Split common compound words
        formatted = formatted.replace(/Data/g, ' Data');
        
        return formatted.trim();
    }
    
    async loadTopActiveReports(timeRange = 'monthly') {
        try {
            const response = await fetch('api/get_all_submissions.php');
            const result = await response.json();
            
            if (result.success) {
                let submissions = this.filterByAnalyticsType(result.data || []);
                
                // Filter by time range
                if (timeRange === 'weekly') {
                    const now = new Date();
                    const weekAgo = new Date(now.getTime() - (7 * 24 * 60 * 60 * 1000));
                    submissions = submissions.filter(s => {
                        const date = new Date(s.submitted_at || s.created_at);
                        return date >= weekAgo;
                    });
                } else if (timeRange === 'monthly') {
                    const now = new Date();
                    const monthAgo = new Date(now.getFullYear(), now.getMonth() - 1, now.getDate());
                    submissions = submissions.filter(s => {
                        const date = new Date(s.submitted_at || s.created_at);
                        return date >= monthAgo;
                    });
                } else if (timeRange === 'yearly') {
                    const now = new Date();
                    const yearAgo = new Date(now.getFullYear() - 1, now.getMonth(), now.getDate());
                    submissions = submissions.filter(s => {
                        const date = new Date(s.submitted_at || s.created_at);
                        return date >= yearAgo;
                    });
                }
                
                this.populateTopActiveReports(submissions);
            }
        } catch (error) {
            console.error('Error loading top active reports:', error);
        }
    }
    
    populateTopActiveReports(submissions) {
        const tbody = document.querySelector('#topReportsTable tbody');
        if (!tbody) return;
        
        // Group by report type
        const reportTypeCounts = {};
        submissions.forEach(s => {
            const reportType = (s.table_name || s.report_type || 'Unknown').trim();
            if (!reportTypeCounts[reportType]) {
                reportTypeCounts[reportType] = { count: 0, approved: 0 };
            }
            reportTypeCounts[reportType].count++;
            if (s.status === 'approved') {
                reportTypeCounts[reportType].approved++;
            }
        });
        
        // Sort by count and get top 5
        const topReports = Object.entries(reportTypeCounts)
            .map(([type, data]) => ({
                type,
                count: data.count,
                approved: data.approved,
                rate: data.count > 0 ? Math.round((data.approved / data.count) * 100) : 0
            }))
            .sort((a, b) => b.count - a.count)
            .slice(0, 5);
        
        if (topReports.length === 0) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="2" style="text-align: center; padding: 40px; color: #9ca3af;">
                        No reports found
                    </td>
                </tr>
            `;
            return;
        }
        
        const reportTypeIcons = {
            'campuspopulation': 'building',
            'admissiondata': 'user-graduate',
            'enrollmentdata': 'user-plus',
            'graduatesdata': 'user-graduate',
            'employee': 'user-tie',
            'pwd': 'user-shield',
            'pwddata': 'user-shield',
            'leaveprivilege': 'calendar-alt',
            'disabilitydata': 'wheelchair',
            'wastedata': 'trash',
            'vehicledata': 'car',
            'fueldata': 'gas-pump',
            'waterdata': 'tint',
            'electricitydata': 'bolt'
        };
        
        tbody.innerHTML = topReports.map(report => {
            const iconName = reportTypeIcons[report.type.toLowerCase()] || 'file-alt';
            const formattedType = this.formatReportTypeName(report.type);
            
            return `
                <tr>
                    <td>
                        <div class="report-type-cell">
                            <div class="report-type-icon" style="background: #e0e7ff; color: #3b82f6;">
                                <i class="fas fa-${iconName}"></i>
                            </div>
                            <span>${formattedType}</span>
                        </div>
                    </td>
                    <td>${report.count}</td>
                </tr>
            `;
        }).join('');
    }
    
    async loadAnalytics() {
        console.log('Loading analytics...');
        
        try {
            const response = await fetch('api/get_all_submissions.php');
            const result = await response.json();
            
            if (result.success) {
                let submissions = result.data || [];
                
                // Filter by campuses if not super admin
                if (!this.isSuperAdmin && this.userCampus) {
                    const norm = (x) => (x || '').toString().trim().toLowerCase().replace(/\s*campus\s*$/,'').replace(/[^a-z0-9]/g,'');
                    const allowed = (this.getAccessibleCampuses() || []).map(norm);
                    submissions = submissions.filter(s => {
                        const k = norm(s.campus);
                        return allowed.some(a => k.includes(a) || a.includes(k));
                    });
                    console.log(`Filtered by campuses ${allowed.join(', ')}: ${submissions.length} submissions`);
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
    
    /**
     * Refresh analytics if dashboard section is currently visible
     * @param {boolean} forceRefresh - If true, refresh even if dashboard section check fails
     */
    async refreshAnalyticsIfVisible(forceRefresh = false) {
        try {
            // Check if dashboard section is visible (unless forced)
            if (!forceRefresh) {
                const dashboardSection = document.getElementById('dashboard');
                if (!dashboardSection || !dashboardSection.classList.contains('active')) {
                    return; // Dashboard not visible, skip refresh
                }
            }
            
            console.log('Refreshing analytics...');
            
            // Refresh analytics summary (loadAnalytics)
            await this.loadAnalytics();
            
            // Refresh dashboard stats and charts
            await this.loadDashboardStats();
            await this.loadSubmissionsGrowthChart('current');
            await this.loadSubmissionsMonthlyChart();
            await this.loadReportsByType();
            await this.loadTopActiveReports('monthly');
            
            // Refresh KPI cards
            await this.loadKPICards();
            
            console.log('Analytics refreshed successfully');
        } catch (error) {
            console.error('Error refreshing analytics:', error);
            // Don't show error to user - this is a background refresh
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
            maintenanceMode: document.getElementById('settingMaintenanceMode')?.checked,
            maxFileSize: document.getElementById('settingMaxFileSize')?.value,
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
            if (settings.maintenanceMode !== undefined) document.getElementById('settingMaintenanceMode').checked = settings.maintenanceMode;
            if (settings.maxFileSize) document.getElementById('settingMaxFileSize').value = settings.maxFileSize;
            if (settings.exportFormat) document.getElementById('settingExportFormat').value = settings.exportFormat;
            
            console.log('Settings loaded:', settings);
        } catch (error) {
            console.error('Error loading settings:', error);
        }
    }

    /**
     * ===== Campus Management (Super Admin Only) =====
     * Uses api/campus_settings.php to load/save dynamic campus hierarchy.
     */
    async initCampusManagement() {
        try {
            const card = document.getElementById('campusManagementCard');
            if (!card) return;

            // Only show for super admins (front-end guard; backend also checks)
            if (!this.isSuperAdmin) {
                card.style.display = 'none';
                return;
            }

            card.style.display = 'block';
            await this.loadCampusSettings();
            // Also sync the Add User campus dropdown with dynamic campuses
            this.updateUserCampusDropdownFromCampuses();
        } catch (e) {
            console.error('Error initializing campus management:', e);
        }
    }

    async loadCampusSettings() {
        try {
            const body = document.getElementById('campusSettingsBody');
            if (!body) return;

            body.innerHTML = `
                <tr>
                    <td colspan="3" style="text-align:center; padding: 16px; color: #6b7280;">
                        <i class="fas fa-spinner fa-spin"></i> Loading campus list...
                    </td>
                </tr>
            `;

            const response = await fetch('api/campus_settings.php', {
                method: 'GET',
                credentials: 'include'
            });

            const result = await response.json();
            if (!result.success || !result.data || !Array.isArray(result.data.campuses)) {
                throw new Error(result.message || 'Failed to load campus settings');
            }

            this.campusSettings = result.data.campuses;
            this.renderCampusSettingsTable();
            this.refreshCampusParentOptions();
            this.updateUserCampusDropdownFromCampuses();
        } catch (error) {
            console.error('Error loading campus settings:', error);
            const body = document.getElementById('campusSettingsBody');
            if (body) {
                body.innerHTML = `
                    <tr>
                        <td colspan="3" style="text-align:center; padding: 16px; color: #b91c1c;">
                            Failed to load campus list. Please try again later.
                        </td>
                    </tr>
                `;
            }
            this.showNotification('Failed to load campus list', 'error');
        }
    }

    renderCampusSettingsTable() {
        const body = document.getElementById('campusSettingsBody');
        if (!body) return;

        const campuses = this.campusSettings || [];
        if (campuses.length === 0) {
            body.innerHTML = `
                <tr>
                    <td colspan="3" style="text-align:center; padding: 16px; color: #6b7280;">
                        No campuses defined yet. Use the form below to add one.
                    </td>
                </tr>
            `;
            return;
        }

        const rows = campuses
            .slice()
            .sort((a, b) => (a.name || '').localeCompare(b.name || ''))
            .map((item, index) => {
                const campusName = (item.name || '').toString();
                const parent = (item.parent || '') ? item.parent : '—';
                return `
                    <tr data-index="${index}">
                        <td>${campusName}</td>
                        <td>${parent}</td>
                        <td>
                            <button class="btn-sm btn-view" type="button" onclick="adminDashboard.removeCampus(${index})" style="background: linear-gradient(135deg,#ef4444 0%,#dc2626 100%);">
                                <i class="fas fa-trash-alt"></i> Remove
                            </button>
                        </td>
                    </tr>
                `;
            })
            .join('');

        body.innerHTML = rows;
    }

    refreshCampusParentOptions() {
        const parentSelect = document.getElementById('newCampusParent');
        if (!parentSelect) return;

        const campuses = this.campusSettings || [];
        const previous = parentSelect.value;

        parentSelect.innerHTML = `
            <option value="">No Parent (Top-level campus)</option>
        `;

        campuses
            .slice()
            .sort((a, b) => (a.name || '').localeCompare(b.name || ''))
            .forEach(item => {
                const name = (item.name || '').toString();
                if (!name) return;
                const opt = document.createElement('option');
                opt.value = name;
                opt.textContent = name;
                parentSelect.appendChild(opt);
            });

        if (previous && Array.from(parentSelect.options).some(o => o.value === previous)) {
            parentSelect.value = previous;
        }
    }

    cancelEditCampus() {
        const nameInput = document.getElementById('newCampusName');
        const parentSelect = document.getElementById('newCampusParent');
        const label = document.getElementById('campusFormSubmitLabel');
        const cancelEditBtn = document.getElementById('cancelEditCampus');
        
        this.editCampusIndex = null;
        
        if (nameInput) {
            nameInput.value = '';
            nameInput.disabled = false;
        }
        if (parentSelect) {
            parentSelect.value = '';
        }
        if (label) {
            label.textContent = 'Add Campus';
        }
        if (cancelEditBtn) {
            cancelEditBtn.style.display = 'none';
        }
    }

    addCampusFromForm() {
        const nameInput = document.getElementById('newCampusName');
        const parentSelect = document.getElementById('newCampusParent');
        const name = nameInput?.value?.trim();
        const parent = parentSelect?.value?.trim() || null;

        if (!name) {
            this.showNotification('Campus name is required', 'error');
            return;
        }

        // If we're editing an existing campus, only update the parent campus
        if (typeof this.editCampusIndex === 'number' && this.editCampusIndex >= 0 && this.campusSettings && this.campusSettings[this.editCampusIndex]) {
            const idx = this.editCampusIndex;
            const originalName = (this.campusSettings[idx].name || '').toString();
            this.campusSettings[idx].parent = parent;

// Reset edit mode
            this.cancelEditCampus();

            this.renderCampusSettingsTable();
            this.refreshCampusParentOptions();
            this.updateUserCampusDropdownFromCampuses();
            this.showNotification(`Updated parent campus for "${originalName}"`, 'success');
            return;
        }

        try {
            // Simple confirmation before adding campus
            const message = parent
                ? `Add campus "${name}" under parent campus "${parent}"?`
                : `Add campus "${name}" as a top-level campus?`;
            const confirmAdd = window.confirm(message);
            if (!confirmAdd) {
                return;
            }
        } catch (e) {
            console.error('Campus add confirm error:', e);
            // If confirm fails for some reason, still allow adding (fail-open)
        }

        this.campusSettings = this.campusSettings || [];

        // Prevent duplicates (case-insensitive)
        const exists = this.campusSettings.some(c => 
            (c.name || '').toString().trim().toLowerCase() === name.toLowerCase()
        );
        if (exists) {
            this.showNotification('Campus already exists in the list', 'error');
            return;
        }

        this.campusSettings.push({ name, parent });
        this.cancelEditCampus();

        this.renderCampusSettingsTable();
        this.refreshCampusParentOptions();
        this.updateUserCampusDropdownFromCampuses();
    }

    removeCampus(index) {
        if (!Array.isArray(this.campusSettings)) return;
        if (index < 0 || index >= this.campusSettings.length) return;

        const target = this.campusSettings[index];
        const name = (target && target.name ? target.name.toString() : 'this campus');

        try {
            // Check if other campuses use this as parent (simple name match)
            const hasChildren = this.campusSettings.some(
                (c, i) => i !== index && (c.parent || '').toString().trim() === name
            );

            let message = `Are you sure you want to remove campus "${name}" from the list?`;
            if (hasChildren) {
                message += '\n\nWarning: Other campuses are currently set under this campus. You may want to adjust their parent campus after removal.';
            }

            const confirmed = window.confirm(message);
            if (!confirmed) {
                return;
            }
        } catch (e) {
            console.error('Campus remove confirm error:', e);
            // If confirm fails, do not remove to be safe
            return;
        }

        const removed = this.campusSettings.splice(index, 1)[0];
        console.log('Removed campus:', removed);

        this.renderCampusSettingsTable();
        this.refreshCampusParentOptions();
        this.updateUserCampusDropdownFromCampuses();
    }

    /**
     * Sync the Add/Edit User modal campus dropdown with the dynamic campus list.
     * - For super admins: show all campuses from campusSettings (+ Main Campus).
     * - For campus admins: limit to accessible campuses if possible.
     */
    updateUserCampusDropdownFromCampuses() {
        try {
            const select = document.getElementById('userCampus');
            if (!select) return;

            const current = select.value;
            const campuses = Array.isArray(this.campusSettings) ? this.campusSettings.map(c => (c.name || '').toString().trim()) : [];

            // Fallback: also use existing accessible campus logic if no dynamic campuses
            let list = campuses.filter(Boolean);
            if (list.length === 0) {
                list = this.getAccessibleCampuses() || [];
            }

            // For non-super admins, restrict to accessible campuses if available
            if (!this.isSuperAdmin) {
                const accessible = (this.getAccessibleCampuses() || []).map(c => c.toString().trim());
                if (accessible.length > 0) {
                    list = list.filter(c => accessible.includes(c));
                }
            }

            // Build unique, sorted list
            const unique = Array.from(new Set(list)).filter(Boolean).sort((a, b) => a.localeCompare(b));

            // Rebuild options
            select.innerHTML = '';
            const placeholder = document.createElement('option');
            placeholder.value = '';
            placeholder.textContent = 'Select campus';
            select.appendChild(placeholder);

            // Add special "Main Campus" option for super admins
            if (this.isSuperAdmin) {
                const mainOpt = document.createElement('option');
                mainOpt.value = 'Main Campus';
                mainOpt.textContent = 'Main Campus';
                select.appendChild(mainOpt);
            }

            unique.forEach(name => {
                const opt = document.createElement('option');
                opt.value = name;
                opt.textContent = name;
                select.appendChild(opt);
            });

            // Restore previous selection if still present
            if (current && Array.from(select.options).some(o => o.value === current)) {
                select.value = current;
            }
        } catch (e) {
            console.error('Error updating user campus dropdown from campuses:', e);
        }
    }

    async saveCampusSettings() {
        try {
            if (!this.isSuperAdmin) {
                this.showNotification('Only super admins can update campus list', 'error');
                return;
            }

            const campuses = this.campusSettings || [];
            if (campuses.length === 0) {
                this.showNotification('Add at least one campus before saving', 'error');
                return;
            }

            this.showNotification('Saving campus list...', 'info');

            const response = await fetch('api/campus_settings.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'include',
                body: JSON.stringify({ campuses })
            });

            const result = await response.json();
            if (!response.ok || !result.success) {
                throw new Error(result.message || 'Failed to save campus settings');
            }

            this.showNotification('Campus list saved successfully', 'success');
        } catch (e) {
            console.error('Error saving campus settings:', e);
            this.showNotification('Failed to save campus list', 'error');
        }
    }
    
    async createBackup() {
        try {
            this.showNotification('Creating database backup...', 'info');
            
            // Call the backup API
            const response = await fetch('api/create_database_backup.php?format=sql', {
                method: 'GET',
                credentials: 'include'
            });
            
            if (!response.ok) {
                const errorText = await response.text();
                let errorMessage = 'Failed to create backup';
                try {
                    const errorData = JSON.parse(errorText);
                    errorMessage = errorData.error || errorMessage;
                } catch (e) {
                    errorMessage = errorText || `HTTP error: ${response.status}`;
                }
                throw new Error(errorMessage);
            }
            
            // Get the backup file as blob
            const blob = await response.blob();
            
            // Get filename from Content-Disposition header or create default
            const contentDisposition = response.headers.get('content-disposition');
            let filename = `database_backup_${new Date().toISOString().split('T')[0]}.sql`;
            
            if (contentDisposition) {
                const filenameMatch = contentDisposition.match(/filename="?([^"]+)"?/i);
                if (filenameMatch) {
                    filename = filenameMatch[1];
                }
            }
            
            // Create download link and trigger download
            const url = window.URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = url;
            link.download = filename;
            link.style.display = 'none';
            document.body.appendChild(link);
            link.click();
            
            // Cleanup
            setTimeout(() => {
                document.body.removeChild(link);
                window.URL.revokeObjectURL(url);
            }, 100);
            
            this.showNotification(`Backup downloaded: ${filename}`, 'success');
            console.log('Backup downloaded:', filename);
            
        } catch (error) {
            console.error('Backup creation error:', error);
            this.showNotification('Error creating backup: ' + error.message, 'error');
        }
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
        
        // Status chart removed - no longer showing status breakdown
        // Destroy existing chart if it exists
        if (this.statusChart) {
            this.statusChart.destroy();
            this.statusChart = null;
        }
        
        return;
        
        // Chart code removed - keeping structure for potential future use
        this.statusChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: [],
                datasets: [{
                    data: [],
                    backgroundColor: [],
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
            const usersUrl = this.isSuperAdmin || !this.userCampus
                ? 'api/users.php?action=list'
                : `api/users.php?action=list&campus=${encodeURIComponent(this.userCampus)}`;
            const usersResponse = await fetch(usersUrl);
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
                
                // Filter by campuses if not super admin
                if (!this.isSuperAdmin && this.userCampus) {
                    const norm = (x) => (x || '').toString().trim().toLowerCase();
                    const allowed = (this.getAccessibleCampuses() || []).map(norm);
                    submissions = submissions.filter(s => allowed.includes(norm(s.campus)));
                    console.log(`Filtered submissions for campuses [${allowed.join(', ')}]: ${submissions.length} submissions`);
                }
                
                const totalReports = submissions.length;
                // Update dashboard stats
                const dashTotalReports = document.getElementById('dashTotalReports');
                
                if (dashTotalReports) dashTotalReports.textContent = totalReports;
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
                
                // Filter by campuses if not super admin
                if (!this.isSuperAdmin && this.userCampus) {
                    const norm = (x) => (x || '').toString().trim().toLowerCase();
                    const allowed = (this.getAccessibleCampuses() || []).map(norm);
                    submissions = submissions.filter(s => allowed.includes(norm(s.campus)));
                    console.log(`Filtered recent submissions for campuses [${allowed.join(', ')}]: ${submissions.length} submissions`);
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
            console.log('Loading user activities...');
            
            // Get filter values
            const campusFilter = document.getElementById('activityCampusFilter')?.value || '';
            const dateFrom = document.getElementById('activityDateFromFilter')?.value || '';
            const dateTo = document.getElementById('activityDateToFilter')?.value || '';
            
            // Build query string
            const params = new URLSearchParams();
            if (campusFilter) params.append('campus', campusFilter);
            if (dateFrom) params.append('date_from', dateFrom);
            if (dateTo) params.append('date_to', dateTo);
            
            const url = 'api/user_activities.php' + (params.toString() ? '?' + params.toString() : '');
            
            const response = await fetch(url, {
                credentials: 'include'
            });
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            const result = await response.json();
            
            if (result.success) {
                const activities = result.activities || [];
                this.allActivities = activities;
                
                // Setup campus filter dropdown if not already populated
                this.setupActivityCampusFilter(result.available_campuses || []);
                
                console.log(`Loaded ${activities.length} activities`);
                
                // Display activities
                this.displayActivities(activities);
            } else {
                console.error('Failed to load user activities:', result.error);
                const container = document.getElementById('userActivityList');
                if (container) {
                    container.innerHTML = `
                        <div class="loading-state" style="text-align: center; padding: 40px;">
                            <i class="fas fa-exclamation-circle" style="font-size: 48px; color: #ef4444; margin-bottom: 15px; display: block;"></i>
                            <p style="color: #666;">Error loading activities: ${result.error}</p>
                        </div>
                    `;
                }
            }
        } catch (error) {
            console.error('Error loading user activities:', error);
            const container = document.getElementById('userActivityList');
            if (container) {
                container.innerHTML = `
                    <div class="loading-state" style="text-align: center; padding: 40px;">
                        <i class="fas fa-exclamation-circle" style="font-size: 48px; color: #ef4444; margin-bottom: 15px; display: block;"></i>
                        <p style="color: #666;">Error: ${error.message}</p>
                    </div>
                `;
            }
        }
    }
    
    setupActivityCampusFilter(availableCampuses) {
        const campusFilter = document.getElementById('activityCampusFilter');
        if (!campusFilter) return;
        
        // Only populate if dropdown is empty or has only default option
        if (campusFilter.options.length <= 1) {
            // Clear existing options except "All Campuses"
            campusFilter.innerHTML = '<option value="">All Campuses</option>';
            
            // Add available campuses
            availableCampuses.forEach(c => {
                const code = (c.code || c).toString();
                const label = this.campusMap[code] || (c.name || c);
                const option = document.createElement('option');
                option.value = code; // use code in value for API consistency
                option.textContent = label; // show friendly name to users
                campusFilter.appendChild(option);
            });
        }
    }
    
    displayActivities(activities) {
        const container = document.getElementById('userActivityList');
        if (!container) return;
        
        // Update count badge
        const countBadge = document.getElementById('activityCountBadge');
        if (countBadge) {
            countBadge.textContent = activities.length;
        }
        
        if (activities.length === 0) {
            container.innerHTML = `
                <div style="text-align: center; padding: 60px 20px; background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%); border-radius: 16px; border: 2px dashed #e2e8f0;">
                    <div style="
                        width: 80px;
                        height: 80px;
                        margin: 0 auto 20px;
                        background: linear-gradient(135deg, #e2e8f0 0%, #cbd5e1 100%);
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                    ">
                        <i class="fas fa-user-clock" style="font-size: 36px; color: #94a3b8;"></i>
                    </div>
                    <h3 style="
                        font-size: 18px;
                        color: #1e293b;
                        font-weight: 700;
                        margin: 0 0 10px 0;
                        background: linear-gradient(135deg, #1e293b 0%, #475569 100%);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    ">No Activity Found</h3>
                    <p style="color: #64748b; font-size: 14px; margin: 0; font-weight: 500;">Try adjusting your filters to see more activities</p>
                </div>
            `;
            return;
        }
        
        container.innerHTML = activities.map((activity, index) => {
            // Normalize campus display
            const campusCode = activity.campus_code || activity.campus || '';
            const campusName = this.campusMap[campusCode] || activity.campus_name || campusCode || 'Unknown';
            const timeAgo = this.getTimeAgo(new Date(activity.created_at));
            const dateTime = this.formatDateToPhilippines(new Date(activity.created_at));
            
            // Enhanced color gradients based on action type
            const gradientColors = {
                'login': 'linear-gradient(135deg, #10b981 0%, #059669 100%)',
                'logout': 'linear-gradient(135deg, #6b7280 0%, #4b5563 100%)',
                'report_submission': 'linear-gradient(135deg, #f59e0b 0%, #d97706 100%)',
                'data_submission': 'linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%)',
                'report_approved': 'linear-gradient(135deg, #10b981 0%, #059669 100%)',
                'report_rejected': 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)',
                'user_created': 'linear-gradient(135deg, #3b82f6 0%, #2563eb 100%)',
                'user_updated': 'linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%)',
                'user_deleted': 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)'
            };
            
            const bgGradient = gradientColors[activity.action] || `linear-gradient(135deg, ${activity.action_color} 0%, ${activity.action_color}dd 100%)`;
            const iconBg = `linear-gradient(135deg, ${activity.action_color}20, ${activity.action_color}35)`;
            
            return `
                <div class="activity-item-enhanced" style="
                    padding: 20px;
                    margin-bottom: 12px;
                    background: linear-gradient(to right, white 0%, #fafbfc 100%);
                    border-left: 4px solid ${activity.action_color};
                    border-radius: 12px;
                    box-shadow: 0 2px 8px rgba(0,0,0,0.08), 0 1px 3px rgba(0,0,0,0.05);
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    position: relative;
                    overflow: hidden;
                " data-index="${index}">
                    <!-- Background Pattern -->
                    <div style="
                        position: absolute;
                        top: 0;
                        right: 0;
                        width: 120px;
                        height: 120px;
                        background: ${iconBg};
                        border-radius: 50%;
                        transform: translate(30px, -30px);
                        opacity: 0.3;
                        z-index: 0;
                    "></div>
                    
                    <div style="display: flex; align-items: flex-start; gap: 18px; position: relative; z-index: 1;">
                        <!-- Enhanced Icon Container -->
                        <div style="
                            width: 56px;
                            height: 56px;
                            border-radius: 16px;
                            background: ${bgGradient};
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            flex-shrink: 0;
                            box-shadow: 0 4px 12px ${activity.action_color}40, 0 2px 4px rgba(0,0,0,0.1);
                            position: relative;
                            overflow: hidden;
                        ">
                            <div style="
                                position: absolute;
                                top: -50%;
                                left: -50%;
                                width: 200%;
                                height: 200%;
                                background: radial-gradient(circle, rgba(255,255,255,0.3) 0%, transparent 70%);
                                animation: shimmer 3s infinite;
                            "></div>
                            <i class="fas ${activity.action_icon}" style="color: white; font-size: 24px; position: relative; z-index: 1; filter: drop-shadow(0 2px 4px rgba(0,0,0,0.2));"></i>
                        </div>
                        
                        <div style="flex: 1; min-width: 0;">
                            <!-- User Info with Enhanced Styling -->
                            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 10px; flex-wrap: wrap;">
                                <strong style="
                                    font-size: 16px;
                                    color: #1a202c;
                                    font-weight: 700;
                                    background: linear-gradient(135deg, #1a202c 0%, #4a5568 100%);
                                    -webkit-background-clip: text;
                                    -webkit-text-fill-color: transparent;
                                    background-clip: text;
                                ">${activity.user_name || 'Unknown User'}</strong>
                                <span style="
                                    font-size: 12px;
                                    color: #718096;
                                    font-weight: 500;
                                    padding: 2px 8px;
                                    background: #f1f5f9;
                                    border-radius: 8px;
                                ">${activity.username || 'N/A'}</span>
                                <span style="
                                    font-size: 11px;
                                    color: white;
                                    font-weight: 600;
                                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                    padding: 4px 12px;
                                    border-radius: 20px;
                                    box-shadow: 0 2px 4px rgba(102, 126, 234, 0.3);
                                    text-transform: uppercase;
                                    letter-spacing: 0.5px;
                                ">${activity.user_campus || 'Unknown'}</span>
                                ${activity.user_office ? `<span style="
                                    font-size: 11px;
                                    color: white;
                                    font-weight: 600;
                                    background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                                    padding: 4px 12px;
                                    border-radius: 20px;
                                    box-shadow: 0 2px 4px rgba(245, 87, 108, 0.3);
                                ">${activity.user_office}</span>` : ''}
                            </div>
                            
                            <!-- Action Badge with Enhanced Design -->
                            <div style="
                                display: inline-flex;
                                align-items: center;
                                gap: 8px;
                                margin-bottom: 8px;
                                padding: 6px 14px;
                                background: ${iconBg};
                                border-radius: 20px;
                                border: 1px solid ${activity.action_color}30;
                                box-shadow: 0 2px 4px ${activity.action_color}20;
                            ">
                                <i class="fas ${activity.action_icon}" style="color: ${activity.action_color}; font-size: 13px;"></i>
                                <span style="
                                    font-size: 13px;
                                    color: ${activity.action_color};
                                    font-weight: 700;
                                    letter-spacing: 0.3px;
                                ">${activity.action_label}</span>
                            </div>
                            
                            <!-- Description with Enhanced Typography -->
                            ${activity.description ? `<div style="
                                margin: 8px 0 0 0;
                                padding: 10px 14px;
                                background: linear-gradient(to right, #f8f9fa 0%, #ffffff 100%);
                                border-left: 3px solid ${activity.action_color};
                                border-radius: 8px;
                                color: #2d3748;
                                font-size: 13px;
                                line-height: 1.6;
                                font-weight: 500;
                                box-shadow: inset 0 1px 2px rgba(0,0,0,0.02);
                            ">${activity.description}</div>` : ''}
                            
                            <!-- Metadata Footer -->
                            <div style="
                                display: flex;
                                align-items: center;
                                gap: 16px;
                                margin-top: 12px;
                                padding-top: 12px;
                                border-top: 1px solid #e2e8f0;
                                flex-wrap: wrap;
                            ">
                                <span style="
                                    font-size: 12px;
                                    color: #64748b;
                                    display: flex;
                                    align-items: center;
                                    gap: 6px;
                                    font-weight: 500;
                                    padding: 4px 10px;
                                    background: #f8f9fa;
                                    border-radius: 8px;
                                ">
                                    <i class="fas fa-clock" style="color: #64748b; font-size: 11px;"></i>
                                    <span>${dateTime}</span>
                                </span>
                                ${activity.ip_address ? `<span style="
                                    font-size: 12px;
                                    color: #64748b;
                                    display: flex;
                                    align-items: center;
                                    gap: 6px;
                                    font-weight: 500;
                                    padding: 4px 10px;
                                    background: #f8f9fa;
                                    border-radius: 8px;
                                ">
                                    <i class="fas fa-network-wired" style="color: #64748b; font-size: 11px;"></i>
                                    <span>${activity.ip_address}</span>
                                </span>` : ''}
                            </div>
                        </div>
                        
                        <!-- Time Ago Badge -->
                        <div style="
                            text-align: right;
                            flex-shrink: 0;
                            padding: 6px 12px;
                            background: linear-gradient(135deg, #e2e8f0 0%, #cbd5e1 100%);
                            border-radius: 20px;
                            color: #475569;
                            font-size: 11px;
                            font-weight: 600;
                            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                            white-space: nowrap;
                        ">
                            ${timeAgo}
                        </div>
                    </div>
                </div>
            `;
        }).join('');
        
        // Add enhanced hover effects and animations
        const activityItems = container.querySelectorAll('.activity-item-enhanced');
        activityItems.forEach((item, index) => {
            // Add stagger animation on load
            setTimeout(() => {
                item.style.opacity = '0';
                item.style.transform = 'translateY(20px)';
                item.style.transition = 'all 0.4s cubic-bezier(0.4, 0, 0.2, 1)';
                
                setTimeout(() => {
                    item.style.opacity = '1';
                    item.style.transform = 'translateY(0)';
                }, 50);
            }, index * 50);
            
            item.addEventListener('mouseenter', function() {
                const borderColor = this.style.borderLeftColor || '#dc3545';
                this.style.background = `linear-gradient(to right, #ffffff 0%, #f8fafc 100%)`;
                this.style.boxShadow = `0 8px 24px rgba(0,0,0,0.12), 0 4px 8px rgba(0,0,0,0.08), 0 0 0 1px ${borderColor}20`;
                this.style.transform = 'translateY(-4px) scale(1.01)';
                this.style.borderLeftWidth = '5px';
            });
            
            item.addEventListener('mouseleave', function() {
                this.style.background = 'linear-gradient(to right, white 0%, #fafbfc 100%)';
                this.style.boxShadow = '0 2px 8px rgba(0,0,0,0.08), 0 1px 3px rgba(0,0,0,0.05)';
                this.style.transform = 'translateY(0) scale(1)';
                this.style.borderLeftWidth = '4px';
            });
        });
    }
    
    filterUserActivity() {
        // Reload activities with current filters
        this.loadUserActivity();
    }
    
    clearActivityFilters() {
        const campusFilter = document.getElementById('activityCampusFilter');
        const dateFrom = document.getElementById('activityDateFromFilter');
        const dateTo = document.getElementById('activityDateToFilter');
        
        if (campusFilter) campusFilter.value = '';
        if (dateFrom) dateFrom.value = '';
        if (dateTo) dateTo.value = '';
        
        // Reload activities
        this.loadUserActivity();
    }

    getTimeAgo(date) {
        if (!date) return 'Unknown';
        
        const now = new Date();
        const time = new Date(date);
        const diff = now - time;
        
        const seconds = Math.floor(diff / 1000);
        const minutes = Math.floor(seconds / 60);
        const hours = Math.floor(minutes / 60);
        const days = Math.floor(hours / 24);
        const weeks = Math.floor(days / 7);
        const months = Math.floor(days / 30);
        const years = Math.floor(days / 365);
        
        if (seconds < 60) return 'Just now';
        if (minutes < 60) return `${minutes} min${minutes > 1 ? 's' : ''} ago`;
        if (hours < 24) return `${hours} hour${hours > 1 ? 's' : ''} ago`;
        if (days < 7) return `${days} day${days > 1 ? 's' : ''} ago`;
        if (weeks < 4) return `${weeks} week${weeks > 1 ? 's' : ''} ago`;
        if (months < 12) return `${months} month${months > 1 ? 's' : ''} ago`;
        return `${years} year${years > 1 ? 's' : ''} ago`;
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

    // User Management Methods
    /**
     * Setup campus dropdown for user management section
     */
    setupUsersCampusFilter() {
        try {
            const campusFilter = document.getElementById('usersCampusFilter');
            if (!campusFilter) return;
            // Ensure session is available (for campus admins)
            if (!this.userCampus && !this.isSuperAdmin) this.getUserSession();

            const campuses = this.getAccessibleCampuses() || [];
            const current = campusFilter.value;
            campusFilter.innerHTML = '<option value="">All Campus</option>';
            Array.from(new Set(campuses))
                .filter(Boolean)
                .sort((a,b)=>a.localeCompare(b))
                .forEach(c => {
                    const opt = document.createElement('option');
                    opt.value = c; opt.textContent = c; campusFilter.appendChild(opt);
                });
            if (current) campusFilter.value = current;

            campusFilter.onchange = null;
            campusFilter.addEventListener('change', () => {
                if (typeof this.setupUsersOfficeFilter === 'function') {
                    this.setupUsersOfficeFilter();
                }
                this.filterUsers();
            });
            console.log('Populated users campus dropdown with', campuses.length, 'campuses');
        } catch (e) {
            console.error('Error setting up users campus filter:', e);
        }
    }

    filterUsers() {
        const campusFilter = document.getElementById('usersCampusFilter')?.value || '';
        const officeFilter = document.getElementById('usersOfficeFilter')?.value || '';
        const accessibleCampuses = this.getAccessibleCampuses();
        
        console.log('=== Filtering Users ===');
        console.log('Filter values:', {
            campusFilter,
            accessibleCampuses,
            totalUsers: this.allUsers ? this.allUsers.length : 0
        });
        
        if (!this.allUsers || this.allUsers.length === 0) {
            console.warn('No users data available for filtering');
            return;
        }
        
        if (this.allUsers.length > 0) {
            console.log('Sample user campuses:', 
                [...new Set(this.allUsers.slice(0, 10).map(u => (u.campus || 'NULL').toString().trim()))]
            );
        }
        
        // Filter users array (campus + office)
        const filteredUsers = this.allUsers.filter(user => {
            const userCampus = (user.campus || '').toString().trim();
            const filterCampus = (campusFilter || '').toString().trim();
            const campusMatch = !campusFilter || userCampus.toLowerCase() === filterCampus.toLowerCase();

            const userOffice = (user.office || '').toString().trim();
            const filterOffice = (officeFilter || '').toString().trim();
            const officeMatch = !officeFilter || userOffice.toLowerCase() === filterOffice.toLowerCase();
            
            // Check if campus is accessible (only if not super admin)
            let accessibleMatch = true;
            if (!this.isSuperAdmin && accessibleCampuses.length > 0) {
                accessibleMatch = accessibleCampuses.some(ac => 
                    ac.trim().toLowerCase() === userCampus.toLowerCase()
                );
            }
            
            const matches = campusMatch && officeMatch && accessibleMatch;
            
            if ((campusFilter || officeFilter) && matches) {
                console.log('✓ User match found:', {
                    userId: user.id,
                    userName: user.name,
                    userCampus,
                    userOffice,
                    filterCampus,
                    filterOffice
                });
            }
            
            return matches;
        });
        
        console.log('=== User Filter Results ===');
        console.log({
            filteredCount: filteredUsers.length,
            originalCount: this.allUsers.length,
            filterActive: [
                campusFilter ? `Campus: "${campusFilter}"` : null,
                officeFilter ? `Office: "${officeFilter}"` : null
            ].filter(Boolean).join(' | ') || 'No filters'
        });
        
        if (filteredUsers.length === 0 && this.allUsers.length > 0 && campusFilter) {
            console.warn('⚠️ No users matched the filter!');
            console.warn('Available campuses in data:', [...new Set(this.allUsers.map(u => (u.campus || 'NULL').toString().trim()))]);
            console.warn('Trying to filter by:', campusFilter);
        }
        
        // Re-render table with filtered users
        this.renderUsersTable(filteredUsers);
    }

    async loadUsers() {
        try {
            console.log('Loading users...');
            const accessibleCampuses = this.getAccessibleCampuses();
            
            // For super admin, load all users
            // For campus admins, we need to load users from all accessible campuses
            let usersUrl;
            if (this.isSuperAdmin) {
                usersUrl = 'api/users.php?action=list';
            } else {
                // Build URL with multiple campuses - backend will need to handle this
                // For now, we'll load all and filter on frontend
                usersUrl = 'api/users.php?action=list';
            }
            
            const response = await fetch(usersUrl);
            const result = await response.json();
            
            if (result.success) {
                let users = result.users || [];
                
                // Store all users for filtering (don't pre-filter, let dropdown handle it)
                this.allUsers = users;
                
                // For non-super admins, filter to only show accessible campuses initially
                if (!this.isSuperAdmin) {
                    users = users.filter(user => {
                        const userCampus = (user.campus || '').toString().trim();
                        return accessibleCampuses.some(ac => 
                            ac.trim().toLowerCase() === userCampus.toLowerCase()
                        );
                    });
                    console.log(`Campus Admin (${this.userCampus}) - Showing ${users.length} users from accessible campuses:`, accessibleCampuses);
                } else {
                    console.log(`Super Admin - Loaded all ${users.length} users`);
                }

                // Role visibility rules:
                // - Super Admins should not see super_admin accounts
                // - Admins should not see admin accounts
                const initialCount = users.length;
                if (this.isSuperAdmin) {
                    users = users.filter(u => (u.role || '').toLowerCase() !== 'super_admin');
                } else {
                    users = users.filter(u => (u.role || '').toLowerCase() !== 'admin');
                }
                if (initialCount !== users.length) {
                    console.log('Role visibility filter applied. Displaying', users.length, 'of', initialCount, 'users');
                }

                // Ensure in-memory list used by filters matches what we display
                this.allUsers = users;
                
                // Setup filters after loading
                setTimeout(() => {
                    this.setupUsersCampusFilter();
                    if (typeof this.setupUsersOfficeFilter === 'function') {
                        this.setupUsersOfficeFilter();
                    } else {
                        console.warn('setupUsersOfficeFilter is not available at runtime, using inline population');
                        try {
                            const officeFilter = document.getElementById('usersOfficeFilter');
                            if (officeFilter) {
                                const selectedCampus = (document.getElementById('usersCampusFilter')?.value || '').toString().trim().toLowerCase();
                                const officesSet = new Set();
                                (this.allUsers || []).forEach(u => {
                                    const campusOk = !selectedCampus || (u.campus || '').toString().trim().toLowerCase() === selectedCampus;
                                    if (!campusOk) return;
                                    const off = (u.office || '').toString().trim();
                                    if (off) officesSet.add(off);
                                });
                                if (officesSet.size === 0 && Array.isArray(this.availableOffices)) {
                                    this.availableOffices.forEach(o => {
                                        const name = (o.office_name || o.name || o.office || o.title || '').toString().trim();
                                        if (name) officesSet.add(name);
                                    });
                                }
                                if (officesSet.size === 0) {
                                    [
                                        'Office of the Chancellor','Internal Audit','Quality Assurance Management','Sustainable Development',
                                        'Planning and Development','External Affairs','Resource Generation','ICT Services',
                                        'College of Arts and Sciences','College of Accountancy, Business and Economics','College of Informatics and Computing Sciences',
                                        'College of Engineering Technology','College of Teacher Education','College of Engineering','Registrar','Library','HRMO','GSO'
                                    ].forEach(n => officesSet.add(n));
                                }
                                const current = officeFilter.value;
                                officeFilter.innerHTML = '<option value="">All Offices</option>';
                                Array.from(officesSet).sort((a,b)=>a.localeCompare(b)).forEach(off => {
                                    const opt = document.createElement('option');
                                    opt.value = off; opt.textContent = off; officeFilter.appendChild(opt);
                                });
                                if (current) officeFilter.value = current;
                                officeFilter.onchange = null;
                                officeFilter.addEventListener('change', () => this.filterUsers());
                                console.log('Inline: Users office dropdown populated with', officesSet.size, 'offices');
                            }
                        } catch (e) {
                            console.error('Inline office population failed:', e);
                        }
                    }
                }, 100);
                
                // Render users
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
            tbody.innerHTML = '<tr><td colspan="8" style="text-align: center; padding: 40px;"><i class="fas fa-users" style="font-size: 48px; color: #ccc; margin-bottom: 10px;"></i><p style="color: #666;">No users found</p></td></tr>';
            return;
        }
        
        // Update statistics
        this.updateUserStats(users);
        
        tbody.innerHTML = '';
        
        users.forEach((user, index) => {
            const row = document.createElement('tr');
            // Normalize status for display
            const userStatus = (user.status || 'active').toLowerCase().trim();
            const isActive = userStatus === 'active';
            const isDisabled = userStatus === 'disable' || userStatus === 'disabled';
            const statusClass = isActive ? 'status-approved' : 
                               isDisabled ? 'status-rejected' : 'status-pending';
            const statusDisplay = isActive ? 'Active' : (isDisabled ? 'Disable' : user.status || 'Inactive');
            
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
                <td>
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <div class="user-avatar-small">
                            <i class="fas fa-user"></i>
                        </div>
                        <strong>${user.name || '-'}</strong>
                    </div>
                </td>
                <td>${user.username || '-'}</td>
                <td data-role="${user.role || 'user'}"><span class="role-badge ${roleBadgeClass}">${roleDisplay}</span></td>
                <td>${user.campus || '-'}</td>
                <td>${user.office || '-'}</td>
                <td data-status="${userStatus}"><span class="status-badge ${statusClass}">${statusDisplay}</span></td>
                <td>${lastLogin}</td>
                <td class="action-buttons" style="text-align: center;">
                    <button class="btn-sm btn-view" onclick="editUser(${user.id})" title="Edit User">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-sm btn-download" onclick="adminDashboard.promptDeleteUser(${user.id}, '${(user.name || user.username || '').replace(/'/g, "\'")}')" title="Delete User">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            `;
            tbody.appendChild(row);
        });
    }

    promptDeleteUser(userId, userLabel = '') {
        try {
            const modal = document.getElementById('confirmModal');
            const title = document.getElementById('confirmModalTitle');
            const message = document.getElementById('confirmModalMessage');
            const btn = document.getElementById('confirmModalButton');
            if (!modal || !title || !message || !btn) {
                if (confirm(`Delete user ${userLabel || userId}? This action cannot be undone.`)) {
                    this.performDeleteUser(userId);
                }
                return;
            }
            title.textContent = 'Confirm Delete User';
            message.textContent = `Are you sure you want to delete ${userLabel || 'this user'}? This action cannot be undone.`;
            // Remove previous handlers
            const newBtn = btn.cloneNode(true);
            btn.parentNode.replaceChild(newBtn, btn);
            newBtn.onclick = () => this.performDeleteUser(userId);
            modal.style.display = 'flex';
        } catch (e) {
            console.error('Error opening delete confirm:', e);
        }
    }

    async performDeleteUser(userId) {
        try {
            const response = await fetch('api/users.php?action=delete', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ id: userId })
            });
            const result = await response.json();
            if (result.success) {
                this.showNotification('User deleted successfully', 'success');
                // Close confirm modal if available
                try { if (typeof closeConfirmModal === 'function') closeConfirmModal(); } catch (_) {}
                const modal = document.getElementById('confirmModal');
                if (modal) modal.style.display = 'none';
                this.loadUsers();
            } else {
                this.showNotification('Error: ' + (result.error || 'Failed to delete user'), 'error');
            }
        } catch (error) {
            console.error('Delete user error:', error);
            this.showNotification('Error deleting user: ' + error.message, 'error');
        }
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
        
        // Enable campus field for new users
        if (campusSelect) {
            campusSelect.disabled = false;
            campusSelect.style.backgroundColor = '';
            campusSelect.style.cursor = '';
        }
        
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
        
        // Populate role options based on current user's role
        const roleSelect = document.getElementById('userRoleSelect');
        if (roleSelect) {
            roleSelect.innerHTML = ''; // Clear existing options
            
            if (this.isSuperAdmin) {
                // Super admin can create all roles
                roleSelect.innerHTML = `
                    <option value="user" selected>User</option>
                    <option value="admin">Admin</option>
                    <option value="super_admin">Super Admin</option>
                `;
                // Explicitly set default value
                roleSelect.value = 'user';
            } else {
                // Regular admin can only create users
                roleSelect.innerHTML = `
                    <option value="user" selected>User</option>
                `;
                roleSelect.value = 'user';
            }
        }
        
        // Reset password strength indicator
        const strengthFill = document.getElementById('strengthFill');
        const strengthText = document.getElementById('strengthText');
        if (strengthFill) strengthFill.className = 'strength-fill';
        if (strengthText) {
            strengthText.textContent = 'Minimum 8 characters required with uppercase, lowercase, number, and special character';
            strengthText.style.color = '#666';
        }
        
        // Reset password confirmation field
        const passwordConfirmInput = document.getElementById('userPasswordConfirm');
        const passwordMatchError = document.getElementById('passwordMatchError');
        if (passwordConfirmInput) {
            passwordConfirmInput.value = '';
            passwordConfirmInput.required = true;
        }
        if (passwordMatchError) {
            passwordMatchError.style.display = 'none';
        }
        
        // Add event listeners for password validation
        if (passwordInput) {
            passwordInput.addEventListener('input', () => this.checkPasswordStrength());
        }
        if (passwordConfirmInput) {
            passwordConfirmInput.addEventListener('input', () => this.checkPasswordMatch());
        }
        
        // Reset campus field - don't lock it yet, let handleRoleChange handle it
        if (campusSelect) {
            campusSelect.disabled = false;
            campusSelect.value = '';
            const campusGroup = campusSelect.closest('.form-group-modern');
            const notice = campusGroup?.querySelector('.campus-lock-notice');
            if (notice) notice.remove();
        }
        
        // Call handleRoleChange to set initial state based on default role
        setTimeout(() => {
            handleRoleChange();
        }, 50);
        
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
                console.log('User data received:', user); // Debug log
                
                // Normalize role value (handle case sensitivity and different formats)
                const userRole = (user.role || '').toLowerCase().trim();
                console.log('Normalized user role:', userRole); // Debug log
                
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
                
                // Populate role options based on current user's role for editing
                const roleSelect = document.getElementById('userRoleSelect');
                // Normalize role value to match option values
                let roleValue = 'user';
                if (userRole === 'admin') {
                    roleValue = 'admin';
                } else if (userRole === 'super_admin' || userRole === 'superadmin') {
                    roleValue = 'super_admin';
                }
                
                if (roleSelect) {
                    roleSelect.innerHTML = ''; // Clear existing options
                    
                    if (this.isSuperAdmin) {
                        // Super admin can edit to all roles
                        roleSelect.innerHTML = `
                            <option value="user" ${userRole === 'user' ? 'selected' : ''}>User</option>
                            <option value="admin" ${userRole === 'admin' ? 'selected' : ''}>Admin</option>
                            <option value="super_admin" ${userRole === 'super_admin' || userRole === 'superadmin' ? 'selected' : ''}>Super Admin</option>
                        `;
                        // Explicitly set the value to ensure it's selected
                        setTimeout(() => {
                            roleSelect.value = roleValue;
                            console.log('Set role select value to:', roleSelect.value, 'from original:', user.role, 'normalized:', userRole); // Debug log
                            
                            // Verify it was set correctly
                            if (roleSelect.value !== roleValue) {
                                console.warn('Role value mismatch! Setting again...');
                                roleSelect.value = roleValue;
                            }
                        }, 100);
                    } else {
                        // Regular admin can only assign user role
                        roleSelect.innerHTML = `
                            <option value="user" selected>User</option>
                        `;
                        roleSelect.value = 'user';
                    }
                }
                
                // Reset password confirmation field for edit
                const passwordConfirmInput = document.getElementById('userPasswordConfirm');
                const passwordMatchError = document.getElementById('passwordMatchError');
                if (passwordConfirmInput) {
                    passwordConfirmInput.value = '';
                    passwordConfirmInput.required = false; // Not required when editing
                    passwordConfirmInput.placeholder = 'Re-enter password to change (optional)';
                }
                if (passwordMatchError) {
                    passwordMatchError.style.display = 'none';
                }
                
                // Fill form with user data
                document.getElementById('userId').value = user.id;
                const nameEl = document.getElementById('userName');
                if (nameEl) nameEl.value = user.name || '';
                const usernameEl = document.getElementById('userUsername');
                if (usernameEl) usernameEl.value = user.username || '';
                
                // Lock campus field when editing
                const campusSelect = document.getElementById('userCampus');
                if (campusSelect) {
                    campusSelect.value = user.campus || '';
                    campusSelect.disabled = true;
                    campusSelect.style.backgroundColor = '#f3f4f6';
                    campusSelect.style.cursor = 'not-allowed';
                }
                
                // Double-check role value is set correctly after a delay
                setTimeout(() => {
                    const roleSelectCheck = document.getElementById('userRoleSelect');
                    if (roleSelectCheck && this.isSuperAdmin) {
                        const currentRole = roleSelectCheck.value;
                        console.log('Final verification - role select value:', currentRole, 'Expected:', roleValue);
                        if (currentRole !== roleValue) {
                            roleSelectCheck.value = roleValue;
                            console.log('Corrected role select value to:', roleSelectCheck.value);
                        }
                    }
                }, 300);
                
                // Status and campus are already set above, just set office
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

    checkPasswordStrength() {
        const password = document.getElementById('userPassword')?.value || '';
        const strengthFill = document.getElementById('strengthFill');
        const strengthText = document.getElementById('strengthText');
        
        if (!strengthFill || !strengthText) return;
        
        // Password requirements: minimum 8 characters, uppercase, lowercase, number, special character
        const minLength = password.length >= 8;
        const hasUpper = /[A-Z]/.test(password);
        const hasLower = /[a-z]/.test(password);
        const hasNumber = /[0-9]/.test(password);
        const hasSpecial = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password);
        
        const requirementsMet = minLength && hasUpper && hasLower && hasNumber && hasSpecial;
        const strength = [minLength, hasUpper, hasLower, hasNumber, hasSpecial].filter(Boolean).length;
        
        // Update strength bar
        strengthFill.className = 'strength-fill';
        if (requirementsMet) {
            strengthFill.style.width = '100%';
            strengthFill.style.backgroundColor = '#10b981';
            strengthText.textContent = 'Strong password';
            strengthText.style.color = '#10b981';
        } else if (strength >= 3) {
            strengthFill.style.width = '60%';
            strengthFill.style.backgroundColor = '#f59e0b';
            strengthText.textContent = 'Medium strength - add more requirements';
            strengthText.style.color = '#f59e0b';
        } else if (strength >= 1) {
            strengthFill.style.width = '30%';
            strengthFill.style.backgroundColor = '#ef4444';
            strengthText.textContent = 'Weak password - needs more requirements';
            strengthText.style.color = '#ef4444';
        } else {
            strengthFill.style.width = '0%';
            strengthText.textContent = 'Minimum 8 characters required with uppercase, lowercase, number, and special character';
            strengthText.style.color = '#666';
        }
        
        return requirementsMet;
    }
    
    checkPasswordMatch() {
        const password = document.getElementById('userPassword')?.value || '';
        const passwordConfirm = document.getElementById('userPasswordConfirm')?.value || '';
        const passwordMatchError = document.getElementById('passwordMatchError');
        
        if (!passwordMatchError) return;
        
        if (passwordConfirm && password !== passwordConfirm) {
            passwordMatchError.style.display = 'block';
            return false;
        } else {
            passwordMatchError.style.display = 'none';
            return true;
        }
    }
    
    async saveUserFromModal(event) {
        event.preventDefault();
        
        const userId = document.getElementById('userId').value;
        const isEdit = userId !== '';
        const username = (document.getElementById('userUsername')?.value || '').trim();
        const password = document.getElementById('userPassword')?.value || '';
        const passwordConfirm = document.getElementById('userPasswordConfirm')?.value || '';
        const role = document.getElementById('userRoleSelect').value;
        
        // Basic validation before showing confirmation
        if (!username) {
            this.showNotification('Username is required', 'error');
            return;
        }
        
        // Password validation for new users
        if (!isEdit) {
            if (!password) {
                this.showNotification('Password is required for new users', 'error');
                return;
            }
            
            if (password.length < 8) {
                this.showNotification('Password must be at least 8 characters long', 'error');
                return;
            }
            
            // Check password strength
            const isStrong = this.checkPasswordStrength();
            if (!isStrong) {
                this.showNotification('Password is too weak. It must contain uppercase, lowercase, number, and special character', 'error');
                return;
            }
            
            // Check password match
            if (!passwordConfirm) {
                this.showNotification('Please confirm your password', 'error');
                return;
            }
            
            if (password !== passwordConfirm) {
                this.showNotification('Passwords do not match', 'error');
                this.checkPasswordMatch();
                return;
            }
        } else {
            // For editing, password is optional but if provided, must meet requirements
            if (password) {
                if (password.length < 8) {
                    this.showNotification('Password must be at least 8 characters long', 'error');
                    return;
                }
                
                const isStrong = this.checkPasswordStrength();
                if (!isStrong) {
                    this.showNotification('Password is too weak. It must contain uppercase, lowercase, number, and special character', 'error');
                    return;
                }
                
                if (passwordConfirm && password !== passwordConfirm) {
                    this.showNotification('Passwords do not match', 'error');
                    this.checkPasswordMatch();
                    return;
                }
            }
        }
        
        // Validate role permissions
        if (!this.isSuperAdmin && role !== 'user') {
            this.showNotification('You can only create user accounts', 'error');
            return;
        }
        
        // Show confirmation dialog after validation passes
        const modal = document.getElementById('confirmModal');
        const title = document.getElementById('confirmModalTitle');
        const message = document.getElementById('confirmModalMessage');
        const btn = document.getElementById('confirmModalButton');
        
        console.log('Confirmation modal elements:', { modal, title, message, btn });
        
        if (modal && title && message && btn) {
            title.textContent = isEdit ? 'Confirm User Update' : 'Confirm User Creation';
            message.innerHTML = isEdit 
                ? `Are you sure you want to update the user <strong>"${username}"</strong>?`
                : `Are you sure you want to create a new user <strong>"${username}"</strong>?`;
            
            // Ensure modal is on top and visible
            modal.style.zIndex = '10001';
            modal.style.position = 'fixed';
            modal.style.top = '0';
            modal.style.left = '0';
            modal.style.width = '100%';
            modal.style.height = '100%';
            modal.style.display = 'flex';
            modal.style.alignItems = 'center';
            modal.style.justifyContent = 'center';
            
            // Also add a class to ensure visibility (CSS will handle !important)
            modal.classList.add('confirm-modal-visible');
            
            // Force a reflow to ensure the modal is rendered
            void modal.offsetHeight;
            
            console.log('Confirmation modal displayed', {
                display: modal.style.display,
                zIndex: modal.style.zIndex,
                computedDisplay: window.getComputedStyle(modal).display,
                modalVisible: modal.offsetParent !== null
            });
            
            // Remove any existing event listeners from confirm button
            const newBtn = btn.cloneNode(true);
            btn.parentNode.replaceChild(newBtn, btn);
            
            // Add new event listener to confirm button
            newBtn.addEventListener('click', () => {
                modal.style.display = 'none';
                modal.classList.remove('confirm-modal-visible');
                this.performSaveUser();
            });
            
            // Ensure cancel button closes modal (it already has onclick="closeConfirmModal()" in HTML)
            // Just make sure the function exists
            if (typeof window.closeConfirmModal !== 'function') {
                window.closeConfirmModal = function() {
                    const modal = document.getElementById('confirmModal');
                    if (modal) {
                        modal.style.display = 'none';
                        modal.classList.remove('confirm-modal-visible');
                    }
                };
            }
            
            return;
        } else {
            // Fallback to direct save if modal not available
            this.performSaveUser();
        }
    }
    
    async performSaveUser() {
        const userId = document.getElementById('userId').value;
        const isEdit = userId !== '';
        
        const username = (document.getElementById('userUsername')?.value || '').trim();
        // Use username as name since there's no separate name field in the form
        const name = username;
        const password = document.getElementById('userPassword')?.value || '';
        const passwordConfirm = document.getElementById('userPasswordConfirm')?.value || '';
        const role = document.getElementById('userRoleSelect').value;
        // Status field removed from edit form - preserve existing status when editing, default to 'active' for new users
        let status = 'active';
        if (isEdit) {
            // When editing, fetch current user's status to preserve it
            try {
                const userResponse = await fetch(`api/users.php?action=get&id=${userId}`);
                const userResult = await userResponse.json();
                if (userResult.success && userResult.user) {
                    status = userResult.user.status || 'active';
                }
            } catch (error) {
                console.warn('Could not fetch current user status, defaulting to active:', error);
                status = 'active';
            }
        }
        const campus = document.getElementById('userCampus').value;
        const office = (document.getElementById('userOffice')?.value || '').trim();
        
        // Validation already done in saveUserFromModal before showing confirmation
        // Proceed directly to save
        
        const userData = {
            name,
            username,
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
        
        // Debug logging
        console.log('Saving user with data:', userData);
        console.log('Role value:', role);
        console.log('Campus value:', campus);
        
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
                
                // Sync: Notify dashboards about user update
                if (this.sync) {
                    this.sync.broadcast('user_updated', { 
                        userId: userId,
                        timestamp: Date.now() 
                    });
                }
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
        this.currentTableName = tableName;
        
        if (!data || data.length === 0) {
            container.innerHTML = '<div class="empty-state"><i class="fas fa-inbox"></i><h3>No data available</h3></div>';
            return;
        }
        
        const columns = Object.keys(data[0]);
        
        // Filter out internal metadata columns
        const columnsToHide = [
            'id', 'submission_id', 'submission id', 'batch_id', 'batch id',
            'submitted_by', 'submitted by', 'submitted_at', 'submitted at',
            'created_at', 'created at', 'updated_at', 'updated at'
        ];
        let visibleColumns = columns.filter(col => {
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
        
        visibleColumns.sort((a, b) => {
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
        
        // Build column filters - get unique values for each column
        const columnFilters = {};
        visibleColumns.forEach(col => {
            const uniqueValues = Array.from(new Set(
                data.map(row => String(row[col] ?? '')).filter(v => v !== '' && v !== '-' && v !== 'null' && v !== 'undefined')
            )).sort((a, b) => a.localeCompare(b));
            columnFilters[col] = uniqueValues;
        });
        
        let tableHTML = `
            <div class="data-table-wrapper">
                <table class="data-table">
                    <thead>
                        <tr>
                            ${visibleColumns.map(col => {
                                const formattedColName = this.formatColumnName(col);
                                return `<th style="padding: 0 !important; text-align: left; font-weight: 700; font-size: 14px; color: #ffffff; background: linear-gradient(135deg, #dc143c 0%, #a00000 100%); border-right: 1px solid rgba(255, 255, 255, 0.2); vertical-align: top; position: relative !important; height: 110px !important; max-height: 110px !important; overflow: visible !important; box-sizing: border-box !important;">
                                    <div style="padding: 16px 18px; height: 100% !important; min-height: 110px !important; max-height: 110px !important; display: flex !important; flex-direction: column !important; position: relative !important; box-sizing: border-box !important;">
                                        <div class="column-header-label" style="font-weight: 700; font-size: 14px; color: #ffffff; line-height: 1.4; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; flex: 1 1 auto; display: flex; align-items: center; min-height: 0; max-height: calc(110px - 58px); position: relative; top: 0; margin-bottom: 0; padding-bottom: 0;" title="${this.escapeHtml(formattedColName)}">${this.escapeHtml(formattedColName)}</div>
                                        <div style="position: absolute !important; bottom: 16px !important; left: 18px !important; right: 18px !important; height: 42px !important; top: auto !important;">
                                            <select class="column-filter" data-column="${this.escapeHtml(col)}" style="width: 100% !important; box-sizing: border-box !important; padding: 10px 42px 10px 14px !important; border: 2px solid rgba(255, 255, 255, 0.3) !important; border-radius: 10px !important; font-size: 14px !important; background: rgba(255, 255, 255, 0.95) !important; backdrop-filter: blur(10px) !important; cursor: pointer !important; height: 42px !important; min-height: 42px !important; max-height: 42px !important; font-weight: 500 !important; color: #374151 !important; appearance: none !important; -webkit-appearance: none !important; -moz-appearance: none !important; background-image: url('data:image/svg+xml,%3Csvg xmlns=\\'http://www.w3.org/2000/svg\\' width=\\'20\\' height=\\'20\\' viewBox=\\'0 0 24 24\\' fill=\\'none\\' stroke=\\'%23dc143c\\' stroke-width=\\'2.5\\' stroke-linecap=\\'round\\' stroke-linejoin=\\'round\\'%3E%3Cpolyline points=\\'6 9 12 15 18 9\\'%3E%3C/polyline%3E%3C/svg%3E'); background-repeat: no-repeat !important; background-position: right 16px center !important; background-size: 18px 18px !important; margin: 0 !important; position: absolute !important; bottom: 0 !important; left: 0 !important; right: 0 !important; top: auto !important; transform: none !important;" onchange="adminDashboard.filterTableData(this)">
                                                <option value="">All ${this.escapeHtml(formattedColName)}</option>
                                                ${columnFilters[col].map(val => `<option value="${this.escapeHtml(String(val).replace(/\"/g, '&quot;'))}">${this.escapeHtml(String(val).length > 50 ? String(val).substring(0, 50) + '...' : String(val))}</option>`).join('')}
                                            </select>
                                        </div>
                                    </div>
                                </th>`;
                            }).join('')}
                            <th class="actions-cell" style="padding: 16px 18px; text-align: left; font-weight: 700; font-size: 14px; color: #ffffff; background: linear-gradient(135deg, #dc143c 0%, #a00000 100%); border-right: none; vertical-align: middle;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${data.map((row, index) => {
                            const cells = visibleColumns.map(col => `<td>${(row[col] !== undefined && row[col] !== null) ? this.escapeHtml(String(row[col])) : '-'}</td>`).join('');
                            const editId = (row.id !== undefined && row.id !== null) ? row.id : index;
                            const delAttr = (row.id && Number(row.id) > 0)
                                ? `onclick="adminDashboard.deleteRecord('${tableName}', ${row.id})"`
                                : 'disabled';
                            return `
                                <tr>
                                    ${cells}
                                    <td class="actions-cell">
                                        <button class="action-btn edit" onclick="adminDashboard.editRecord('${tableName}', ${editId})">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="action-btn copy" onclick="adminDashboard.copyRecord(${index})">
                                            <i class="fas fa-copy"></i> Copy
                                        </button>
                                        <button class="action-btn delete" ${delAttr}>
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </td>
                                </tr>`;
                        }).join('')}
                    </tbody>
                </table>
            </div>
        `;
        
        container.innerHTML = tableHTML;
        this.currentTableData = data;
        this.currentTableColumns = visibleColumns;
        
        // Store original data for filtering
        this.originalTableData = data;
    }
    
    filterTableData(selectElement) {
        const tbody = document.querySelector('#dataTableContainer tbody');
        if (!tbody || !this.originalTableData) return;
        
        // Get all active filters
        const filters = {};
        document.querySelectorAll('#dataTableContainer .column-filter').forEach(select => {
            const col = select.getAttribute('data-column');
            const val = select.value;
            if (val) {
                filters[col] = val;
            }
        });
        
        // Filter data
        const filteredData = this.originalTableData.filter(row => {
            return Object.keys(filters).every(col => {
                const rowValue = String(row[col] ?? '').trim();
                const filterValue = String(filters[col]).trim();
                return rowValue.toLowerCase() === filterValue.toLowerCase();
            });
        });
        
        // Re-render table body with filtered data
        const cells = filteredData.map((row, index) => {
            const rowCells = this.currentTableColumns.map(col => 
                `<td>${(row[col] !== undefined && row[col] !== null) ? this.escapeHtml(String(row[col])) : '-'}</td>`
            ).join('');
            const editId = (row.id !== undefined && row.id !== null) ? row.id : index;
            const delAttr = (row.id && Number(row.id) > 0)
                ? `onclick="adminDashboard.deleteRecord('${this.currentTableName || 'unknown'}', ${row.id})"`
                : 'disabled';
            return `
                <tr>
                    ${rowCells}
                    <td class="actions-cell">
                        <button class="action-btn edit" onclick="adminDashboard.editRecord('${this.currentTableName || 'unknown'}', ${editId})">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <button class="action-btn copy" onclick="adminDashboard.copyRecord(${index})">
                            <i class="fas fa-copy"></i> Copy
                        </button>
                        <button class="action-btn delete" ${delAttr}>
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </td>
                </tr>`;
        }).join('');
        
        tbody.innerHTML = cells || '<tr><td colspan="' + (this.currentTableColumns.length + 1) + '" style="text-align: center; padding: 40px;">No data matches the selected filters</td></tr>';
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

    // Selection management functions

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
    const roleSelect = document.getElementById('userRoleSelect');
    if (!roleSelect) return;
    
    const role = roleSelect.value;
    console.log('Role changed to:', role); // Debug log
    
    const officeGroup = document.getElementById('officeGroup');
    const campusSelect = document.getElementById('userCampus');
    const adminDashboard = window.adminDashboard;
    const campusGroup = campusSelect?.closest('.form-group-modern');
    
    // Remove any existing notice
    const existingNotice = campusGroup?.querySelector('.campus-lock-notice');
    if (existingNotice) existingNotice.remove();
    
    if (role === 'super_admin') {
        // Super admin: Main Campus, no office
        campusSelect.value = 'Main Campus';
        campusSelect.disabled = true;
        officeGroup.style.display = 'none';
    } else if (role === 'admin') {
        // Campus admin: specific campus, no office
        // Only super admins can select campus for admins
        if (adminDashboard && adminDashboard.isSuperAdmin) {
            campusSelect.disabled = false;
        } else {
            // Regular admin creating another admin - lock to their campus
            if (adminDashboard && adminDashboard.userCampus) {
                campusSelect.value = adminDashboard.userCampus;
                campusSelect.disabled = true;
                
                // Add lock notice
                if (campusGroup) {
                    const notice = document.createElement('small');
                    notice.className = 'campus-lock-notice form-help';
                    notice.style.color = '#dc143c';
                    notice.innerHTML = `<i class="fas fa-lock"></i> Locked to your campus: <strong>${adminDashboard.userCampus}</strong>`;
                    campusGroup.appendChild(notice);
                }
            }
        }
        officeGroup.style.display = 'none';
    } else {
        // Office user: specific campus and office
        // Lock campus for non-super admins
        if (adminDashboard && !adminDashboard.isSuperAdmin && adminDashboard.userCampus) {
            campusSelect.value = adminDashboard.userCampus;
            campusSelect.disabled = true;
            
            // Add lock notice
            if (campusGroup) {
                const notice = document.createElement('small');
                notice.className = 'campus-lock-notice form-help';
                notice.style.color = '#dc143c';
                notice.innerHTML = `<i class="fas fa-lock"></i> Locked to your campus: <strong>${adminDashboard.userCampus}</strong>`;
                campusGroup.appendChild(notice);
            }
        } else {
            campusSelect.disabled = false;
        }
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
        if (row.classList.contains('no-results-row')) {
            row.style.display = 'none';
            continue;
        }
        
        const name = row.cells[0]?.textContent.toLowerCase() || '';
        const username = row.cells[1]?.textContent.toLowerCase() || '';
        
        // Get role from data attribute (more reliable)
        const roleCell = row.cells[2];
        const roleValue = roleCell?.getAttribute('data-role')?.toLowerCase() || '';
        
        // Get status from data attribute
        const statusCell = row.cells[5];
        const statusValue = statusCell?.getAttribute('data-status')?.toLowerCase() || '';
        
        const matchesSearch = !searchTerm || name.includes(searchTerm) || username.includes(searchTerm);
        const matchesRole = !roleFilter || roleValue === roleFilter.toLowerCase();
        const matchesStatus = !statusFilter || statusValue === statusFilter.toLowerCase();
        
        console.log('Filter check:', {
            name: name.substring(0, 20),
            role: roleValue,
            roleFilter: roleFilter,
            matchesRole: matchesRole,
            status: statusValue,
            statusFilter: statusFilter,
            matchesStatus: matchesStatus
        });
        
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
            newRow.innerHTML = '<td colspan="8" style="text-align: center; padding: 40px;"><i class="fas fa-search" style="font-size: 48px; color: #ccc; margin-bottom: 10px;"></i><p style="color: #666;">No users match your filters</p></td>';
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

async function loadNotifications() {
    const list = document.getElementById('notificationsList');
    const badge = document.getElementById('notificationCount');
    
    // Show loading state
    if (list) {
        list.innerHTML = `
            <div class="notification-loading">
                <i class="fas fa-spinner fa-spin"></i>
                <p>Loading notifications...</p>
            </div>
        `;
    }
    
    try {
        // Use relative path - works in both local and production
        const apiUrl = 'api/user_notifications.php?action=get_notifications';
        
        const response = await fetch(apiUrl, {
            method: 'GET',
            credentials: 'include'
        });

        let notifications = [];

        if (response.ok) {
            const result = await response.json();
            if (result.success && result.data && Array.isArray(result.data)) {
                // Map API notification format to UI format
                notifications = result.data.map(notif => ({
                    id: notif.id || notif['id'],
                    type: notif.type || 'info',
                    icon: getIconForType(notif.type || 'info'),
                    title: notif.title || 'Notification',
                    message: notif.message || '',
                    time: notif.time || getRelativeTime(notif.created_at),
                    unread: !notif.read
                }));
            }
        } else {
            console.error('Failed to fetch notifications:', response.status);
        }

        renderNotifications(notifications);
    } catch (error) {
        console.error('Error loading notifications:', error);
        if (list) {
            list.innerHTML = `
                <div class="notification-empty">
                    <i class="fas fa-exclamation-circle"></i>
                    <p>Failed to load notifications</p>
                </div>
            `;
        }
        if (badge) {
            badge.textContent = '0';
            badge.style.display = 'none';
        }
    }
}

/**
 * Get FontAwesome icon class based on notification type
 */
function getIconForType(type) {
    const iconMap = {
        'success': 'fa-check-circle',
        'warning': 'fa-exclamation-triangle',
        'error': 'fa-times-circle',
        'info': 'fa-info-circle'
    };
    return iconMap[type] || 'fa-bell';
}

/**
 * Get relative time string from date
 */
function getRelativeTime(dateString) {
    if (!dateString) return 'Just now';
    
    const date = new Date(dateString);
    const now = new Date();
    const diffMs = now - date;
    const diffSecs = Math.floor(diffMs / 1000);
    const diffMins = Math.floor(diffSecs / 60);
    const diffHours = Math.floor(diffMins / 60);
    const diffDays = Math.floor(diffHours / 24);
    
    if (diffSecs < 60) return 'Just now';
    if (diffMins < 60) return `${diffMins} minute${diffMins > 1 ? 's' : ''} ago`;
    if (diffHours < 24) return `${diffHours} hour${diffHours > 1 ? 's' : ''} ago`;
    if (diffDays < 7) return `${diffDays} day${diffDays > 1 ? 's' : ''} ago`;
    
    return date.toLocaleDateString();
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

async function markAsRead(notificationId) {
    try {
        // Extract the actual notification ID (remove prefixes like 'notif_', 'sub_approved_', etc.)
        let actualId = notificationId;
        if (typeof notificationId === 'string') {
            // Remove common prefixes
            actualId = notificationId.replace(/^(notif_|sub_approved_|sub_rejected_|sub_pending_|data_sub_approved_|data_sub_rejected_|data_sub_pending_|task_new_|task_deadline_|task_overdue_)/, '');
        }
        
        // Use relative path - works in both local and production
        const apiUrl = `api/user_notifications.php?action=mark_read&id=${actualId}`;
        
        const response = await fetch(apiUrl, {
            method: 'POST',
            credentials: 'include'
        });
        
        if (response.ok) {
            // Reload notifications to update UI
            loadNotifications();
        } else {
            console.error('Failed to mark notification as read');
        }
    } catch (error) {
        console.error('Error marking notification as read:', error);
    }
}

async function markAllAsRead(event) {
    event.stopPropagation();
    
    try {
        // Use relative path - works in both local and production
        const apiUrl = 'api/user_notifications.php?action=mark_all_read';
        
        const response = await fetch(apiUrl, {
            method: 'POST',
            credentials: 'include'
        });
        
        if (response.ok) {
            const badge = document.getElementById('notificationCount');
            if (badge) {
                badge.textContent = '0';
                badge.style.display = 'none';
            }
            // Reload notifications to update UI
            loadNotifications();
        } else {
            console.error('Failed to mark all notifications as read');
        }
    } catch (error) {
        console.error('Error marking all notifications as read:', error);
    }
    
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

// ================= Password Resets Integration (list + approve + modal) =================
async function loadPasswordResets() {
    const tbody = document.getElementById('passwordResetsTableBody');
    if (!tbody) return;
    tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding:24px;"><i class="fas fa-spinner fa-spin"></i> Loading...</td></tr>';
    try {
        const res = await fetch('api/password_reset_admin.php?action=list_pending', { credentials: 'include' });
        const text = await res.text();
        let json;
        try { json = JSON.parse(text); } catch { json = { success:false, error:'Invalid JSON', detail:text.slice(0,300) }; }
        if (json.success) {
            renderPasswordResets(json.requests || []);
        } else {
            tbody.innerHTML = `<tr><td colspan="5" style="text-align:center; padding:24px; color:#b91c1c;">${json.error || 'Failed to load'}${json.detail ? ' - ' + json.detail : ''}</td></tr>`;
        }
    } catch (e) {
        console.error('password resets load error', e);
        tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding:24px; color:#b91c1c;">Network error</td></tr>';
    }
}

function renderPasswordResets(requests) {
    const tbody = document.getElementById('passwordResetsTableBody');
    if (!tbody) return;
    if (!requests.length) {
        tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding:24px;">No pending requests</td></tr>';
        return;
    }
    tbody.innerHTML = '';
    requests.forEach(r => {
        const tr = document.createElement('tr');
        const badge = `<span class="status-badge status-${r.status}">${r.status}</span>`;
        tr.innerHTML = `
          <td>${r.id}</td>
          <td>${r.username}</td>
          <td>${r.created_at ? new Date(r.created_at).toLocaleString() : ''}</td>
          <td>${badge}</td>
          <td>
            <button class="btn-sm btn-view" data-approve-id="${r.id}"><i class="fas fa-check"></i> Approve</button>
          </td>
        `;
        tbody.appendChild(tr);
    });
}

function openResetConfirmModal(requestId) {
    window._pendingResetId = requestId;
    const modal = document.getElementById('resetConfirmModal');
    if (modal) modal.style.display = 'flex';
}

function closeResetConfirmModal() {
    const modal = document.getElementById('resetConfirmModal');
    if (modal) modal.style.display = 'none';
}

async function approvePasswordReset(requestId) {
    try {
        const res = await fetch('api/password_reset_admin.php?action=approve', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'include',
            body: JSON.stringify({ request_id: requestId })
        });
        const text = await res.text();
        let json;
        try { json = JSON.parse(text); } catch { json = { success:false, error:'Invalid JSON', detail:text.slice(0,300) }; }
        if (json.success) {
            alert('Approved. Password updated.');
            loadPasswordResets();
        } else {
            alert((json.error || 'Failed to approve') + (json.detail ? '\n' + json.detail : ''));
        }
    } catch (e) {
        console.error('approve error', e);
        alert('Network error');
    }
}

// Delegated click for Approve buttons
document.addEventListener('click', (e) => {
    const approveBtn = e.target.closest('[data-approve-id]');
    if (approveBtn) {
        const id = parseInt(approveBtn.getAttribute('data-approve-id'), 10);
        if (id) openResetConfirmModal(id);
    }
});

// Modal buttons and nav hook
document.addEventListener('DOMContentLoaded', () => {
    const closeBtn = document.getElementById('resetConfirmCloseBtn');
    const cancelBtn = document.getElementById('btnResetCancel');
    const approveBtn = document.getElementById('btnResetApprove');
    if (closeBtn) closeBtn.addEventListener('click', closeResetConfirmModal);
    if (cancelBtn) cancelBtn.addEventListener('click', closeResetConfirmModal);
    if (approveBtn) approveBtn.addEventListener('click', () => {
        const id = window._pendingResetId; window._pendingResetId = null;
        closeResetConfirmModal();
        if (id) approvePasswordReset(id);
    });
    // Esc to close modal
    document.addEventListener('keydown', (ev) => {
        if (ev.key === 'Escape') closeResetConfirmModal();
    });
    // Hook nav click to load when entering Password Resets
    const prNav = document.querySelector('[data-section="passwordResets"]');
    if (prNav) {
        prNav.addEventListener('click', () => {
            // Ensure section becomes visible even if main controller doesn't manage it
            try {
                // Hide other sections
                document.querySelectorAll('.content-section').forEach(sec => { sec.style.display = 'none'; sec.classList.remove('active'); });
                // Remove active from all nav items
                document.querySelectorAll('.nav-item').forEach(it => it.classList.remove('active'));
                // Show target section
                const section = document.getElementById('passwordResets');
                if (section) { section.style.display = 'block'; section.classList.add('active'); }
                // Mark nav active
                prNav.classList.add('active');
                // Update title if present
                const title = document.getElementById('pageTitle');
                if (title) title.textContent = 'Password Reset Requests';
            } catch (e) { /* ignore */ }
            setTimeout(() => loadPasswordResets(), 0);
        });
    }
    // If section already visible at load
    const sectionEl = document.getElementById('passwordResets');
    if (sectionEl && sectionEl.style.display !== 'none') {
        loadPasswordResets();
    }
});

// Initialize dashboard when DOM is loaded
document.addEventListener('DOMContentLoaded', async () => {
    console.log('DOMContentLoaded - Initializing AdminDashboard');
    
    // GLOBAL DELETE BUTTON HANDLER - Works no matter what blocks the button
    document.addEventListener('click', async function(e) {
        // Find delete button from any clicked element (button, anchor, or div)
        let target = e.target;
        let deleteBtn = null;
        
        // If clicking icon, find parent (div, button, or anchor)
        if (target.tagName === 'I') {
            deleteBtn = target.closest('.btn-danger') || 
                       target.closest('.delete-submission-btn') ||
                       target.closest('[data-action="delete"]') ||
                       target.closest('[data-submission-id]');
        } else if (target.classList && (target.classList.contains('btn-danger') || target.classList.contains('delete-submission-btn'))) {
            deleteBtn = target;
        } else if (target.closest) {
            deleteBtn = target.closest('.btn-danger[data-submission-id]') || 
                       target.closest('.delete-submission-btn[data-submission-id]') ||
                       target.closest('[data-action="delete"]') ||
                       target.closest('[data-submission-id]');
        }
        
        // Check if it's a delete element (div, button, or anchor) with submission ID
        if (deleteBtn) {
            // Get submission ID - try multiple ways
            let subId = 0;
            const subIdAttr = deleteBtn.getAttribute('data-submission-id');
            if (subIdAttr) {
                subId = parseInt(subIdAttr, 10);
            }
            
            // If still 0, try getting from parent or dataset
            if (!subId && deleteBtn.dataset && deleteBtn.dataset.submissionId) {
                subId = parseInt(deleteBtn.dataset.submissionId, 10);
            }
            
            // If still 0, try getting from parent row
            if (!subId && deleteBtn.closest) {
                const row = deleteBtn.closest('tr');
                if (row) {
                    const rowSubId = row.getAttribute('data-submission-id');
                    if (rowSubId) {
                        subId = parseInt(rowSubId, 10);
                    }
                }
            }
            
            // Only proceed if we have a valid submission ID
            if (!subId || subId <= 0) {
                // Not a delete button we care about
                return;
            }
            
            // Check if disabled (only buttons can be disabled, divs and anchors can't)
            if (deleteBtn.tagName === 'BUTTON' && deleteBtn.disabled) {
                console.log('Delete button is disabled, ignoring click');
                return;
            }
            
            // Check if disabled via data attribute (for divs)
            if (deleteBtn.getAttribute('data-disabled') === 'true') {
                console.log('Delete element is disabled, ignoring click');
                return;
            }
            
            e.preventDefault();
            e.stopPropagation();
            e.stopImmediatePropagation();
            
            const reportName = deleteBtn.getAttribute('data-report-name') || 
                              deleteBtn.dataset?.reportName || 
                              'Report';
            
            console.log('GLOBAL HANDLER TRIGGERED - Delete clicked for submission:', subId, 'Report:', reportName, 'Element:', deleteBtn.tagName, deleteBtn.className, 'Attributes:', {
                'data-submission-id': deleteBtn.getAttribute('data-submission-id'),
                'data-report-name': deleteBtn.getAttribute('data-report-name'),
                'data-action': deleteBtn.getAttribute('data-action')
            });
            
            // Try multiple ways to access adminDashboard
            let adminDashboard = window.adminDashboard;
            if (!adminDashboard && window.AdminDashboard) {
                // Try to get instance if it's a class
                adminDashboard = new window.AdminDashboard();
            }
            
            if (subId && adminDashboard && typeof adminDashboard.deleteSubmission === 'function') {
                console.log('GLOBAL HANDLER - Calling deleteSubmission for:', subId);
                try {
                    adminDashboard.deleteSubmission(subId, reportName);
                } catch (err) {
                    console.error('GLOBAL HANDLER - Error calling deleteSubmission:', err);
                    alert('Error deleting submission: ' + err.message);
                }
            } else {
                    // Try direct API call as fallback - use modal confirmation
                    if (subId) {
                        console.log('GLOBAL HANDLER - adminDashboard not available, trying direct API call for submission:', subId);
                        // Create a simple confirmation modal for fallback
                        const confirmDelete = await new Promise((resolve) => {
                            const modal = document.createElement('div');
                            modal.style.cssText = 'position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); display: flex; align-items: center; justify-content: center; z-index: 100000;';
                            modal.innerHTML = `
                                <div style="background: white; border-radius: 16px; padding: 30px; max-width: 400px; text-align: center; box-shadow: 0 20px 60px rgba(0,0,0,0.3);">
                                    <div style="font-size: 48px; color: #ef4444; margin-bottom: 20px;"><i class="fas fa-exclamation-triangle"></i></div>
                                    <h3 style="margin: 0 0 15px 0; color: #374151;">Delete Submission</h3>
                                    <p style="margin: 0 0 25px 0; color: #6b7280;">Delete ${reportName} submission #${subId}? This cannot be undone.</p>
                                    <div style="display: flex; gap: 10px; justify-content: center;">
                                        <button id="cancelBtn" style="padding: 10px 20px; background: #f3f4f6; border: none; border-radius: 8px; cursor: pointer; font-weight: 600;">Cancel</button>
                                        <button id="confirmBtn" style="padding: 10px 20px; background: #ef4444; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: 600;">Delete</button>
                                    </div>
                                </div>
                            `;
                            document.body.appendChild(modal);
                            document.getElementById('cancelBtn').onclick = () => { modal.remove(); resolve(false); };
                            document.getElementById('confirmBtn').onclick = () => { modal.remove(); resolve(true); };
                        });
                        
                        if (confirmDelete) {
                        fetch('api/admin_submissions.php', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            credentials: 'include',
                            body: JSON.stringify({ action: 'delete', submission_id: subId })
                        })
                        .then(res => res.json())
                        .then(data => {
                            if (data.success) {
                                alert('Submission deleted successfully');
                                // Try to reload submissions if adminDashboard becomes available
                                if (window.adminDashboard && typeof window.adminDashboard.loadSubmissions === 'function') {
                                    window.adminDashboard.loadSubmissions();
                                } else {
                                    window.location.reload();
                                }
                            } else {
                                alert('Error: ' + (data.message || 'Failed to delete submission'));
                            }
                        })
                        .catch(err => {
                            console.error('Direct API delete error:', err);
                            alert('Error deleting submission: ' + err.message);
                        });
                    }
                } else {
                    console.error('GLOBAL HANDLER - Cannot delete:', { 
                        subId, 
                        hasAdmin: !!window.adminDashboard, 
                        hasFunction: typeof window.adminDashboard?.deleteSubmission,
                        adminDashboardType: typeof window.adminDashboard
                    });
                    alert('Delete function not available. Please refresh the page.');
                }
            }
            return false;
        }
    }, true); // Use capture phase to catch before anything else
    
    // Initialize adminDashboard immediately (don't wait for async)
    try {
        if (!window.adminDashboard) {
            window.adminDashboard = new AdminDashboard();
            // Init in background, don't block
            window.adminDashboard.init().then(() => {
                console.log('AdminDashboard initialized successfully');
            }).catch(err => {
                console.error('AdminDashboard init error:', err);
            });
        }
    } catch (error) {
        console.error('Failed to initialize AdminDashboard:', error);
    }
});

// ===== Logout confirmation and action =====
async function performLogout() {
    try {
        const btn = document.getElementById('logoutButton');
        if (btn) { btn.disabled = true; btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Logging out...'; }
        await fetch('api/simple_auth.php?action=logout', { method: 'POST', credentials: 'include' });
    } catch (e) {
        console.error('Logout error', e);
    } finally {
        try { sessionStorage.clear(); } catch {}
        try { localStorage.removeItem('userSession'); } catch {}
        window.location.href = 'login.html';
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const btn = document.getElementById('logoutButton');
    const logoutModal = document.getElementById('logoutConfirmModal');
    const btnClose = document.getElementById('btnLogoutClose');
    const btnCancel = document.getElementById('btnLogoutCancel');
    const btnConfirm = document.getElementById('btnLogoutConfirm');

    function openLogoutConfirm(e){
        if (e) { e.preventDefault(); e.stopPropagation(); }
        if (logoutModal) logoutModal.style.display = 'flex';
    }
    function closeLogoutConfirm(){ if (logoutModal) logoutModal.style.display = 'none'; }

    if (btn && !btn._logoutBound) { btn.addEventListener('click', openLogoutConfirm); btn._logoutBound = true; }
    if (btnClose && !btnClose._bound){ btnClose.addEventListener('click', closeLogoutConfirm); btnClose._bound = true; }
    if (btnCancel && !btnCancel._bound){ btnCancel.addEventListener('click', closeLogoutConfirm); btnCancel._bound = true; }
    if (btnConfirm && !btnConfirm._bound){
        btnConfirm.addEventListener('click', async (e) => {
            e.preventDefault(); e.stopPropagation();
            closeLogoutConfirm();
            await performLogout();
        });
        btnConfirm._bound = true;
    }
    // Esc to close
    document.addEventListener('keydown', (ev) => { if (ev.key === 'Escape') closeLogoutConfirm(); });
});

// Expose window.logout as the opener only, to prevent immediate logout by external calls
window.logout = function(e){
    e?.preventDefault?.(); e?.stopPropagation?.();
    const m = document.getElementById('logoutConfirmModal');
    if (m) m.style.display = 'flex';
    return false;
};
