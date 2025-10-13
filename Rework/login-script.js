class SimpleLoginSystem {
    constructor() {
        this.isLoading = false;
        this.init();
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

        this.setLoading(true);
        this.hideError();

        try {
            const result = await this.authenticateUser(username, password, rememberMe);
            
            if (result.success) {
                this.showSuccess('Login successful! Redirecting...');
                this.storeUserSession(result.user, rememberMe);
                
                setTimeout(() => {
                    this.redirectToDashboard(result.user);
                }, 1500);
            } else {
                this.showError(result.message);
            }
        } catch (error) {
            console.error('Login error:', error);
            this.showError('An error occurred. Please try again.');
        } finally {
            this.setLoading(false);
        }
    }

    async authenticateUser(username, password, rememberMe) {
        try {
            console.log('Attempting login with:', { username, rememberMe });
            
            // Use absolute path to avoid URL resolution issues
            const response = await fetch('/Rework/api/simple_auth.php?action=login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    username: username,
                    password: password,
                    remember: rememberMe
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
        const usernameRegex = /^[a-zA-Z0-9-_]+$/;

        if (!username) {
            this.showFieldError(usernameInput, 'Username is required');
            return false;
        } else if (username.length < 3) {
            this.showFieldError(usernameInput, 'Username must be at least 3 characters');
            return false;
        } else if (!usernameRegex.test(username)) {
            this.showFieldError(usernameInput, 'Username can only contain letters, numbers, hyphens, and underscores');
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
        input.parentNode.appendChild(errorDiv);
        input.classList.add('error');
    }

    clearFieldError(input) {
        const existingError = input.parentNode.querySelector('.field-error');
        if (existingError) {
            existingError.remove();
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
        // Determine dashboard based on user role and campus
        if (user.role === 'super_admin') {
            // Super admin - redirect to super admin dashboard
            window.location.href = 'admin-dashboard.html?super=true';
        } else if (user.role === 'admin') {
            // Campus admin - redirect to campus admin dashboard
            window.location.href = `admin-dashboard.html?campus=${encodeURIComponent(user.campus)}`;
        } else {
            // Office user - redirect to user dashboard
            window.location.href = `user-dashboard.html?campus=${encodeURIComponent(user.campus)}&office=${encodeURIComponent(user.office || '')}`;
        }
    }

    setLoading(loading) {
        this.isLoading = loading;
        const loginBtn = document.querySelector('.login-btn');
        const form = document.getElementById('loginForm');
        
        if (loading) {
            loginBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing In...';
            loginBtn.disabled = true;
            form.style.opacity = '0.7';
        } else {
            loginBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Sign In';
            loginBtn.disabled = false;
            form.style.opacity = '1';
        }
    }

    showError(message) {
        const errorDiv = document.getElementById('errorMessage');
        const errorText = document.getElementById('errorText');
        
        errorText.textContent = message;
        errorDiv.style.display = 'block';
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
        successDiv.style.display = 'block';
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
}

// Initialize the login system when the page loads
document.addEventListener('DOMContentLoaded', () => {
    new SimpleLoginSystem();
});
