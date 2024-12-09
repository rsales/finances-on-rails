//////////////////////////////
// Nested Form for Group Members
//////////////////////////////

document.addEventListener("turbo:load", () => {
  const addUserButton = document.getElementById("add-user");
  const groupMembersContainer = document.getElementById("group-members");

  addUserButton.addEventListener("click", (e) => {
    e.preventDefault();

    const newId = new Date().getTime();
    const regexp = new RegExp("new_group_members", "g");
    const newFields = document.createElement("tr");
    newFields.classList.add("group-member-fields");
    newFields.innerHTML = groupMembersContainer.dataset.fields.replace(regexp, newId);

    groupMembersContainer.appendChild(newFields);
  });

  groupMembersContainer.addEventListener("click", (e) => {
    if (e.target.classList.contains("remove-fields")) {
      e.preventDefault();
      const fieldContainer = e.target.closest(".group-member-fields");
      fieldContainer.querySelector("input[name*='_destroy']").value = "1";
      fieldContainer.style.display = "none";
    }
  });
});