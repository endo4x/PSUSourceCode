import { useEffect, useState } from "react"
import styles from "./Select.module.css"
import Select from "react-select"


export default function select(props) {
  const [defaultValue, setDefaultValue] = useState(props.options[0])

  useEffect(() => {
    console.log('Rerendering select')
    setDefaultValue(props.defaultValue)
  }, [props.defaultValue])

  console.log(defaultValue)

  return (
    <div className={styles.container}>
      <span>{props.name}</span>
      <Select 
        className={styles.selectStyles}
        options={props.options}
        onChange={props.onChange}
        value={defaultValue || props.options[0]}
        styles={{
          option: (provided, state) => ({
            ...provided,
            backgroundColor: state.isSelected ? "var(--psu-bg)" : "var(--psu-bg-alt)",
            cursor: "pointer",
          }),

          control: (provided, state) => ({
            ...provided,
            cursor: "pointer",
            backgroundColor: "var(--psu-bg-alt)",
            color: "#fff",
            borderColor: state.isFocused ? "var(--psu-green)" : "#ddd",
            borderWidth: state.isFocused ? "2px" : "1px",
            boxShadow: 'none'
          }),

          menu: (provided) => ({
            ...provided,
            backgroundColor: "var(--psu-bg-alt)"
          }),

          singleValue: (provided) => ({
            ...provided,
            color: "#ddd"
          })
        }}
      />
    </div>
  )
}

