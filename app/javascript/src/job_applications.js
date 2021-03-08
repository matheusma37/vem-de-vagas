function showForm(id) {
  form = document.getElementById(id);
  if (form.style.display === "none") {
    form.style.display = "flex";
  }
}