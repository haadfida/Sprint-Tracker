import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'
import { AuthProvider } from './contexts/AuthContext'
import { Layout } from './components/Layout'
import { Login } from './pages/Login'
import { Register } from './pages/Register'
import { Dashboard } from './pages/Dashboard'
import { Projects } from './pages/Projects'
import { ProjectDetail } from './pages/ProjectDetail'
import { Issues } from './pages/Issues'
import { Sprints } from './pages/Sprints'
import './index.css'
import { ColorModeProvider } from './contexts/ColorModeContext'
import { LocalizationProvider } from '@mui/x-date-pickers'
import { AdapterDateFns } from '@mui/x-date-pickers/AdapterDateFns'
import { SnackbarProvider } from 'notistack'

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: 1,
      staleTime: 5 * 60 * 1000, // 5 minutes
    },
  },
})

function App() {
  return (
    <ColorModeProvider>
      <QueryClientProvider client={queryClient}>
        <AuthProvider>
          <SnackbarProvider maxSnack={3} autoHideDuration={3000} anchorOrigin={{vertical:'bottom',horizontal:'right'}}>
            <LocalizationProvider dateAdapter={AdapterDateFns}>
              <Router>
                <div style={{ minHeight: '100vh' }}>
                  <Routes>
                    <Route path="/login" element={<Login />} />
                    <Route path="/register" element={<Register />} />
                    <Route path="/" element={<Layout />}>
                      <Route index element={<Navigate to="/dashboard" replace />} />
                      <Route path="dashboard" element={<Dashboard />} />
                      <Route path="projects" element={<Projects />} />
                      <Route path="projects/:id" element={<ProjectDetail />} />
                      <Route path="issues" element={<Issues />} />
                      <Route path="sprints" element={<Sprints />} />
                    </Route>
                  </Routes>
                </div>
              </Router>
            </LocalizationProvider>
          </SnackbarProvider>
        </AuthProvider>
        <ReactQueryDevtools initialIsOpen={false} />
      </QueryClientProvider>
    </ColorModeProvider>
  )
}

export default App
