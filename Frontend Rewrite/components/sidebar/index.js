import React from "react";
import styles from "./Sidebar.module.css";
import Link from 'next/link';
import Profile from '../profile';
import { FaHome } from "react-icons/fa";

const Sidebar = (props) => {
  return (
    <div className={styles.Sidebar}>
      <div className={styles.iconContainer}>
        <div className={styles.icon}>
          <img src="psu_banner.png" />
        </div>
      </div>

      <div className={styles.linksContainer}>
        <div className={styles.links}>
          {props.children}
        </div>
      </div>

      <div className={styles.myAccountContainer}>
        <div>
          {/* TODO: Put something like "my account" here with the users profile pictyure */}
        </div>
      </div>
    </div>
  )
}

const SidebarLink = (props) => {
  return (
    <div>
      <Link href={props.href}>
        {props.children}
      </Link>
    </div>
  );
}

Sidebar.Link = SidebarLink;

export default Sidebar;
