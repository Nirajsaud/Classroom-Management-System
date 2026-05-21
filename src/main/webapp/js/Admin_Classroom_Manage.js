(function () {
    'use strict';

    /* ── Bell / Notification ── */
    var bellBtn       = document.getElementById('bellBtn');
    var bellWrapper   = document.getElementById('bellWrapper');
    var notifDropdown = document.getElementById('notifDropdown');
    var bellBadge     = document.getElementById('bellBadge');
    var markAllRead   = document.getElementById('markAllRead');
    var notifList     = document.getElementById('notifList');
    var notifEmpty    = document.getElementById('notifEmpty');

    function updateBadge() {
        var count = notifList.querySelectorAll('.notif-item.unread').length;
        bellBadge.style.display = count > 0 ? 'block' : 'none';
    }

    function checkEmpty() {
        var remaining = notifList.querySelectorAll('.notif-item:not(.dismissed)').length;
        if (remaining === 0) { notifEmpty.style.display = 'block'; }
    }

    function dismissItem(item) {
        item.classList.add('dismissed');
        setTimeout(function () { item.remove(); checkEmpty(); }, 380);
    }

    updateBadge();

    bellBtn.addEventListener('click', function (e) {
        e.stopPropagation();
        var isOpen = notifDropdown.classList.toggle('open');
        bellBtn.setAttribute('aria-expanded', String(isOpen));
    });

    markAllRead.addEventListener('click', function () {
        notifList.querySelectorAll('.notif-item').forEach(function (el) { dismissItem(el); });
        updateBadge();
    });

    notifList.addEventListener('click', function (e) {
        var approveBtn = e.target.closest('.btn-approve');
        var rejectBtn  = e.target.closest('.btn-reject');
        if (!approveBtn && !rejectBtn) return;

        var item    = e.target.closest('.notif-item');
        if (!item) return;

        var nameEl  = item.querySelector('strong');
        var name    = nameEl ? nameEl.textContent : 'Student';
        var action  = approveBtn ? 'approved' : 'rejected';
        var content = item.querySelector('.notif-content');

        if (content) {
            content.innerHTML =
                '<div class="notif-text" style="color:' +
                (approveBtn ? '#15803d' : '#b91c1c') + ';font-weight:700;">' +
                (approveBtn ? '✓ ' : '✕ ') + name + ' ' + action + '.</div>';
        }

        item.classList.remove('unread');
        updateBadge();
        setTimeout(function () { dismissItem(item); }, 900);
    });

    document.addEventListener('click', function (e) {
        if (!bellWrapper.contains(e.target)) {
            notifDropdown.classList.remove('open');
            bellBtn.setAttribute('aria-expanded', 'false');
        }
    });

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            notifDropdown.classList.remove('open');
            bellBtn.setAttribute('aria-expanded', 'false');
            bellBtn.focus();
        }
    });

    /* ── Inline Price Edit ── */
    var changePriceBtn  = document.getElementById('changePriceBtn');
    var priceDisplay    = document.getElementById('priceDisplay');
    var priceEditRow    = document.getElementById('priceEditRow');
    var priceInput      = document.getElementById('priceInput');
    var savePriceBtn    = document.getElementById('savePriceBtn');
    var cancelPriceBtn  = document.getElementById('cancelPriceBtn');

    /* Enter edit mode */
    changePriceBtn.addEventListener('click', function () {
        priceInput.value = priceDisplay.textContent.trim();
        priceDisplay.style.display = 'none';
        priceEditRow.classList.add('visible');
        changePriceBtn.style.display = 'none';
        priceInput.focus();
        priceInput.select();
    });

    /* Save new price */
    savePriceBtn.addEventListener('click', function () {
        var newVal = priceInput.value.trim();
        if (newVal === '' || isNaN(Number(newVal)) || Number(newVal) < 0) {
            priceInput.style.borderColor = '#ef4444';
            return;
        }
        priceInput.style.borderColor = '';
        priceDisplay.textContent = newVal;
        exitEditMode();

        // TODO: Send price update to backend API
        // Example: POST /api/classrooms/updatePrice with { classroomId, newPrice }
    });

    /* Cancel edit */
    cancelPriceBtn.addEventListener('click', exitEditMode);

    /* Also save on Enter key */
    priceInput.addEventListener('keydown', function (e) {
        if (e.key === 'Enter')  savePriceBtn.click();
        if (e.key === 'Escape') cancelPriceBtn.click();
    });

    function exitEditMode() {
        priceDisplay.style.display = '';
        priceEditRow.classList.remove('visible');
        changePriceBtn.style.display = '';
    }

    /* ── Add/Delete Subjects ── */
    var addSubjectBtn = document.getElementById('addSubjectBtn');
    var newSubjectInput = document.getElementById('newSubjectInput');
    var deleteSubjectBtns = document.querySelectorAll('.btn-delete-subject');

    /* Add Subject */
    addSubjectBtn.addEventListener('click', function () {
        var subjectName = newSubjectInput.value.trim();
        
        if (subjectName === '') {
            newSubjectInput.style.borderColor = '#ef4444';
            newSubjectInput.focus();
            return;
        }
        
        newSubjectInput.style.borderColor = '';
        
        // TODO: Send POST request to backend API to add subject
        // Example: POST /api/classrooms/addSubject with { classroomId, subjectName }
        // On success: Clear input and refresh subject list
        
        newSubjectInput.value = '';
        newSubjectInput.focus();
    });

    /* Delete Subject */
    deleteSubjectBtns.forEach(function (btn) {
        btn.addEventListener('click', function () {
            var subject = btn.getAttribute('data-subject');
            
            // TODO: Send DELETE request to backend API to delete subject
            // Example: DELETE /api/classrooms/deleteSubject with { classroomId, subjectName }
            // On success: Refresh subject list to show updated data
            
            // For now, just remove the button's row for instant feedback
            btn.closest('.subjects-table-row').style.opacity = '0.5';
        });
    });

    /* Allow Enter key to add subject */
    newSubjectInput.addEventListener('keydown', function (e) {
        if (e.key === 'Enter') {
            addSubjectBtn.click();
        }
    });

})();