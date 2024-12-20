export const getMenuItems = () => fetch('/api/menu-items')
  .then(res => res.json())
  .then(json => json.data)

export const getIngredients = () => fetch('/api/ingredients')
  .then(res => res.json())
  .then(json => json.data)

export const createIngredient = data => fetch('/api/ingredients', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify(data)
})
  .then(res => {
    if (!res.ok) throw new Error('Failed to create ingredient.')
    return res.json()
  })
  .then(json => json.data)
