import styles from "./Button.module.css";

const RaisedButton = (props) => {
  return (
    <button onClick={props.onClick} className={styles.raisedButton} type={props.type || "button"}>
      {props.children}
    </button>
  );
}

const Button = (props) => {
  return (
    <button onClick={props.onClick} className={styles.button} type={props.type || "button"}>
      {props.children}
    </button>
  );
};

Button.Raised = RaisedButton;

export default Button;
