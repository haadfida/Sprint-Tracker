import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { issueService } from '../services/issueService'
import type { Issue } from '../services/issueService'

export const useIssuesApi = () => {
  const queryClient = useQueryClient()

  const {
    data: issues = [],
    isLoading,
    isError,
    error,
  } = useQuery<Issue[], Error>({
    queryKey: ['issues'],
    queryFn: () => issueService.list(),
  })

  const createMutation = useMutation({
    mutationFn: (payload: Partial<Issue>) => issueService.create(payload),
    onSuccess: (created) => {
      // optimistically append to cache to avoid refetch delay
      queryClient.setQueryData<Issue[]>(['issues'], (old) => (old ? [...old, created] : [created]))
    },
  })

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: number; data: Partial<Issue> }) => issueService.update(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['issues'] })
    },
  })

  const deleteMutation = useMutation({
    mutationFn: (id: number) => issueService.remove(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['issues'] })
    },
  })

  return {
    issues,
    isLoading,
    isError,
    error,
    createIssue: createMutation.mutate,
    updateIssue: updateMutation.mutate,
    deleteIssue: deleteMutation.mutate,
  }
} 