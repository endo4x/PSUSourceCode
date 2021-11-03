<template>
<div class="errorPage">
  <div>
    <h1>404</h1>
    <h2>Page not found</h2>
  </div>
</div>
</template>

<script>
export default {

}
</script>

<style lang="scss">
  .errorPage {
    width: 100%;
    height: 100%;

    div {
      position: absolute;
      text-align: center;
      left: 50%;
      top: 50%;

      transform: translateX(-50%) translateY(-50%);

      h1 {
        font-size: 200px;
        margin: 0px;
      }

      h2 {
        font-size: 50px;
        margin: 0px;
      }
    }
  }
</style>