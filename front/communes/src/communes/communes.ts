import type { City } from '../models';

export async function findCommunesWithItem(name: string): Promise<City[]> {
    const url = `api/communes?name=${name}`;
    const communes = await fetch(url);
    return await communes.json();
}
