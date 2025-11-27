/**
 * Dashboard Synchronization Manager
 * Enables real-time sync between admin and user dashboards
 */

class DashboardSync {
    constructor() {
        this.channel = null;
        this.syncEnabled = true;
        this.lastSyncTime = Date.now();
        
        // Initialize BroadcastChannel if supported
        if (typeof BroadcastChannel !== 'undefined') {
            this.channel = new BroadcastChannel('dashboard_sync');
            this.setupBroadcastListener();
        }
        
        // Setup localStorage listener for cross-tab sync
        this.setupStorageListener();
        
        console.log('Dashboard sync initialized');
    }
    
    setupBroadcastListener() {
        if (!this.channel) return;
        
        this.channel.addEventListener('message', (event) => {
            this.handleSyncEvent(event.data);
        });
    }
    
    setupStorageListener() {
        window.addEventListener('storage', (event) => {
            if (event.key && event.key.startsWith('dashboard_sync_')) {
                try {
                    const syncData = JSON.parse(event.newValue);
                    if (syncData && syncData.type) {
                        this.handleSyncEvent(syncData);
                    }
                } catch (error) {
                    console.error('Error parsing sync event:', error);
                }
            }
        });
    }
    
    handleSyncEvent(data) {
        if (!data || !data.type) return;
        
        // Prevent processing our own events (avoid loops)
        const currentSource = window.location.pathname.includes('admin') ? 'admin' : 'user';
        if (data.source === currentSource) {
            console.log('📡 Sync event ignored (same source):', data.type);
            return;
        }
        
        console.log('📡 Sync event received:', data.type, 'from', data.source);
        
        switch (data.type) {
            case 'submission_updated':
                this.syncSubmissions();
                break;
            case 'task_assigned':
                this.syncTasks();
                break;
            case 'user_updated':
                this.syncUsers();
                break;
            case 'dashboard_updated':
                this.syncDashboard();
                break;
            case 'refresh_all':
                this.refreshAll();
                break;
            default:
                console.log('Unknown sync event type:', data.type);
        }
    }
    
    // Broadcast sync event to other tabs/windows
    broadcast(type, payload = {}) {
        const syncData = {
            type: type,
            payload: payload,
            timestamp: Date.now(),
            source: window.location.pathname.includes('admin') ? 'admin' : 'user'
        };
        
        // Use BroadcastChannel if available
        if (this.channel) {
            this.channel.postMessage(syncData);
        }
        
        // Also use localStorage for cross-tab sync
        const storageKey = `dashboard_sync_${Date.now()}`;
        localStorage.setItem(storageKey, JSON.stringify(syncData));
        
        // Clean up old sync keys (keep last 10)
        this.cleanupSyncKeys();
        
        console.log('📤 Sync event broadcasted:', type);
    }
    
    cleanupSyncKeys() {
        try {
            const keys = Object.keys(localStorage).filter(k => k.startsWith('dashboard_sync_'));
            if (keys.length > 10) {
                keys.sort().slice(0, keys.length - 10).forEach(key => {
                    localStorage.removeItem(key);
                });
            }
        } catch (error) {
            console.error('Error cleaning up sync keys:', error);
        }
    }
    
    // Sync methods - these will be overridden by dashboard instances
    syncSubmissions() {
        if (window.userDashboard && typeof window.userDashboard.loadSubmissions === 'function') {
            window.userDashboard.loadSubmissions();
        }
        if (window.adminDashboard && typeof window.adminDashboard.loadSubmissions === 'function') {
            window.adminDashboard.loadSubmissions();
        }
    }
    
    syncTasks() {
        if (window.userDashboard && typeof window.userDashboard.loadAssignedReports === 'function') {
            window.userDashboard.loadAssignedReports();
        }
    }
    
    syncUsers() {
        if (window.adminDashboard && typeof window.adminDashboard.loadUsers === 'function') {
            window.adminDashboard.loadUsers();
        }
    }
    
    syncDashboard() {
        if (window.userDashboard && typeof window.userDashboard.loadDashboardData === 'function') {
            window.userDashboard.loadDashboardData();
        }
        if (window.adminDashboard && typeof window.adminDashboard.loadDashboardData === 'function') {
            window.adminDashboard.loadDashboardData();
        }
    }
    
    refreshAll() {
        this.syncSubmissions();
        this.syncTasks();
        this.syncUsers();
        this.syncDashboard();
    }
}

// Create global sync instance
window.dashboardSync = new DashboardSync();

