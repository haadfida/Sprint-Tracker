import { useState, useEffect } from 'react'
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { projectService } from '../services/projectService'
import type { Project } from '../services/projectService'
import {
  Paper,
  Typography,
  TextField,
  Button,
  Box,
  Drawer,
  Stack,
} from '@mui/material'
import { DataGrid } from '@mui/x-data-grid'
import { DataGridToolbar } from '../components/DataGridToolbar'
import type { GridColDef, GridCellParams } from '@mui/x-data-grid'
import IconButton from '@mui/material/IconButton'
import DeleteIcon from '@mui/icons-material/Delete'
import { format as formatDate, parseISO } from 'date-fns'
import { DatePicker } from '@mui/x-date-pickers'
import { useSnackbar } from 'notistack'
import Fab from '@mui/material/Fab'
import { motion, AnimatePresence } from 'framer-motion'
import { LoaderSkeleton } from '../components/LoaderSkeleton'
import { EmptyState } from '../components/EmptyState'

type ProjectRow = Omit<Project, 'start_date' | 'end_date'> & {
  start_date: string | null
  end_date: string | null
}

export const Projects = () => {
  const queryClient = useQueryClient()
  const { enqueueSnackbar } = useSnackbar()

  const projectsQuery = useQuery({
    queryKey: ['projects'],
    queryFn: () => projectService.list(),
  })

  const createMutation = useMutation({
    mutationFn: (data: Partial<Project>) => projectService.create(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['projects'] })
      enqueueSnackbar('Project created', { variant: 'success' })
    },
  })

  const deleteMutation = useMutation({
    mutationFn: (id: number) => projectService.remove(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['projects'] })
      enqueueSnackbar('Project deleted', { variant: 'info' })
    },
  })

  const [name, setName] = useState('')
  const [startDate, setStartDate] = useState<string | null>(null)
  const [endDate, setEndDate] = useState<string | null>(null)

  const [drawerOpen, setDrawerOpen] = useState(false)
  const [selected, setSelected] = useState<ProjectRow | null>(null)

  const [editName, setEditName] = useState('')
  const [editStart, setEditStart] = useState<string | null>(null)
  const [editEnd, setEditEnd] = useState<string | null>(null)

  useEffect(() => {
    if (selected) {
      setEditName(selected.name)
      setEditStart(selected.start_date)
      setEditEnd(selected.end_date)
    }
  }, [selected])

  const updateMutation = useMutation({
    mutationFn: (payload: Partial<Project>) => projectService.update(selected!.id, payload),
    onSuccess: (updated) => {
      queryClient.setQueryData(['projects'], (old: Project[] | undefined) => {
        if (!old) return old
        return old.map((p) => (p.id === updated.id ? updated : p))
      })
      setSelected(updated as ProjectRow)
      setDrawerOpen(false)
      enqueueSnackbar('Project updated', { variant: 'success' })
    },
  })

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    if (!name.trim()) return
    createMutation.mutate({ name, start_date: startDate || null, end_date: endDate || null })
    setName('')
    setStartDate(null)
    setEndDate(null)
  }

  const columns: GridColDef[] = [
    { field: 'id', headerName: '#', width: 70 },
    { field: 'name', headerName: 'Name', flex: 1 },
    {
      field: 'start_date',
      headerName: 'Start',
      width: 120,
      type: 'date',
      valueGetter: (p: GridCellParams) => {
        const v = p?.value as string | null | undefined
        return v ? parseISO(v) : null
      },
      valueFormatter: (p) => {
        const d = (p as { value?: Date | null })?.value
        return d ? formatDate(d, 'dd/MM/yyyy') : '–'
      },
    },
    {
      field: 'end_date',
      headerName: 'End',
      width: 120,
      type: 'date',
      valueGetter: (p: GridCellParams) => {
        const v = p?.value as string | null | undefined
        return v ? parseISO(v) : null
      },
      valueFormatter: (p) => {
        const d = (p as { value?: Date | null })?.value
        return d ? formatDate(d, 'dd/MM/yyyy') : '–'
      },
    },
    {
      field: 'actions',
      headerName: '',
      width: 60,
      sortable: false,
      renderCell: (params) => (
        <IconButton size="small" onClick={(e)=>{e.stopPropagation();deleteMutation.mutate(params.row.id)}}>
          <DeleteIcon fontSize="small" />
        </IconButton>
      ),
    },
  ]

  return (
    <Box sx={{ px: 2, py: 4 }}>
      <Box sx={{ maxWidth: 800, mx: 'auto' }}>
        <Typography variant="h4" component="h1" gutterBottom>
          Projects
        </Typography>

        {/* Create */}
        <Paper sx={{ p: 3, mb: 4 }} elevation={2} component="form" onSubmit={handleSubmit}>
          <Stack direction={{ xs: 'column', sm: 'row' }} spacing={2} alignItems="center">
            <TextField
              label="Project name"
              sx={{ flexGrow: 1 }}
              value={name}
              onChange={(e) => setName(e.target.value)}
              required
            />
            <DatePicker label="Start date" value={startDate? parseISO(startDate): null} onChange={(d)=>setStartDate(d? formatDate(d,'yyyy-MM-dd'): null)} slotProps={{textField:{fullWidth:false}}} />
            <DatePicker label="End date" value={endDate? parseISO(endDate): null} onChange={(d)=>setEndDate(d? formatDate(d,'yyyy-MM-dd'): null)} slotProps={{textField:{fullWidth:false}}} />
            <Button variant="contained" type="submit" disabled={createMutation.isPending} sx={{ minWidth: 100 }}>
              {createMutation.isPending ? 'Adding…' : 'Add'}
            </Button>
          </Stack>
        </Paper>

        {/* Data grid */}
        {projectsQuery.isLoading ? (
          <LoaderSkeleton />
        ) : (projectsQuery.data?.length ? (
          <Paper elevation={2} sx={{ height: 400, '& .MuiDataGrid-row:hover': { boxShadow: 1, transform: 'scale(1.01)' }, transition: 'all 0.2s' }}>
            <DataGrid
              rows={(projectsQuery.data as ProjectRow[]) ?? []}
              columns={columns}
              disableRowSelectionOnClick
              slots={{ toolbar: DataGridToolbar }}
              onRowClick={(params) => {
                setSelected(params.row as ProjectRow)
                setDrawerOpen(true)
              }}
            />
          </Paper>
        ) : (
          <EmptyState title="No projects yet" description="Start by adding your first project." />
        ))}

        <AnimatePresence>
        {drawerOpen && (
        <Drawer
          anchor="right"
          open={drawerOpen}
          onClose={() => setDrawerOpen(false)}
          PaperProps={{ component: motion.div, sx: { width: { xs: '100%', sm: 420 }, backdropFilter:'blur(12px)', backgroundColor:'rgba(255,255,255,0.75)', position:'relative' }, initial:{x:420}, animate:{x:0}, exit:{x:420}, transition:{type:'spring', stiffness:260, damping:25} }}
        >
          <Box sx={{ p: 3, pb:8 }} component="form" onSubmit={(e)=>{e.preventDefault();updateMutation.mutate({name:editName,start_date:editStart||null,end_date:editEnd||null})}}>
            <Typography variant="h6" gutterBottom>Edit Project</Typography>

            <Stack spacing={2}>
              <TextField label="Name" value={editName} onChange={(e)=>setEditName(e.target.value)} required fullWidth />
              <DatePicker label="Start date" value={editStart? parseISO(editStart): null} onChange={(d)=>setEditStart(d? formatDate(d,'yyyy-MM-dd'): null)} slotProps={{textField:{fullWidth:true}}} />
              <DatePicker label="End date" value={editEnd? parseISO(editEnd): null} onChange={(d)=>setEditEnd(d? formatDate(d,'yyyy-MM-dd'): null)} slotProps={{textField:{fullWidth:true}}} />

              <Stack direction="row" spacing={2} justifyContent="flex-end">
                <Button onClick={()=>setDrawerOpen(false)} color="inherit">Cancel</Button>
                <Button type="submit" variant="contained" disabled={updateMutation.isPending}>Save</Button>
              </Stack>
            </Stack>

            <Fab size="small" color="error" sx={{ position:'absolute', bottom:16, right:16 }} onClick={()=>{ if(selected) deleteMutation.mutate(selected.id); setDrawerOpen(false) }}>
              <DeleteIcon />
            </Fab>
          </Box>
        </Drawer>
         )}
         </AnimatePresence>
      </Box>
    </Box>
  )
}

// unused helper removed 