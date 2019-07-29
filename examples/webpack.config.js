const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  mode: "development",
  context: __dirname,
  entry: {
    counter: path.resolve(__dirname, "counter/index.js"),
    "sign-up": path.resolve(__dirname, "sign-up/index.js")
  },
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "[name].js"
  },
  module: {
    rules: [
      {
        test: /\.purs$/,
        exclude: /node_modules/,
        use: [
          {
            loader: "purs-loader",
            options: {
              psc: "psa",
              src: [
                "./.spago/*/*/src/**/*.purs",
                "../src/**/*.purs",
                "./counter/**/*.purs",
                "./sign-up/**/*.purs"
              ]
            }
          }
        ]
      },
      {
        test: /\.css$/,
        use: [{ loader: "style-loader" }, { loader: "css-loader" }]
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: "counter",
      chunks: ["counter"],
      filename: "counter.html"
    }),
    new HtmlWebpackPlugin({
      title: "sign-up",
      chunks: ["sign-up"],
      filename: "sign-up.html"
    })
  ],
  devServer: {
    publicPath: "/",
    contentBase: path.resolve(__dirname, "dist"),
    port: 8080,
    stats: "errors-only",
    progress: true,
    inline: true,
    hot: true
  }
};
