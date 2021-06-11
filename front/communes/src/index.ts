interface City {
    nom: string;
    code: string;
    codeDepartement: string;
    codeRegion: string;
    population: number;
    wikipediaLink: string;
}

async function findCommunesWithItem(name: string): Promise<City[]> {
    const url = `api/communes?name=${name}`;
    const communes = await fetch(url);
    return await communes.json();
}


window.findCommunesWithItem = findCommunesWithItem;

window.onload = function() {
    console.log('load');
}
