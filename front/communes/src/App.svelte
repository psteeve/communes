<script lang="ts">
  import { debounce } from "./commons";

  const cityMap = new Map<string, City[]>([]);

  import { findCommunesWithItem } from "./communes";
  import type { City } from "./models";

  let cities: City[] = [];

  const onInputNameHandler = async (value: string) => {
    if (value === "") {
      cities = [];
      return;
    }

    if (cityMap.has(value)) {
      cities = cityMap.get(value);
      return;
    } else {
      const values = await findCommunesWithItem(value);
      if (values.length > 0) {
        cityMap.set(value, values);
      }
      cities = values;
    }
  };
</script>

<form onsubmit="return false;">
  <p>
    <input
      on:keyup={({ target: { value } }) => debounce(value, onInputNameHandler)}
    />
  </p>
</form>

<ul>
  {#await cities then value}
    {#each value as city (city.nom)}
      <li>
        <span><a target="_blank" href={city.wikipediaLink}>{city.nom}</a></span>
      </li>
    {/each}
  {/await}
</ul>

<style>
  input {
    width: 80%;
    margin-right: 10%;
    margin-left: 10%;
  }
</style>
