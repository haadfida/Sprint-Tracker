import React, { createContext, useState, useMemo, useContext } from 'react'
import type { ReactNode } from 'react'
import { createTheme, ThemeProvider, CssBaseline } from '@mui/material'
import type { PaletteMode } from '@mui/material'

interface ColorModeContextType {
  mode: PaletteMode
  toggleColorMode: () => void
}

const ColorModeContext = createContext<ColorModeContextType>({ mode: 'light', toggleColorMode: () => {} })

export const useColorMode = () => useContext(ColorModeContext)

export const ColorModeProvider = ({ children }: { children: ReactNode }) => {
  const [mode, setMode] = useState<PaletteMode>(() => (localStorage.getItem('mode') as PaletteMode) || 'light')

  const toggleColorMode = () =>
    setMode((prev) => {
      const m: PaletteMode = prev === 'light' ? 'dark' : 'light'
      localStorage.setItem('mode', m)
      return m
    })

  const theme = useMemo(
    () =>
      createTheme({
        palette: {
          mode,
          primary: {
            main: '#7c3aed',
            light: '#a78bfa',
            dark: '#5b21b6',
            contrastText: '#fff',
          },
          secondary: {
            main: '#14b8a6',
          },
          background: {
            default: mode === 'light' ? '#f3f4fa' : '#121212',
            paper: mode === 'light' ? '#ffffff' : '#1e1e1e',
          },
        },
        shape: {
          borderRadius: 10,
        },
        typography: {
          fontFamily: ['Inter', 'Roboto', 'Helvetica', 'Arial', 'sans-serif'].join(','),
          h1: { fontWeight: 700 },
          h2: { fontWeight: 700 },
          h3: { fontWeight: 700 },
        },
        components: {
          MuiButton: {
            styleOverrides: {
              root: {
                textTransform: 'none',
                borderRadius: 8,
                transition: 'box-shadow 0.25s',
                '&:focus-visible': {
                  boxShadow: '0 0 0 3px rgba(124,58,237,0.6), 0 0 10px rgba(124,58,237,0.7)',
                  outline: 'none',
                },
              },
              containedPrimary: {
                boxShadow: '0 3px 10px rgba(124, 58, 237, 0.3)',
                '&:hover': {
                  boxShadow: '0 4px 12px rgba(124, 58, 237, 0.35)',
                },
              },
            },
          },
          MuiPaper: {
            styleOverrides: {
              rounded: {
                borderRadius: 12,
              },
              root: {
                transition: 'transform 0.25s, box-shadow 0.25s',
                '&:hover': {
                  transform: 'translateY(-2px)',
                  boxShadow: '0 8px 20px rgba(0,0,0,0.08)',
                },
              },
            },
          },
          MuiOutlinedInput: {
            styleOverrides: {
              root: {
                transition: 'box-shadow 0.25s',
                '&.Mui-focused .MuiOutlinedInput-notchedOutline': {
                  borderColor: '#7c3aed',
                  boxShadow: '0 0 0 3px rgba(124,58,237,0.5), 0 0 8px rgba(124,58,237,0.6)',
                },
              },
            },
          },
        },
      }),
    [mode]
  )

  const value = useMemo(() => ({ mode, toggleColorMode }), [mode])

  return (
    <ColorModeContext.Provider value={value}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        {children}
      </ThemeProvider>
    </ColorModeContext.Provider>
  )
} 