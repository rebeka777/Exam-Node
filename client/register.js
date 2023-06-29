const validatePasswords = () => {
  const password = document.getElementById('password').value;
  const confirm_password = document.getElementById('confirm_password').value;
  const password_error = document.getElementById('password_error');

  if (password !== confirm_password) {
    alert("Passwords don't match");
    return false;
  }

  return true;
};

const form = document.querySelector('form');

const API_BASE = 'http://localhost:8080';

const onRegisterUser = async (payload) => {
  try {
    const response = await fetch(`${API_BASE}/register`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(payload),
    });

    return await response.json();
  } catch (err) {
    return console.log(err);
  }
};

form.addEventListener('submit', async (event) => {
  event.preventDefault();

  if (!validatePasswords()) {
    return;
  }

  const payload = {
    full_name: event.target.full_name.value,
    email: event.target.email.value,
    password: event.target.password.value,
  };

  const userData = await onRegisterUser(payload);
  if (userData.token) {
    Cookies.set('token', userData.token, { expires: 0.1 });
    window.location.replace('./login.html');
  }
});
