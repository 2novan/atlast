module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
              backgroundImage: theme => ({
'home': "url('/assets/images/concert.jpg')",
        })
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
