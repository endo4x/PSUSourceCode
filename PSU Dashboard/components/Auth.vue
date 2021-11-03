<template>
  <div class="auth">
    <div v-if="!passwordResetTogged && !handleResetFinalise">
      <div class="signIn authTab" v-if="currentTab == 0">
      <p class="errorNotif" v-if="loginError">Error: {{loginError}}</p>
      <img src="@/assets/images/psu_icon.png" />
      <h1>Sign-in</h1>
      <form v-on:submit.prevent="signIn">
        <input v-model="signInForm.username" required type="text" placeholder="Username" />
        <input v-model="signInForm.password" required type="password" placeholder="Password" />
        <recaptcha style="margin: 0 auto; margin-top:10px;" @success="processRecaptchaSuccess" dataTheme="dark" />
        <button v-bind:disabled="!CaptchaFinished || processingRequest">Sign In</button>
      </form>
      <span>Haven't got an account?</span>
      <p class="resetPasswordButton" v-on:click="switchTabs">Register</p>
      </div>
      <div class="register authTab" v-if="currentTab == 1">
      <img src="@/assets/images/psu_icon.png" />
      <h1>Register</h1>
      <p class="errorNotif" v-if="registerError">Error: {{registerError}}</p>
      <form v-on:submit.prevent="registerUser">
        <input v-model="registerForm.username" required type="text" placeholder="Username" />
        <input v-model="registerForm.email" required type="email" placeholder="Email Address" />
        <input v-model="registerForm.password" required type="password" placeholder="Password" />
        <div class="passwordSecurity">
          <div class="bar" :style="{width: generatePasswordBarStyle().width, backgroundColor: generatePasswordBarStyle().backgroundColor}" />
        </div>
        <input v-model="registerForm.password_confirmation" required type="password" placeholder="Confirm Password" />

        <label>
          <input v-model="registerForm.ToS" type="checkbox" required />
          I accept PSU's ToS and Privacy Policy
        </label>

        <recaptcha style="margin: 0 auto; margin-top:10px;" @success="processRecaptchaSuccess" dataTheme="dark" />
        <button v-bind:disabled="!CaptchaFinished || processingRequest">Register</button>
      </form>
      <span>Already got an account?</span>
      <p class="resetPasswordButton" v-on:click="switchTabs">Sign In</p>
      </div>
    </div>
    <div v-if="passwordResetTogged && !handleResetFinalise" class="authTab">
      <img src="@/assets/images/psu_icon.png" />
      <h1>Reset Password</h1>
        <p class="errorNotif" v-if="resetError">Error: {{resetError}}</p>
        <p class="successNotif" v-if="resetSuccess">If the email address belonged to a valid account a email has been sent with a password reset link.</p>
        <form v-on:submit.prevent="resetPassword">
          <input v-model="passwordResetEmail" required type="email" placeholder="Email Address" />
          <recaptcha style="margin: 0 auto; margin-top:10px;" @success="processRecaptchaSuccess" dataTheme="dark" />
          <button v-bind:disabled="!CaptchaFinished || processingRequest">Request Reset</button>
        </form>
    </div>
    <div v-if="handleResetFinalise" class="authTab">
      <img src="@/assets/images/psu_icon.png" />
      <h1>Change Password</h1>
      <p class="errorNotif" v-if="resetError">Error: {{resetError}}</p>
      <p class="successNotif" v-if="finaliseSuccess">Successfully reset password! <br> Redirecting you to login shortly...</p>
      <form v-on:submit.prevent="finaliseResetPassword">
        <input v-model="finaliseResetForm.newPassword" required type="password" placeholder="New Password" />
        <div class="passwordSecurity">
          <div class="bar" :style="{width: generatePasswordBarStyle().width, backgroundColor: generatePasswordBarStyle().backgroundColor}" />
        </div>
        <input v-model="finaliseResetForm.confirmNewPassword" required type="password" placeholder="Confirm New Password" />
        <recaptcha style="margin: 0 auto; margin-top:10px;" @success="processRecaptchaSuccess" dataTheme="dark" />
        <button v-bind:disabled="!CaptchaFinished || processingRequest">Change Password</button>
      </form>
    </div>
    <p class="resetPasswordButton" v-on:click="togglePasswordReset" v-if="!handleResetFinalise">{{passwordResetTogged ? 'Go back to sign-in' : 'Forgot your password?'}}</p>
  </div>
</template>

<script>
import zxcvbn from 'zxcvbn';

export default {
  data() {
    return {
      currentTab: false,
      processingRequest: false,
      CaptchaFinished: false,
      passwordResetTogged: false,
      passwordResetEmail: '',
      resetSuccess: false,
      resetError: false,
      finaliseSuccess: false,
      handleResetFinalise: false,
      passwordScore: 0,
      finaliseResetForm: {
        newPassword: '',
        confirmNewPassword: ''
      },
      signInForm: {
        username: '',
        password: ''
      },
      registerForm: {
        username: '',
        email: '',
        password: '',
        password_confirmation: '',
        tos: false
      },
      loginError: false,
      registerError: false
    }
  },
  watch: {
    'registerForm.password': function(changeTo) {
      if (changeTo.length >= 100) {
        this.debouncedGetStrength()
      } else {
        this.getStrength()
      }
    },
    'finaliseResetForm.newPassword': function(changeTo) {
      if (changeTo.length >= 100) {
        this.debouncedGetStrength()
      } else {
        this.getStrength()
      }
    }
  },
  mounted() {
    this.debouncedGetStrength = this.debounce(this.getStrength, 500)
    if (this.$router.history.current.path == '/resetPassword') {
      // Handle switching into password reset mode
      this.handleResetFinalise = true
      return
    }

    var cookieArr = document.cookie.split(";");

    for(var i = 0; i < cookieArr.length; i++) {
      var cookiePair = cookieArr[i].split("=");
      if("PSUToken" == cookiePair[0].trim()) {
        this.processResponseLogin({ token: decodeURIComponent(cookiePair[1]) })
      }
    }
  },
  methods: {
    generatePasswordBarStyle() {
      switch (this.passwordScore) {
        case 0: {return {width: '10%', 'backgroundColor': '#a23e3e'}}
        case 1: {return {width: '40%', 'backgroundColor': '#a23e3e'}}
        case 2: {return {width: '60%', 'backgroundColor': '#a29c3e'}}
        case 3: {return {width: '80%', 'backgroundColor': '#a29c3e'}}
        case 4: {return {width: '100%', 'backgroundColor': '#46a23e'}}
        default: {return {width: '10%;', 'backgroundColor': '#a23e3e'}}
      }
    },
    getStrength() {
      if (!this.handleResetFinalise) {
        this.passwordScore = zxcvbn(this.registerForm.password).score
      } else {
        this.passwordScore = zxcvbn(this.finaliseResetForm.newPassword).score
      }
    },
    debounce(func, wait, immediate) {
	var timeout;
	  return function() {
	  	var context = this, args = arguments;
	  	var later = function() {
	  		timeout = null;
	  		if (!immediate) func.apply(context, args);
	  	};
	  	var callNow = immediate && !timeout;
	  	clearTimeout(timeout);
	  	timeout = setTimeout(later, wait);
	  	if (callNow) func.apply(context, args);
	  };
  },


    async finaliseResetPassword() {
      if (this.processingRequest) { return };
      this.resetError = false

      if (this.passwordScore <= 1) {
        this.resetError = "Password is too weak \n"
        return;
      }

      if (this.finaliseResetForm.newPassword !== this.finaliseResetForm.confirmNewPassword) {
        this.resetError = "The passwords do not match"
        return
      }

      const token = await this.$recaptcha.getResponse()
      this.processingRequest = true

      await fetch('https://next.psu.dev/api/v2/auth/finalise_reset', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
              resetToken: new URLSearchParams(document.location.search).get("token"),
              newPassword: this.finaliseResetForm.newPassword,
              captcha: token
          })
      })
          .then(response => response.json())
          .then(data => this.processResponseFinalise(data))
          .catch(err => {
              this.processingRequest = false
              this.resetError = err.message
          });

      this.processingRequest = false
    },
    togglePasswordReset() {
      this.passwordResetTogged = !this.passwordResetTogged
    },
    switchTabs() {
      this.currentTab = !this.currentTab
      this.CaptchaFinished = false
    },
    processRecaptchaSuccess() {
      this.CaptchaFinished = true
    },
    processAPIKey(data) {
      if (data.success) {
        this.$store.commit('userData/SET_APITOKEN', data.api_key);
      } else {
        window.createNotification('ERROR', `ERROR: Failed to get API Key for obfuscation, Please contact support.`, 15)
      }
    },
    processPerms(data) {
      if (data.success) {
        this.$store.commit('userData/SET_PERMS', data.data);
      } else {
        window.createNotification('ERROR', `ERROR: Failed to get user permissions, Please contact support.`, 15)
      }
    },
    processUserdataResponse(data, token) {
      if (data.success) {
        this.$store.commit('userData/SET_USER', data.userData)
        var cookieExpire = new Date();
        cookieExpire.setDate(cookieExpire.getDate() + 14);
        document.cookie = `PSUToken=${token}; expires=${cookieExpire.toUTCString()}; path=/`;
        this.$store.commit('userData/SETTOKEN', token)
        return
      } else {
        // Handle error
        document.cookie = "PSUToken=; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
        console.error(data.message)
      }
    },
    async processResponseLogin(data) {
      if (!data.token) {
        this.loginError = "Your login was invalid, please try again."
        this.processingRequest = false
        return
      }
      // Get user data
      await fetch('https://next.psu.dev/api/v2/auth/me', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
              "token": data.token
          })
      })
          .then(response => response.json())
          .then(data2 => this.processUserdataResponse(data2, data.token))
          .catch(err => {
              this.processingRequest = false
              this.loginError = err.message
          });

      // Get user's permissions
      await fetch('https://next.psu.dev/api/v2/auth/perms/get_self_perms', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
              "token": data.token
          })
      })
          .then(response => response.json())
          .then(data => this.processPerms(data))
          .catch(err => {
            console.error(err)
          });

      // Get API Key
      await fetch('https://next.psu.dev/api/v2/auth/get_apikey', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
              "token": data.token
          })
      })
          .then(response => response.json())
          .then(data => this.processAPIKey(data))
          .catch(err => {
            console.error(err)
          });
    },
    processResponseRegister(data) {
      if (data.success) {
        this.signInForm.username = this.registerForm.username
        this.signInForm.password = this.registerForm.password
        this.processingRequest = false
        this.signIn()
      } else {
        this.processingRequest = false
        this.registerError = data.message
      }
    },
    async processResponseFinalise(data) {
      if (data.success) {
        this.finaliseSuccess = true
        this.passwordResetEmail = ''

        await new Promise(resolve => setTimeout(resolve, 5000))
        this.finaliseResetForm.newPassword = ''
        this.finaliseResetForm.confirmNewPassword = ''
        this.processingRequest = false
        this.handleResetFinalise = false
        this.passwordScore = 0
        this.currentTab = false
        this.CaptchaFinished = false
        this.$router.push("/")
      } else {
        this.resetError = data.message
      }
    },
    processResponseReset(data) {
      if (data.success) {
        this.resetSuccess = true
        this.passwordResetEmail = ''
      } else {
        this.resetError = data.message
      }
    },
    async resetPassword() {
      if (this.processingRequest) { return };
      this.resetError = false

      const token = await this.$recaptcha.getResponse()
      this.processingRequest = true

      await fetch('https://next.psu.dev/api/v2/auth/reset_password', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
              email: this.passwordResetEmail,
              captcha: token
          })
      })
          .then(response => response.json())
          .then(data => this.processResponseReset(data))
          .catch(err => {
              this.processingRequest = false
              this.resetError = err.message
          });

      this.processingRequest = false
    },
    async registerUser() {
      if (this.processingRequest) { return };
      this.registerError = false

      if (this.passwordScore <= 1) {
        this.registerError = 'Password is too weak \n'
        return
      }

      this.signInForm.username = this.registerForm.username
      this.signInForm.password = this.registerForm.password

      if (this.registerForm.password !== this.registerForm.password_confirmation) {
        this.registerError = "Passwords do not match"
        return
      }

      const token = await this.$recaptcha.getResponse()

      this.processingRequest = true

      fetch('https://next.psu.dev/api/v2/auth/register', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
              email: this.registerForm.email,
              username: this.registerForm.username,
              password: this.registerForm.password,
              captcha: token
          })
      })
          .then(response => response.json())
          .then(data => this.processResponseRegister(data))
          .catch(err => {
              this.processingRequest = false
              this.registerError = err.message
          });
    },
    async signIn() {
      if (this.processingRequest) { return };
      this.loginError = false

      const token = await this.$recaptcha.getResponse()

      this.processingRequest = true

      // Start processing login...

      fetch('https://next.psu.dev/api/v2/auth/login', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
              username: this.signInForm.username,
              password: this.signInForm.password,
              "captcha": token
          })
      })
          .then(response => response.json())
          .then(data => this.processResponseLogin(data))
          .catch(err => {
              this.processingRequest = false
              this.loginError = err.message
          });
    }
  },
}
</script>

<style lang="scss">
  .passwordSecurity {
    height: 10px;
    display: block;
    background: #171717;
    width: 90%;
    margin: 0 auto;
    border-radius: 10px;
    overflow: hidden;
    position: relative;

    .bar {
      position: absolute;
      left: 0px;
      height: 100%;
      background: #a23e3e;
      transition: 0.2s ease-in-out;
    }
  }

  .auth  {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translateX(-50%) translateY(-50%);
    background: #222;
    border-radius: 10px;
    border: 2px solid var(--border);
    width: 400px;
    padding: 20px;
    text-align: center;
    box-sizing: border-box;
  }

  .resetPasswordButton {
    font-weight: bold;

    &:hover {
      cursor: pointer;
    }
  }

  .lmao2 {
    &:hover {
      cursor: pointer;
    }
  }

  .errorNotif {
    background: #ca4b4b;
    padding: 7px;
    border-radius: 5px;
  }

  .successNotif {
    background: #347942;
    padding: 7px;
    border-radius: 5px;
  }

  .authTab {
    h1 {
      margin-bottom: 20px;
      font-weight: 400;
    }

    img {
      height: 100px;
    }

    input[type="text"], input[type="email"], input[type="password"] {
      width: 90%;
      margin: 0 auto;
      margin-top: 10px;
      margin-bottom: 10px;
    }

    input {
      margin-top: 10px;
      margin-bottom: 10px;
    }

    button {
      margin-top: 20px;
      width: 90%;
    }

    > .button2 {
      margin-top: 10px;
    }

    .g-recaptcha {
      > div {
        margin: 0 auto;
      }
    }

    span {
      display: block;
      margin-top: 20px;

      > a {
        display: block;
        margin-top: 10px;
        color: var(--theme-gradient-1-primary);
        font-weight: 600;
        text-decoration: none;
      }
    }
  }
</style>
