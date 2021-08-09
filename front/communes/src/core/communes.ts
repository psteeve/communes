export interface Commune {
    nom: string;
    code: string;
    codeDepartement: string;
    codeRegion: string;
    population: number;
    surface: number
    wikipediaLink: string
}

export function communes() {
    return fetch('/api/v1/communes').then(data => data.json());
}