// Wait until the whole HTML page loads first
document.addEventListener("DOMContentLoaded", function () {
    const tabButtons = document.querySelectorAll(".tab-btn");
    const tabContents = document.querySelectorAll(".tab-content");
	
	// Loop through every tab button
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
	
	// Open upload popup/modal when upload button is clicked
    document.getElementById("openUploadBtn").onclick = function () {
        document.getElementById("uploadOverlay").classList.add("active");
    };

    document.getElementById("cancelUploadBtn").onclick = function () {
        document.getElementById("uploadOverlay").classList.remove("active");
    };

    document.getElementById("materialFile").onchange = function () {
        previewFile();
    };
});

// Function to show selected file name
function previewFile() {
    const fileInput = document.getElementById("materialFile");
    const fileNameText = document.getElementById("uploadText");
    const icon = document.getElementById("uploadIcon");

    const file = fileInput.files[0];

    if (file) {
        fileNameText.innerHTML = file.name;
        icon.style.display = "none";
    }
}