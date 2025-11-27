// Confirmation Modal Functionality
class ConfirmationModal {
    constructor() {
        this.modal = document.getElementById('confirmModal');
        this.title = document.getElementById('confirmModalTitle');
        this.message = document.getElementById('confirmModalMessage');
        this.confirmButton = document.getElementById('confirmModalButton');
        this.setupEventListeners();
    }

    setupEventListeners() {
        // Close modal when clicking outside the modal content
        window.addEventListener('click', (e) => {
            if (e.target === this.modal) {
                this.hide();
            }
        });
    }

    show(title, message, confirmCallback) {
        this.title.textContent = title;
        this.message.textContent = message;
        
        // Remove previous event listeners
        const newButton = this.confirmButton.cloneNode(true);
        this.confirmButton.parentNode.replaceChild(newButton, this.confirmButton);
        this.confirmButton = newButton;
        
        // Add new click handler
        this.confirmButton.onclick = () => {
            if (typeof confirmCallback === 'function') {
                confirmCallback();
            }
            this.hide();
        };
        
        this.modal.style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    hide() {
        this.modal.style.display = 'none';
        document.body.style.overflow = 'auto';
    }
}

// Initialize the modal when the DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    window.confirmationModal = new ConfirmationModal();
});

// Global function to show the confirmation modal
function showConfirmModal(title, message, confirmCallback) {
    if (window.confirmationModal) {
        window.confirmationModal.show(title, message, confirmCallback);
    }
}

// Global function to close the confirmation modal
function closeConfirmModal() {
    if (window.confirmationModal) {
        window.confirmationModal.hide();
    }
}
