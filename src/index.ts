import { readFile } from "node:fs/promises"
import { Plugin } from "@opencode/plugin"

const source = await readFile(new URL("../SKILL.md", import.meta.url), "utf8")
const instructions = source.replace(/^---\r?\n[\s\S]*?\r?\n---\r?\n/, "").trim()

export default Plugin.define({
  id: "token-guard",
  async setup(ctx) {
    const context = await ctx.session.hook("context", (event) => {
      event.system.push({ type: "text", text: instructions })
    })

    return async () => {
      await context.dispose()
    }
  },
})
