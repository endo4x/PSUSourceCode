<template>
  <div class="paymentReceipt">
    <div>
      <h1>Purchase Success!</h1>
      <svg class="transactionSuccess" xmlns='http://www.w3.org/2000/svg' viewBox='0 0 52 52'>
        <circle class="transactionSuccessCircle" cx='26' cy='26' r='25' fill='none' />
        <path class="transactionSuccessCheck" fill='none' d='M14.1 27.2l7.1 7.2 16.7-16.8' />
      </svg>
      <h2>Thank you for your purchase!</h2>
      <nuxt-link to="/"><button>Go to dashboard</button></nuxt-link>
    </div>
  </div>
</template>

<script>
export default {

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

.paymentReceipt {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translateX(-50%) translateY(-50%);
  text-align: center;
  border: 1px solid var(--border);
  border-radius: 10px;
  background: var(--background-secondary);
  padding: 100px;

  h2 {
    font-weight: 300;
  }
}
</style>
