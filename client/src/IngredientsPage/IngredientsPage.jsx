import { useQuery } from "@tanstack/react-query"
import { getIngredients } from "../api/inventory"
import { HStack, Heading, List, Spinner } from "@chakra-ui/react"
import { AddIngredientModal } from "./AddIngredientModal"

export const IngredientsPage = () => {
  const ingredientsQuery = useQuery({
    queryKey: ['ingredients'],
    queryFn: getIngredients,
  })

  if (ingredientsQuery.isFetching) return <Spinner />
  if (ingredientsQuery.isError) return 'Error!'

  return (
    <div>
      <HStack w="100%" justifyContent="space-between">
        <Heading>
          Ingredients
        </Heading>
        <AddIngredientModal />
      </HStack>

      <List.Root>
        {ingredientsQuery.data.map(ingredient => (
          <List.Item key={ingredient.id}>{ingredient.name} ({ingredient.unit})</List.Item>
        ))}
      </List.Root>
    </div>
  )
}
