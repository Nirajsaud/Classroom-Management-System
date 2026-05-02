const passInput = document.getElementById('password');

// Show password when user enters the field
passInput.addEventListener('focus', () => {
    passInput.type = 'text';
});

// Hide password when user leaves the field
passInput.addEventListener('blur', () => {
    passInput.type = 'password';
});