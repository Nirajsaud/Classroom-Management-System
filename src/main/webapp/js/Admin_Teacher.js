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
        if (remaining === 0) notifEmpty.style.display = 'block';
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

    /* ── Teacher list pagination ── */
    var teacherRows       = Array.prototype.slice.call(document.querySelectorAll('.teacher-row'));
    var teacherPagination = document.getElementById('teacherPagination');
    var rowsPerPage = 4;
    var currentPage = 1;

    function renderTeacherPage(page) {
        var totalPages = Math.ceil(teacherRows.length / rowsPerPage) || 1;
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        currentPage = page;

        teacherRows.forEach(function (row, index) {
            var start = (currentPage - 1) * rowsPerPage;
            var end   = start + rowsPerPage;
            row.style.display = (index >= start && index < end) ? '' : 'none';
        });

        if (!teacherPagination) return;
        teacherPagination.innerHTML = '';
        teacherPagination.style.display = 'flex';

        function createButton(label, disabled, onClick, active) {
            var btn = document.createElement('button');
            btn.type = 'button';
            btn.className = 'page-btn' + (active ? ' active' : '');
            btn.textContent = label;
            if (disabled) {
                btn.disabled = true;
            } else {
                btn.addEventListener('click', onClick);
            }
            return btn;
        }

        teacherPagination.appendChild(
            createButton('Prev', currentPage === 1, function () { renderTeacherPage(currentPage - 1); })
        );

        for (var i = 1; i <= totalPages; i++) {
            teacherPagination.appendChild(
                createButton(i, false, (function (pageNumber) {
                    return function () { renderTeacherPage(pageNumber); };
                })(i), i === currentPage)
            );
        }

        teacherPagination.appendChild(
            createButton('Next', currentPage === totalPages, function () { renderTeacherPage(currentPage + 1); })
        );
    }

    if (teacherRows.length && teacherPagination) {
        renderTeacherPage(currentPage);
    }

})();