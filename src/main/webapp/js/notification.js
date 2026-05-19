document.addEventListener("DOMContentLoaded", function () {
    const bellBtn = document.getElementById("bellBtn");
    const bellWrapper = document.getElementById("bellWrapper");
    const notifDropdown = document.getElementById("notifDropdown");
    const markAllRead = document.getElementById("markAllRead");
    const bellBadge = document.getElementById("bellBadge");
    const notifList = document.getElementById("notifList");

    if (!bellBtn || !bellWrapper || !notifDropdown) {
        return;
    }

    bellBtn.addEventListener("click", function (event) {
        event.stopPropagation();
        notifDropdown.classList.toggle("open");
    });

    if (markAllRead && notifList) {
        markAllRead.addEventListener("click", function () {
            const notifications = notifList.querySelectorAll(".notif-item");

            notifications.forEach(function (item) {
                item.classList.add("dismissed");
            });

            if (bellBadge) {
                bellBadge.style.display = "none";
            }
        });
    }

    document.addEventListener("click", function (event) {
        if (!bellWrapper.contains(event.target)) {
            notifDropdown.classList.remove("open");
        }
    });
});