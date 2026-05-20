/* =============================================
   PATHSHALA — about.js
   Scroll effects, counter animation, mobile nav
   ============================================= */

(function () {
    'use strict';

    /* ---- Navbar scroll shadow ---- */
    const navbar = document.getElementById('navbar');

    function handleNavbarScroll() {
        if (window.scrollY > 20) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    }

    window.addEventListener('scroll', handleNavbarScroll, { passive: true });
    handleNavbarScroll(); // run once on load

    /* ---- Mobile nav toggle ---- */
    const mobileToggle = document.getElementById('mobileToggle');
    const navCenter = document.querySelector('.nav-center');

    if (mobileToggle && navCenter) {
        mobileToggle.addEventListener('click', function () {
            navCenter.classList.toggle('open');
            const isOpen = navCenter.classList.contains('open');
            mobileToggle.setAttribute('aria-expanded', isOpen);

            // Animate hamburger → X
            const spans = mobileToggle.querySelectorAll('span');
            if (isOpen) {
                spans[0].style.transform = 'translateY(7px) rotate(45deg)';
                spans[1].style.opacity = '0';
                spans[2].style.transform = 'translateY(-7px) rotate(-45deg)';
            } else {
                spans[0].style.transform = '';
                spans[1].style.opacity = '';
                spans[2].style.transform = '';
            }
        });

        // Close nav when a link is clicked
        navCenter.querySelectorAll('a').forEach(function (link) {
            link.addEventListener('click', function () {
                navCenter.classList.remove('open');
                const spans = mobileToggle.querySelectorAll('span');
                spans[0].style.transform = '';
                spans[1].style.opacity = '';
                spans[2].style.transform = '';
            });
        });
    }

    /* ---- Scroll-reveal (IntersectionObserver) ---- */
    const revealEls = document.querySelectorAll('.reveal');

    const revealObserver = new IntersectionObserver(
        function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    const delay = entry.target.getAttribute('data-delay') || 0;
                    setTimeout(function () {
                        entry.target.classList.add('visible');
                    }, parseInt(delay, 10));
                    revealObserver.unobserve(entry.target);
                }
            });
        },
        {
            threshold: 0.12,
            rootMargin: '0px 0px -40px 0px'
        }
    );

    revealEls.forEach(function (el) {
        revealObserver.observe(el);
    });

    /* ---- Team card tilt on mouse move (subtle 3-D feel) ---- */
    const teamCards = document.querySelectorAll('.team-card');

    teamCards.forEach(function (card) {
        card.addEventListener('mousemove', function (e) {
            const rect = card.getBoundingClientRect();
            const cx = rect.left + rect.width / 2;
            const cy = rect.top + rect.height / 2;
            const dx = (e.clientX - cx) / (rect.width / 2);
            const dy = (e.clientY - cy) / (rect.height / 2);
            const tiltX = dy * -4;   // degrees
            const tiltY = dx * 4;
            card.style.transform = 'translateY(-6px) rotateX(' + tiltX + 'deg) rotateY(' + tiltY + 'deg)';
            card.style.transition = 'transform 0.1s ease';
        });

        card.addEventListener('mouseleave', function () {
            card.style.transform = '';
            card.style.transition = 'transform 0.35s cubic-bezier(0.4,0,0.2,1), box-shadow 0.35s ease';
        });
    });

})();