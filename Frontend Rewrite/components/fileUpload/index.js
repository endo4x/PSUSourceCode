import { useState } from 'react'
import styles from "./FileUpload.module.css"
export default function FileUpload(props) {
  const [buttonText, setButtonText] = useState("Select File")

  const onFileUpload = async (e) => {
    const item = e.target.files.item(0)

    console.log(item)

    let fileName = item.name

    if (fileName.length > 15) {
      fileName = fileName.substr(0, 15) + "..."
    }

    setButtonText(fileName)
    
    console.log(await item.text())
  }

  return (
    <div className={styles.container}>
      {props.children}
      <div className={styles.inputContainer}>
        {/* I know this is horrible, but it's the only way to make it aria friendly and customizable */}
        <input onChange={onFileUpload} className={styles.input} type="file" id="file_upload" />
        <label className={styles.actualButton} htmlFor="file_upload"><span>{buttonText}</span></label>
      </div>
    </div>
  )
}
