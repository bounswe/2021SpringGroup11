import Button from "@mui/material/Button";
import CssBaseline from "@mui/material/CssBaseline";

export function App() {
  return (
    <>
      <CssBaseline />
      <h1>Hello world!</h1>
      <Button
        sx={{
          color: "yellow",
          ":hover": {
            backgroundColor: "red",
          },
        }}
        variant="contained"
      >
        Hello World
      </Button>
    </>
  );
}
