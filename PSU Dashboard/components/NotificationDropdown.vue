<template>
  <div class="notificationDropdown">
    <div class="arrow" />
    <div class="notifHeader">
      <h2>Notifications</h2>
    </div>
    <p>No Notifications to show!</p>
  </div>
</template>

<script>
export default {

}
</script>

<style lang="scss">
  .notificationDropdown {
    position: absolute;
    width: 300px;
    background: var(--background-secondary);
    border: 2px var(--border) solid;
    border-radius: 10px;
    top: 40px;
    right: -10px;
    z-index: 100;

    &:hover {
      cursor: default !important;
    }

    > p {
      text-align: center;
      color: var(--text-color-secondary);
    }

    .arrow {
        width: 0;
        height: 0;
        border-left: 10px solid transparent;
        border-right: 10px solid transparent;

        border-bottom: 15px solid var(--border);
        position: absolute;
        right: 10px;
        top: -15px;
    }

    .notifHeader {
      height: 50px;
      width: 100%;
      background: var(--border);

      h2 {
        margin: 0px;
        width: 100%;
        text-align: left;
        font-weight: 400;
        line-height: 45px;
        padding-left: 20px;
        box-sizing: border-box;
        font-size: 20px;
      }
    }
  }
</style>
