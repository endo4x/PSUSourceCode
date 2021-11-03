<template>
  <div>
    <Restricted v-if="userRank <= 2" />
    <div class="commonPage">
      <div class="whitelistSearchbar">
        <input class="searchBar" placeholder="Search">
        <SearchDropdown dropdownName="Search Before"/>
        <SearchDropdown dropdownName="Search After"/>
        <SearchDropdown dropdownName="Search During"/>
      </div>

      <div class="whitelistTable">
         <table>
          <tr>
            <th>Email</th>
            <th>Username</th>
            <th>Discord I.D</th>
            <th>I.P</th>
            <th>HWID</th>
            <th>Account Creation</th>
            <th>Whitelists</th>
          </tr>
          <tr v-for="data in tableData[currentPage - 1]" :key="data.HWID">
            <td>{{data.name}}</td>
            <td>{{data.username}}</td>
            <td>{{data.discordID}}</td>
            <td>{{data.IP}}</td>
            <td>{{data.HWID}}</td>
            <td>{{data.createdAt}}</td>
            <td><div v-bind:class="data.whitelistStatus ? 'DataWhitelisted': 'DataBlacklisted'">{{data.whitelistStatus ? 'Whitelisted': 'Blacklisted' }}</div></td>
          </tr>
        </table>
        <div class="tableControls">
          <div class="tableButton">
            <div class="arrow">
              <svg id="Layer_2" data-name="Layer 2" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                <g id="arrow-back">
                  <rect id="Rectangle_116" data-name="Rectangle 116" width="24" height="24" transform="translate(24) rotate(90)" fill="#5e5e5e" opacity="0"/>
                  <path id="Path_437" data-name="Path 437" d="M19,11H7.14l3.63-4.36A1,1,0,0,0,9.23,5.36l-5,6a1.19,1.19,0,0,0-.09.15.127.127,0,0,1-.07.13.961.961,0,0,0,0,.72.127.127,0,0,0,.07.13,1.19,1.19,0,0,0,.09.15l5,6a1,1,0,1,0,1.54-1.28L7.14,13H19a1,1,0,0,0,0-2Z" fill="#5e5e5e"/>
                </g>
              </svg>
            </div>

            <div class="pages">
              <div v-for="i in tableData.length" :key="i" v-bind:style="i == currentPage ? 'background: #0A0A0A;' : ''" v-on:click="() => changePage(i)"><span>{{i}}</span></div>
            </div>

            <div class="arrow">
              <svg style="transform: translateX(-50%) translateY(-50%) rotate(180deg);" id="Layer_2" data-name="Layer 2" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                <g id="arrow-back">
                  <rect id="Rectangle_116" data-name="Rectangle 116" width="24" height="24" transform="translate(24) rotate(90)" fill="#5e5e5e" opacity="0"/>
                  <path id="Path_437" data-name="Path 437" d="M19,11H7.14l3.63-4.36A1,1,0,0,0,9.23,5.36l-5,6a1.19,1.19,0,0,0-.09.15.127.127,0,0,1-.07.13.961.961,0,0,0,0,.72.127.127,0,0,0,.07.13,1.19,1.19,0,0,0,.09.15l5,6a1,1,0,1,0,1.54-1.28L7.14,13H19a1,1,0,0,0,0-2Z" fill="#5e5e5e"/>
                </g>
              </svg>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  mounted() {
    this.$store.commit('routerManager/CHANGE_PAGE', 'Whitelist Dashboard')
  },
  data() {
    return {
      currentPage: 1,
      tableData: [
        [
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: false
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: false
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: false
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          }
        ],
        [
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: false
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: false
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: false
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: false
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: false
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: true
          },
          {
            name: 'example@gmail.com',
            username: 'xxxxxxxxxxxxxxx',
            discordID: '111111111111111111',
            IP: '111.111.11.11',
            HWID: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
            createdAt: '00/00/0000 0:00 PM',
            whitelistStatus: false
          }
        ],
      ]
    }
  },
  computed: {
    userRank() {
      return this.$store.state.userData.userRank
    }
  },
  methods: {
    changePage(page) {
      this.currentPage = page
    }
  }
}
</script>

<style lang="scss">
  .whitelistSearchbar {
    width: 100%;
    height: 50px;
    margin-left: 2px;

    .searchBar {
      background: var(--background-secondary);
      border: none;
      height: 40px;
      width: 170px;
      border-radius: 10px;

      font-size: 13px;
      color: var(--text-color-primary);
      padding-left: 10px;
      box-sizing: border-box;
      font-family: "Poppins", sans-serif;
      transition: 0.3s ease-in-out;
      outline: none;
      border: 2px solid transparent;
      float: left;
    }

    .searchBar::placeholder {
      color: #aeaeae;
    }

    .searchBar:active, .searchBar:focus, .searchBar:focus-within {
      width: 250px;
      border: 2px solid var(--border);
    }
  }

  .whitelistTable {
    width: 100%;

    table {
      width: 100%;
    }

    table, th, td {
      border: 1px solid transparent;
      border-spacing: 2px;
    }

    th, tr {
      height: 52px;
      text-align: center;
    }

    tr:first-child {
      background: none !important;
    }

    tr th {
      background: #131313;
    }

    tr th:last-child {
      border-top-right-radius: 10px;
      background: #131313;
    }

    tr th:first-child {
      border-top-left-radius: 10px;
    }

    th {
      font-weight: 600;
    }

    tr {
      font-size: 15px;
    }

    tr:nth-child(even) {
      background-color: #0D0D0D;
    }

    tr:nth-child(odd) {
      background-color: #131313;
    }

    .DataWhitelisted {
      font-size: 10px;
      width: 70px;
      margin: 0 auto;
      background-color: #10734B;
      border: #043B25 2px solid;
      height: 25px;
      border-radius: 5px;
      font-weight: 600;
      line-height: 25px;
    }

    .DataBlacklisted {
      font-size: 10px;
      width: 70px;
      margin: 0 auto;
      background-color: #333333;
      border: #5E5E5E 2px solid;
      height: 25px;
      border-radius: 5px;
      font-weight: 600;
      line-height: 25px;
    }

    .tableControls {
      width: calc(100% - 4px);
      margin: 0 auto;
      height: 83px;
      background: #0D0D0D;
      border-bottom-left-radius: 10px;
      border-bottom-right-radius: 10px;

      .tableButton {
        margin: 0 auto;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;

        .arrow {
          position: relative;
          width: 43px;
          height: 43px;
          background-color: #131313;
          display: inline-block;
          border-radius: 7px;
          margin: 10px;

          svg {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translateX(-50%) translateY(-50%);
          }
        }

        .arrow:first-child {
          margin-right: 30px;
        }

        .arrow:last-child {
          margin-left: 30px;
        }

        .arrow:hover {
          cursor: pointer;
          background: #0A0A0A;
        }

        .pages {
          display: flex;
          align-items: center;

          > div {
            position: relative;
            width: 43px;
            height: 43px;
            background-color: #131313;
            display: inline-block;
            margin: 1px;
            line-height: 43px;
            font-weight: 600;
            box-sizing: border-box;

            > span {
              position: absolute;
              left: 50%;
              top: 50%;
              transform: translateX(-50%) translateY(-50%);
              box-sizing: border-box;
            }
          }

          > div:first-child {
            border-top-left-radius: 7px;
            border-bottom-left-radius: 7px;
          }

          > div:last-child {
            border-top-right-radius: 7px;
            border-bottom-right-radius: 7px;
          }

          > div:hover {
            cursor: pointer;
            background: #0A0A0A;
          }
        }
      }
    }
  }
</style>
