import { useState } from "react"
import Head from "next/head";
import styles from '../styles/Login.module.css';
import Button from '../components/button';
import ReCAPTCHA from 'react-google-recaptcha';
import Link from 'next/link';
import { BiReset } from 'react-icons/bi';
import backend from "../utils/backend"

export default function ForgotPassword() {
  const [captcha, setCaptcha] = useState(null)
  const [email, setEmail] = useState("")
  const [err, setErr] = useState("")
  const [success, setSuccess] = useState("")

  const handleInput = (e) => {
    setEmail(e.target.value)
  }

  const handleSubmit = async (e) => {
    e.preventDefault()

    if (!captcha) {
      setErr("Invalid captcha")
      return
    }

    try {
      console.log(email)
      const requestData = {
        captcha,
        email
      }

      console.log(requestData)

      await backend.request("auth/reset_password", "POST", requestData)

      setSuccess("If the email belonged to a valid account, an email has been sent with a password reset link.")
    } catch (err) {
      if (!err.message) {
        setErr("Something went wrong, try again later")
      } else {
        setErr(err.message)
      }
    }
  }
  
  return (
    <div>
      <Head>
        <title>PSU | Forgot Password</title>
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
          content="Perth's Scripting Utilities - Forgot Password"
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
            <p>Request a password reset</p>
          </div>
          <div className={styles.centre}>
            <div className={styles.card}>
              <img src="psu_icon.png" />
              <h2>Happens to the best of us!</h2>
              <p className={styles.success}>{success}</p>
              <form onSubmit={handleSubmit} noValidate autoComplete="off">
                <input onInput={handleInput} id="email" type="email" placeholder="Email" required />
                <p className={styles.error}>{err}</p>
                <ReCAPTCHA onChange={setCaptcha} sitekey="6LenZb8aAAAAAAb5CJpF3tr0CnCWKWTCVONw2X09" theme="dark" />
                <Button styleType="raised" type="submit">
                    <BiReset />
                    Request Reset
                </Button>
                <p>Remembered your password?</p>
                <Link href="/login">Login</Link>
              </form>
            </div>
          </div>
      </div>
    </div>
  )
}
