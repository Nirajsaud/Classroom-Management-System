/* =============================================
   PATHSHALA — contact.js
   Navbar scroll shadow + form-page reveal effects
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

        setupReveal([
            '.contact-form-wrapper',
            '.contact-info-wrapper',
            '.info-item',
            '.footer-grid'
        ].join(','));

        document.querySelectorAll('.info-item, .icon-circle, .social-icons-contact a').forEach(function (item) {
            item.addEventListener('mouseenter', function () {
                item.style.transform = 'translateY(-3px)';
            });

            item.addEventListener('mouseleave', function () {
                item.style.transform = '';
            });
        });
    });
})();
