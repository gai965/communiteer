module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/**/*.js.erb',
    './app/helpers/**/*.rb',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    screens: {
      'xs': '430px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
      '2xl': '1536px',
    },
    inset: {
      0: 0,
      8: '2rem',
      10: '2.5rem',
      14: '3.5rem', 
      '1/10': '10%',
      '1/20': '5%',
    },
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
      backgroundImage: theme => ({
        'right-arrow': "url('../../assets/images/right_arrow.png')",
        'left-arrow' : "url('../../assets/images/left_arrow.png')",
      }),
      borderWidth: ['hover'],
    },
  },
  variants: {
    extend: {
      borderWidth: ['group-hover']
    }
  },
  plugins: [],
}
