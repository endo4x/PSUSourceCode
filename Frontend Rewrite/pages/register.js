import { useState } from "react"
import backend from "../utils/backend"
import Head from "next/head";
import styles from '../styles/Login.module.css';
import Button from '../components/button';
import ReCAPTCHA from 'react-google-recaptcha';
import Link from 'next/link';
import { FaClipboardCheck } from 'react-icons/fa';

export default function Register() {
  const [email, setEmail] = useState("")
  const [username, setUsername] = useState("")
  const [password, setPassword] = useState("")
  const [captcha, setCaptcha] = useState(null)

  const [error, setError] = useState("")

  const handleInput = (e) => {
    switch (e.target.id) {
      case "email":
        setEmail(e.target.value)
        break;
      case "username":
        setUsername(e.target.value)
        break;
      case "password":
        setPassword(e.target.value)
        break;
    }
  }

  const handleSubmit = async (e) => {
    e.preventDefault()

    if (!captcha) {
      setError("Invalid captcha")
      return
    }

    try {
      await backend.request("auth/register", "POST", {
        email,
        password,
        username,
        captcha
      })

      // Redirect
    } catch (err) {
      if (err.body?.message) {
        setError(err.body.message)
      } else {
        setError("Something went wrong, please try again later")
      }
    }
  }
  return (
    <div>
      <Head>
        <title>PSU | Register</title>
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
          content="Perth's Scripting Utilities - Register"
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
            <p>Register a new account</p>
          </div>
          <div className={styles.centre}>
            <div className={styles.card}>
              <img src="psu_icon.png" />
              <h2>Join in on the fun.</h2>
              <form onSubmit={handleSubmit} noValidate autoComplete="off">
                <input onInput={handleInput} id="email" type="email" placeholder="Email" required />
                <input onInput={handleInput} id="username" type="text" placeholder="Username" required />
                <input onInput={handleInput} id="password" type="password" placeholder="Password" required />
                <ReCAPTCHA onChange={setCaptcha} sitekey="6LenZb8aAAAAAAb5CJpF3tr0CnCWKWTCVONw2X09" theme="dark" />
                <Button styleType="raised" type="submit">
                  <FaClipboardCheck />
                  Register
                </Button>
                <p>Already got an account?</p>
                <Link href="/login">Login</Link>
              </form>
            </div>
          </div>
      </div>
    </div>
  )
}
