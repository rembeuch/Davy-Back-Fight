import { Controller } from "stimulus";

export default class extends Controller {


    connect() {
    }

    days(event) {
        let id = event.target.closest("[data-id]").dataset.id
        let index = document.getElementById(`portzone${id}`).options.selectedIndex
        let selected_zone = document.getElementById(`portzone${id}`).options[index].value
        let indexVersion = document.getElementById(`portversion${id}`).options.selectedIndex
        let selected_version = document.getElementById(`portversion${id}`).options[indexVersion].value
        if (selected_version === "barque") {
            document.getElementById(`portcost${id}`).innerHTML = '100 Berrys'
            document.getElementById(`portwood${id}`).innerHTML = '100 de bois 🪵'
        } else if (selected_version === "caravelle") {
            document.getElementById(`portcost${id}`).innerHTML = '200 Berrys'
            document.getElementById(`portwood${id}`).innerHTML = '200 de bois 🪵'
        }
        
        if (selected_zone === "Ile de Dawn") {
            document.getElementById(`portdays${id}`).innerHTML = `${Math.abs(document.getElementById(`portdays${id}`).dataset.days - 1)} jours de trajet`
        }
        if (selected_zone === "Shimotsuki") {
            document.getElementById(`portdays${id}`).innerHTML = `${Math.abs(document.getElementById(`portdays${id}`).dataset.days - 2)} jours de trajet`
        }
        if (selected_zone === "Ile de Goat") {
            document.getElementById(`portdays${id}`).innerHTML = `${Math.abs(document.getElementById(`portdays${id}`).dataset.days - 3)} jours de trajet`
        }
        if (selected_zone === "Yotsuba") {
            document.getElementById(`portdays${id}`).innerHTML = `${Math.abs(document.getElementById(`portdays${id}`).dataset.days - 4)} jours de trajet`
        }
        if (selected_zone === "Archipel des Orgao") {
            document.getElementById(`portdays${id}`).innerHTML = `${Math.abs(document.getElementById(`portdays${id}`).dataset.days - 5)} jours de trajet`
        }
        if (selected_zone === "Ile des animaux rares") {
            document.getElementById(`portdays${id}`).innerHTML = `${Math.abs(document.getElementById(`portdays${id}`).dataset.days - 6)} jours de trajet`
        }
}
}