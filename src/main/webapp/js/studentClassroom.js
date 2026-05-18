// Wait until the full HTML page loads first
document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.getElementById("searchInput");
    const searchBtn = document.getElementById("searchBtn");
    const priceFilter = document.getElementById("priceFilter");
    const grid = document.getElementById("classroomGrid");
    const emptyMessage = document.getElementById("emptyMessage");

    searchBtn.onclick = filterClassrooms;

    searchInput.onkeyup = function () {
        filterClassrooms();
    };

    priceFilter.onchange = function () {
        filterClassrooms();
    };
	// Main filtering function
    function filterClassrooms() {
		// Get all classroom cards and convert to array
        let cards = Array.from(document.getElementsByClassName("classroom-card"));
        let searchValue = cleanText(searchInput.value);
        let visibleCount = 0;

        cards.forEach(function (card) {
			// Get title from data-title attribute
            let title = cleanText(card.getAttribute("data-title"));

            if (searchValue === "" || title.includes(searchValue)) {
                card.style.display = "grid";
                visibleCount++;
            } else {
				// Hide card if not matched
                card.style.display = "none";
            }
        });

        sortCards(cards);
		// Show message if no classroom found
        if (visibleCount === 0) {
            emptyMessage.style.display = "block";
        } else {
            emptyMessage.style.display = "none";
        }
    }
	// Function to sort classroom cards
    function sortCards(cards) {
        let sortValue = priceFilter.value;
		// Lowest price first
        if (sortValue === "low") {
            cards.sort(function (a, b) {
                return Number(a.getAttribute("data-price")) - Number(b.getAttribute("data-price"));
            });
        }
		// Highest price first
        if (sortValue === "high") {
            cards.sort(function (a, b) {
                return Number(b.getAttribute("data-price")) - Number(a.getAttribute("data-price"));
            });
        }
		// Re-add sorted cards into grid
        cards.forEach(function (card) {
            grid.appendChild(card);
        });
    }

	// Function to clean text
    function cleanText(text) {
		// Convert to lowercase
		// Remove spaces
		// Remove extra whitespace
        return text.toLowerCase().replace(/\s+/g, "").trim();
    }
});
function openPaymentModal() {
    document.getElementById("paymentOverlay").classList.add("active");
}

function closePaymentModal() {
    document.getElementById("paymentOverlay").classList.remove("active");
}