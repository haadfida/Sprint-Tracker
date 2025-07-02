import { useState } from 'react'
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Button,
  MenuItem,
  Stack,
} from '@mui/material'
import { useProjects } from '../hooks/useProjects'
import { useIssuesApi } from '../hooks/useIssues'

interface Props {
  open: boolean
  onClose: () => void
}

export const AddIssueDialog = ({ open, onClose }: Props) => {
  const { projects, isLoading: loadingProjects } = useProjects()
  const { createIssue, isLoading: creating } = useIssuesApi()

  const [title, setTitle] = useState('')
  const [description, setDescription] = useState('')
  const [projectId, setProjectId] = useState<number | ''>('')

  const canSubmit = title.trim() && description.trim() && projectId !== '' && !creating

  const handleSubmit = () => {
    if (!canSubmit) return
    createIssue({
      title: title.trim(),
      description: description.trim(),
      project_id: projectId as number,
      status: 'open',
      priority: 'medium',
      category: 'feature',
    })
    setTitle('')
    setDescription('')
    setProjectId('')
    onClose()
  }

  return (
    <Dialog open={open} onClose={onClose} fullWidth maxWidth="sm">
      <DialogTitle>Create Issue</DialogTitle>
      <DialogContent>
        <Stack spacing={2} mt={1}>
          <TextField label="Title" value={title} onChange={(e)=>setTitle(e.target.value)} fullWidth required />
          <TextField label="Description" value={description} onChange={(e)=>setDescription(e.target.value)} fullWidth multiline rows={4} required />
          <TextField
            select
            label="Project"
            value={projectId}
            onChange={(e)=> setProjectId(Number(e.target.value))}
            fullWidth
            disabled={loadingProjects}
            required
          >
            {projects.map(p=> (
              <MenuItem key={p.id} value={p.id}>{p.name}</MenuItem>
            ))}
          </TextField>
        </Stack>
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose}>Cancel</Button>
        <Button variant="contained" onClick={handleSubmit} disabled={!canSubmit}>Create</Button>
      </DialogActions>
    </Dialog>
  )
} 