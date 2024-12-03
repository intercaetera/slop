import { VStack, HStack, Heading, Spacer, Link as ChakraLink, Container } from "@chakra-ui/react"
import { Link, Outlet } from "react-router"
import { Toaster } from "./components/ui/toaster"

function App() {
  return (
    <VStack>
      <HStack w="100%" bg="bg.muted" py={2} px={4} borderBottom="1px solid" borderBottomColor="bg.emphasized">
        <Heading>Slop</Heading>
        <Spacer />
        <ChakraLink asChild variant="underline">
          <Link to="/ingredients">Ingredients</Link>
        </ChakraLink>

        <ChakraLink asChild variant="underline">
          <Link to="/menu-items">Menu Items</Link>
        </ChakraLink>
      </HStack>
      <Container maxWidth="xl" bg="bg.subtle" py={2} px={8} borderRadius="md">
        <Outlet />
      </Container>
      <Toaster />
    </VStack>
  )
}

export default App
