import React from "react";
import {
  Nav,
  NavLink,
  Bars,
  NavMenu,
  NavBtn,
  NavBtnLink,
} from "./NavbarElements";

const Navbar = () => {
  const navs = <React.Fragment>
    <NavLink to="#about">About</NavLink>
    <NavLink to="#services">Services</NavLink>
    <NavLink to="#team">Team</NavLink>
    <NavLink to="#pricing">Pricing</NavLink>
    <NavLink to="https://discord.gg/psu">Discord</NavLink>
  </React.Fragment>

  return (
    <>
      <Nav>
        <NavLink to="/">
          <img
            src="psu_banner.png"
            style={{
              maxWidth: "192px",
              marginLeft: "-10px",
              marginRight: "10px",
            }}
          />
        </NavLink>
        <Bars>
          {navs}
        </Bars>
        <NavMenu>
          {navs}
        </NavMenu>
        <NavBtn>
          <NavBtnLink to="/login">Login/Register</NavBtnLink>
        </NavBtn>
      </Nav>
    </>
  );
}

export default Navbar;
