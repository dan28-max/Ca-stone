/**
 * Confirmation Dialog Component
 * A modern, reusable confirmation dialog with customizable options
 */
class ConfirmDialog {
    constructor() {
        this.dialog = null;
        this.resolve = null;
        // Wait for DOM to be ready before initializing
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.init());
        } else {
            this.init();
        }
    }

    init() {
        // Ensure body exists before proceeding
        if (!document.body) {
            setTimeout(() => this.init(), 10);
            return;
        }
        
        // Remove any existing dialog first
        const existingDialog = document.querySelector('.confirm-dialog');
        if (existingDialog) {
            console.log('ConfirmDialog: Removing existing dialog');
            existingDialog.remove();
        }
        
        console.log('ConfirmDialog: Initializing new dialog');
        // Create dialog container with backdrop
        this.dialog = document.createElement('div');
        this.dialog.className = 'confirm-dialog';
        this.dialog.id = 'confirm-dialog-instance'; // Add ID for easier debugging
        // Use setProperty with important flag for critical styles
        this.dialog.style.setProperty('display', 'none', 'important');
        this.dialog.style.setProperty('position', 'fixed', 'important');
        this.dialog.style.setProperty('top', '0', 'important');
        this.dialog.style.setProperty('left', '0', 'important');
        this.dialog.style.setProperty('width', '100%', 'important');
        this.dialog.style.setProperty('height', '100%', 'important');
        this.dialog.style.setProperty('background-color', 'rgba(15, 23, 42, 0.75)', 'important');
        this.dialog.style.setProperty('justify-content', 'center', 'important');
        this.dialog.style.setProperty('align-items', 'center', 'important');
        this.dialog.style.setProperty('z-index', '99999', 'important');
        this.dialog.style.setProperty('opacity', '0', 'important');
        this.dialog.style.setProperty('transition', 'opacity 0.3s cubic-bezier(0.4, 0, 0.2, 1)', 'important');
        this.dialog.style.setProperty('backdrop-filter', 'blur(4px)', 'important');
        this.dialog.style.setProperty('pointer-events', 'auto', 'important');

        // Create dialog content container
        const contentWrapper = document.createElement('div');
        contentWrapper.className = 'confirm-dialog-wrapper';
        contentWrapper.style.position = 'relative';
        contentWrapper.style.width = '90%';
        contentWrapper.style.maxWidth = '440px';

        // Create dialog content
        const content = document.createElement('div');
        content.className = 'confirm-dialog-content';
        content.style.setProperty('background', '#ffffff', 'important');
        content.style.setProperty('border-radius', '20px', 'important');
        content.style.setProperty('width', '100%', 'important');
        content.style.setProperty('overflow', 'hidden', 'important');
        content.style.setProperty('box-shadow', '0 20px 60px rgba(0, 0, 0, 0.3), 0 0 0 1px rgba(0, 0, 0, 0.05)', 'important');
        content.style.setProperty('transform', 'translateY(30px) scale(0.95)', 'important');
        content.style.setProperty('transition', 'transform 0.4s cubic-bezier(0.34, 1.56, 0.64, 1)', 'important');

        // Add icon section with gradient background
        const iconSection = document.createElement('div');
        iconSection.className = 'confirm-dialog-icon-section';
        iconSection.style.setProperty('padding', '32px 24px 24px', 'important');
        iconSection.style.setProperty('text-align', 'center', 'important');
        iconSection.style.setProperty('background', 'linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%)', 'important');
        iconSection.style.setProperty('position', 'relative', 'important');
        iconSection.style.setProperty('overflow', 'hidden', 'important');

        // Add decorative circle
        const decorativeCircle = document.createElement('div');
        decorativeCircle.style.position = 'absolute';
        decorativeCircle.style.top = '-50px';
        decorativeCircle.style.right = '-50px';
        decorativeCircle.style.width = '150px';
        decorativeCircle.style.height = '150px';
        decorativeCircle.style.borderRadius = '50%';
        decorativeCircle.style.background = 'rgba(239, 68, 68, 0.1)';
        decorativeCircle.style.filter = 'blur(20px)';
        iconSection.appendChild(decorativeCircle);

        // Icon container with animation
        const iconContainer = document.createElement('div');
        iconContainer.className = 'confirm-dialog-icon-container';
        iconContainer.style.setProperty('display', 'inline-flex', 'important');
        iconContainer.style.setProperty('align-items', 'center', 'important');
        iconContainer.style.setProperty('justify-content', 'center', 'important');
        iconContainer.style.setProperty('width', '80px', 'important');
        iconContainer.style.setProperty('height', '80px', 'important');
        iconContainer.style.setProperty('border-radius', '50%', 'important');
        iconContainer.style.setProperty('background', '#ffffff', 'important');
        iconContainer.style.setProperty('box-shadow', '0 8px 16px rgba(239, 68, 68, 0.2)', 'important');
        iconContainer.style.setProperty('position', 'relative', 'important');
        iconContainer.style.setProperty('z-index', '1', 'important');

        const icon = document.createElement('i');
        icon.className = 'fas fa-trash-alt';
        icon.style.setProperty('color', '#ef4444', 'important');
        icon.style.setProperty('font-size', '36px', 'important');
        iconContainer.appendChild(icon);
        iconSection.appendChild(iconContainer);

        // Add header with title
        const header = document.createElement('div');
        header.className = 'confirm-dialog-header';
        header.style.padding = '24px 24px 16px';
        header.style.textAlign = 'center';

        const title = document.createElement('h3');
        title.className = 'confirm-dialog-title';
        title.textContent = 'Confirm Delete';
        title.style.margin = '0 0 8px';
        title.style.color = '#1e293b';
        title.style.fontSize = '1.5rem';
        title.style.fontWeight = '700';
        title.style.letterSpacing = '-0.02em';

        const subtitle = document.createElement('p');
        subtitle.className = 'confirm-dialog-subtitle';
        subtitle.textContent = 'This action cannot be undone';
        subtitle.style.margin = '0';
        subtitle.style.color = '#64748b';
        subtitle.style.fontSize = '0.875rem';
        subtitle.style.fontWeight = '400';

        header.appendChild(title);
        header.appendChild(subtitle);

        // Add body
        const body = document.createElement('div');
        body.className = 'confirm-dialog-body';
        body.style.padding = '0 24px 24px';
        body.style.color = '#475569';
        body.style.lineHeight = '1.6';
        body.style.textAlign = 'center';

        const message = document.createElement('p');
        message.className = 'confirm-dialog-message';
        message.textContent = 'Are you sure you want to delete this row?';
        message.style.margin = '0';
        message.style.fontSize = '0.9375rem';
        message.style.fontWeight = '400';

        body.appendChild(message);

        // Add footer with buttons
        const footer = document.createElement('div');
        footer.className = 'confirm-dialog-footer';
        footer.style.padding = '20px 24px 24px';
        footer.style.background = '#f8fafc';
        footer.style.display = 'flex';
        footer.style.justifyContent = 'center';
        footer.style.gap = '12px';
        footer.style.borderTop = '1px solid #e2e8f0';

        const cancelBtn = document.createElement('button');
        cancelBtn.className = 'confirm-dialog-cancel';
        cancelBtn.textContent = 'Cancel';
        cancelBtn.style.padding = '12px 24px';
        cancelBtn.style.background = '#ffffff';
        cancelBtn.style.border = '2px solid #e2e8f0';
        cancelBtn.style.borderRadius = '10px';
        cancelBtn.style.color = '#475569';
        cancelBtn.style.cursor = 'pointer';
        cancelBtn.style.fontWeight = '600';
        cancelBtn.style.fontSize = '0.9375rem';
        cancelBtn.style.transition = 'all 0.2s cubic-bezier(0.4, 0, 0.2, 1)';
        cancelBtn.style.minWidth = '100px';
        cancelBtn.style.display = 'inline-flex';
        cancelBtn.style.alignItems = 'center';
        cancelBtn.style.justifyContent = 'center';
        cancelBtn.style.gap = '6px';

        const confirmBtn = document.createElement('button');
        confirmBtn.className = 'confirm-dialog-confirm';
        confirmBtn.textContent = 'Confirm';
        // Icon will be updated based on type in show() method
        confirmBtn.style.padding = '12px 24px';
        confirmBtn.style.background = 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)';
        confirmBtn.style.border = 'none';
        confirmBtn.style.borderRadius = '10px';
        confirmBtn.style.color = 'white';
        confirmBtn.style.cursor = 'pointer';
        confirmBtn.style.fontWeight = '600';
        confirmBtn.style.fontSize = '0.9375rem';
        confirmBtn.style.transition = 'all 0.2s cubic-bezier(0.4, 0, 0.2, 1)';
        confirmBtn.style.minWidth = '100px';
        confirmBtn.style.display = 'inline-flex';
        confirmBtn.style.alignItems = 'center';
        confirmBtn.style.justifyContent = 'center';
        confirmBtn.style.boxShadow = '0 4px 12px rgba(239, 68, 68, 0.3)';
        confirmBtn.style.position = 'relative';
        confirmBtn.style.overflow = 'hidden';

        // Add hover and active effects with smooth transitions
        cancelBtn.addEventListener('mouseenter', () => {
            cancelBtn.style.background = '#f1f5f9';
            cancelBtn.style.borderColor = '#cbd5e1';
            cancelBtn.style.transform = 'translateY(-1px)';
        });
        cancelBtn.addEventListener('mouseleave', () => {
            cancelBtn.style.background = '#ffffff';
            cancelBtn.style.borderColor = '#e2e8f0';
            cancelBtn.style.transform = 'translateY(0)';
        });
        cancelBtn.addEventListener('mousedown', () => {
            cancelBtn.style.transform = 'translateY(0)';
        });
        cancelBtn.addEventListener('mouseup', () => {
            cancelBtn.style.transform = 'translateY(-1px)';
        });

        confirmBtn.addEventListener('mouseenter', () => {
            // Darken the button on hover
            confirmBtn.style.filter = 'brightness(0.9)';
            confirmBtn.style.transform = 'translateY(-2px)';
            const currentShadow = confirmBtn.style.boxShadow;
            if (currentShadow) {
                confirmBtn.style.boxShadow = currentShadow.replace('0 4px', '0 6px').replace('12px', '16px');
            }
        });
        confirmBtn.addEventListener('mouseleave', () => {
            confirmBtn.style.filter = '';
            confirmBtn.style.transform = 'translateY(0)';
            const currentShadow = confirmBtn.style.boxShadow;
            if (currentShadow) {
                confirmBtn.style.boxShadow = currentShadow.replace('0 6px', '0 4px').replace('16px', '12px');
            }
        });
        confirmBtn.addEventListener('mousedown', () => {
            confirmBtn.style.transform = 'translateY(0) scale(0.98)';
        });
        confirmBtn.addEventListener('mouseup', () => {
            confirmBtn.style.transform = 'translateY(-2px) scale(1)';
        });

        // Add click handlers - prevent event propagation to avoid closing parent modals
        cancelBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            e.preventDefault();
            this.hide(false);
        });
        confirmBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            e.preventDefault();
            this.hide(true);
        });

        footer.appendChild(cancelBtn);
        footer.appendChild(confirmBtn);

        // Assemble dialog
        content.appendChild(iconSection);
        content.appendChild(header);
        content.appendChild(body);
        content.appendChild(footer);
        contentWrapper.appendChild(content);
        this.dialog.appendChild(contentWrapper);
        
        // Debug: Log structure after creation
        console.log('ConfirmDialog: Dialog structure created', {
            dialog: !!this.dialog,
            contentWrapper: !!contentWrapper,
            content: !!content,
            iconSection: !!iconSection,
            header: !!header,
            body: !!body,
            footer: !!footer
        });

        // Add to body (ensure body exists)
        if (document.body) {
            document.body.appendChild(this.dialog);
            console.log('ConfirmDialog: Dialog appended to body successfully');
        } else {
            // If body doesn't exist yet, wait for it
            const checkBody = setInterval(() => {
                if (document.body) {
                    document.body.appendChild(this.dialog);
                    console.log('ConfirmDialog: Dialog appended to body (delayed)');
                    clearInterval(checkBody);
                }
            }, 10);
            // Safety timeout
            setTimeout(() => {
                if (checkBody) clearInterval(checkBody);
            }, 5000);
        }
        
        // Verify dialog is in DOM
        setTimeout(() => {
            const verifyDialog = document.getElementById('confirm-dialog-instance');
            if (verifyDialog) {
                console.log('ConfirmDialog: Dialog verified in DOM ✓');
            } else {
                console.error('ConfirmDialog: Dialog NOT found in DOM after initialization!');
            }
        }, 100);

        // Close on backdrop click - prevent propagation
        this.dialog.addEventListener('click', (e) => {
            if (e.target === this.dialog) {
                e.stopPropagation();
                this.hide(false);
            }
        });

        // ESC key handler - check if dialog is actually visible
        const escapeHandler = (e) => {
            if (e.key === 'Escape' && 
                this.dialog && 
                this.dialog.style.display === 'flex' && 
                this.dialog.style.opacity !== '0') {
                this.hide(false);
            }
        };
        document.addEventListener('keydown', escapeHandler);
        
        // Store handler reference for potential cleanup if needed
        this.escapeHandler = escapeHandler;
    }

    show(options = {}) {
        // Ensure dialog exists and is properly initialized
        if (!this.dialog) {
            console.error('ConfirmDialog: Dialog not initialized. Reinitializing...');
            this.init();
            if (!this.dialog) {
                console.error('ConfirmDialog: Failed to initialize dialog');
                return Promise.resolve(false);
            }
        }

        // Update content based on options
        const title = this.dialog.querySelector('.confirm-dialog-title');
        const message = this.dialog.querySelector('.confirm-dialog-message');
        const subtitle = this.dialog.querySelector('.confirm-dialog-subtitle');
        const confirmBtn = this.dialog.querySelector('.confirm-dialog-confirm');
        const cancelBtn = this.dialog.querySelector('.confirm-dialog-cancel');
        const icon = this.dialog.querySelector('.confirm-dialog-icon-container i');
        const iconSection = this.dialog.querySelector('.confirm-dialog-icon-section');
        const iconContainer = this.dialog.querySelector('.confirm-dialog-icon-container');

        // Debug: Check if elements exist
        if (!title || !message || !confirmBtn || !cancelBtn || !icon) {
            console.error('ConfirmDialog: Missing required elements', {
                title: !!title,
                message: !!message,
                subtitle: !!subtitle,
                confirmBtn: !!confirmBtn,
                cancelBtn: !!cancelBtn,
                icon: !!icon,
                iconSection: !!iconSection,
                iconContainer: !!iconContainer
            });
            // Reinitialize if elements are missing
            this.init();
            return this.show(options);
        }

        if (options.title && title) title.textContent = options.title;
        if (options.message && message) message.textContent = options.message;
        if (options.subtitle && subtitle) subtitle.textContent = options.subtitle;
        
        // Update confirm button with icon
        if (confirmBtn) {
            let iconClass = 'fas fa-check';
            // Determine icon based on type or explicit icon option
            if (options.icon) {
                iconClass = `fas fa-${options.icon.replace('fa-', '').replace('fas fa-', '')}`;
            } else if (options.type) {
                const iconMap = {
                    'warning': 'fas fa-exclamation-triangle',
                    'danger': 'fas fa-trash-alt',
                    'info': 'fas fa-paper-plane',
                    'success': 'fas fa-check-circle',
                    'question': 'fas fa-question-circle'
                };
                iconClass = iconMap[options.type] || 'fas fa-check';
            }
            
            if (options.confirmText) {
                confirmBtn.innerHTML = `<i class="${iconClass}" style="margin-right: 6px;"></i> ${options.confirmText}`;
            } else {
                confirmBtn.innerHTML = `<i class="${iconClass}" style="margin-right: 6px;"></i> Confirm`;
            }
        }
        if (options.cancelText && cancelBtn) cancelBtn.textContent = options.cancelText;
        
        // Set icon based on type
        if (options.type) {
            const icons = {
                'warning': 'exclamation-triangle',
                'danger': 'trash-alt',
                'info': 'paper-plane',
                'success': 'check-circle',
                'question': 'question-circle'
            };
            
            const iconType = icons[options.type] || 'trash-alt';
            const iconColor = {
                'warning': '#f59e0b',
                'danger': '#ef4444',
                'info': '#3b82f6',
                'success': '#10b981',
                'question': '#6b7280'
            }[options.type] || '#ef4444';
            
            const gradientBg = {
                'warning': 'linear-gradient(135deg, #fffbeb 0%, #fef3c7 100%)',
                'danger': 'linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%)',
                'info': 'linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%)',
                'success': 'linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%)',
                'question': 'linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%)'
            }[options.type] || 'linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%)';
            
            const buttonGradient = {
                'warning': 'linear-gradient(135deg, #f59e0b 0%, #d97706 100%)',
                'danger': 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)',
                'info': 'linear-gradient(135deg, #3b82f6 0%, #2563eb 100%)',
                'success': 'linear-gradient(135deg, #10b981 0%, #059669 100%)',
                'question': 'linear-gradient(135deg, #6b7280 0%, #4b5563 100%)'
            }[options.type] || 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)';
            
            const buttonShadow = {
                'warning': 'rgba(245, 158, 11, 0.3)',
                'danger': 'rgba(239, 68, 68, 0.3)',
                'info': 'rgba(59, 130, 246, 0.3)',
                'success': 'rgba(16, 185, 129, 0.3)',
                'question': 'rgba(107, 114, 128, 0.3)'
            }[options.type] || 'rgba(239, 68, 68, 0.3)';
            
            if (icon) {
                icon.className = `fas fa-${iconType}`;
                icon.style.color = iconColor;
            }
            if (iconSection) iconSection.style.background = gradientBg;
            if (iconContainer) iconContainer.style.boxShadow = `0 8px 16px ${iconColor}40`;
            
            // Update confirm button styling based on type
            if (confirmBtn) {
                confirmBtn.style.setProperty('background', buttonGradient, 'important');
                confirmBtn.style.setProperty('box-shadow', `0 4px 12px ${buttonShadow}`, 'important');
            }
        }
        
        // Update icon if explicitly provided
        if (options.icon && icon) {
            const iconType = typeof options.icon === 'string' ? options.icon.replace('fa-', '').replace('fas fa-', '') : 'trash-alt';
            icon.className = `fas fa-${iconType}`;
        }

        // Show dialog with animation
        console.log('ConfirmDialog: Showing dialog');
        
        // Store original body overflow
        const originalOverflow = document.body.style.overflow;
        const originalPaddingRight = document.body.style.paddingRight;
        
        // Prevent body scroll when dialog is open
        document.body.style.overflow = 'hidden';
        
        // Enable pointer events and show dialog
        this.dialog.style.setProperty('pointer-events', 'auto', 'important');
        this.dialog.style.setProperty('display', 'flex', 'important');
        this.dialog.style.setProperty('z-index', '99999', 'important');
        
        // Force reflow to ensure display change is applied
        this.dialog.offsetHeight;
        
        setTimeout(() => {
            this.dialog.style.opacity = '1';
            const content = this.dialog.querySelector('.confirm-dialog-content');
            if (content) {
                content.style.transform = 'translateY(0) scale(1)';
                console.log('ConfirmDialog: Dialog shown, content transformed');
            } else {
                console.error('ConfirmDialog: Content element not found when showing');
            }
        }, 10);

        // Focus confirm button for better keyboard navigation
        setTimeout(() => {
            if (confirmBtn) confirmBtn.focus();
        }, 50);

        // Return a promise that resolves with the user's choice
        return new Promise((resolve) => {
            this.resolve = resolve;
        });
    }

    hide(confirmed) {
        // Immediately disable pointer events to prevent blocking interactions
        this.dialog.style.setProperty('pointer-events', 'none', 'important');
        
        // Hide with animation
        this.dialog.style.opacity = '0';
        const content = this.dialog.querySelector('.confirm-dialog-content');
        if (content) {
            content.style.transform = 'translateY(30px) scale(0.95)';
        }

        // Restore body overflow immediately
        document.body.style.overflow = '';
        document.body.style.paddingRight = '';

        // Remove from DOM after animation
        setTimeout(() => {
            this.dialog.style.setProperty('display', 'none', 'important');
            this.dialog.style.setProperty('z-index', '-1', 'important');
            
            // Resolve the promise
            if (this.resolve) {
                this.resolve(confirmed);
                this.resolve = null;
            }
        }, 400);
    }
}

// Add enhanced styles for better animations and focus states (only once)
if (!document.getElementById('confirm-dialog-styles')) {
    const style = document.createElement('style');
    style.id = 'confirm-dialog-styles';
    style.textContent = `
    /* Override any conflicting styles with !important */
    #confirm-dialog-instance,
    .confirm-dialog {
        display: flex !important;
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        width: 100% !important;
        height: 100% !important;
        background-color: rgba(15, 23, 42, 0.75) !important;
        justify-content: center !important;
        align-items: center !important;
        z-index: 99999 !important;
        backdrop-filter: blur(4px) !important;
        pointer-events: auto !important;
    }
    
    .confirm-dialog-content {
        background: #ffffff !important;
        border-radius: 20px !important;
        width: 100% !important;
        max-width: 440px !important;
        overflow: hidden !important;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3), 0 0 0 1px rgba(0, 0, 0, 0.05) !important;
        will-change: transform !important;
    }
    
    .confirm-dialog-icon-section {
        padding: 32px 24px 24px !important;
        text-align: center !important;
        background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%) !important;
        position: relative !important;
        overflow: hidden !important;
    }
    
    .confirm-dialog-icon-container {
        display: inline-flex !important;
        align-items: center !important;
        justify-content: center !important;
        width: 80px !important;
        height: 80px !important;
        border-radius: 50% !important;
        background: #ffffff !important;
        box-shadow: 0 8px 16px rgba(239, 68, 68, 0.2) !important;
        position: relative !important;
        z-index: 1 !important;
    }
    
    .confirm-dialog-icon-container i {
        color: #ef4444 !important;
        font-size: 36px !important;
    }
    
    .confirm-dialog-header {
        padding: 24px 24px 16px !important;
        text-align: center !important;
    }
    
    .confirm-dialog-title {
        margin: 0 0 8px !important;
        color: #1e293b !important;
        font-size: 1.5rem !important;
        font-weight: 700 !important;
        letter-spacing: -0.02em !important;
    }
    
    .confirm-dialog-subtitle {
        margin: 0 !important;
        color: #64748b !important;
        font-size: 0.875rem !important;
        font-weight: 400 !important;
    }
    
    .confirm-dialog-body {
        padding: 0 24px 24px !important;
        color: #475569 !important;
        line-height: 1.6 !important;
        text-align: center !important;
    }
    
    .confirm-dialog-message {
        margin: 0 !important;
        font-size: 0.9375rem !important;
        font-weight: 400 !important;
        user-select: text !important;
    }
    
    .confirm-dialog-footer {
        padding: 20px 24px 24px !important;
        background: #f8fafc !important;
        display: flex !important;
        justify-content: center !important;
        gap: 12px !important;
        border-top: 1px solid #e2e8f0 !important;
    }
    
    .confirm-dialog-cancel,
    .confirm-dialog-confirm {
        padding: 12px 24px !important;
        border-radius: 10px !important;
        cursor: pointer !important;
        font-weight: 600 !important;
        font-size: 0.9375rem !important;
        transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
        min-width: 100px !important;
        display: inline-flex !important;
        align-items: center !important;
        justify-content: center !important;
        border: none !important;
    }
    
    .confirm-dialog-cancel {
        background: #ffffff !important;
        border: 2px solid #e2e8f0 !important;
        color: #475569 !important;
    }
    
    .confirm-dialog-confirm {
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%) !important;
        color: white !important;
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3) !important;
    }
    
    @keyframes confirmDialogPulse {
        0%, 100% {
            transform: scale(1);
        }
        50% {
            transform: scale(1.03);
        }
    }
    
    .confirm-dialog-icon-container {
        animation: confirmDialogPulse 3s ease-in-out infinite;
    }
    
    .confirm-dialog-cancel:focus,
    .confirm-dialog-confirm:focus {
        outline: 3px solid rgba(59, 130, 246, 0.5) !important;
        outline-offset: 2px !important;
    }
    
    .confirm-dialog-confirm:focus {
        box-shadow: 0 0 0 4px rgba(239, 68, 68, 0.3), 0 4px 12px rgba(239, 68, 68, 0.3) !important;
    }
    
    .confirm-dialog-cancel:focus {
        box-shadow: 0 0 0 3px rgba(148, 163, 184, 0.3) !important;
    }
    
    /* Prevent text selection during animation */
    .confirm-dialog-content * {
        user-select: none !important;
    }
    
    /* Re-enable text selection for message */
    .confirm-dialog-message {
        user-select: text !important;
    }
`;
    document.head.appendChild(style);
    console.log('ConfirmDialog: Styles added to head');
}

// Create a singleton instance after DOM is ready
let confirmDialog = null;

function getConfirmDialog() {
    if (!confirmDialog) {
        console.log('getConfirmDialog: Creating new ConfirmDialog instance');
        // Remove any old instance
        const oldDialog = document.querySelector('.confirm-dialog');
        if (oldDialog) {
            console.log('getConfirmDialog: Removing old dialog');
            oldDialog.remove();
        }
        confirmDialog = new ConfirmDialog();
        // Wait a bit for initialization
        if (!confirmDialog.dialog) {
            console.warn('getConfirmDialog: Dialog not created immediately, waiting...');
        }
    } else {
        console.log('getConfirmDialog: Using existing instance');
    }
    return confirmDialog;
}

// Initialize when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        getConfirmDialog();
    });
} else {
    getConfirmDialog();
}

// Export the show method
window.showConfirmDialog = (options = {}) => {
    console.log('showConfirmDialog called with options:', options);
    const dialog = getConfirmDialog();
    if (!dialog) {
        console.error('showConfirmDialog: Failed to get dialog instance');
        return Promise.resolve(false);
    }
    const finalOptions = {
        title: options.title || 'Confirm Action',
        message: options.message || 'Are you sure you want to continue?',
        subtitle: options.subtitle || 'This action cannot be undone',
        confirmText: options.confirmText || 'Confirm',
        cancelText: options.cancelText || 'Cancel',
        type: options.type || (options.confirmButtonClass === 'btn-danger' ? 'danger' : 'warning'), // warning, danger, info, success, question
        icon: options.icon
    };
    console.log('showConfirmDialog final options:', finalOptions);
    return dialog.show(finalOptions);
};

// Make it globally available
window.ConfirmDialog = ConfirmDialog;
