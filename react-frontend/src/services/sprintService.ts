import api from './apiClient'

export interface Sprint {
  id: number
  name: string
  description: string | null
  start_date: string | null
  end_date: string | null
  status: string
  project_id: number | null
}

class SprintService {
  async list(filter?: { project_id?: number }): Promise<Sprint[]> {
    const { data } = await api.get<Sprint[]>('/sprints', { params: filter })
    return data
  }

  async create(payload: Partial<Sprint>): Promise<Sprint> {
    const { data } = await api.post<Sprint>('/sprints', { sprint: payload })
    return data
  }

  async update(id: number, payload: Partial<Sprint>): Promise<Sprint> {
    const { data } = await api.put<Sprint>(`/sprints/${id}`, { sprint: payload })
    return data
  }

  async remove(id: number): Promise<void> {
    await api.delete(`/sprints/${id}`)
  }

  async show(id: number): Promise<Sprint> {
    const { data } = await api.get<Sprint>(`/sprints/${id}`)
    return data
  }
}

export const sprintService = new SprintService() 