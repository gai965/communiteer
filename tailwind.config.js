module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      spacing: {
        112: '28rem',
        120: '30rem',
        128: '32rem',
        148: '36rem',
        160: '40rem',
        176: '44rem',
        192: '48rem',
        224: '56rem',
        240: '60rem',
      },
    }
  },
  variants: {
    extend: {
      borderWidth: ['group-hover']
    }
  },
  plugins: [],
}
