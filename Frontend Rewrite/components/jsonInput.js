import { useRef, useEffect } from "react"
import Editor from "@monaco-editor/react"

function jsonTextbox(props) {
  const editorRef = useRef(null)

  const handleMount = (editor) => {
    editorRef.current = editor

    if (props.onGetRef) {
      props.onGetRef(editorRef)
    }

    if (props.value) {
      console.log('Setting value', props.value)
      editorRef.current.setValue(props.value)
    }
  }

  let didSetValue = false

  useEffect(() => {
    if (editorRef.current) {
      editorRef.current.setValue(props.value)
      didSetValue = true
    }
  })

  const onChange = (newValue, ev) => {
    if (didSetValue && props.onChange) {
      props.onChange(newValue, ev)
    }
  }

  return <Editor 
    height="50vh"
    defaultLanguage="json"
    theme="vs-dark"
    onMount={handleMount}
    options={{
      scrollBeyondLastLine: false,
      lineNumbers: false,
      folding: false,
      formatOnPaste: true,
      formatOnType: true,
      scrollbar: {
        horizontal: "hidden",
        vertical: "hidden"
      }
    }}
    onChange={onChange}
  />
}

export default jsonTextbox
