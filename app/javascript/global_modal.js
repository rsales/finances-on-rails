//////////////////////////////
// Open and Close Modal
//////////////////////////////

document.addEventListener("turbo:frame-load", (event) => {
  const modal = document.getElementById("modal");
  if (event.target.id === "modal-frame") {
    modal.classList.remove("hidden");
    setTimeout(() => {
      modal.classList.remove("translate-x-full");
    }, 10); // Pequeno atraso para garantir que a classe hidden seja removida antes da transição
  }
});

document.addEventListener("click", (event) => {
  if (event.target.matches(".modal") || event.target.closest(".modal-close")) {
    const modal = document.getElementById("modal");
    modal.classList.add("translate-x-full");
    setTimeout(() => {
      modal.classList.add("hidden");
    }, 300); // Duração da transição
  }
});