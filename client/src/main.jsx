import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import App from './App.jsx'
import { Provider as ChakraProvider } from './components/ui/provider'
import { BrowserRouter, Routes, Route } from 'react-router'
import * as routes from './routes.js'

import { IngredientsPage } from './IngredientsPage/IngredientsPage'
import { MenuItemsPage } from './MenuItemsPage/MenuItemsPage'

const qc = new QueryClient()

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <QueryClientProvider client={qc}>
      <ChakraProvider>
        <BrowserRouter>
          <Routes>
            <Route path={routes.ROOT} element={<App />}>
              <Route path={routes.INGREDIENTS} element={<IngredientsPage />} />
              <Route path={routes.MENU_ITEMS} element={<MenuItemsPage />} />
            </Route>
          </Routes>
        </BrowserRouter>
      </ChakraProvider>
    </QueryClientProvider>
  </StrictMode>
)
