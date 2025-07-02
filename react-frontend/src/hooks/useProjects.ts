import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { projectService } from '../services/projectService'
import type { Project } from '../services/projectService'

export const useProjects = () => {
  const queryClient = useQueryClient()

  // LIST
  const {
    data: projects = [],
    isLoading,
    isError,
    error,
  } = useQuery<Project[], Error>({
    queryKey: ['projects'],
    queryFn: () => projectService.list(),
  })

  // CREATE
  const createMutation = useMutation({
    mutationFn: (payload: Partial<Project>) => projectService.create(payload),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['projects'] })
    },
  })

  // UPDATE
  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: number; data: Partial<Project> }) => projectService.update(id, data),
    onSuccess: (updated) => {
      // optimistically update cache entry for the single project if cached
      queryClient.setQueryData<Project[]>(['projects'], (old) => old?.map((p) => (p.id === updated.id ? updated : p)) ?? [])
    },
  })

  // DELETE
  const deleteMutation = useMutation({
    mutationFn: (id: number) => projectService.remove(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['projects'] })
    },
  })

  return {
    projects,
    isLoading,
    isError,
    error,
    createProject: createMutation.mutate,
    updateProject: updateMutation.mutate,
    deleteProject: deleteMutation.mutate,
  }
} 