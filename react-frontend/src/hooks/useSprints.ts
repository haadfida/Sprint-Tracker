import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { sprintService } from '../services/sprintService'
import type { Sprint } from '../services/sprintService'

export const useSprintsApi = (filter?: { project_id?: number }) => {
  const queryClient = useQueryClient()

  const {
    data: sprints = [],
    isLoading,
    isError,
    error,
  } = useQuery<Sprint[], Error>({
    queryKey: ['sprints', filter],
    queryFn: () => sprintService.list(filter),
  })

  const createMutation = useMutation({
    mutationFn: (payload: Partial<Sprint>) => sprintService.create(payload),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['sprints'] })
    },
  })

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: number; data: Partial<Sprint> }) => sprintService.update(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['sprints'] })
    },
  })

  const deleteMutation = useMutation({
    mutationFn: (id: number) => sprintService.remove(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['sprints'] })
    },
  })

  const activeCount = sprints.filter((s) => s.status !== 'CLOSED').length

  return {
    sprints,
    activeCount,
    isLoading,
    isError,
    error,
    createSprint: createMutation.mutate,
    updateSprint: updateMutation.mutate,
    deleteSprint: deleteMutation.mutate,
  }
} 