<template>
  <div class="dropdown" v-bind:style="{top:y + 'px',left:x+'px'}">
    <slot v-if="opened"></slot>
  </div>
</template>

<script>
export default {
  data: () => {
    return {
      opened: false,
      x: 0,
      y: 0
    }
  },
  methods: {
    openDropdown () {
      this.opened = true

      let cursor = window.getCurrentPos();
      this.x = cursor.cursorX;
      this.y = cursor.cursorY;
    },
    closeDropdown () {
      this.opened = false
    }
  }
}
</script>

<style lang="scss">
  .dropdown {
    position: fixed;
    min-width: 90px;
    background-color: white;
    border-radius: 10px;
    border-top-left-radius: 0px;
    z-index: 100;

    span {
      display: block;
      padding-bottom: 5px;
      padding-top: 5px;
      padding-left: 10px;
      padding-right: 20px;

      color: #21A485;
      font-weight: 600;
    }

    .alertOption {
      color: #E44;

      &:hover {
        color: #fff;
        background: linear-gradient(180deg, #950707 0%, #CA4141 100%);
      }
    }

    span:hover {
      color: #fff;
      background: linear-gradient(180deg, var(--theme-gradient-1-primary) 0%, var(--theme-gradient-1-secondary) 100%);
    }

    span:first-child {
      border-top-right-radius: 8px;
    }

    span:last-child {
      border-bottom-left-radius: 8px;
      border-bottom-right-radius: 8px;
    }
  }
</style>
