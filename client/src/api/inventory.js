export const getMenuItems = () => fetch('/api/menu-items')
  .then(res => res.json())
  .then(json => json.data)

export const getIngredients = () => fetch('/api/ingredients')
  .then(res => res.json())
  .then(json => json.data)
