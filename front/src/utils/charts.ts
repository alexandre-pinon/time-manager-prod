/* eslint-disable @typescript-eslint/no-explicit-any */
import _ from "lodash";

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
      const borderColor = `rgba(${_.trimStart(_.trimEnd(color, ")"), "rgba(")
        .split(",")
        .map((val: any, idx: number) => Math.max(idx < 3 ? +val / 1.25 : 1, 0))
        .join(",")})`;
      console.log({ color, borderColor });
      return {
        label: key,
        data: val,
        backgroundColor: color,
        borderColor,
        borderWidth: 3,
      };
    }),
    hoverOffset,
    ...restOpts,
  };
};

export const chartOptions = {
  responsive: true,
  lineTension: 1,
  scales: {
    yAxes: [
      {
        ticks: {
          beginAtZero: true,
          padding: 25,
        },
      },
    ],
  },
};
