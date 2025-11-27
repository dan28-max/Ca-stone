(function(){
  let pendingResetId = null;
  function showSection(sectionId){
    document.querySelectorAll('.content-section').forEach(s=>s.style.display='none');
    const el = document.getElementById(sectionId);
    if (el) el.style.display='block';
    document.querySelectorAll('.nav-item').forEach(i=>i.classList.remove('active'));
    const nav = document.querySelector(`[data-section="${sectionId}"]`);
    if (nav) nav.classList.add('active');
  }

  async function loadPasswordResets(){
    const tbody = document.getElementById('passwordResetsTableBody');
    if (!tbody) return;
    tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding:24px;"><i class="fas fa-spinner fa-spin"></i> Loading...</td></tr>';
    try{
      const res = await fetch('api/password_reset.php?action=list_pending', { credentials: 'include' });
      const json = await res.json();
      if (!json.success){
        tbody.innerHTML = `<tr><td colspan="5" style="text-align:center; padding:24px; color:#b91c1c;">${json.error||'Failed to load requests'}</td></tr>`;
        return;
      }
      const rows = json.requests || [];
      if (!rows.length){
        tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding:24px;">No pending requests</td></tr>';
        return;
      }
      tbody.innerHTML = '';
      rows.forEach(r=>{
        const tr = document.createElement('tr');
        const statusBadge = `<span class="status-badge status-${r.status}">${r.status}</span>`;
        tr.innerHTML = `
          <td>${r.id}</td>
          <td>${r.username}</td>
          <td>${r.created_at ? new Date(r.created_at).toLocaleString() : ''}</td>
          <td>${statusBadge}</td>
          <td>
            <button class="btn-sm btn-view" data-approve-id="${r.id}"><i class="fas fa-check"></i> Approve</button>
          </td>
        `;
        tbody.appendChild(tr);
      });
    }catch(e){
      console.error('password resets load error', e);
      tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding:24px; color:#b91c1c;">Network error</td></tr>';
    }
  }

  function openResetConfirmModal(requestId){
    pendingResetId = requestId;
    const modal = document.getElementById('resetConfirmModal');
    if (!modal) { approvePasswordReset(requestId); return; }
    modal.style.display = 'flex';
  }

  function closeResetConfirmModal(){
    const modal = document.getElementById('resetConfirmModal');
    if (modal) modal.style.display = 'none';
  }

  async function approvePasswordReset(requestId){
    try{
      const res = await fetch('api/password_reset.php?action=approve', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ request_id: requestId })
      });
      const json = await res.json();
      if (json.success){
        alert('Approved. Password set to default.');
        loadPasswordResets();
      } else {
        alert(json.error || 'Failed to approve');
      }
    }catch(e){
      console.error('approve error', e);
      alert('Network error');
    }
  }

  document.addEventListener('click', function(e){
    const btn = e.target.closest('[data-approve-id]');
    if (btn){
      const id = parseInt(btn.getAttribute('data-approve-id'), 10);
      if (id) openResetConfirmModal(id);
    }
  });

  document.addEventListener('DOMContentLoaded', function(){
    const nav = document.querySelector('[data-section="passwordResets"]');
    if (nav){
      nav.addEventListener('click', function(){
        showSection('passwordResets');
        loadPasswordResets();
      });
    }
    // If section is visible on load, fetch immediately
    const section = document.getElementById('passwordResets');
    if (section && section.style.display !== 'none'){
      loadPasswordResets();
    }

    // Modal buttons
    const closeBtn = document.getElementById('resetConfirmCloseBtn');
    const cancelBtn = document.getElementById('btnResetCancel');
    const approveBtn = document.getElementById('btnResetApprove');
    if (closeBtn) closeBtn.addEventListener('click', closeResetConfirmModal);
    if (cancelBtn) cancelBtn.addEventListener('click', closeResetConfirmModal);
    if (approveBtn) approveBtn.addEventListener('click', function(){
      if (pendingResetId){
        const id = pendingResetId; pendingResetId = null;
        closeResetConfirmModal();
        approvePasswordReset(id);
      }
    });
  });
})();
