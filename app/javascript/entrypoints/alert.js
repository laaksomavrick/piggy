const setupAlerts = () => {
  const alerts = document.querySelectorAll('.alert');
  for (const alert of alerts) {
    alert.addEventListener('click', (e) => {
      if (e.target.classList.contains('alert')) {
        e.target.remove();
      } else {
        e.currentTarget.remove();
      }
    });
  }
};

document.addEventListener('turbo:load', setupAlerts);
