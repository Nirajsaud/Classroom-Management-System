document.addEventListener("DOMContentLoaded", function () {
    const tabButtons = document.querySelectorAll(".tab-btn");
    const tabContents = document.querySelectorAll(".tab-content");

    tabButtons.forEach(function (button) {
        button.addEventListener("click", function () {
            const selectedTab = button.getAttribute("data-tab");

            tabButtons.forEach(function (btn) {
                btn.classList.remove("active");
            });

            tabContents.forEach(function (content) {
                content.classList.remove("active");
            });

            button.classList.add("active");

            const activeContent = document.getElementById(selectedTab);

            if (activeContent) {
                activeContent.classList.add("active");
            }
        });
    });
});