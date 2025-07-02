import { Link as RouterLink, useNavigate, Outlet, useLocation } from 'react-router-dom'
import { useAuth } from '../contexts/AuthContext'
import {
  AppBar,
  Toolbar,
  Typography,
  Button,
  Stack,
  Box,
  IconButton,
} from '@mui/material'
import { useColorMode } from '../contexts/ColorModeContext'
import DarkModeIcon from '@mui/icons-material/DarkModeOutlined'
import LightModeIcon from '@mui/icons-material/LightModeOutlined'
import { keyframes } from '@emotion/react'
import { motion, AnimatePresence } from 'framer-motion'

export const Layout = () => {
  const { user, logout } = useAuth()
  const navigate = useNavigate()
  const { mode, toggleColorMode } = useColorMode()
  const location = useLocation()

  const gradientMove = keyframes`
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
  `

  const handleLogout = async () => {
    await logout()
    navigate('/login')
  }

  return (
    <Box sx={{ minHeight: '100vh', bgcolor: 'background.default' }}>
      <AppBar position="static" color="inherit" elevation={1} sx={{ position:'relative', '&::after':{ content:'""', position:'absolute', left:0, bottom:0, width:'100%', height:3, background:'linear-gradient(90deg, #7c3aed, #14b8a6, #facc15, #ec4899, #7c3aed)', backgroundSize:'400% 100%', animation:`${gradientMove} 8s linear infinite` } }}>
        <Toolbar sx={{ maxWidth: 'lg', mx: 'auto', width: '100%' }}>
          <Typography component={RouterLink} to="/" variant="h6" sx={{ textDecoration: 'none', color: 'primary.main', mr: 4 }}>
            Sprint Tracker
          </Typography>

          {user && (
            <Stack direction="row" spacing={2} sx={{ flexGrow: 1 }}>
              <Button component={RouterLink} to="/dashboard" color="inherit">Dashboard</Button>
              <Button component={RouterLink} to="/projects" color="inherit">Projects</Button>
              <Button component={RouterLink} to="/issues" color="inherit">Issues</Button>
              <Button component={RouterLink} to="/sprints" color="inherit">Sprints</Button>
            </Stack>
          )}

          {/* Dark / light mode toggle */}
          <IconButton onClick={toggleColorMode} color="inherit" sx={{ mr: 2 }}>
            {mode === 'light' ? <DarkModeIcon fontSize="small" /> : <LightModeIcon fontSize="small" />}
          </IconButton>

          {user ? (
            <Stack direction="row" spacing={2} alignItems="center">
              <Typography variant="body2">Welcome, {user.name}</Typography>
              <Button variant="contained" color="primary" onClick={handleLogout} size="small">Logout</Button>
            </Stack>
          ) : (
            <Stack direction="row" spacing={2}>
              <Button component={RouterLink} to="/login" color="inherit">Login</Button>
              <Button component={RouterLink} to="/register" variant="contained" color="primary" size="small">Register</Button>
            </Stack>
          )}
        </Toolbar>
      </AppBar>

      <Box sx={{ maxWidth: 'lg', mx: 'auto', p: 3 }}>
        <AnimatePresence mode="wait">
          <motion.div
            key={location.pathname}
            initial={{ opacity: 0, y: 12 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -12 }}
            transition={{ duration: 0.25 }}
          >
            <Outlet />
          </motion.div>
        </AnimatePresence>
      </Box>
    </Box>
  )
} 