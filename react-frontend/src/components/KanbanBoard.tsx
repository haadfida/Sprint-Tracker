/* eslint-disable @typescript-eslint/no-explicit-any */
import { DragDropContext, Droppable, Draggable } from '@hello-pangea/dnd'
import type { DropResult, DroppableProvided, DroppableStateSnapshot, DraggableProvided, DraggableStateSnapshot } from '@hello-pangea/dnd'
import { Paper, Box, Typography, Stack, CircularProgress, Fab } from '@mui/material'
import { motion } from 'framer-motion'
import { useIssuesApi } from '../hooks/useIssues'
import type { Issue } from '../services/issueService'
import { useState } from 'react'
import { AddIssueDialog } from './AddIssueDialog'
import AddIcon from '@mui/icons-material/Add'

type Column = {
  id: StatusKey
  title: string
  color: string
  tasks: Issue[]
}

type StatusKey = 'open' | 'in_progress' | 'closed'

export const KanbanBoard = () => {
  const { issues, updateIssue, isLoading } = useIssuesApi()

  const statusMap: Record<StatusKey, string> = {
    open: '#64748b',
    in_progress: '#3b82f6',
    closed: '#10b981',
  }

  const normalized = (s: string) => s.toLowerCase().replace(/\s+/g, '_')

  const columns: Column[] = [
    { id:'open', title:'Open', color: statusMap.open, tasks: issues.filter(i=> normalized(i.status)==='open') },
    { id:'in_progress', title:'In Progress', color: statusMap.in_progress, tasks: issues.filter(i=> normalized(i.status)==='in_progress') },
    { id:'closed', title:'Closed', color: statusMap.closed, tasks: issues.filter(i=> ['closed','resolved'].includes(normalized(i.status))) },
  ]

  const onDragEnd = (result: DropResult) => {
    const { destination, draggableId, source } = result
    if (!destination) return
    const from = source.droppableId as StatusKey
    const to = destination.droppableId as StatusKey
    if (from === to) return
    const id = Number(draggableId)
    updateIssue({ id, data: { status: to } })
  }

  const [dialogOpen, setDialogOpen] = useState(false)

  if (isLoading) {
    return <Box sx={{ display:'flex', justifyContent:'center', mt:4 }}><CircularProgress /></Box>
  }

  return (
    <DragDropContext onDragEnd={onDragEnd}>
      <Stack direction={{ xs:'column', md:'row' }} spacing={3}>
        {columns.map((col) => (
          <Droppable droppableId={col.id} key={col.id}>
            {(provided: DroppableProvided, snapshot: DroppableStateSnapshot) => (
              <Paper ref={provided.innerRef} {...provided.droppableProps} sx={{ flex:1, p:2, bgcolor:snapshot.isDraggingOver? 'action.hover': 'background.paper', minHeight:300 }} elevation={3}>
                <Stack direction="row" alignItems="center" spacing={1} mb={2}>
                  <Box sx={{ width:10, height:10, borderRadius:'50%', bgcolor:col.color }} />
                  <Typography variant="subtitle1" fontWeight={600}>{col.title}</Typography>
                </Stack>

                {col.tasks.map((t, idx) => (
                  <Draggable draggableId={String(t.id)} index={idx} key={t.id}>
                    {(prov: DraggableProvided, snap: DraggableStateSnapshot) => (
                      <motion.div
                        ref={prov.innerRef}
                        {...(prov.draggableProps as any)}
                        {...(prov.dragHandleProps as any)}
                        style={{ userSelect:'none', marginBottom:8, ...prov.draggableProps.style }}
                        whileHover={{ scale:1.02 }}
                        whileTap={{ scale:0.98 }}
                      >
                        <motion.div whileHover={{ rotateX:2, rotateY:-2, transition:{ type:'spring', stiffness:120, damping:10 } }} style={{ perspective:600 }}>
                          <Paper sx={{ p:2, cursor:'grab', transformStyle:'preserve-3d' }} elevation={snap.isDragging?6:1}>{t.title}</Paper>
                        </motion.div>
                      </motion.div>
                    )}
                  </Draggable>
                ))}
                {provided.placeholder}
              </Paper>
            )}
          </Droppable>
        ))}
      </Stack>
      <Fab color="primary" sx={{ position:'fixed', bottom:32, right:32 }} onClick={()=>setDialogOpen(true)}>
        <AddIcon />
      </Fab>

      <AddIssueDialog open={dialogOpen} onClose={()=>setDialogOpen(false)} />
    </DragDropContext>
  )
} 