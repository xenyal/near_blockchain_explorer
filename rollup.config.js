import babel from '@rollup/plugin-babel';
import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import replace from '@rollup/plugin-replace';

import { terser } from 'rollup-plugin-terser';

export default {
  input: 'app/javascript/application.js',
  output: {
    file: 'app/assets/builds/application.js',
    format: 'iife',
    sourcemap: true,
  },
  plugins: [
    replace({
      'process.env.NODE_ENV': JSON.stringify('production')
    }),
    resolve({
      extensions: ['.js', '.jsx']
    }),
    babel({
      babelHelpers: 'bundled',
      exclude: 'node_modules/**',
      extensions: ['.js', '.jsx'],
      presets: [
        '@babel/preset-env',
        '@babel/preset-react'
      ]
    }),
    commonjs(),
    terser()
  ],
};
