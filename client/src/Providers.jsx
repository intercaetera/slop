import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { Provider as ChakraProvider } from './components/ui/provider'

const qc = new QueryClient()

export const Providers = ({ children }) => (
  <QueryClientProvider client={qc}>
    <ChakraProvider>
      {children}
    </ChakraProvider>
  </QueryClientProvider>
)
