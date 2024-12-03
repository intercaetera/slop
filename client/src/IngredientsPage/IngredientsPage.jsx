import { useQuery } from "@tanstack/react-query"
import { getIngredients } from "../api/inventory"
import { Heading, List, Spinner } from "@chakra-ui/react"

export const IngredientsPage = () => {
  const ingredientsQuery = useQuery({
    queryKey: ['ingredients'],
    queryFn: getIngredients,
  })

  if (ingredientsQuery.isFetching) return <Spinner />
  if (ingredientsQuery.isError) return 'Error!'

  return (
    <div>
      <Heading>Ingredients</Heading>

      <List.Root>
        {ingredientsQuery.data.map(ingredient => (
          <List.Item key={ingredient.id}>{ingredient.name} ({ingredient.unit})</List.Item>
        ))}
      </List.Root>
    </div>
  )
}
