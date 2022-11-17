import { Controller } from "stimulus";

export default class extends Controller {

    static targets = ["zone"]

    connect() {
        this.zoneTarget.classList.add('d-none')
    }

    openZone(event) {
        const persoId = event.target.dataset.id
        document.getElementById(`toggleZone${persoId}`).classList.add('d-none')
        this.zoneTarget.classList.remove('d-none')
        
    }
    closeZone(event) {
        const persoId = event.target.dataset.id
        document.getElementById(`toggleZone${persoId}`).classList.remove('d-none')
        this.zoneTarget.classList.add('d-none')
        
    }
    days(event) {
        let id = event.target.closest("[data-id]").dataset.id
        let index = document.getElementById(`selectedzone${id}`).options.selectedIndex
        let selected_zone = document.getElementById(`selectedzone${id}`).options[index].value
        if (selected_zone === "Ile de Dawn") {
            document.getElementById(`days${id}`).innerHTML = `${Math.abs(document.getElementById(`days${id}`).dataset.days - 1)} jours de trajet`
        }
        if (selected_zone === "Shimotsuki") {
            document.getElementById(`days${id}`).innerHTML = `${Math.abs(document.getElementById(`days${id}`).dataset.days - 2)} jours de trajet`
        }
        if (selected_zone === "Ile de Goat") {
            document.getElementById(`days${id}`).innerHTML = `${Math.abs(document.getElementById(`days${id}`).dataset.days - 3)} jours de trajet`
        }
        if (selected_zone === "Yotsuba") {
            document.getElementById(`days${id}`).innerHTML = `${Math.abs(document.getElementById(`days${id}`).dataset.days - 4)} jours de trajet`
        }
        if (selected_zone === "Archipel des Orgao") {
            document.getElementById(`days${id}`).innerHTML = `${Math.abs(document.getElementById(`days${id}`).dataset.days - 5)} jours de trajet`
        }
        if (selected_zone === "Ile des animaux rares") {
            document.getElementById(`days${id}`).innerHTML = `${Math.abs(document.getElementById(`days${id}`).dataset.days - 6)} jours de trajet`
        }
}
}
