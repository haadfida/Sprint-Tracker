import api from './apiClient'

export interface Issue {
  id: number
  title: string
  description: string
  status: string
  priority: string
  category: string
  estimated_time: number | null
  project_id: number | null
  sprint_id: number | null
}

class IssueService {
  async list(): Promise<Issue[]> {
    const { data } = await api.get<Issue[]>('/issues')
    return data
  }

  async create(payload: Partial<Issue>): Promise<Issue> {
    const { data } = await api.post<Issue>('/issues', { issue: payload })
    return data
  }

  async update(id: number, payload: Partial<Issue>): Promise<Issue> {
    const { data } = await api.put<Issue>(`/issues/${id}`, { issue: payload })
    return data
  }

  async remove(id: number): Promise<void> {
    await api.delete(`/issues/${id}`)
  }

  async show(id: number): Promise<Issue> {
    const { data } = await api.get<Issue>(`/issues/${id}`)
    return data
  }
}

export const issueService = new IssueService() 