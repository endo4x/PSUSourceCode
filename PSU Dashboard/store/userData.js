export const state = () => ({
  perms: [],
  notifications: [],
  notificationsUnread: false,
  currentUser: null,
  // currentUser: {
  //   id: 100,
  //   email: 'testuser@gmail.com',
  //   username: 'Amadeus',
  //   first_name: 'Wolfgang',
  //   last_name: 'Amadeus Mozart',
  //   avatar: '',
  //   discord_id: '750076727350263908',
  //   role_id: 2,
  //   last_login: '2020-11-30 13:00',
  //   email_verified_at: '2020-11-30 13:00',
  //   remember_token: 'AFAKETOKEN',
  //   created_at: '2020-11-30 09:00',
  //   updated_at: '2020-11-30 09:00',
  //   announcements_last_read_at: '2020-11-30 11:00',
  //   api_enabled: true,
  //   api_key: '0d8498008189f1dd8563f240440d2df7cd4b'
  // },
  authToken: false,
  signedIn: false
})

export const mutations = {
  SET_USER (state, userData) {
    state.userRank = 4
    state.currentUser = userData
  },
  ADD_NOTIFICATION (state, notification) {
    state.notification.push(notification)
    state.notificationsUnread = true
  },
  SETTOKEN (state, token) {
    state.authToken = token
    state.signedIn = true
  },
  SIGNOUT (state) {
    state.authToken = null
    state.signedIn = false
  },
  SET_APITOKEN (state, token) {
    state.currentUser.api_key = token
  },
  SET_PERMS (state, perms) {
    state.perms = perms
  }
}
