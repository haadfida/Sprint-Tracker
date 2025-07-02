import { format } from 'date-fns'
import api from './apiClient'

export interface Project {
  id: number
  name: string
  start_date: string | null
  end_date: string | null
  manager_id: number | null
}

class ProjectService {
  async list(): Promise<Project[]> {
    const { data } = await api.get<Project[]>('/projects')
    return data
  }

  async create(data: Partial<Project>): Promise<Project> {
    const payload = convertDates(data)
    const { data: project } = await api.post<Project>('/projects', { project: payload })
    return project
  }

  async update(id: number, data: Partial<Project>): Promise<Project> {
    const { data: project } = await api.put<Project>(`/projects/${id}`, { project: convertDates(data) })
    return project
  }

  async remove(id: number): Promise<void> {
    await api.delete(`/projects/${id}`)
  }

  async show(id: number): Promise<Project> {
    const { data } = await api.get<Project>(`/projects/${id}`)
    return data
  }
}

export const projectService = new ProjectService()

function convertDates(data: Partial<Project>): Partial<Project> {
  const copy: Record<string, unknown> = { ...data }
  ;['start_date', 'end_date'].forEach((key) => {
    const v = copy[key] as unknown
    if (v === '') copy[key] = null
    if (v instanceof Date) {
      copy[key] = `${format(v, 'yyyy-MM-dd')}T00:00:00Z`
    } else if (typeof v === 'string' && v) {
      // Convert dd/MM/yyyy -> yyyy-MM-dd if needed
      let iso = v
      const m = v.match(/^(\d{2})\/(\d{2})\/(\d{4})$/)
      if (m) iso = `${m[3]}-${m[2]}-${m[1]}`
      copy[key] = `${iso}T00:00:00Z`
    }
  })
  return copy
} 