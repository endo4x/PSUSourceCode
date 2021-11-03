<template>
  <div class="underConstruction">
    <div class="mainDiv">
      <font-awesome-icon icon="wrench" />
      <h1>Under Construction</h1>
      <p>We are still working on this section. <br /> Please bear with us while we work to deliver the full PSU Experience.</p>
    </div>
  </div>
</template>

<style lang="scss">
  .underConstruction {
    .mainDiv {
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translateX(-50%) translateY(-50%);
      color: #595959;
      text-align: center;
      max-width: 500px;

      > svg {
        width: 200px;
        margin: 0 auto;
        display: block;
      }

      h1 {
        margin-top: 20px;
        font-weight: 500;
        margin-bottom: 0px;
      }

      p {
        margin-top: 10px;
        text-align: center;
      }

      span {
        margin: 0 auto;
        display: block;
        text-align: center;
        font-size: 20px;
        color: white;

        &:hover {
          cursor: pointer;
        }
      }
    }
  }
</style>
