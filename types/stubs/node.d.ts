declare namespace NodeJS { interface ProcessEnv { [k: string]: string | undefined; } interface Process { env: ProcessEnv; } }
declare var process: NodeJS.Process;
 