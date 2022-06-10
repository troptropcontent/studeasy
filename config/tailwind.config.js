const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  purge: {
    safelist: [
      'grid-cols-1',
      'grid-cols-2',
      'grid-cols-3',
      'grid-cols-4',
      'grid-cols-5',
      'grid-cols-6',
      'grid-cols-7',
      'grid-cols-8',
      'grid-cols-9',
      'grid-cols-10',
    ],
  },
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        body: ['Montserrat', 'sans-serif'],
        title: ['Bebas Neue', 'cursive'],
      },
      flex: {
        '2': '2 2 0%',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
