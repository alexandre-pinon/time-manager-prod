/* eslint-disable @typescript-eslint/no-explicit-any */
export const handleError = (source: string, err: Record<string, any>): void => {
  console.error("API | " + source + " > ", err);
};

export const chainPromises = async (queries: Array<any>): Promise<any> => {
  return await Promise.all(queries);
};

export const hexToRGB = (hex: string, alpha: string): string => {
  const r = parseInt(hex.slice(1, 3), 16);
  const g = parseInt(hex.slice(3, 5), 16);
  const b = parseInt(hex.slice(5, 7), 16);
  return `rgba(${r}, ${g}, ${b}, ${alpha || "1"})`;
};
