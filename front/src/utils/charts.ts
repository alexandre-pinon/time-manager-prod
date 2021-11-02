/* eslint-disable @typescript-eslint/no-explicit-any */
import _ from "lodash";
import { hexToRGB } from "./helpers";

export const generateChartData = function (
  series: Record<string, Array<number>> = {},
  labels: Array<any> = [],
  colors: Array<string> = [],
  opts: Record<string, any> = {}
): Record<string, any> {
  const { hoverOffset = 2, ...restOpts } = opts;
  const length: any = _.maxBy(_.values(series), "length")?.length;
  if (!length || labels?.length !== length) return {};
  return {
    labels,
    datasets: _.map(series, (val: Array<number>, key: string) => {
      if (val?.length !== length) return;
      const color =
        colors?.length > 1
          ? colors[_.keys(series).indexOf(key)] || "rgba(71, 183,132,.5)"
          : colors[0];
      const borderColor = `rgba(${_.trimStart(
        _.trimEnd(color[0] === "#" ? hexToRGB(color, "1") : color, ")"),
        "rgba("
      )
        .split(",")
        .map((val: any, idx: number) => Math.max(idx < 3 ? +val / 1.25 : 1, 0))
        .join(",")})`;
      console.log({ color, borderColor });
      return {
        label: key,
        data: val,
        color: chartColors.textColor,
        backgroundColor: color,
        borderColor,
        borderWidth: 3,
      };
    }),
    hoverOffset,
    ...restOpts,
  };
};

export const chartColors = {
  appColor: "#2B4162",
  layerColor: "#385F71",
  borderColor: "#518AA4",
  textColor: "#F5F0F6",
  accentColor: "#49A078",
  hoverColor: "#81D986",
};

export const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  lineTension: 1,
  plugins: {
    legend: {
      labels: {
        color: chartColors.textColor,
      },
    },
  },
  scales: {
    y: {
      grid: {
        color: chartColors.borderColor,
      },
      ticks: {
        color: chartColors.textColor,
        beginAtZero: true,
        padding: 25,
      },
    },
    x: {
      grid: {
        color: chartColors.borderColor,
      },
      ticks: {
        color: chartColors.textColor,
      },
    },
  },
};
