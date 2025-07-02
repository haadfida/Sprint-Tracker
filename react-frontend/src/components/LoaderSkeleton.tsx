import { Stack, Skeleton, Paper } from '@mui/material'

export const LoaderSkeleton = () => (
  <Stack spacing={2}>
    {Array.from({ length: 3 }).map((_, i)=>(
      <Paper key={i} sx={{ p:2 }}>
        <Skeleton variant="text" width="40%" height={32} />
        <Skeleton variant="rectangular" height={120} sx={{ mt:1 }} />
      </Paper>
    ))}
  </Stack>
) 