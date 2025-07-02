import { createTheme } from '@mui/material'

const theme = createTheme({
  palette: {
    primary: {
      main: '#7c3aed',
      light: '#a78bfa',
      dark: '#5b21b6',
      contrastText: '#fff',
    },
    secondary: {
      main: '#14b8a6', // teal accent
    },
    background: {
      default: '#f9fafb',
      paper: '#ffffff',
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
      },
    },
  },
})

export default theme 