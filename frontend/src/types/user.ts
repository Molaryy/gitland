import {z} from "zod";

export const userSchema = z.object({
    address: z.string(),
    username: z.string(),
});
export const usersSchema = z.array(userSchema);
export type User = z.infer<typeof userSchema>;
