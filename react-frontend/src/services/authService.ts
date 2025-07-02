interface User {
  id: number
  email: string
  name: string
  company_id: number
  role_id: number
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

class AuthService {
  private baseUrl = 'http://localhost:3000'

  async login(email: string, password: string): Promise<User> {
    const response = await fetch(`${this.baseUrl}/accounts/sign_in`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      credentials: 'include',
      body: JSON.stringify({ user: { email, password } }),
    })

    if (!response.ok) {
      throw new Error('Login failed')
    }

    return response.json()
  }

  async register(data: RegisterData): Promise<User> {
    const response = await fetch(`${this.baseUrl}/accounts`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      credentials: 'include',
      body: JSON.stringify({ user: data }),
    })

    if (!response.ok) {
      throw new Error('Registration failed')
    }

    return response.json()
  }

  async logout(): Promise<void> {
    await fetch(`${this.baseUrl}/accounts/sign_out`, {
      method: 'DELETE',
      headers: {
        'Accept': 'application/json',
      },
      credentials: 'include',
    })
  }

  async getCurrentUser(): Promise<User | null> {
    try {
      const response = await fetch(`${this.baseUrl}/api/me`, {
        headers: {
          'Accept': 'application/json',
        },
        credentials: 'include',
      })

      if (!response.ok) {
        return null
      }

      return response.json()
    } catch {
      return null
    }
  }
}

export const authService = new AuthService()
export type { User, RegisterData } 