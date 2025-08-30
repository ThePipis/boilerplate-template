import { Controller, Get } from "@nestjs/common";

import { AppService } from "./app.service";

@Controller()
export class AppController {
  constructor(private readonly app: AppService) {}
  @Get("health") health() { return { ok: true, service: "api" }; }
  @Get("hello")  hello()  { return this.app.hello(); }
}
