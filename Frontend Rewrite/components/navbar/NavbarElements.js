import React from "react"
import Link from "../link";
import { FaBars } from "react-icons/fa";
import styles from "./Navbar.module.css";

export const Nav = (props) => {
  return <nav className={styles.nav}>{props.children}</nav>;
};

export const NavLink = (props) => {
  return (
    <Link activeClassName="navLinkActive" href={props.to}>
      <a className={styles.navLink}>{props.children}</a>
    </Link>
  );
};

export const Bars = (props) => {
  const [hamburgerOpen, setHamburgerOpen] = React.useState(false)
  const [trayClass, setTrayClass] = React.useState(styles.hamburgerTray)
  const [clickAwayClass, setClickAwayClass] = React.useState(styles.clickAwayListener)

  const openHamburger = () => {
    setHamburgerOpen(true)
    setTrayClass(styles.hamburgerTray + " " + styles.open)
    setClickAwayClass(styles.clickAwayListener + " " + styles.open)
  }

  const closeHamburger = () => {
    setHamburgerOpen(false)
    setTrayClass(styles.hamburgerTray)
    setClickAwayClass(styles.clickAwayListener)
  }

  return <React.Fragment>
    {/* wrapping it in button for accesibility */}
    <button onClick={openHamburger} className={styles.hamburgerButton} aria-label="Hamburger navigation">
      <FaBars className={styles.bars} />
    </button>

    {/* Actual tray */}
    <div className={trayClass}>
      {props.children}
    </div>

    {/* Div that gets placed over the screen so that if people click outside the tray it closes */}
    <div onClick={closeHamburger} className={clickAwayClass}>
      
    </div>
  </React.Fragment>
};

export const NavMenu = (props) => {
  return <div className={styles.navMenu}>{props.children}</div>;
};

export const NavBtn = (props) => {
  return <nav className={styles.navBtn}>{props.children}</nav>;
};

export const NavBtnLink = (props) => {
  return (
    <Link href={props.to}>
      <a className={styles.navBtnLink}>{props.children}</a>
    </Link>
  );
};
