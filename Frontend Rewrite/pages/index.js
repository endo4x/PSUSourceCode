import Head from "next/head";
import Navbar from "../components/navbar";
import Button from "../components/button";
import styles from "../styles/Home.module.css";
import { FaCheckCircle, FaCode, FaLock } from "react-icons/fa";
import { SiCodesandbox } from "react-icons/si";
import { AiFillApi, AiOutlineShoppingCart } from "react-icons/ai";

export default function Home() {
  return (
    <div>
      <Head>
        <title>PSU | Home</title>
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
          content="Perth's Scripting Utilities - Home"
        />
        <meta property="og:type" content="website" />
        <meta property="og:image" content="https://cdn.psu.dev/psu_icon.png" />
        <meta property="og:image:type" content="image/png" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Navbar />

      {/* Most of this is really, really scuffed code that I will clean up tomorrow probably */}

      <header className={styles.header}>
        <div className={styles.headerContent}>
          <div className={styles.headerLogoContainer}>
            <img src="psu_icon.png" />
          </div>
          <div className={styles.headerTextContainer}>
            <h1>
              Welcome to <span>PSU</span>.
            </h1>
            <p>
              Perth's Scripting Utilities is a combination of utilities
              dedicated to the
              <b>
                {/* the {" "}'s are here because <b> negates spaces around it otherwise */}
                {" "}<a href="http://lua.org">Lua</a>{" "}
              </b>
              scripting language.
            </p>
          </div>
        </div>
      </header>

      <div className={styles.section} id="about">
        <div className={styles.sectionContainer}>
          <h1>About Us</h1>
          <p>
            Here at PSU, our goal is to provide premium solutions to our
            customers for their Lua scripts. We offer a range of products such
            as a premium Lua obfuscator and an up-and-coming Roblox script
            whitelist. More details about our obfuscator and other products can
            be found below in the <a href="#services">Services</a> section.
          </p>
          <p>
            Currently, we have 600+ happy buyers, and hopefully more to come.
          </p>
          <h2>We believe that privacy is an indisputable right</h2>
          <p>
            And for that reason, we don't store your scripts. <b>At all.</b>
          </p>
          <h2>History</h2>
          <p>
            PSU began as a smaller Lua obfuscation service just over a year ago
            - the team of developers & staff was significantly smaller, and ever
            since the PSU team has grown to be better and stronger than ever
            before. Ever since release, PSU's developers have been constantly
            advancing PSU, making it bigger, better and more secure for our 
            customers to use.
          </p>
        </div>
      </div>
      <div className={styles.coloredSection} id="team">
        <div className={styles.sectionContainer}>
          <h1>Team</h1>
          <p>These individuals help make PSU what it is.</p>
          <div className={styles.cardContainer}>
            <div className={styles.card}>
              <img src="perth.gif" />
              <h1>Perth</h1>
              <p className={styles.role}>Chief Executive Officer</p>
              <p className={styles.quote}>
                "I'm the Chief Executive Officer of the PSU corporation. My
                primary responsibilities are making major decisions, managing
                the overall operations and managing resources of the company."
              </p>
            </div>
            <div className={styles.card}>
              <img src="cold.png" />
              <h1>Cold</h1>
              <p className={styles.role}>Second-in-Command</p>
              <p className={styles.quote}>
                "Hey! My name's Cold & I act as a second-in-command under Perth.
                I make sure PSU is operational, and I developed & designed this
                site."
              </p>
            </div>
            <div className={styles.card}>
              <img src="zackrain.png" />
              <h1>ZackRain</h1>
              <p className={styles.role}>Chief Technology Officer</p>
              <p className={styles.quote}>
                "Hey! I'm ZackRain, I'm a full stack developer specializing in
                backend development and embedded languages exploitation. I work
                for PSU on the main site API & the upcoming marketplace."
              </p>
            </div>
            <div className={styles.card}>
              <img src="tobeqz.png" />
              <h1>Tobeqz</h1>
              <p className={styles.role}>Frontend Developer</p>
              <p className={styles.quote}>
                "I helped work on the website you're seeing right now. I also designed the new logo, together with the rest of the team I make sure our brand is top notch."
              </p>
            </div>
            <div className={styles.card}>
              <img src="federal.png" />
              <h1>Federal</h1>
              <p className={styles.role}>Head of Obfuscation</p>
              <p className={styles.quote}>
                "Hi, I'm Federal and I develop this obfuscator.  I have worked with C# for years, and have experience with other scripting languages."
              </p>
            </div>
          </div>
        </div>
      </div>

      <div className={styles.section} id="services">
        <div className={styles.sectionContainer}>
          <h1>Services</h1>
          <p>Find a list of our offered services here.</p>
          <h2>Obfuscator</h2>
          <p>
            PSU Obfuscator is a sophisticated tool which has taken months of
            development to perfect. PSU Obfuscator secures your Lua script with
            multiple layers of protection, keeping the bad guys out and ensuring
            your script stays secure forever. We use a combination of techniques
            to achieve this, and it's why we are the leading Lua obfuscator.
          </p>
          <div className={styles.cardContainer}>
            <div className={styles.miniCard}>
              <h1>
                <FaLock /> String Encryption
              </h1>
              <p>
                Our string encryption further protects your scripts by
                encrypting any strings found within variables. This keeps the
                bad guys out and keeps them from being able to read your
                strings.
              </p>
            </div>
            <div className={styles.miniCard}>
              <h1>
                <span>
                  <FaCode size="2rem" /> Vanity Bytecode
                </span>
              </h1>
              <p>
                The vanity bytecode feature allows you to customise the output
                of the bytecode produced by our obfuscator. You can pick from a
                variety of different options, such as Chinese, Korean, Arabic
                and more.
              </p>
            </div>
            <div className={styles.miniCard}>
              <h1>
                <SiCodesandbox size="2rem" /> Virtualization
              </h1>
              <p>
                Whenever you obfuscate a script with PSU, the resulting script
                is contained in a Lua Virtual Machine, which is able to
                understand the complex bytecode that the script contains.
              </p>
            </div>
            <div className={styles.miniCard}>
              <h1>
                <span>
                  <AiFillApi size="2rem" /> Fast, stellar API
                </span>
              </h1>
              <p>
                Our obfuscator has a fantastic API that allows you to integrate
                PSU obfuscation into almost anything. Take a look at our
                homemade{" "}
                <a href="https://github.com/psuDevelopment/Obfuscate-With-PSU">
                  GitHub action
                </a>{" "}
                as an example of this.
              </p>
            </div>
          </div>
        </div>
      </div>
      {/* TODO: Clean this up and make it not use embedded styling */}
      <h1
        style={{
          textAlign: "center",
          color: "#fff",
          fontSize: "4rem",
          marginBottom: "-10px",
          marginTop: "-20px",
          color: "#46e393",
        }}
      >
        So, what are you waiting for?
      </h1>
      <div className={styles.section} id="pricing">
        <div className={styles.sectionContainer}>
          <h1>Premium Pricing</h1>
          <p>
            We have a range of different options of which you can choose from.
          </p>
          <div className={styles.cardContainer}>
            <div className={styles.coloredCard}>
              <h1>Monthly</h1>
              <h2>
                $4.49<span>/mo</span>
              </h2>
              <ul className={styles.featureBox}>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Highly Secure
                  Obfuscator
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Obfuscation
                  API**
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Custom Bytecode
                  Formatting
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Custom Macros
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Increased
                  Security Features
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Higher
                  Performance
                </li>
              </ul>
              <Button>
                <AiOutlineShoppingCart />
                Purchase
              </Button>
            </div>
            <div className={styles.coloredCard}>
              <h1>Yearly</h1>
              <h2>
                $20.99<span>/year</span>
              </h2>
              <ul className={styles.featureBox}>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Highly Secure
                  Obfuscator
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Obfuscation
                  API**
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Custom Bytecode
                  Formatting
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Custom Macros
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Increased
                  Security Features
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Higher
                  Performance
                </li>
              </ul>
              <Button>
                <AiOutlineShoppingCart />
                Purchase
              </Button>
            </div>
            <div className={styles.coloredCard}>
              <h1>Lifetime*</h1>
              <h2>$34.99</h2>
              <ul className={styles.featureBox}>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Highly Secure
                  Obfuscator
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Obfuscation
                  API**
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Custom Bytecode
                  Formatting
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Custom Macros
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Increased
                  Security Features
                </li>
                <li>
                  <FaCheckCircle color="#46e393" size="2rem" /> Higher
                  Performance
                </li>
              </ul>
              <Button>
                <AiOutlineShoppingCart />
                Purchase
              </Button>
            </div>
          </div>
          <h1>Or...</h1>
          <p>
            If you would not like to purchase PSU, you can instead join our{" "}
            <a href="https://discord.gg/psu">Discord server</a> and use the free
            version of PSU.
          </p>
        </div>
      </div>
      <div className={styles.line} />
      <footer className={styles.footer}>
        <img src="psu_banner.png" />
        <p>
          *Lifetime being a period of 100 years, which is more than the{" "}
          <a href="https://www.google.com/search?q=life+expectancy+of+a+human">
            average life expectancy of a human
          </a>
          .
        </p>
        <p>
          **Obfuscation API is capped at 100 obfuscations per day. This is to
          prevent API abuse and lessen the potential for people to create
          systems that would enable piracy of the premium version of the
          obfuscator.
        </p>
        <p>
          Perth Scripting Utilities (PSU) is not affiliated with Roblox, FiveM,
          Lua or any other game that uses Lua as a scripting language. We
          provide a variety of services to tailor to securing scripts, and we
          are not developers nor maintainers for these products. If you have any
          issues, please contact their developers and not us.
        </p>
        <div className={styles.footerLinks}>
          <a href="https://discord.gg/psu">Discord</a>
          <a href="https://github.com/psuDevelopment">GitHub</a>
        </div>
      </footer>
    </div>
  );
}
