import { Controller } from "stimulus";

export default class extends Controller {


    connect() {
    }

    days(event) {
        let id = event.target.closest("[data-id]").dataset.id
        let index = document.getElementById(`chantierzone${id}`).options.selectedIndex
        let selected_zone = document.getElementById(`chantierzone${id}`).options[index].value
        let indexVersion = document.getElementById(`chantierversion${id}`).options.selectedIndex
        let selected_version = document.getElementById(`chantierversion${id}`).options[indexVersion].value
        if (selected_version === "canon") {
            document.getElementById(`chantiercost${id}`).innerHTML = '150 Berrys'
            document.getElementById(`chantierwood${id}`).innerHTML = '150 de bois 🪵'
        } else {
            document.getElementById(`chantiercost${id}`).innerHTML = '200 Berrys'
            document.getElementById(`chantierwood${id}`).innerHTML = '200 de bois 🪵'
        }
        
        if (selected_zone === "Ile de Dawn") {
            document.getElementById(`chantierdays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierdays${id}`).dataset.days - 1)} jours de trajet`
        }
        if (selected_zone === "Shimotsuki") {
            document.getElementById(`chantierdays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierdays${id}`).dataset.days - 2)} jours de trajet`
        }
        if (selected_zone === "Ile de Goat") {
            document.getElementById(`chantierdays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierdays${id}`).dataset.days - 3)} jours de trajet`
        }
        if (selected_zone === "Yotsuba") {
            document.getElementById(`chantierdays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierdays${id}`).dataset.days - 4)} jours de trajet`
        }
        if (selected_zone === "Archipel des Orgao") {
            document.getElementById(`chantierdays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierdays${id}`).dataset.days - 5)} jours de trajet`
        }
        if (selected_zone === "Ile des animaux rares") {
            document.getElementById(`chantierdays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierdays${id}`).dataset.days - 6)} jours de trajet`
        }
}

    change(event) {
    let id = event.target.closest("[data-id]").dataset.id
    let index = document.getElementById(`chantierchange${id}`).options.selectedIndex
    let selected_zone = document.getElementById(`chantierchange${id}`).options[index].value
    
    
    if (selected_zone === "Ile de Dawn") {
        document.getElementById(`chantierchangedays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierchangedays${id}`).dataset.days - 1)} jours de trajet`
    }
    if (selected_zone === "Shimotsuki") {
        document.getElementById(`chantierchangedays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierchangedays${id}`).dataset.days - 2)} jours de trajet`
    }
    if (selected_zone === "Ile de Goat") {
        document.getElementById(`chantierchangedays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierchangedays${id}`).dataset.days - 3)} jours de trajet`
    }
    if (selected_zone === "Yotsuba") {
        document.getElementById(`chantierchangedays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierchangedays${id}`).dataset.days - 4)} jours de trajet`
    }
    if (selected_zone === "Archipel des Orgao") {
        document.getElementById(`chantierchangedays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierchangedays${id}`).dataset.days - 5)} jours de trajet`
    }
    if (selected_zone === "Ile des animaux rares") {
        document.getElementById(`chantierchangedays${id}`).innerHTML = `${Math.abs(document.getElementById(`chantierchangedays${id}`).dataset.days - 6)} jours de trajet`
    }
}
}