import { useState, useEffect } from "react"
import styles from "./Toggle.module.css"
// This could probably be made prettier, but for now I just want it to function

const Toggle = (props) => {
  const [active, setActive] = useState(!!props.active)

  const toggleActive = () => {
    console.log("Toggling active")
    setActive(!active)

    if(props.onClick) {
      props.onClick(!active)
    }
  }

  useEffect(() => {
    setActive(props.active)
  }, [props.active])

  const buttonClasses = styles.toggleButton + (active ? ` ${styles.active}` : "")

  return (
    <div
      className={styles.mainContainer}
      onClick={toggleActive}
    >
      <span className={styles.buttonTitle}>{props.children}</span>
      <button
        className={buttonClasses}
        aria-label="toggle button"
      />
    </div>
  )
}

export default Toggle;
