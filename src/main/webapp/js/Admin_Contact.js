(function () {
    'use strict';

    /* ── Bell / Notification ── */
    const bellBtn       = document.getElementById('bellBtn');
    const bellWrapper   = document.getElementById('bellWrapper');
    const notifDropdown = document.getElementById('notifDropdown');
    const bellBadge     = document.getElementById('bellBadge');
    const markAllRead   = document.getElementById('markAllRead');
    const notifList     = document.getElementById('notifList');
    const notifEmpty    = document.getElementById('notifEmpty');

    function updateBadge() {
        var count = notifList.querySelectorAll('.notif-item.unread').length;
        bellBadge.style.display = count > 0 ? 'block' : 'none';
    }

    function checkEmpty() {
        var remaining = notifList.querySelectorAll('.notif-item:not(.dismissed)').length;
        if (remaining === 0) {
            notifEmpty.style.display = 'block';
        }
    }

    function dismissItem(item) {
        item.classList.add('dismissed');
        // remove from DOM after animation finishes
        setTimeout(function () { item.remove(); checkEmpty(); }, 380);
    }

    updateBadge();

    /* Toggle dropdown */
    bellBtn.addEventListener('click', function (e) {
        e.stopPropagation();
        var isOpen = notifDropdown.classList.toggle('open');
        bellBtn.setAttribute('aria-expanded', String(isOpen));
    });

    /* Dismiss all */
    markAllRead.addEventListener('click', function () {
        notifList.querySelectorAll('.notif-item').forEach(function (el) {
            dismissItem(el);
        });
        updateBadge();
    });

    /* Approve / Reject button clicks */
    notifList.addEventListener('click', function (e) {
        var approveBtn = e.target.closest('.btn-approve');
        var rejectBtn  = e.target.closest('.btn-reject');

        if (approveBtn || rejectBtn) {
            var item = e.target.closest('.notif-item');
            if (!item) return;

            var nameEl = item.querySelector('strong');
            var name   = nameEl ? nameEl.textContent : 'Student';
            var action = approveBtn ? 'approved' : 'rejected';

            /* Visual feedback — swap content before dismissing */
            var content = item.querySelector('.notif-content');
            if (content) {
                content.innerHTML =
                    '<div class="notif-text" style="color:' +
                    (approveBtn ? '#15803d' : '#b91c1c') + ';font-weight:700;">' +
                    (approveBtn ? '✓ ' : '✕ ') + name + ' ' + action + '.</div>';
            }

            item.classList.remove('unread');
            updateBadge();

            /* Dismiss after short delay so user sees the confirmation */
            setTimeout(function () { dismissItem(item); }, 900);

        }
    });

    /* Close on outside click */
    document.addEventListener('click', function (e) {
        if (!bellWrapper.contains(e.target)) {
            notifDropdown.classList.remove('open');
            bellBtn.setAttribute('aria-expanded', 'false');
        }
    });

    /* Close on Escape */
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            notifDropdown.classList.remove('open');
            bellBtn.setAttribute('aria-expanded', 'false');
            bellBtn.focus();
        }
    });

    /* ── Ripple on action cards ── */
    document.querySelectorAll('.action-card').forEach(function (card) {
        card.addEventListener('click', function (e) {
            var rect   = card.getBoundingClientRect();
            var size   = Math.max(rect.width, rect.height) * 1.5;
            var x      = e.clientX - rect.left - size / 2;
            var y      = e.clientY - rect.top  - size / 2;
            var ripple = document.createElement('span');
            ripple.className = 'ripple';
            ripple.style.cssText = 'width:' + size + 'px;height:' + size + 'px;left:' + x + 'px;top:' + y + 'px;';
            card.appendChild(ripple);
            setTimeout(function () { ripple.remove(); }, 600);
        });
    });

    /* ── Count-up animation ── */
    function formatNepalNumber(n, prefix) {
        var s = Math.round(n).toString();
        var result;
        if (s.length <= 3) {
            result = s;
        } else {
            var last3   = s.slice(-3);
            var rest    = s.slice(0, -3);
            var chunked = '';
            while (rest.length > 2) {
                chunked = ',' + rest.slice(-2) + chunked;
                rest    = rest.slice(0, -2);
            }
            result = rest + chunked + ',' + last3;
        }
        return (prefix || '') + result;
    }

    function countUp(el, target, prefix, duration) {
        var startTime = null;
        function step(ts) {
            if (!startTime) startTime = ts;
            var progress = Math.min((ts - startTime) / duration, 1);
            var eased    = 1 - Math.pow(1 - progress, 3);
            el.textContent = formatNepalNumber(eased * target, prefix);
            if (progress < 1) requestAnimationFrame(step);
        }
        requestAnimationFrame(step);
    }

    document.querySelectorAll('.stat-value[data-target]').forEach(function (wrapper) {
        var target = parseInt(wrapper.getAttribute('data-target'), 10);
        var prefix = wrapper.getAttribute('data-prefix') || '';
        var span   = wrapper.querySelector('.count-target');
        if (!span || isNaN(target)) return;
        setTimeout(function () { countUp(span, target, prefix, 1200); }, 300);
    });
    <script></script>
})();
