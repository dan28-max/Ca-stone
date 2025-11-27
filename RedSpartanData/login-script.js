class SimpleLoginSystem {
    constructor() {
        this.isLoading = false;
        this.init();
    }

    async requestPasswordReset() {
        // Fallback to prompts if inline form cannot be built
        try {
            // Prefer opening the inline form
            if (this.showForgotPasswordForm && this.showForgotPasswordForm()) return;
        } catch (_) {}

        try {
            const usernameInput = document.getElementById('username');
            let username = (usernameInput?.value || '').trim();
            if (!username) {
                username = prompt('Enter your username to request a password change (admin approval required):');
                if (!username) return;
                username = username.trim();
            }

            const newPass = prompt('Enter your new password:');
            if (!newPass) return;
            const confirmPass = prompt('Confirm your new password:');
            if (confirmPass === null) return;
            if (newPass !== confirmPass) {
                this.showError('Passwords do not match');
                return;
            }

            const basePath = this.getBasePath();
            const apiUrl = `${basePath}/api/forgot_password_request.php`;
            const res = await fetch(apiUrl, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ username, new_password: newPass, confirm_password: confirmPass })
            });
            const result = await res.json().catch(() => ({ success: false, error: 'Invalid server response' }));

            if (result.success) {
                this.showSuccess(result.message || 'Request submitted. Please wait for admin approval.');
            } else {
                this.showError(result.error || 'Failed to submit request');
            }
        } catch (err) {
            console.error('Reset request error:', err);
            this.showError('Network error while submitting request');
        }
    }

    showForgotPasswordForm() {
        try {
            const form = document.getElementById('loginForm');
            if (!form) return false;
            // Prevent duplicates
            if (document.getElementById('forgotPwdInline')) {
                document.getElementById('forgotPwdInline').scrollIntoView({ behavior: 'smooth', block: 'center' });
                return true;
            }

            const container = document.createElement('div');
            container.id = 'forgotPwdInline';
            container.style.marginTop = '16px';
            container.style.padding = '12px';
            container.style.border = '1px solid #e5e7eb';
            container.style.borderRadius = '8px';
            container.style.background = '#fafafa';

            container.innerHTML = `
                <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:8px;">
                    <div style="font-weight:600; color:#1f2937;">Forgot password (Admin approval)</div>
                    <button type="button" id="fpCloseBtn" style="background:none; border:none; color:#6b7280; cursor:pointer;">✕</button>
                </div>
                <div class="form-group">
                    <label style="display:block; font-size:12px; color:#374151; margin-bottom:4px;">Username</label>
                    <input id="fpUsername" type="text" class="input-group" style="width:100%; padding:8px; border:1px solid #d1d5db; border-radius:6px;" placeholder="Enter your username" />
                </div>
                <div class="form-group" style="margin-top:8px;">
                    <label style="display:block; font-size:12px; color:#374151; margin-bottom:4px;">New Password</label>
                    <input id="fpNewPassword" type="password" class="input-group" style="width:100%; padding:8px; border:1px solid #d1d5db; border-radius:6px;" placeholder="Enter new password" />
                </div>
                <div class="form-group" style="margin-top:8px;">
                    <label style="display:block; font-size:12px; color:#374151; margin-bottom:4px;">Confirm New Password</label>
                    <input id="fpConfirmPassword" type="password" class="input-group" style="width:100%; padding:8px; border:1px solid #d1d5db; border-radius:6px;" placeholder="Confirm new password" />
                </div>
                <div style="display:flex; gap:8px; margin-top:12px;">
                    <button type="button" id="fpSubmitBtn" class="login-btn" style="flex:1; display:inline-flex; align-items:center; justify-content:center; gap:6px; padding:10px 12px; border-radius:6px; background:#b91c1c; color:#fff; border:none; cursor:pointer;">
                        <i class="fas fa-paper-plane"></i> Send Request
                    </button>
                </div>
            `;

            // Pre-fill username if available
            const usernameInput = document.getElementById('username');
            if (usernameInput && usernameInput.value.trim()) {
                container.querySelector('#fpUsername').value = usernameInput.value.trim();
            }

            form.parentNode.insertBefore(container, form.nextSibling);

            const closeBtn = container.querySelector('#fpCloseBtn');
            closeBtn.addEventListener('click', () => container.remove());
            const submitBtn = container.querySelector('#fpSubmitBtn');
            submitBtn.addEventListener('click', async () => {
                const u = container.querySelector('#fpUsername').value.trim();
                const p1 = container.querySelector('#fpNewPassword').value;
                const p2 = container.querySelector('#fpConfirmPassword').value;
                if (!u || !p1 || !p2) { this.showError('Please fill in all fields'); return; }
                if (p1 !== p2) { this.showError('Passwords do not match'); return; }
                if (p1.length < 6) { this.showError('Password must be at least 6 characters'); return; }

                const basePath = this.getBasePath();
                const apiUrl = `${basePath}/api/forgot_password_request.php`;
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';
                try {
                    const res = await fetch(apiUrl, {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ username: u, new_password: p1, confirm_password: p2 })
                    });
                    const result = await res.json().catch(() => ({ success: false, error: 'Invalid server response' }));
                    if (result.success) {
                        this.showSuccess(result.message || 'Request submitted. Please wait for admin approval.');
                        container.remove();
                    } else {
                        this.showError(result.error || 'Failed to submit request');
                    }
                } catch (err) {
                    console.error('Forgot password request error:', err);
                    this.showError('Network error while submitting request');
                } finally {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Send Request';
                }
            });

            return true;
        } catch (e) {
            return false;
        }
    }

    init() {
        this.setupEventListeners();
        this.checkExistingSession();
    }

    setupEventListeners() {
        const form = document.getElementById('loginForm');
        const passwordToggle = document.getElementById('passwordToggle');
        const usernameInput = document.getElementById('username');
        const passwordInput = document.getElementById('password');
        const resetLink = document.querySelector('.forgot-password');

        // Form submission
        form.addEventListener('submit', (e) => {
            e.preventDefault();
            this.handleLogin();
        });

        // Password toggle
        passwordToggle.addEventListener('click', () => {
            this.togglePasswordVisibility();
        });

        // Real-time validation
        usernameInput.addEventListener('input', () => {
            this.validateUsername();
        });

        passwordInput.addEventListener('input', () => {
            this.validatePassword();
        });

        // Clear errors on input
        [usernameInput, passwordInput].forEach(input => {
            input.addEventListener('input', () => {
                this.hideError();
            });
        });

        // Forgot password disabled: remove link from UI
        if (resetLink) {
            // Hide the element entirely to avoid confusion
            resetLink.style.display = 'none';
        }
    }

    checkExistingSession() {
        const sessionData = localStorage.getItem('spartan_session');
        if (sessionData) {
            try {
                const session = JSON.parse(sessionData);
                if (session.isAuthenticated && session.expires_at > Date.now()) {
                    this.redirectToDashboard(session.user);
                }
            } catch (e) {
                localStorage.removeItem('spartan_session');
            }
        }
    }

    async handleLogin() {
        if (this.isLoading) return;

        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;
        const rememberMe = document.getElementById('rememberMe').checked;

        // Validate form
        if (!this.validateForm(username, password)) {
            return;
        }

        // Get reCAPTCHA token
        let recaptchaToken = '';
        try {
            if (typeof grecaptcha !== 'undefined') {
                const recaptchaWidget = document.getElementById('recaptchaWidget');
                if (recaptchaWidget) {
                    // Get the widget ID (stored when rendering programmatically)
                    const widgetId = recaptchaWidget.getAttribute('data-widget-id');
                    if (widgetId !== null) {
                        recaptchaToken = grecaptcha.getResponse(parseInt(widgetId));
                    } else {
                        // Try to get response from first widget (default)
                        recaptchaToken = grecaptcha.getResponse();
                    }
                }
            }
        } catch (error) {
            console.warn('reCAPTCHA error:', error);
            // Continue without reCAPTCHA if it's not configured
        }

        this.setLoading(true);
        this.hideError();

        try {
            const result = await this.authenticateUser(username, password, rememberMe, recaptchaToken);
            
            if (result.success) {
                this.showSuccess('Login successful! Redirecting...');
                this.storeUserSession(result.user, rememberMe);
                
                setTimeout(() => {
                    this.redirectToDashboard(result.user);
                }, 1500);
            } else {
                this.showError(result.message);
                // Reset reCAPTCHA on error
                if (typeof grecaptcha !== 'undefined') {
                    const recaptchaWidget = document.getElementById('recaptchaWidget');
                    if (recaptchaWidget) {
                        const widgetId = recaptchaWidget.getAttribute('data-widget-id');
                        if (widgetId !== null) {
                            grecaptcha.reset(parseInt(widgetId));
                        } else {
                            grecaptcha.reset();
                        }
                    }
                }
            }
        } catch (error) {
            console.error('Login error:', error);
            this.showError('An error occurred. Please try again.');
            // Reset reCAPTCHA on error
            if (typeof grecaptcha !== 'undefined') {
                const recaptchaWidget = document.getElementById('recaptchaWidget');
                if (recaptchaWidget) {
                    const widgetId = recaptchaWidget.getAttribute('data-widget-id');
                    if (widgetId !== null) {
                        grecaptcha.reset(parseInt(widgetId));
                    } else {
                        grecaptcha.reset();
                    }
                }
            }
        } finally {
            this.setLoading(false);
        }
    }

    async authenticateUser(username, password, rememberMe, recaptchaToken = '') {
        try {
            console.log('Attempting login with:', { username, rememberMe });
            
            // Auto-detect base path from current location
            const basePath = this.getBasePath();
            const apiUrl = `${basePath}/api/simple_auth.php?action=login`;
            console.log('API URL:', apiUrl);
            
            const response = await fetch(apiUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    username: username,
                    password: password,
                    remember: rememberMe,
                    recaptcha_token: recaptchaToken
                })
            });

            console.log('Login response status:', response.status);
            const result = await response.json();
            console.log('Login response:', result);
            
            if (result.success) {
                return {
                    success: true,
                    user: result.data.user
                };
            } else {
                return {
                    success: false,
                    message: result.error || 'Authentication failed'
                };
            }
        } catch (error) {
            console.error('Authentication error:', error);
            return {
                success: false,
                message: 'Network error. Please check your connection.'
            };
        }
    }

    validateForm(username, password) {
        let isValid = true;

        // Validate username
        if (!this.validateUsername()) {
            isValid = false;
        }

        // Validate password
        if (!this.validatePassword()) {
            isValid = false;
        }

        return isValid;
    }

    validateUsername() {
        const usernameInput = document.getElementById('username');
        const username = usernameInput.value.trim();

        if (!username) {
            this.showFieldError(usernameInput, 'Username is required');
            return false;
        } else if (username.length < 3) {
            this.showFieldError(usernameInput, 'Username must be at least 3 characters');
            return false;
        } else {
            this.clearFieldError(usernameInput);
            return true;
        }
    }

    validatePassword() {
        const passwordInput = document.getElementById('password');
        const password = passwordInput.value;

        if (!password) {
            this.showFieldError(passwordInput, 'Password is required');
            return false;
        } else if (password.length < 6) {
            this.showFieldError(passwordInput, 'Password must be at least 6 characters');
            return false;
        } else {
            this.clearFieldError(passwordInput);
            return true;
        }
    }

    showFieldError(input, message) {
        this.clearFieldError(input);
        
        const errorDiv = document.createElement('div');
        errorDiv.className = 'field-error';
        errorDiv.textContent = message;
        
        // Find the form-group container (parent of input-group)
        const formGroup = input.closest('.form-group');
        if (formGroup) {
            // Append to form-group so error appears below the input
            formGroup.appendChild(errorDiv);
        } else {
            // Fallback: use input-group if form-group not found
            input.parentNode.appendChild(errorDiv);
        }
        
        input.classList.add('error');
    }

    clearFieldError(input) {
        // Find the form-group container
        const formGroup = input.closest('.form-group');
        if (formGroup) {
            const existingError = formGroup.querySelector('.field-error');
            if (existingError) {
                existingError.remove();
            }
        } else {
            // Fallback: check input-group
            const existingError = input.parentNode.querySelector('.field-error');
            if (existingError) {
                existingError.remove();
            }
        }
        input.classList.remove('error');
    }

    togglePasswordVisibility() {
        const passwordInput = document.getElementById('password');
        const toggleIcon = document.getElementById('passwordToggle').querySelector('i');
        
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleIcon.classList.remove('fa-eye');
            toggleIcon.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            toggleIcon.classList.remove('fa-eye-slash');
            toggleIcon.classList.add('fa-eye');
        }
    }

    storeUserSession(user, rememberMe) {
        const sessionData = {
            ...user,
            isAuthenticated: true,
            expires_at: rememberMe ? Date.now() + (30 * 24 * 60 * 60 * 1000) : Date.now() + (24 * 60 * 60 * 1000)
        };
        
        console.log('Storing session data:', sessionData);
        localStorage.setItem('spartan_session', JSON.stringify(sessionData));
    }

    redirectToDashboard(user) {
        console.log('Redirecting user:', user);
        
        // Determine dashboard based on user role and campus
        if (user.role === 'super_admin') {
            // Super admin - redirect to super admin dashboard
            window.location.href = 'admin-dashboard.html?super=true';
        } else if (user.role === 'admin') {
            // Campus admin - redirect to campus admin dashboard
            window.location.href = `admin-dashboard.html?campus=${encodeURIComponent(user.campus)}`;
        } else {
            // Office user - redirect to user dashboard (use enhanced version)
            window.location.href = `user-dashboard-enhanced.html?campus=${encodeURIComponent(user.campus || '')}&office=${encodeURIComponent(user.office || '')}`;
        }
    }

    setLoading(loading) {
        this.isLoading = loading;
        const loginBtn = document.querySelector('.login-btn');
        const form = document.getElementById('loginForm');
        
        if (loading) {
            loginBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Logging In...';
            loginBtn.disabled = true;
            form.style.opacity = '0.7';
        } else {
            loginBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Login';
            loginBtn.disabled = false;
            form.style.opacity = '1';
        }
    }

    showError(message) {
        const errorDiv = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');
        
        errorText.textContent = message;
        errorDiv.style.display = 'flex';
        errorDiv.style.animation = 'slideInDown 0.5s ease';
        
        // Auto-hide after 5 seconds
        setTimeout(() => {
            this.hideError();
        }, 5000);
    }

    showSuccess(message) {
        const successDiv = document.getElementById('successMessage');
        const successText = document.getElementById('successText');
        
        successText.textContent = message;
        successDiv.style.display = 'flex';
        successDiv.style.animation = 'slideInDown 0.5s ease';
    }

    hideError() {
        const errorDiv = document.getElementById('errorMessage');
        errorDiv.style.display = 'none';
    }

    hideSuccess() {
        const successDiv = document.getElementById('successMessage');
        successDiv.style.display = 'none';
    }
    
    /**
     * Get base path from current location
     * Works for both local development and production
     */
    getBasePath() {
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
}

// Initialize the login system when the page loads
document.addEventListener('DOMContentLoaded', () => {
    new SimpleLoginSystem();
});
