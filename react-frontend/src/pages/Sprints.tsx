/* eslint-disable @typescript-eslint/no-explicit-any */
import { useState } from 'react'
import { Box, Paper, Stack, TextField, Button, Typography, MenuItem } from '@mui/material'
import { DatePicker } from '@mui/x-date-pickers'
import { DataGrid, type GridColDef } from '@mui/x-data-grid'
import { useSprintsApi } from '../hooks/useSprints'
import { useProjects } from '../hooks/useProjects'
import { format as formatDate, parseISO } from 'date-fns'
import { DataGridToolbar } from '../components/DataGridToolbar'
import { LoaderSkeleton } from '../components/LoaderSkeleton'
import { EmptyState } from '../components/EmptyState'

export const Sprints = () => {
  const { sprints, createSprint, isLoading } = useSprintsApi()
  const { projects } = useProjects()

  const [name, setName] = useState('')
  const [start, setStart] = useState<string | null>(null)
  const [end, setEnd] = useState<string | null>(null)
  const [projectId, setProjectId] = useState<number | ''>('')

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    if (!name.trim() || !start || !end || projectId==='') return
    createSprint({ name: name.trim(), start_date: start, end_date: end, project_id: projectId })
    setName('')
    setStart(null)
    setEnd(null)
    setProjectId('')
  }

  const rows = sprints.map((s, idx) => ({ id: s.id, seq: idx + 1, name: s.name, start: s.start_date, end: s.end_date }))

  const columns: GridColDef[] = [
    { field: 'seq', headerName: '#', width: 70 },
    { field: 'name', headerName: 'Name', flex: 1 },
    { field: 'start', headerName: 'Start', width: 120, valueFormatter: (p:any)=> p?.value ? formatDate(parseISO(p.value as string),'dd/MM/yyyy'): '–' },
    { field: 'end', headerName: 'End', width: 120, valueFormatter: (p:any)=> p?.value ? formatDate(parseISO(p.value as string),'dd/MM/yyyy'): '–' },
  ]

  return (
    <Box sx={{ px:2, py:4 }}>
      <Typography variant="h4" gutterBottom>Sprints</Typography>

      <Paper elevation={2} sx={{ p:3, mb:4 }} component="form" onSubmit={handleSubmit}>
        <Stack direction={{ xs:'column', sm:'row' }} spacing={2} alignItems="center">
          <TextField label="Name" sx={{ flexGrow:1 }} value={name} onChange={(e)=>setName(e.target.value)} required />
          <DatePicker label="Start" value={start? parseISO(start): null} onChange={(d)=> setStart(d? formatDate(d,'yyyy-MM-dd'): null)} slotProps={{textField:{fullWidth:false}}} />
          <DatePicker label="End" value={end? parseISO(end): null} onChange={(d)=> setEnd(d? formatDate(d,'yyyy-MM-dd'): null)} slotProps={{textField:{fullWidth:false}}} />
          <TextField select label="Project" value={projectId} onChange={(e)=>setProjectId(Number(e.target.value))} sx={{ minWidth:140 }} required>
            {projects.map(p=> (<MenuItem key={p.id} value={p.id}>{p.name}</MenuItem>))}
          </TextField>
          <Button variant="contained" size="large" sx={{ minWidth:120 }} type="submit" disabled={!name.trim() || !start || !end || projectId===''}>Add</Button>
        </Stack>
      </Paper>

      {isLoading ? (
        <LoaderSkeleton />
      ) : rows.length ? (
        <Paper elevation={2} sx={{ height: 400 }}>
          <DataGrid rows={rows} columns={columns} hideFooter disableRowSelectionOnClick slots={{ toolbar: DataGridToolbar }} />
        </Paper>
      ) : (
        <EmptyState title="No sprints yet" description="Create your first sprint to get started." />
      )}
    </Box>
  )
} 