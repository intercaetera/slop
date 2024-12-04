import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from './App.jsx'
import { BrowserRouter, Routes, Route } from 'react-router'
import * as routes from './routes.js'

import { IngredientsPage } from './IngredientsPage/IngredientsPage'
import { MenuItemsPage } from './MenuItemsPage/MenuItemsPage'
import { Providers } from './Providers'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <Providers>
      <BrowserRouter>
        <Routes>
          <Route path={routes.ROOT} element={<App />}>
            <Route path={routes.INGREDIENTS} element={<IngredientsPage />} />
            <Route path={routes.MENU_ITEMS} element={<MenuItemsPage />} />
          </Route>
        </Routes>
      </BrowserRouter>
    </Providers>
  </StrictMode>
)
