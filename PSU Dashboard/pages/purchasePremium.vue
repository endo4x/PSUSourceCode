<template>
  <div class="purchasePremiumCore">
    <div v-if="stage === 0">
      <div class="upgradeText">
        <p>Protect your scripts with top grade security</p>
        <h1>Unlock the full potential of PSU</h1>
      </div>
      <div class="cardDisplay">
      <div v-bind:class="selected === 0 ? 'selectedCard' : ''" v-on:click="() => selectCard(0)">
        <div class="cardTitle">
          <h1>Monthly</h1>
        </div>
        <h1 class="price">
          $6.49<span>/month</span>
        </h1>
        <span class="seperator" />
        <div class="stuffYouGet">
          <p><font-awesome-icon icon="check-circle" />Highly-Secure Obfuscator</p>
          <p><font-awesome-icon icon="check-circle" />Obfuscation API</p>
          <p><font-awesome-icon icon="check-circle" />Custom Bytecode Formatting</p>
          <p><font-awesome-icon icon="check-circle" />Custom Macros</p>
          <p><font-awesome-icon icon="check-circle" />Increased Security Features</p>
          <p><font-awesome-icon icon="check-circle" />Higher Performance</p>
        </div>
        <h1 class="selected" v-if="selected === 0">Selected</h1>
      </div>
      <div v-bind:class="selected === 1 ? 'selectedCard' : ''" v-on:click="() => selectCard(1)">
        <div class="cardTitle">
          <h1>Yearly</h1>
        </div>
        <h1 class="price">
          $29.99<span>/year</span>
        </h1>
        <span class="seperator" />
        <div class="stuffYouGet">
          <p><font-awesome-icon icon="check-circle" />Highly-Secure Obfuscator</p>
          <p><font-awesome-icon icon="check-circle" />Obfuscation API</p>
          <p><font-awesome-icon icon="check-circle" />Custom Bytecode Formatting</p>
          <p><font-awesome-icon icon="check-circle" />Custom Macros</p>
          <p><font-awesome-icon icon="check-circle" />Increased Security Features</p>
          <p><font-awesome-icon icon="check-circle" />Higher Performance</p>
        </div>
        <h1 class="selected" v-if="selected === 1">Selected</h1>
      </div>
      <div v-bind:class="selected === 2 ? 'selectedCard' : ''" v-on:click="() => selectCard(2)">
        <div class="cardTitle">
          <h1>Lifetime</h1>
        </div>
        <h1 class="price">
          $74.99
        </h1>
        <span class="seperator" />
        <div class="stuffYouGet">
          <p><font-awesome-icon icon="check-circle" />Highly-Secure Obfuscator</p>
          <p><font-awesome-icon icon="check-circle" />Obfuscation API</p>
          <p><font-awesome-icon icon="check-circle" />Custom Bytecode Formatting</p>
          <p><font-awesome-icon icon="check-circle" />Custom Macros</p>
          <p><font-awesome-icon icon="check-circle" />Increased Security Features</p>
          <p><font-awesome-icon icon="check-circle" />Higher Performance</p>
        </div>
        <h1 class="selected" v-if="selected == 2">Selected</h1>
      </div>
      </div>
      <button class="purchaseButton" :disabled="selected === false" v-on:click="gotoCheckout">Continue to checkout</button>
      <p class="weAccept">We accept</p>
      <div class="acceptedMethods">
      <font-awesome-icon :icon="['fab', 'cc-paypal']" />
      <font-awesome-icon :icon="['fab', 'cc-stripe']" />
      <font-awesome-icon :icon="['fab', 'bitcoin']" />
      </div>
    </div>
    <div v-if="stage === 1" class="paymentMethod">
      <div class="lds-ring premiumLoader" v-if="loadingCheckout"><div></div><div></div><div></div><div></div></div>
      <div class="checkoutMethod" v-if="!loadingCheckout">
        <h1>Complete Checkout With</h1>
        <button v-on:click="startStripeCheckout" :disabled="stripeLoading">
          <span v-if="!stripeLoading">Credit or Debit Card</span>
          <span v-if=stripeLoading><font-awesome-icon icon="spinner" spin /></span>
        </button>
        <div class="paypalContainer" id="paypalContainer"></div>
        <p class="goBack" v-on:click="gotoStage0">Go Back</p>
      </div>
    </div>
    <div v-if="stage === 2" class="paymentReceipt">
      <div class="lds-ring premiumLoader" v-if="processingOrder"><div></div><div></div><div></div><div></div></div>
      <div v-if="!processingOrder && (paymentData.status == 'COMPLETED')">
        <h1>Purchase Success!</h1>
        <svg class="transactionSuccess" xmlns='http://www.w3.org/2000/svg' viewBox='0 0 52 52'>
          <circle class="transactionSuccessCircle" cx='26' cy='26' r='25' fill='none' />
          <path class="transactionSuccessCheck" fill='none' d='M14.1 27.2l7.1 7.2 16.7-16.8' />
        </svg>
        <h2>A Receipt has been emailed to {{paymentEmail}}</h2>
        <nuxt-link to="/"><button>Go to dashboard</button></nuxt-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      selected: false,
      stage: 0,
      loadingCheckout: true,
      paymentVendor: null,
      paymentData: null,
      paymentEmail: '',
      processingOrder: true,
      paymentError: false,
      paymentStatus: '',
      stripeLoading: false
    }
  },
  mounted() {
    this.$store.commit('routerManager/CHANGE_PAGE', 'Purchase Premium')
  },
  computed: {
    authToken() {
      return this.$store.state.userData.authToken
    }
  },
  methods: {
    async startStripeCheckout() {
      this.stripeLoading = true

      // Handle Stripe
      var stripe = Stripe('pk_live_51HN9h9Enq0tzcOdNima0Xjq8O03oOb8knA9KxmHYnKtxUqOTYkrjpK0vbsxJeVVo0XFYJ0JIDgBsPJAxtspIN2CX00D2Pt2KWB');

      let response = await fetch('https://next.psu.dev/api/v2/payments/stripe/createOrderID', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          token: this.authToken,
          orderType: this.selected
        })
      })
      .then(data => data.json());

      if (response.success) {
        return stripe.redirectToCheckout({ sessionId: response.data });
      }

      this.stripeLoading = false

      this.paymentError = response.message
      return
    },
    selectCard(data) {
      this.selected = data
    },
    gotoStage0() {
      this.stage = 0
    },
    processUserdataResponse(data, token) {
      if (data.success) {
        this.$store.commit('userData/SET_USER', data.userData)
        var cookieExpire = new Date();
        cookieExpire.setDate(cookieExpire.getDate() + 14);
        document.cookie = `PSUToken=${token}; expires=${cookieExpire.toUTCString()} path=/`;
        this.$store.commit('userData/SETTOKEN', token)
        return
      } else {
        // Handle error
        document.cookie = "PSUToken=; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
        console.error(data.message)
      }
    },
    async refreshUserData() {
      // Get user data
      await fetch('https://next.psu.dev/api/v2/auth/me', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
              "token": this.authToken
          })
      })
          .then(response => response.json())
          .then(data => this.processUserdataResponse(data, this.authToken))
          .catch(err => {
              this.processingRequest = false
              this.loginError = err.message
          });
    },
    async handleOrderProcessing() {
      let data = await fetch('https://next.psu.dev/api/v2/payments/paypal/getOrderID', {
        method: 'POST',
        headers: {
          'Content-Type':'application/json'
        },
        body: JSON.stringify(
          {
            "token": this.authToken,
            "orderID": this.paymentData.id,
            "orderType": this.selected
          })
      })
      .then(data => data.json())
      .catch(err => {
        console.error(err)
        this.paymentError = `ERROR: Something went wrong processing this transaction. Please contact support.`
      })

      if (!data.success) {
        this.paymentError = `ERROR: Something went wrong processing this transaction. Please contact support. ERRCODE: ${err.message}`
        return
      }

      this.refreshUserData()

      this.paymentStatus = data.success
      this.processingOrder = false
    },
    async gotoCheckout() {
      this.stage = 1

      this.loadingCheckout = false

      await new Promise(resolve => {setTimeout(resolve, 200)});

      let amount;

      switch (this.selected) {
        case 2: {
          amount = 74.99 // Lifetime
          break;
        }
        case 1: {
          amount = 29.99 // Yearly
          break;
        }
        case 0: {
          amount = 6.49 // Monthly
          break;
        }
      }

       // Initialize the buttons
       var button = window.paypal.Buttons({
         createOrder: (data, actions) => {
           // This function sets up the details of the transaction, including the amount and line item details.
           return fetch('https://next.psu.dev/api/v2/payments/paypal/createOrderID', {
             method: 'POST',
             headers: {
               'Content-Type': 'application/json'
             },
             body: JSON.stringify({
               token: this.authToken,
               orderType: this.selected
             })
           }).then(function(res) {
             return res.json();
           }).then(function(data) {
             return data.data;
           });
         },
         onApprove: (data, actions) => {
           // This function captures the funds from the transaction.
           return actions.order.capture().then((details) => {
             // This function shows a transaction success message to your buyer.
             this.stage = 2
             this.paymentVendor = "PAYPAL"
             this.paymentData = details
             this.paymentEmail = details.payer.email_address

             this.handleOrderProcessing()
           });
         },
         fundingSource: window.paypal.FUNDING.PAYPAL,
       });

      //Render the standalone button for that funding source
      button.render("#paypalContainer");
    }
  }
}
</script>

<style lang="scss">
  .transactionSuccessCircle {
    stroke-dasharray: 166;
    stroke-dashoffset: 166;
    stroke-width: 2;
    stroke-miterlimit: 10;
    stroke: #7ac142;
    fill: none;
    animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
  }

  .transactionSuccess {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    display: block;
    stroke-width: 2;
    stroke: #fff;
    stroke-miterlimit: 10;
    margin: 30px auto;
    box-shadow: inset 0px 0px 0px #7ac142;
    animation: fill .4s ease-in-out .4s forwards, scale .3s ease-in-out .9s both;
  }

  .transactionSuccessCheck {
    transform-origin: 50% 50%;
    stroke-dasharray: 48;
    stroke-dashoffset: 48;
    animation: stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.8s forwards;
  }

  @keyframes stroke {
    100% {
      stroke-dashoffset: 0;
    }
  }

  @keyframes scale {
    0%, 100% {
      transform: none;
    }
    50% {
      transform: scale3d(1.1, 1.1, 1);
    }
  }

  @keyframes fill {
    100% {
      box-shadow: inset 0px 0px 0px 100px #7ac142;
    }
  }

  .weAccept {
    text-align: center;
    margin: 0px;
    margin-top: 10px;
    font-size: 20px;
  }

  .purchasePremiumCore {
    height: 100%;
  }

  .paymentMethod {
    position: relative;
    height: 100%;
    .premiumLoader {
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translateX(-50%) translateY(-50%);
      scale: 1.5;
    }

    .checkoutMethod {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translateY(-50%) translateX(-50%);
      width: 500px;
      border: 1px solid var(--border);
      border-radius: 10px;
      background: var(--background-secondary);

      .goBack {
        text-align: center;
        font-size: 20px;

        &:hover {
          cursor: pointer;
        }
      }

      .paypalContainer {
        width: 90%;
        margin: 0 auto;
      }

      > h1 {
        margin-top: 20px;
        text-align: center;
      }

      > button {
        display: block;
        width: 90%;
        height: 45px;
        border-radius: 5px;
        margin: 20px auto;
        padding: 0px;
        font-size: 20px;

        svg {
          height: 30px;
          margin-top: 5px;
        }
      }
    }
  }


  .lds-ring {
  display: inline-block;
  position: relative;
  width: 80px;
  height: 80px;
}
.lds-ring div {
  box-sizing: border-box;
  display: block;
  position: absolute;
  width: 64px;
  height: 64px;
  margin: 8px;
  border: 8px solid #fff;
  border-radius: 50%;
  animation: lds-ring 1.2s cubic-bezier(0.5, 0, 0.5, 1) infinite;
  border-color: #fff transparent transparent transparent;
}
.lds-ring div:nth-child(1) {
  animation-delay: -0.45s;
}
.lds-ring div:nth-child(2) {
  animation-delay: -0.3s;
}
.lds-ring div:nth-child(3) {
  animation-delay: -0.15s;
}
@keyframes lds-ring {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.paymentReceipt {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translateX(-50%) translateY(-50%);
  text-align: center;
  border: 1px solid var(--border);
  border-radius: 10px;
  background: var(--background-secondary);
  padding: 50px;

  h2 {
    font-weight: 300;
  }
}

  .acceptedMethods {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 4px;

    svg {
      height: 30px;
      margin-left: 5px;
      margin-right: 5px;
    }
  }
  .purchaseButton {
    margin: 0 auto;
    display: block;
    font-size: 20px;
    margin-top: 20px;
  }
  .upgradeText {
    text-align: center;
    margin-top: 20px;

      p {
        font-size: 20px;
        margin-bottom: 0px;
      }

      h1 {
        margin-top: 0px;
        font-size: 50px;
      }
    }
  .cardDisplay {
    width: 100%;
    display: flex;
    justify-content: center;

    .stuffYouGet {
      p {
        vertical-align:middle;

        svg {
          transform: translateY(-2px);
          margin-left: 10px;
          vertical-align:middle;
          width: 20px;
          margin-right: 10px;
        }
      }
    }

    .selected {
      text-align: center;
      color: #fff;
    }

    .selectedCard {
      background: linear-gradient(141deg, var(--theme-gradient-1-primary) 32%, var(--theme-gradient-2-secondary) 100%);
      scale: 1.05;
    }

    > div {
      width: 300px;
      height: 500px;
      position: relative;
      box-sizing: border-box;
      padding: 10px;
      transition: 0.2s ease-in-out;

      &:hover {
        cursor: pointer;
        scale: 1.05;
      }

      border: 2px #2C2C2C solid;
      border-radius: 15px;
      background: linear-gradient(141deg, var(--theme-black-gradient-primary) 32%, var(--theme-black-gradient-secondary) 100%);
      margin: 20px;
      border-radius: 10px;

      .seperator {
        display: block;
        height: 1px;
        background: #2C2C2C75;
        width: 80%;
        margin: 0 auto;
      }

      .price {
        margin-top: 20px;
        font-size: 50px;
        text-align: center;
        margin-bottom: 10px;

        span {
          font-size: 20px;
          color: #ffffff70;
        }
      }

      .cardTitle {
        position: relative;
        height: 100%;
        height: 60px;
        border-bottom: 1px #2C2C2C75 solid;

        h1 {
          position: absolute;
          margin: 0px;
          top: 50%;
          transform: translateY(-50%);
          left: 10px;
          font-size: 27px;
        }
      }
    }
  }
</style>
