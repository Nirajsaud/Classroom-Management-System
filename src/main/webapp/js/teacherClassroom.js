document.addEventListener("DOMContentLoaded", function () {
    const openUploadBtn = document.getElementById("openUploadBtn");
    const cancelUploadBtn = document.getElementById("cancelUploadBtn");
    const uploadOverlay = document.getElementById("uploadOverlay");
    const materialFile = document.getElementById("materialFile");

    if (openUploadBtn && uploadOverlay) {
        openUploadBtn.addEventListener("click", function () {
            uploadOverlay.classList.add("active");
        });
    }

    if (cancelUploadBtn && uploadOverlay) {
        cancelUploadBtn.addEventListener("click", function () {
            uploadOverlay.classList.remove("active");
        });
    }

    if (materialFile) {
        materialFile.addEventListener("change", function () {
            const file = materialFile.files[0];
            const uploadText = document.getElementById("uploadText");
            const uploadIcon = document.getElementById("uploadIcon");

            if (file && uploadText && uploadIcon) {
                uploadText.innerHTML = file.name;
                uploadIcon.style.display = "none";
            }
        });
    }
});