//////////////////////////////
// Open dropdown Add new transaction
//////////////////////////////

document.addEventListener("turbo:load", function () {
  const button = document.querySelector('#button-add-transaction');
  const dropdown = document.querySelector('#dropdown-transactions');
  const bgDropdown = document.querySelector('#bg-dropdown');

  button.addEventListener('click', function () {
    if (dropdown.classList.contains('hidden')) {
      dropdown.classList.remove('hidden');
      dropdown.classList.add('transition', 'ease-out', 'duration-100', 'transform', 'opacity-100', 'scale-100');
      dropdown.classList.remove('opacity-0', 'scale-95');
      // bgDropdown.classList.remove('hidden');
      // bgDropdown.classList.add('transition', 'ease-out', 'duration-100', 'transform', 'opacity-60');
      // bgDropdown.classList.remove('opacity-0');
    } else {
      dropdown.classList.add('transition', 'ease-in', 'duration-75', 'transform', 'opacity-0', 'scale-95');
      dropdown.classList.remove('opacity-100', 'scale-100');
      // bgDropdown.classList.add('transition', 'ease-out', 'duration-75', 'transform', 'opacity-0');
      // bgDropdown.classList.remove('opacity-60');
      setTimeout(() => {
        dropdown.classList.add('hidden');
        // bgDropdown.classList.add('hidden');
      }, 75);
    }
  });

  document.addEventListener('click', function (event) {
    if (!button.contains(event.target) && !dropdown.contains(event.target)) {
      dropdown.classList.add('transition', 'ease-in', 'duration-75', 'transform', 'opacity-0', 'scale-95');
      dropdown.classList.remove('opacity-100', 'scale-100');
      // bgDropdown.classList.add('transition', 'ease-out', 'duration-75', 'transform', 'opacity-0');
      // bgDropdown.classList.remove('opacity-60');
      setTimeout(() => {
        dropdown.classList.add('hidden');
        // bgDropdown.classList.add('hidden');
      }, 75);
    }
  });
});