// Logout functionality with confirmation
async function logout(event) {
    if (event) {
        event.preventDefault();
        event.stopPropagation();
    }

    // Show confirmation dialog using the existing modal
    if (window.confirmationModal) {
        try {
            // Store the button that triggered the logout
            const logoutBtn = event?.currentTarget || 
                             document.querySelector('.logout-btn') || 
                             document.querySelector('[onclick*="logout"]');
            
            // Show the confirmation modal
            confirmationModal.show(
                'Confirm Logout',
                'Are you sure you want to log out? Any unsaved changes may be lost.',
                async () => {
                    // This is the confirm callback
                    try {
                        // Show loading state on the button if it exists
                        if (logoutBtn) {
                            const originalHtml = logoutBtn.innerHTML;
                            const originalDisabled = logoutBtn.disabled;
                            
                            logoutBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Logging out...';
                            logoutBtn.disabled = true;
                            
                            // Restore button state after a delay
                            setTimeout(() => {
                                if (logoutBtn) {
                                    logoutBtn.innerHTML = originalHtml;
                                    logoutBtn.disabled = originalDisabled;
                                }
                            }, 2000);
                        }
                        
                        // Try to call the server-side logout endpoint
                        const response = await fetch('api/auth.php?action=logout', {
                            method: 'POST',
                            credentials: 'include'
                        });

                        // Clear client-side storage
                        localStorage.removeItem('userSession');
                        sessionStorage.removeItem('userSession');
                        
                        // Redirect to login page
                        window.location.href = 'login.html';
                        
                    } catch (error) {
                        console.error('Logout error:', error);
                        // Show error message
                        if (window.confirmationModal) {
                            confirmationModal.show(
                                'Logout Error',
                                'There was an issue logging out. You will be redirected to the login page.',
                                () => {
                                    window.location.href = 'login.html';
                                }
                            );
                        } else {
                            // Fallback in case the modal is not available
                            if (confirm('There was an issue logging out. Click OK to continue to the login page.')) {
                                window.location.href = 'login.html';
                            }
                        }
                    }
                }
            );
            
        } catch (error) {
            console.error('Error showing confirmation dialog:', error);
            // Fallback to default behavior if there's an error with the modal
            if (confirm('Are you sure you want to log out?')) {
                window.location.href = 'login.html';
            }
        }
    } else {
        // Fallback if confirmation modal is not available
        if (confirm('Are you sure you want to log out?')) {
            window.location.href = 'login.html';
        }
    }
    
    return false;
}

// Make the function globally available
window.logout = logout;

// Add click event listeners when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Add click handlers to all logout buttons
    const logoutButtons = [
        ...document.querySelectorAll('.logout-btn'),
        ...document.querySelectorAll('[onclick*="logout"]'),
        ...document.querySelectorAll('[data-action="logout"]')
    ];
    
    // Add click handler to logout links in dropdowns
    const logoutLinks = document.querySelectorAll('a[href*="logout"]');
    logoutLinks.forEach(link => {
        if (!link.onclick) {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                logout(e);
            });
        }
    });
    
    // Add click handlers to all logout buttons
    logoutButtons.forEach(btn => {
        if (!btn.onclick) {
            btn.addEventListener('click', logout);
        }
    });
});

// Add keyboard shortcut for logout (Ctrl+Alt+L)
document.addEventListener('keydown', (e) => {
    if ((e.ctrlKey || e.metaKey) && e.altKey && e.key.toLowerCase() === 'l') {
        e.preventDefault();
        logout();
    }
});
