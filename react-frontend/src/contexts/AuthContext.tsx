import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react'
import { authService } from '../services/authService'

interface User {
  id: number
  email: string
  name: string
  company_id: number
  role_id: number
}

interface AuthContextType {
  user: User | null
  login: (email: string, password: string) => Promise<void>
  logout: () => void
  register: (userData: RegisterData) => Promise<void>
  loading: boolean
}

interface RegisterData {
  name: string
  email: string
  password: string
  password_confirmation: string
  phone_num: string
  company_attributes: {
    name: string
    subdomain: string
  }
}

const AuthContext = createContext<AuthContextType | undefined>(undefined)

export const useAuth = () => {
  const context = useContext(AuthContext)
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider')
  }
  return context
}

interface AuthProviderProps {
  children: ReactNode
}

export const AuthProvider: React.FC<AuthProviderProps> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    // Check if user is already logged in
    const checkAuth = async () => {
      try {
        const currentUser = await authService.getCurrentUser()
        setUser(currentUser)
      } catch (error) {
        console.log('Not authenticated')
      } finally {
        setLoading(false)
      }
    }

    checkAuth()
  }, [])

  const login = async (email: string, password: string) => {
    const userData = await authService.login(email, password)
    setUser(userData)
  }

  const logout = () => {
    authService.logout()
    setUser(null)
  }

  const register = async (userData: RegisterData) => {
    const newUser = await authService.register(userData)
    setUser(newUser)
  }

  const value = {
    user,
    login,
    logout,
    register,
    loading
  }

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
} 