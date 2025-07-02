import { useParams, useNavigate } from 'react-router-dom'
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { projectService } from '../services/projectService'
import type { Project } from '../services/projectService'
import { useState, useEffect } from 'react'

export const ProjectDetail = () => {
  const { id } = useParams<{ id: string }>()
  const projectId = Number(id)
  const navigate = useNavigate()
  const queryClient = useQueryClient()

  const { data: project, isLoading, error } = useQuery<Project, Error>({
    queryKey: ['project', projectId],
    queryFn: () => projectService.show(projectId),
  })

  const updateMutation = useMutation({
    mutationFn: (payload: Partial<Project>) => projectService.update(projectId, payload),
    onSuccess: (updated) => {
      queryClient.setQueryData(['project', projectId], updated)
      queryClient.invalidateQueries({ queryKey: ['projects'] })
    },
  })

  const deleteMutation = useMutation({
    mutationFn: () => projectService.remove(projectId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['projects'] })
      navigate('/projects')
    },
  })

  // local form state
  const [name, setName] = useState('')
  const [startDate, setStartDate] = useState('')
  const [endDate, setEndDate] = useState('')

  useEffect(() => {
    if (project) {
      setName(project.name)
      setStartDate(project.start_date ?? '')
      setEndDate(project.end_date ?? '')
    }
  }, [project])

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    updateMutation.mutate({ name, start_date: startDate || null, end_date: endDate || null })
  }

  if (isLoading) return <p className="p-4">Loading…</p>
  if (error) return <p className="p-4 text-red-600">{error.message}</p>

  return (
    <div className="px-4 py-6 sm:px-0 max-w-3xl mx-auto">
      <h1 className="text-3xl font-bold text-gray-900 mb-6">Edit Project</h1>

      <form onSubmit={handleSubmit} className="space-y-4 bg-white shadow p-6 rounded">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Name</label>
          <input
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            className="mt-1 block w-full border rounded px-3 py-2"
            required
          />
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Start Date</label>
            <input
              type="date"
              value={startDate ?? ''}
              onChange={(e) => setStartDate(e.target.value)}
              className="mt-1 block w-full border rounded px-3 py-2"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">End Date</label>
            <input
              type="date"
              value={endDate ?? ''}
              onChange={(e) => setEndDate(e.target.value)}
              className="mt-1 block w-full border rounded px-3 py-2"
            />
          </div>
        </div>

        <div className="flex items-center space-x-2 pt-4">
          <button
            type="submit"
            className="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded"
            disabled={updateMutation.isPending}
          >
            {updateMutation.isPending ? 'Saving…' : 'Save'}
          </button>

          <button
            type="button"
            className="text-red-600 hover:text-red-800 ml-auto"
            onClick={() => deleteMutation.mutate()}
            disabled={deleteMutation.isPending}
          >
            {deleteMutation.isPending ? 'Deleting…' : 'Delete'}
          </button>
        </div>
      </form>
    </div>
  )
} 