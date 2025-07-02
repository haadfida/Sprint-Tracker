import { Box, Typography, Button } from '@mui/material'
import type { ReactNode } from 'react'
import AddIcon from '@mui/icons-material/Add'

interface Props {
  title: string
  description?: string
  actionLabel?: string
  onAction?: () => void
  icon?: ReactNode
}

export const EmptyState = ({ title, description, actionLabel, onAction, icon }: Props) => {
  return (
    <Box sx={{ textAlign:'center', py:6, px:2, color:'text.secondary' }}>
      {icon && <Box sx={{ fontSize:64, mb:2, color:'primary.main' }}>{icon}</Box>}
      <Typography variant="h6" gutterBottom>{title}</Typography>
      {description && <Typography variant="body2" sx={{ mb:2 }}>{description}</Typography>}
      {actionLabel && onAction && <Button variant="contained" startIcon={<AddIcon />} onClick={onAction}>{actionLabel}</Button>}
    </Box>
  )
} 