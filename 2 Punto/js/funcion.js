// 2. Escribe una función en lenguaje de su preferencia que tome una lista de
// enteros y un entero de destino, y devuelva los índices de los dos números
// que sumados dan el resultado del entero destino.
// Función funcion_dos.

function funcion_dos(nums, target) {
    const seen = new Map();
    for (let i = 0; i < nums.length; i++) {
        const val = nums[i];
        const need = target - val;
        if (seen.has(need)) {
            return [seen.get(need), i];
        }
        seen.set(val, i);
    }
    return null;
}

document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById('twoSumForm');
    const resultCard = document.getElementById('resultCard');
    const resultTable = document.getElementById('resultTable');

    form.addEventListener('submit', function (e) {
        e.preventDefault();

        const numsInput = document.getElementById('nums').value.trim();
        const target = parseInt(document.getElementById('target').value);

        const nums = numsInput.split(',').map(n => parseInt(n.trim())).filter(n => !isNaN(n));

        const result = funcion_dos(nums, target);

        resultTable.innerHTML = `
        <tr>
          <td>[${nums.join(', ')}]</td>
          <td>${target}</td>
          <td>${result ? `[${result.join(', ')}]` : 'No se encontró solución'}</td>
        </tr>
      `;

        resultCard.classList.remove('d-none');
    });
});
