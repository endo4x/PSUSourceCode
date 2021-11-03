import styles from "./DashboardPage.module.css"
import Sidebar from "../sidebar"

const DashboardPage = (props) => {
  return (
    <div className={styles.dashboardPage}>
      <Sidebar>
        <Sidebar.Link href="/dashboard">Home</Sidebar.Link>
        <Sidebar.Link href="/obfuscate">Obfuscate</Sidebar.Link>
      </Sidebar>
      <div className={styles.dashboardContent}>
        <div className={styles.dashboardContainer}>
          {props.children}
        </div>
      </div>
    </div>
  )
}

export default DashboardPage;
