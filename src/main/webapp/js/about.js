/* =============================================
   PATHSHALA — about.js
   Scroll effects, reveal animation, mobile nav, team tilt
   Compatible with public-navbar.css
   ============================================= */

(function () {
    'use strict';

function setupPublicNavbar() {
    const navbar = document.querySelector('.public-navbar');
    const mobileToggle = document.getElementById('mobileToggle');
    const navCenter = document.querySelector('.public-nav-center');
    const navRight = document.querySelector('.public-nav-right');

    function handleNavbarScroll() {
        if (!navbar) return;
        if (window.scrollY > 20) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    }

    window.addEventListener('scroll', handleNavbarScroll, { passive: true });
    handleNavbarScroll();

    if (mobileToggle && navCenter && navRight) {
        mobileToggle.addEventListener('click', function () {
            const isOpen = navCenter.classList.toggle('open');
            navRight.classList.toggle('open', isOpen);
            mobileToggle.classList.toggle('open', isOpen);
            mobileToggle.setAttribute('aria-expanded', isOpen);
        });

        navCenter.querySelectorAll('a').forEach(function (link) {
            link.addEventListener('click', function () {
                navCenter.classList.remove('open');
                navRight.classList.remove('open');
                mobileToggle.classList.remove('open');
                mobileToggle.setAttribute('aria-expanded', 'false');
            });
        });
    }
}

function setupReveal(selector, options) {
    const elements = document.querySelectorAll(selector);
    if (!elements.length) return;

    elements.forEach(function (el) {
        if (!el.classList.contains('reveal')) {
            el.classList.add('reveal');
        }
    });

    const observer = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) {
                const delay = entry.target.getAttribute('data-delay') || 0;
                setTimeout(function () {
                    entry.target.classList.add('visible');
                }, parseInt(delay, 10));
                observer.unobserve(entry.target);
            }
        });
    }, options || { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });

    elements.forEach(function (el) {
        observer.observe(el);
    });
}


    document.addEventListener('DOMContentLoaded', function () {
        setupPublicNavbar();
        setupReveal('.reveal');

        const teamCards = document.querySelectorAll('.team-card');

        teamCards.forEach(function (card) {
            card.addEventListener('mousemove', function (e) {
                const rect = card.getBoundingClientRect();
                const cx = rect.left + rect.width / 2;
                const cy = rect.top + rect.height / 2;
                const dx = (e.clientX - cx) / (rect.width / 2);
                const dy = (e.clientY - cy) / (rect.height / 2);
                const tiltX = dy * -4;
                const tiltY = dx * 4;
                card.style.transform = 'translateY(-6px) rotateX(' + tiltX + 'deg) rotateY(' + tiltY + 'deg)';
                card.style.transition = 'transform 0.1s ease';
            });

            card.addEventListener('mouseleave', function () {
                card.style.transform = '';
                card.style.transition = 'transform 0.35s cubic-bezier(0.4,0,0.2,1), box-shadow 0.35s ease';
            });
        });
    });
})();
