import { NestFactory } from "@nestjs/core";

import { AppModule } from "./app.module";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.setGlobalPrefix("api");
  await app.listen(process.env.PORT ? Number(process.env.PORT) : 3001);
  // eslint-disable-next-line no-console
  console.log(`API up on http://127.0.0.1:${process.env.PORT ?? 3001}/api`);
}
bootstrap();
