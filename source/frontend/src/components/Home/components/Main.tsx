import { makeStyles, styled } from '@mui/styles';
import React = require('react');
import { Tab, Tabs } from '@mui/material';
import HomeTabPanel from './HomeTabPanel';
import { items } from '../constants';
interface Props {}
interface StyledTabProps {
  label: string;
}
interface TabPanelProps {
  children?: React.ReactNode;
  index: number;
  value: number;
}

const useStyles = makeStyles(() => ({
  root: {
    display: 'flex',
    flexDirection: 'row',
    height: '100%',
    width: '80%',
  },
  tabs: {
    display: 'inline-block',
    height: '100%',
    width: '15%',
    background: '#70A9FF',
  },
  panels: {
    display: 'inline-block',
    width: '85%',
  },
}));

const TabPanel = (props: TabPanelProps) => {
  const { children, value, index, ...other } = props;

  //TODO FIX THE ITEMS

  return (
    <div
      style={{ height: '100%' }}
      role="tabpanel"
      hidden={value !== index}
      id={`vertical-tabpanel-${index}`}
      aria-labelledby={`vertical-tab-${index}`}
      {...other}
    >
      {value === index && <HomeTabPanel items={items[index]} />}
    </div>
  );
};

const StyledTab = styled((props: StyledTabProps) => <Tab disableRipple {...props} />)(() => ({
  textTransform: 'none',
  fontSize: 20,
  marginBottom: '20px',
  color: '#219653',
  '&.Mui-selected': {
    color: '#fff',
  },
  '&.Mui-focusVisible': {
    backgroundColor: 'rgba(100, 95, 228, 0.32)',
  },
}));

const a11yProps = (index: number) => {
  return {
    id: `vertical-tab-${index}`,
    'aria-controls': `vertical-tabpanel-${index}`,
  };
};

const Main = (props: Props) => {
  const classes = useStyles();

  const [value, setValue] = React.useState(0);
  const handleChange = (event: React.SyntheticEvent, newValue: number) => {
    setValue(newValue);
  };

  return (
    <div className={classes.root}>
      <div className={classes.tabs}>
        <Tabs
          orientation="vertical"
          variant="scrollable"
          value={value}
          textColor={'secondary'}
          onChange={handleChange}
        >
          <StyledTab label="Popular" {...a11yProps(0)} />
          <StyledTab label="For You" {...a11yProps(1)} />
          <StyledTab label="New" {...a11yProps(2)} />
        </Tabs>
      </div>
      <div className={classes.panels}>
        <TabPanel value={value} index={0} />
        <TabPanel value={value} index={1} />
        <TabPanel value={value} index={2} />
      </div>
    </div>
  );
};

export default Main;
