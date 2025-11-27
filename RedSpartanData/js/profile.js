// Make sure the function is globally available
window.fetchAdminProfile = fetchAdminProfile;

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Only run if we're on the profile page
    if (document.getElementById('profile')) {
        fetchAdminProfile();
    }
});

async function fetchAdminProfile() {
    try {
        showLoadingState(true);
        
        // Get the base path dynamically - match the pattern used in other files
        let basePath = '';
        const pathname = window.location.pathname;
        
        if (pathname.includes('/Rework/')) {
            basePath = '/Rework';
        } else if (pathname.includes('/rework/')) {
            basePath = '/rework';
        }
        
        // Fetch admin data from the server
        const apiUrl = basePath ? `${basePath}/api/get_admin_profile.php` : 'api/get_admin_profile.php';
        
        console.log('Fetching profile from:', apiUrl);
        
        const response = await fetch(apiUrl, {
            method: 'GET',
            credentials: 'include' // Important for sending session cookies
        });

        if (!response.ok) {
            throw new Error('Failed to fetch admin profile');
        }

        const result = await response.json();
        
        if (result.success) {
            updateProfileUI(result.data);
        } else {
            throw new Error(result.message || 'Failed to load profile data');
        }
        
    } catch (error) {
        console.error('Error:', error);
        showError('Failed to load profile. ' + error.message);
        // Fallback to default data if API fails
        updateProfileUI(getDefaultProfileData());
    } finally {
        showLoadingState(false);
    }
}

function showLoadingState(isLoading) {
    const profileSection = document.getElementById('profile');
    if (!profileSection) return;
    
    if (isLoading) {
        profileSection.classList.add('loading');
    } else {
        profileSection.classList.remove('loading');
    }
}

function showError(message) {
    // You can implement a more sophisticated error display
    console.error('Profile Error:', message);
    // Example: Show a toast notification
    if (typeof showToast === 'function') {
        showToast(message, 'error');
    }
}

function updateProfileUI(userData) {
    try {
        // Store the data in localStorage as fallback
        localStorage.setItem('adminProfile', JSON.stringify(userData));
        
        // Get user's name or username for avatar initial
        const userName = userData.name || userData.username || 'Admin User';
        const userInitial = userName.charAt(0).toUpperCase();
        
        // Update avatar initial
        const avatarInitial = document.getElementById('avatarInitial');
        if (avatarInitial) avatarInitial.textContent = userInitial;
        
        // Update profile name
        const nameElement = document.getElementById('profileName');
        if (nameElement) nameElement.textContent = userName;
        
        // Update email
        const emailText = document.getElementById('profileEmailText');
        const email = userData.username || userData.email || 'N/A';
        if (emailText) emailText.textContent = email;
        
        // Update role badge
        const roleText = document.getElementById('profileRoleText');
        const role = userData.role || 'Administrator';
        if (roleText) roleText.textContent = role;
        
        // Update last login
        const lastLoginElement = document.getElementById('lastLogin');
        if (lastLoginElement) {
            const lastLoginTimestamp = lastLoginElement.querySelector('.detail-timestamp');
            if (lastLoginTimestamp) {
                lastLoginTimestamp.textContent = formatDate(userData.lastLogin || userData.last_login || new Date().toISOString());
            }
        }
        
        // Update account created
        const accountCreatedElement = document.getElementById('accountCreated');
        if (accountCreatedElement) {
            const createdTimestamp = accountCreatedElement.querySelector('.detail-timestamp');
            if (createdTimestamp) {
                createdTimestamp.textContent = formatDate(userData.accountCreated || userData.created_at);
            }
        }
        
        // Update campus
        const campusElement = document.getElementById('profileCampus');
        if (campusElement) {
            const campusBadge = campusElement.querySelector('.detail-badge-campus');
            if (campusBadge) {
                campusBadge.textContent = userData.campus || 'Not specified';
            } else {
                campusElement.innerHTML = `<span class="detail-badge-campus">${userData.campus || 'Not specified'}</span>`;
            }
        }
        
        // Update office
        const officeElement = document.getElementById('profileOffice');
        if (officeElement) {
            const officeBadge = officeElement.querySelector('.detail-badge-office');
            if (officeBadge) {
                officeBadge.textContent = userData.office || 'Not specified';
            } else {
                officeElement.innerHTML = `<span class="detail-badge-office">${userData.office || 'Not specified'}</span>`;
            }
        }
        
        // Update status badge
        const statusBadge = document.getElementById('statusBadge');
        if (statusBadge) {
            const isActive = userData.isActive !== undefined ? userData.isActive : (userData.status === 'active' || !userData.status || userData.status === 'Active');
            statusBadge.textContent = isActive ? 'Active' : 'Inactive';
            statusBadge.className = 'status-badge-enhanced ' + (isActive ? 'active' : 'inactive');
        }
        
    } catch (error) {
        console.error('Error updating profile UI:', error);
        showError('Error displaying profile information');
    }
}

// Helper function to format dates
function formatDate(dateString) {
    if (!dateString) return 'N/A';
    
    const options = { 
        year: 'numeric', 
        month: 'long', 
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    };
    
    return new Date(dateString).toLocaleDateString(undefined, options);
}

// Fallback data in case API is not available
function getDefaultProfileData() {
    // Try to get data from session storage as fallback
    const storedUser = localStorage.getItem('adminProfile');
    if (storedUser) {
        try {
            return JSON.parse(storedUser);
        } catch (e) {
            console.error('Error parsing stored profile:', e);
        }
    }
    
    // Default fallback data
    return {
        fullName: 'Admin User',
        role: 'Administrator',
        email: 'admin@example.com',
        lastLogin: new Date().toISOString(),
        accountCreated: '2023-01-01T00:00:00.000Z',
        status: 'Active',
        isActive: true,
        campus: 'Main Campus'
    };
}

// Show confirmation dialog
function showConfirmation(message, onConfirm, onCancel = null) {
    const modal = document.createElement('div');
    modal.style.position = 'fixed';
    modal.style.top = '0';
    modal.style.left = '0';
    modal.style.width = '100%';
    modal.style.height = '100%';
    modal.style.backgroundColor = 'rgba(0,0,0,0.5)';
    modal.style.display = 'flex';
    modal.style.justifyContent = 'center';
    modal.style.alignItems = 'center';
    modal.style.zIndex = '2000';
    
    const content = document.createElement('div');
    content.style.background = 'white';
    content.style.padding = '2rem';
    content.style.borderRadius = '8px';
    content.style.maxWidth = '500px';
    content.style.width = '90%';
    content.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.1)';
    
    content.innerHTML = `
        <h3 style="margin-top: 0; color: #1e293b; font-size: 1.25rem;">
            <i class="fas fa-exclamation-circle" style="color: #f59e0b; margin-right: 10px;"></i>
            Confirm Action
        </h3>
        <p style="margin: 1rem 0 2rem; color: #475569; line-height: 1.5;">${message}</p>
        <div style="display: flex; justify-content: flex-end; gap: 12px; margin-top: 2rem; padding-top: 1rem; border-top: 1px solid #e2e8f0;">
            <button id="confirmCancel" style="padding: 8px 16px; background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 6px; cursor: pointer; color: #475569; font-weight: 500;">
                Cancel
            </button>
            <button id="confirmOk" style="padding: 8px 20px; background: #4f46e5; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: 500;">
                OK
            </button>
        </div>
    `;
    
    modal.appendChild(content);
    document.body.appendChild(modal);
    
    // Focus the OK button for better accessibility
    const okBtn = content.querySelector('#confirmOk');
    okBtn.focus();
    
    // Handle confirm
    okBtn.onclick = () => {
        document.body.removeChild(modal);
        onConfirm();
    };
    
    // Handle cancel
    const cancelBtn = content.querySelector('#confirmCancel');
    cancelBtn.onclick = () => {
        document.body.removeChild(modal);
        if (typeof onCancel === 'function') onCancel();
    };
    
    // Close on escape key
    const handleKeyDown = (e) => {
        if (e.key === 'Escape') {
            document.body.removeChild(modal);
            document.removeEventListener('keydown', handleKeyDown);
            if (typeof onCancel === 'function') onCancel();
        }
    };
    
    document.addEventListener('keydown', handleKeyDown);
    
    // Close on outside click
    modal.onclick = (e) => {
        if (e.target === modal) {
            document.body.removeChild(modal);
            document.removeEventListener('keydown', handleKeyDown);
            if (typeof onCancel === 'function') onCancel();
        }
    };
}

// Change Password Functions
function changePassword() {
    // Show confirmation dialog before opening password change form
    showConfirmation('You are about to change your password. Do you want to continue?', () => {
        // Reset form
        const form = document.getElementById('changePasswordForm');
        if (form) form.reset();
        
        const passwordMatch = document.getElementById('password-match');
        if (passwordMatch) passwordMatch.style.display = 'none';
        
        const submitButton = document.getElementById('submitPasswordChange');
        if (submitButton) submitButton.disabled = true;
        
        // Reset password strength meter
        const strengthMeter = document.querySelector('.strength-meter-fill');
        if (strengthMeter) {
            strengthMeter.style.width = '0%';
            strengthMeter.style.background = '#ef4444';
        }
        
        // Reset checkmarks
        document.querySelectorAll('#password-requirements i').forEach(icon => {
            icon.style.display = 'none';
        });
        
        // Show the modal
        const modal = document.getElementById('changePasswordModal');
        if (modal) modal.style.display = 'block';
    });
}

async function handlePasswordChange(event) {
    event.preventDefault();
    
    const currentPassword = document.getElementById('currentPassword').value;
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    // Basic validation
    if (newPassword !== confirmPassword) {
        showError('New password and confirm password do not match');
        return;
    }
    
    if (newPassword.length < 8) {
        showError('Password must be at least 8 characters long');
        return;
    }
    
    // Show confirmation dialog before submitting
    showConfirmation('Are you sure you want to change your password?', async () => {
        // Show loading state
        const submitButton = document.getElementById('submitPasswordChange');
        const submitButtonText = document.getElementById('submitButtonText');
        const submitButtonSpinner = document.getElementById('submitButtonSpinner');
        
        if (!submitButton || !submitButtonText || !submitButtonSpinner) {
            console.error('Required form elements not found');
            showError('System error. Please refresh the page and try again.');
            return;
        }
        
        submitButtonText.style.display = 'none';
        submitButtonSpinner.style.display = 'inline-block';
        submitButton.disabled = true;
        
        try {
            const response = await fetch('api/change_password.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: JSON.stringify({
                    currentPassword: currentPassword,
                    newPassword: newPassword
                }),
                credentials: 'include'
            });

            // First, check if the response is JSON
            const contentType = response.headers.get('content-type');
            let result;
            
            if (contentType && contentType.includes('application/json')) {
                result = await response.json();
            } else {
                // If not JSON, get the text and log it for debugging
                const text = await response.text();
                console.error('Non-JSON response:', text);
                throw new Error('Invalid response from server. Please check the console for details.');
            }
            
            if (!response.ok) {
                throw new Error(result.message || `HTTP error! status: ${response.status}`);
            }
            
            if (result && result.success) {
                // Show success message with a checkmark
                const successMessage = `
                    <div style="text-align: center; padding: 20px;">
                        <div style="width: 60px; height: 60px; margin: 0 auto 20px; background: #4CAF50; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-check" style="color: white; font-size: 30px;"></i>
                        </div>
                        <h3 style="color: #1e293b; margin-bottom: 10px;">Success!</h3>
                        <p style="color: #475569;">Your password has been changed successfully.</p>
                    </div>
                `;
                
                // Show success message in a dialog
                const closeModal = (modalId) => {
                    const modal = document.getElementById(modalId);
                    if (modal) modal.style.display = 'none';
                };
                
                showConfirmation(successMessage, () => {
                    // Close the modal after successful password change
                    closeModal('changePasswordModal');
                    // Reset the form
                    const form = document.getElementById('changePasswordForm');
                    if (form) form.reset();
                });
                
            } else {
                throw new Error(result.message || 'Failed to change password');
            }
        } catch (error) {
            console.error('Error changing password:', error);
            showError(error.message || 'Failed to change password. Please try again.');
        } finally {
            // Reset button state
            if (submitButtonText) submitButtonText.style.display = 'inline-block';
            if (submitButtonSpinner) submitButtonSpinner.style.display = 'none';
            if (submitButton) submitButton.disabled = false;
        }
    });
}

// Password strength checker
function checkPasswordStrength(password) {
    let strength = 0;
    const strengthMeter = document.querySelector('.strength-meter-fill');
    const lengthCheck = document.getElementById('length-check');
    const uppercaseCheck = document.getElementById('uppercase-check');
    const numberCheck = document.getElementById('number-check');
    
    // Reset checks
    lengthCheck.style.display = 'none';
    uppercaseCheck.style.display = 'none';
    numberCheck.style.display = 'none';
    
    // Check length
    if (password.length >= 8) {
        strength += 1;
        lengthCheck.style.display = 'inline-block';
    }
    
    // Check for uppercase letters
    if (/[A-Z]/.test(password)) {
        strength += 1;
        uppercaseCheck.style.display = 'inline-block';
    }
    
    // Check for numbers
    if (/[0-9]/.test(password)) {
        strength += 1;
        numberCheck.style.display = 'inline-block';
    }
    
    // Update strength meter
    const width = (strength / 3) * 100;
    strengthMeter.style.width = width + '%';
    
    // Update color based on strength
    if (strength <= 1) {
        strengthMeter.style.background = '#ef4444'; // Red
    } else if (strength === 2) {
        strengthMeter.style.background = '#f59e0b'; // Orange
    } else {
        strengthMeter.style.background = '#22c55e'; // Green
    }
    
    return strength;
}

// Toggle password visibility
document.addEventListener('click', function(e) {
    if (e.target.closest('.toggle-password')) {
        const toggle = e.target.closest('.toggle-password');
        const input = document.querySelector(toggle.getAttribute('toggle'));
        const icon = toggle.querySelector('i');
        
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
});

// Password match checker
document.getElementById('confirmPassword').addEventListener('input', function() {
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = this.value;
    const matchDiv = document.getElementById('password-match');
    
    if (newPassword && confirmPassword) {
        if (newPassword === confirmPassword) {
            matchDiv.style.display = 'block';
            matchDiv.style.color = '#22c55e';
            matchDiv.innerHTML = '<i class="fas fa-check-circle"></i> Passwords match';
            document.getElementById('submitPasswordChange').disabled = false;
        } else {
            matchDiv.style.display = 'block';
            matchDiv.style.color = '#ef4444';
            matchDiv.innerHTML = '<i class="fas fa-times-circle"></i> Passwords do not match';
            document.getElementById('submitPasswordChange').disabled = true;
        }
    } else {
        matchDiv.style.display = 'none';
        document.getElementById('submitPasswordChange').disabled = true;
    }
});

// Password strength checker
const newPasswordInput = document.getElementById('newPassword');
if (newPasswordInput) {
    newPasswordInput.addEventListener('input', function() {
        checkPasswordStrength(this.value);
    });
}

// Modal close function
function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

// Show success message
function showSuccess(message) {
    // You can replace this with a more sophisticated notification system
    alert('Success: ' + message);
}

// Expose functions to global scope
window.changePassword = changePassword;
window.handlePasswordChange = handlePasswordChange;
window.closeModal = closeModal;
window.fetchUserProfile = fetchAdminProfile; // Alias for backward compatibility
window.fetchAdminProfile = fetchAdminProfile; // Ensure it's available with both names
