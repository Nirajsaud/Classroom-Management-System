const passInput = document.getElementById('password');

// Show password (text) when user clicks into the box
passInput.addEventListener('focus', () => passInput.type = 'text');

// Hide password (dots) when user clicks away
passInput.addEventListener('blur', () => passInput.type = 'password');