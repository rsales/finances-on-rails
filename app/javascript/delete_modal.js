//////////////////////////////
// Open delete confirmation modal
//////////////////////////////

document.addEventListener("turbo:load", () => {
  const deleteButtons = document.querySelectorAll(".delete-transaction");
  const modal = document.getElementById("delete-confirmation-modal");
  const deleteFutureOnlyButton = document.getElementById("delete-future-only");
  const deleteAllButton = document.getElementById("delete-all");
  const cancelDeleteButton = document.getElementById("cancel-delete");

  let transactionId = null;
  let familyGroupId = null;

  deleteButtons.forEach(button => {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      transactionId = button.dataset.transactionId;
      familyGroupId = button.dataset.familyGroupId;
      modal.classList.remove("hidden");
    });
  });

  deleteFutureOnlyButton.addEventListener("click", () => {
    if (transactionId && familyGroupId) {
      fetch(`/finances/${familyGroupId}/transactions/${transactionId}/destroy_future`, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        }
      }).then(() => {
        window.location.reload();
      });
    }
  });

  deleteAllButton.addEventListener("click", () => {
    if (transactionId && familyGroupId) {
      fetch(`/finances/${familyGroupId}/transactions/${transactionId}`, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        }
      }).then(() => {
        window.location.reload();
      });
    }
  });

  cancelDeleteButton.addEventListener("click", () => {
    modal.classList.add("hidden");
  });
});