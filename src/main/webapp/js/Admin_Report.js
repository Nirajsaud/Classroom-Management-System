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

            /*
             * TODO (backend integration):
             * Send an AJAX POST to your servlet here, e.g.:
             *
             * fetch('/pathshala/admin/approveLogin', {
             *     method: 'POST',
             *     headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
             *     body: 'studentId=' + item.dataset.studentId + '&action=' + action
             * });
             */
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

    /* ── Page Navigation ── */
    var viewLinks = document.querySelectorAll('.view-link');
    var teacherTableCard = document.querySelector('.teacher-table-card');
    var teacherPagination = document.getElementById('teacherPagination');

    function buildDetailsPanel(className, students, price, subjects) {
        var container = document.createElement('section');
        container.className = 'classroom-details';

        container.innerHTML = '' +
            '<div class="form-header" style="display:flex;align-items:center;gap:1rem;margin-bottom:1rem;">' +
                '<button id="cancelViewBtn" class="btn-cancel">Cancel</button>' +
                '<h2 style="flex:1;text-align:center;margin:0;">Classroom Details</h2>' +
            '</div>' +
            '<div style="background:#f8fafc;padding:1.1rem;border-radius:8px;border:1px solid rgba(0,0,0,0.04);">' +
                '<h1 style="text-align:center;margin:0 0 1rem;font-size:40px;">' + className + '</h1>' +
                '<div style="display:flex;gap:1.5rem;align-items:flex-start;">' +
                    '<div style="flex:0 0 260px;">' +
                        '<label style="display:block;font-weight:700;margin-bottom:0.6rem;">Total Students</label>' +
                        '<div style="background:#fff;border:1px solid #e5e7eb;padding:1rem;border-radius:8px;font-size:36px;text-align:center;margin-bottom:1rem;">' + students + '</div>' +
                        '<label style="display:block;font-weight:700;margin-bottom:0.6rem;">Classroom Price (Rs.)</label>' +
                        '<div id="displayPrice" style="background:#fff;border:1px solid #e5e7eb;padding:1rem;border-radius:8px;font-size:36px;text-align:center;margin-bottom:1rem;">' + price + '</div>' +
                        '<button id="changePriceBtn" class="classroom-btn" style="background:#10b981;color:#fff;padding:0.9rem 1.2rem;border-radius:10px;border:none;font-size:1.1rem;cursor:pointer;">Change Price</button>' +
                    '</div>' +
                    '<div style="flex:1;background:#f5dfc9;padding:1rem;border-radius:8px;border:1px solid rgba(0,0,0,0.1);">' +
                        '<div style="background:#f59e0b;color:#fff;padding:0.5rem 1rem;border-radius:12px;margin-bottom:0.8rem;font-weight:700;display:flex;justify-content:space-between;">' +
                            '<span>Subject</span><span>Assigned Teacher</span>' +
                        '</div>' +
                        '<div id="subjectsTable"></div>' +
                    '</div>' +
                '</div>' +
            '</div>';

        // populate subjects
        var subjectsTable = container.querySelector('#subjectsTable');
        subjects.forEach(function (row) {
            var rowDiv = document.createElement('div');
            rowDiv.style.display = 'flex';
            rowDiv.style.justifyContent = 'space-between';
            rowDiv.style.padding = '0.85rem 0';
            rowDiv.style.borderBottom = '1px solid rgba(0,0,0,0.03)';
            rowDiv.innerHTML = '<div>' + row[0] + '</div><div>' + (row[1] || '-') + '</div>';
            subjectsTable.appendChild(rowDiv);
        });

        // change price handler
        setTimeout(function () {
            var changeBtn = container.querySelector('#changePriceBtn');
            if (changeBtn) {
                changeBtn.addEventListener('click', function () {
                    var newPrice = prompt('Enter new price (Rs.)', price);
                    if (newPrice !== null) {
                        container.querySelector('#displayPrice').textContent = newPrice;
                        // update the data-price attribute on the corresponding view-link(s)
                        viewLinks.forEach(function (btn) {
                            if (btn.getAttribute('data-class') === className) btn.setAttribute('data-price', newPrice);
                        });
                    }
                });
            }
        }, 40);

        return container;
    }

    function showDetails(panel) {
        var pageHeader = document.querySelector('.page-header');
        // hide table and pagination
        if (teacherTableCard) teacherTableCard.style.display = 'none';
        if (teacherPagination) teacherPagination.style.display = 'none';
        // insert panel after header
        pageHeader.parentNode.insertBefore(panel, pageHeader.nextSibling);

        // cancel handler
        var cancel = panel.querySelector('#cancelViewBtn');
        if (cancel) cancel.addEventListener('click', function () {
            panel.remove();
            if (teacherTableCard) teacherTableCard.style.display = '';
            if (teacherPagination) teacherPagination.style.display = 'flex';
        });
    }

    viewLinks.forEach(function (link) {
        link.addEventListener('click', function () {
            var className = link.getAttribute('data-class') || link.closest('.teacher-row').querySelector('div').textContent;
            var students = link.getAttribute('data-students') || '';
            var price = link.getAttribute('data-price') || '';
            var subjects = [];
            try { subjects = JSON.parse(link.getAttribute('data-subjects') || '[]'); } catch (e) { subjects = []; }

            var panel = buildDetailsPanel(className, students, price, subjects);
            showDetails(panel);
        });
    });

    /* ── Teacher list pagination ── */
    var teacherRows = Array.prototype.slice.call(document.querySelectorAll('.teacher-table-card .teacher-row'));
    var teacherPagination = document.getElementById('teacherPagination');
    // Show all rows by default (was 4) so all classes are visible on the page.
    var rowsPerPage = teacherRows.length || 4;
    var currentPage = 1;

    function renderTeacherPage(page) {
        var totalPages = Math.ceil(teacherRows.length / rowsPerPage) || 1;
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        currentPage = page;

        teacherRows.forEach(function (row, index) {
            var start = (currentPage - 1) * rowsPerPage;
            var end = start + rowsPerPage;
            row.style.display = index >= start && index < end ? '' : 'none';
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

        teacherPagination.appendChild(createButton('Prev', currentPage === 1, function () { renderTeacherPage(currentPage - 1); }));

        for (var i = 1; i <= totalPages; i++) {
            teacherPagination.appendChild(createButton(i, false, (function (pageNumber) {
                return function () { renderTeacherPage(pageNumber); };
            })(i), i === currentPage));
        }

        teacherPagination.appendChild(createButton('Next', currentPage === totalPages, function () { renderTeacherPage(currentPage + 1); }));
    }

    renderTeacherPage(currentPage);

    /* ── Classroom multi-select buttons ── */
    document.querySelectorAll('.classroom-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
            btn.classList.toggle('active');
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

    /* ── Download Report Button ── */
    var downloadReportBtn = document.getElementById('downloadReportBtn');
    if (downloadReportBtn) {
        downloadReportBtn.addEventListener('click', function () {
            // Generate report data (can be HTML or JSON format)
            var reportData = {
                title: 'Admin Report Overview',
                generatedDate: new Date().toLocaleString(),
                stats: {
                    totalStudents: 19572,
                    totalTeachers: 98,
                    totalRevenue: 'Rs. 146390000'
                },
                classroomData: [
                    { classroom: 'Class 4', students: 210, revenue: 'Rs. 140000' },
                    { classroom: 'Class 5', students: 321, revenue: 'Rs. 1650000' },
                    { classroom: 'Class 6', students: 97, revenue: 'Rs. 85000' },
                    { classroom: 'Class 7', students: 109, revenue: 'Rs. 265000' },
                    { classroom: 'Class 8', students: 210, revenue: 'Rs. 19000' },
                    { classroom: 'Class 9', students: 328, revenue: 'Rs. 854000' },
                    { classroom: 'Class 10', students: 278, revenue: 'Rs. 98000' }
                ],
                enrollments: {
                    active: 15809,
                    pending: 5809
                }
            };

            // Create CSV content
            var csvContent = 'data:text/csv;charset=utf-8,';
            csvContent += 'Pathshala Admin Report\n';
            csvContent += 'Generated: ' + reportData.generatedDate + '\n\n';
            csvContent += 'Summary Statistics\n';
            csvContent += 'Total Students,' + reportData.stats.totalStudents + '\n';
            csvContent += 'Total Teachers,' + reportData.stats.totalTeachers + '\n';
            csvContent += 'Total Revenue,' + reportData.stats.totalRevenue + '\n\n';
            csvContent += 'Payment Collected Per Classroom\n';
            csvContent += 'Classroom,No.of Students,Total Revenue\n';
            reportData.classroomData.forEach(function (item) {
                csvContent += item.classroom + ',' + item.students + ',' + item.revenue + '\n';
            });
            csvContent += '\nEnrollments\n';
            csvContent += 'Active Enrollments,' + reportData.enrollments.active + '\n';
            csvContent += 'Pending Enrollments,' + reportData.enrollments.pending + '\n';

            // Create download link
            var link = document.createElement('a');
            link.setAttribute('href', encodeURI(csvContent));
            link.setAttribute('download', 'Pathshala_Admin_Report_' + new Date().toISOString().split('T')[0] + '.csv');
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        });
    }

})();