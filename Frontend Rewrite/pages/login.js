import {useState} from "react"
import Head from "next/head";
import Button from "../components/button";
import styles from "../styles/Login.module.css";
import ReCAPTCHA from "react-google-recaptcha";
import Link from "next/link";
import { RiLockPasswordFill } from 'react-icons/ri';

import backend from "../utils/backend"

//https://next.psu.dev/api/v2/auth/login
//https://next.psu.dev/api/v2/auth/login
export default function Login() {
  const [username, setUsername] = useState("")
  const [password, setPassword] = useState("")
  const [captcha, setCaptcha] = useState(null)
  const [errorMessage, setErrorMessage] = useState("")

  const loginUser = async (event) => {
    event.preventDefault();

    if (captcha === null) {
      setErrorMessage("Invalid captcha")
      return
    }

    try {
      const response = await backend.request("auth/login", "POST", {
        username,
        password,
        captcha
      })

      window.localStorage.setItem('login_token', response.token)
    } catch (err) {
      if (err.body) {
        setErrorMessage(err.body.message)
      } else {
        setErrorMessage("Something went wrong, please try again later")
      }
      console.error(err)
    }
  };

  const handleInput = (event) => {
    switch (event.target.id) {
      case "username":
        setUsername(event.target.value)
        break
      case "password":
        setPassword(event.target.value)
        break
    }    
  }


  return (
    <div>
      <Head>
        <title>PSU | Login</title>
        <meta
          name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no"
        />
        <meta httpEquiv="x-ua-compatible" content="ie=edge" />
        <meta
          property="og:description"
          content="Perth's Scripting Utilities is a combination of utilities dedicated to the Lua scripting language."
        />
        <meta
          property="twitter:description"
          content="Perth's Scripting Utilities is a combination of utilities dedicated to the Lua scripting language."
        />
        <meta property="theme-color" content="#0A5235" />
        <meta
          property="og:title"
          content="Perth's Scripting Utilities - Login"
        />
        <meta property="og:type" content="website" />
        <meta property="og:image" content="https://cdn.psu.dev/psu_icon.png" />
        <meta property="og:image:type" content="image/png" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <div className={styles.container}>
        <div className={styles.left}>
          <img src="psu_icon.png" />
          <h1>PSU</h1>
          <p>Login to your PSU account</p>
        </div>
        <div className={styles.centre}>
          <div className={styles.card}>
            <img src="psu_icon.png" />
            <h2>We're so glad you're here!</h2>
            <form onSubmit={loginUser} noValidate autoComplete="off">
              <input onInput={handleInput} id="username" type="text" placeholder="Username" required />
              <input onInput={handleInput} id="password" type="password" placeholder="Password" required />
              <ReCAPTCHA onChange={setCaptcha} sitekey="6LenZb8aAAAAAAb5CJpF3tr0CnCWKWTCVONw2X09" theme="dark" />
              <p className={styles.errorMessage}>{errorMessage}</p>
              <Button.Raised type="submit">
                <RiLockPasswordFill />
                Login
              </Button.Raised>
              <p>Haven't got an account?</p>
              <Link href="/register">Register</Link>
              <Link href="/forgotPassword">Forgot password?</Link>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
}
