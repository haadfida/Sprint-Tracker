import { Paper, Typography, Stack } from '@mui/material'
import { ResponsiveContainer, LineChart, Line, CartesianGrid, XAxis, YAxis, Tooltip, BarChart, Bar } from 'recharts'
import { useIssuesApi } from '../hooks/useIssues'
import { useSprintsApi } from '../hooks/useSprints'

export const ChartsSection = () => {
  const { issues } = useIssuesApi()
  const { sprints } = useSprintsApi()

  // generate simple burndown mock: 7 days linear from total to done
  const days = 7
  const total = issues.length
  const done = issues.filter(i=> ['CLOSED','RESOLVED','closed','resolved','Closed','Resolved'].includes(i.status.toString())).length
  const openAtStart = total
  const burndownData = Array.from({ length: days }, (_, i) => {
    const remaining = Math.round(openAtStart - ((openAtStart - done) / (days - 1)) * i)
    return { day: `Day ${i + 1}`, remaining }
  })

  // velocity: tasks done per sprint (mock distribution)
  const velocityData = sprints.map((s) => {
    const completed = issues.filter((i)=> i.sprint_id === s.id && ['CLOSED','RESOLVED','closed','resolved','Closed','Resolved'].includes(i.status.toString())).length
    return { name: s.name ?? `S${s.id}`, completed }
  })

  return (
    <Stack spacing={3} mt={6}>
      <Paper elevation={2} sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>Burndown (tasks remaining)</Typography>
        <ResponsiveContainer width="100%" height={250}>
          <LineChart data={burndownData} margin={{ top: 10, right: 20, left: 0, bottom: 0 }}>
            <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
            <XAxis dataKey="day" />
            <YAxis allowDecimals={false} />
            <Tooltip />
            <Line type="monotone" dataKey="remaining" stroke="#7c3aed" strokeWidth={3} dot={{ r: 4 }} isAnimationActive />
          </LineChart>
        </ResponsiveContainer>
      </Paper>

      <Paper elevation={2} sx={{ p: 2 }}>
        <Typography variant="h6" gutterBottom>Velocity (tasks per sprint)</Typography>
        <ResponsiveContainer width="100%" height={250}>
          <BarChart data={velocityData} margin={{ top: 10, right: 20, left: 0, bottom: 0 }}>
            <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
            <XAxis dataKey="name" />
            <YAxis allowDecimals={false} />
            <Tooltip />
            <Bar dataKey="completed" fill="#14b8a6" isAnimationActive />
          </BarChart>
        </ResponsiveContainer>
      </Paper>
    </Stack>
  )
} 