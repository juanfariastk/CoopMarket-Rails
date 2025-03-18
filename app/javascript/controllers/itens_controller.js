import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "template"]

  addItem(event) {
    event.preventDefault();
  
    const template = this.templateTarget.innerHTML;
    const newIndex = this.containerTarget.children.length;
  
    const newItem = template.replace(/NEW_ITEM/g, newIndex);
    this.containerTarget.insertAdjacentHTML("beforeend", newItem);
  }  

  removeItem(event) {
    event.preventDefault();
  
    const item = event.currentTarget.closest(".item-row");
  
    if (item) {
      const destroyInput = item.querySelector("input[name*='_destroy']");
      if (destroyInput) {
        destroyInput.value = "1"; 
        item.style.display = "none";
      } else {
        item.remove(); 
      }
    }
  }
  
}
