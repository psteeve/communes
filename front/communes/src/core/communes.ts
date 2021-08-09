export interface Commune {
    nom: string;
    code: string;
    codeDepartement: string;
    codeRegion: string;
    population: number;
    surface: number
    wikipediaLink: string
}

export function communes(search = '') {
    const url = `/api/v1/communes?search=${search}`
    
    return fetch(url).then(data => data.json());
}