/* eslint-disable @typescript-eslint/no-explicit-any */
import _ from "lodash";
import { hexToRGB } from "./helpers";

export const chartColors = {
  appColor: "#1e303c",
  borderColor: "#374955",
  textColor: "#e6f4f1",
  primaryColor: "#008abb",
  secondaryColor: "#ec9929",
  tertiaryColor: "#009467",
  quaternaryColor: "#cf5c5c",
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

export const generateBorderColor = function (color: string): string {
  return `rgba(${_.trimStart(
    _.trimEnd(color[0] === "#" ? hexToRGB(color, "1") : color, ")"),
    "rgba("
  )
    .split(",")
    .map((val: any, idx: number) => Math.max(idx < 3 ? +val / 1.25 : 1, 0))
    .join(",")})`;
};

export const generateChartProps = function (
  type: string,
  series: Record<string, Array<number>> = {},
  labels: Array<any> = [],
  colors: Array<string> = [],
  opts: Record<string, any> = {},
  options: Record<string, any> = chartOptions
): Record<string, any> {
  return {
    type,
    options,
    data: generateChartData(series, labels, colors, opts, type),
  };
};

export const generateChartData = function (
  series: Record<string, Array<number>> = {},
  labels: Array<any> = [],
  colors: Array<string> = [],
  opts: Record<string, any> = {},
  type: string
): Record<string, any> {
  const { hoverOffset = 2, ...restOpts } = opts;
  const length: any = _.maxBy(_.values(series), "length")?.length;
  if (!length || labels?.length !== length) return {};
  console.log({ series, labels, colors, type });
  const isPie = (): boolean => type === "pie";
  return {
    labels,
    datasets: _.map(series, (val: Array<number>, key: string) => {
      if (val?.length !== length) return;
      let color;
      if (!isPie()) {
        color =
          colors?.length > 1
            ? colors[_.keys(series).indexOf(key)] || "rgba(71, 183,132,.5)"
            : colors[0];
      }
      return {
        label: key,
        data: val,
        color: chartColors.textColor,
        backgroundColor: isPie()
          ? val.map((v: any, idx: number) => colors[idx] || colors[0])
          : color,
        borderColor: isPie()
          ? val.map((v: any, idx: number) =>
              colors[idx] !== undefined
                ? generateBorderColor(colors[idx])
                : generateBorderColor(colors[0])
            )
          : generateBorderColor(color as string),
        borderWidth: 3,
      };
    }),
    hoverOffset,
    ...restOpts,
  };
};
