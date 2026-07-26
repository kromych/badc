
pthread_create.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x3f0              // =1008
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<thread_main>:
               	mov	x0, #0xb                // =11
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x20, #0x0               // =0
               	mov	x1, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x21, x0
               	sub	x0, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x9, x22
               	mov	x1, x20
               	mov	x3, x20
               	blr	x9
               	ldur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x8
               	mov	x9, x21
               	blr	x9
               	ldur	x0, [x29, #-0x8]
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
