import { defineConfig, defaultConfig, createSystem } from '@chakra-ui/react'

const customConfig = defineConfig({
  globalCss: {
    '*:focus': {
      outline: 'none !important',
      boxShadow: 'none !important',
    },
  },
})

export const system = createSystem(defaultConfig, customConfig)
