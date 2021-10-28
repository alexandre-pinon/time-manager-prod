/* eslint-disable @typescript-eslint/no-explicit-any */
export const handleError = (source: string, err: Record<string, any>): void => {
  console.error("API | " + source + " > ", err);
};

export const chainPromises = async (queries: Array<any>): Promise<any> => {
  return await Promise.all(queries);
};
