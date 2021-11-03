import beautify from "json-beautify"
import JsonTextbox from "../components/jsonInput"
import styles from "../styles/Obfuscate.module.css"
import { useState, useEffect } from "react"
import DashboardPage from "../components/dashboardPage"
import Button from "../components/button"
import Toggle from "../components/toggle"
import Select from "../components/select"
import FileUpload from "../components/fileUpload"

const Obfuscate = () => {
  const selectOptions = [
    { value: "Default", label: "Default"},
    { value: "Chinese", label: "Chinese"},
    { value: "Arabic", label: "Arabic"},
    { value: "Korean", label: "Korean"},
    { value: "Emoji", label: "Emoji"},
    { value: "Emoji 2", label: "Emoji 2"},
    { value: "Greek", label: "Greek"},
    { value: "Symbols 1", label: "Symbols 1"},
    { value: "Symbols 2", label: "Symbols 2"},
    { value: "Symbols 3", label: "Symbols 3"}
   ]

  const [premiumOutput, setPremiumOutput] = useState(true)
  const [enhancedOutput, setEnhancedOutput] = useState(false)
  const [maximumSecurity, setMaximumSecurity] = useState(false)
  const [noSuperOperators, setNoSuperOperators] = useState(false)
  const [disableMacros, setDisableMacros] = useState(false)
  const [compressOutput, setCompressOutput] = useState(false)
  const [byteCode, setByteCode] = useState({value: "Default", label: "Default"})
  const [scriptText, setScriptText] = useState("")
  const [editorText, setEditorText] = useState("")

  // This is just to trigger a rerender when the editor is loaded
  const [_, setEditorLoaded] = useState(false)

  const getRequestObj = () => ({
    PremiumOutput: premiumOutput,
    EnhancedOutput: enhancedOutput,
    MaximumSecurity: maximumSecurity,
    NoSuperOperators: noSuperOperators,
    DisableMacros: disableMacros,
    CompressOutput: compressOutput,
    ByteCodeMode: byteCode.value
  })

  useEffect(() => {
    setEditorText(beautify(getRequestObj(), null, 2, 80))
  })

  const editorChanged = (newEditorText) => {
    console.log("Editor changed", newEditorText)
    // Parse JSON
    let parsed

    try {
      parsed = JSON.parse(newEditorText)
    } catch {
      console.log("Couldn't parse")
      return
    }

    if (!selectOptions.find(v => v.label == parsed.ByteCodeMode)) {
      return
    }

    setPremiumOutput(parsed.PremiumOutput)
    setEnhancedOutput(parsed.EnhancedOutput)
    setMaximumSecurity(parsed.MaximumSecurity)
    setNoSuperOperators(parsed.NoSuperOperators)
    setDisableMacros(parsed.DisableMacros)
    setCompressOutput(parsed.CompressOutput)
    setByteCode(selectOptions.find(v => v.label == parsed.ByteCodeMode))
  }

  function obfuscate() {
    const requestObj =  getRequestObj()
    console.log(requestObj)
  }

  
  const form = <div className={styles.inputsContainer}>
    <Toggle active={premiumOutput} onClick={setPremiumOutput}>Premium Output</Toggle>
    <Toggle active={enhancedOutput} onClick={setEnhancedOutput}>Enhanced Output</Toggle>
    <Toggle active={maximumSecurity} onClick={setMaximumSecurity}>Maximum Security</Toggle>
    <Toggle active={noSuperOperators} onClick={setNoSuperOperators}>No Super Operators</Toggle>
    <Toggle active={disableMacros} onClick={setDisableMacros}>Disable Macros</Toggle>
    <Toggle active={compressOutput} onClick={setCompressOutput}>Compress Output</Toggle>
    <Select name="Bytecode" defaultValue={byteCode} onChange={setByteCode} options={selectOptions} />
    <FileUpload>
      File
    </FileUpload>
    <Button.Raised onClick={obfuscate}>Obfuscate</Button.Raised>
  </div> 
  
  return (
    <DashboardPage>
      <h1>PSU Obfuscate</h1>

      {form}

      <JsonTextbox value={editorText} onGetRef={setEditorLoaded} onChange={editorChanged} />
    </DashboardPage>
  );
}

export default Obfuscate;
