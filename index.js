import { Telegraf } from "telegraf";
import { ChatGPTAPIBrowser } from "chatgpt";

const bot = new Telegraf(process.env.BOT_TOKEN);
const api = new ChatGPTAPIBrowser({
  email: process.env.OPENAI_EMAIL,
  password: process.env.OPENAI_PASSWORD,
  isMicrosoftLogin: true,
  markdown: true,
});

(async () => {
  await api.initSession();
})();

bot.start((ctx) => ctx.reply("Welcome"));
bot.help((ctx) => ctx.reply("Send me a sticker"));

// Reply to all other messages
bot.on("message", async (ctx) => {
  const message = ctx.message.text;
  const thinkMSG = (await ctx.reply(`Thinking...`)).message_id;
  const result = await api.sendMessage(message);
  ctx.deleteMessage(thinkMSG);
  ctx.reply(result.response, { parse_mode: "Markdown" });
});

bot.launch();
