import { useQuery } from "@tanstack/react-query"
import { getMenuItems } from "../api/inventory"
import { Heading, List, Spinner } from "@chakra-ui/react"

export const MenuItemsPage = () => {
  const menuItemsQuery = useQuery({
    queryKey: ['menu-items'],
    queryFn: getMenuItems,
  })

  if (menuItemsQuery.isFetching) return <Spinner />
  if (menuItemsQuery.isError) return 'Error!'


  return (
    <div>
      <Heading>Menu Items</Heading>

      <List.Root>
        {menuItemsQuery.data.map(menuItem => (
          <List.Item key={menuItem.id}>
            {menuItem.name}
            <List.Root ps={5}>
              {menuItem.recipe_ingredients.map(recipeIngredient => (
                <List.Item key={recipeIngredient.id}>
                  {recipeIngredient.ingredient.name}
                  {' '}
                  ({recipeIngredient.quantity} {recipeIngredient.ingredient.unit})
                </List.Item>
              ))}
            </List.Root>
          </List.Item>
        ))}
      </List.Root>
    </div>
  )
}
