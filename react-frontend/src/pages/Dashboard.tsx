import { useAuth } from '../contexts/AuthContext'
import { Box, Typography, Stack, Paper } from '@mui/material'
import { motion, useScroll, useTransform } from 'framer-motion'
import { useIssuesApi } from '../hooks/useIssues'
import { useSprintsApi } from '../hooks/useSprints'
import { useQuery } from '@tanstack/react-query'
import { projectService } from '../services/projectService'
import { ChartsSection } from '../components/ChartsSection'
import FolderOpenOutlinedIcon from '@mui/icons-material/FolderOpenOutlined'
import BugReportOutlinedIcon from '@mui/icons-material/BugReportOutlined'
import FlagOutlinedIcon from '@mui/icons-material/FlagOutlined'

export const Dashboard = () => {
  const { user } = useAuth()
  const { issues } = useIssuesApi()
  const { activeCount } = useSprintsApi()
  const projectsQuery = useQuery({ queryKey:['projects'], queryFn:()=> projectService.list() })
  const projectsCount = projectsQuery.data?.length ?? 0

  // Parallax effect based on scroll
  const { scrollY } = useScroll()
  const y1 = useTransform(scrollY, [0, 400], [0, -100])

  const openIssues = issues.filter(i => !['CLOSED','RESOLVED','closed','resolved','Closed','Resolved'].includes(i.status.toString()))

  return (
    <Box>
      {/* Hero */}
      <Box sx={{ position:'relative', height:{ xs: 260, md: 360 }, overflow:'hidden' }}>
        <motion.div
          style={{
            y: y1,
            height:'120%',
            width:'100%',
            backgroundImage:'url(https://images.unsplash.com/photo-1506784983877-45594efa4cbe?auto=format&fit=crop&w=1800&q=80)',
            backgroundSize:'cover',
            backgroundPosition:'center',
          }}
        />

        <Box sx={{ position:'absolute', inset:0, bgcolor:'rgba(0,0,0,0.25)' }} />

        <Stack sx={{ position:'absolute', inset:0 }} alignItems="center" justifyContent="center" spacing={1}>
          <Typography variant="h3" sx={{ color:'#fff', fontWeight:700 }} component={motion.h1} initial={{ opacity:0, y:20 }} animate={{ opacity:1, y:0 }} transition={{ duration:0.6 }}>
            Welcome, {user?.name}
          </Typography>
          <Typography variant="h6" sx={{ color:'#e0e0e0' }} component={motion.p} initial={{ opacity:0, y:20 }} animate={{ opacity:1, y:0 }} transition={{ duration:0.8 }}>
            Your project management cockpit
          </Typography>
        </Stack>
      </Box>

      {/* Stats */}
      <Stack direction={{ xs:'column', md:'row' }} spacing={3} sx={{ mt:-6, px:3, position:'relative', zIndex:1 }}>
        {[
          { label:'Active Projects', value: projectsCount, color:'#7c3aed', icon:<FolderOpenOutlinedIcon /> },
          { label:'Open Issues', value: openIssues.length, color:'#3b82f6', icon:<BugReportOutlinedIcon /> },
          { label:'Active Sprints', value: activeCount, color:'#10b981', icon:<FlagOutlinedIcon /> },
        ].map(({ label, value, color, icon })=> (
          <Paper key={label} sx={{ flex:1, p:3, display:'flex', alignItems:'center', gap:2, transition:'transform .2s', '&:hover':{ transform:'translateY(-4px)', boxShadow:6 } }} elevation={3}>
            <Box sx={{ width:48, height:48, borderRadius:'50%', bgcolor:color, display:'flex', alignItems:'center', justifyContent:'center', color:'#fff' }}>
              {icon}
            </Box>
            <Box>
              <Typography variant="subtitle2" color="text.secondary" sx={{ letterSpacing:.5 }}>{label}</Typography>
              <Typography variant="h5" fontWeight={600}>{value}</Typography>
            </Box>
          </Paper>
        ))}
      </Stack>

      <ChartsSection />
    </Box>
  )
} 