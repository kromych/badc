
struct_stack_arg_then_scalar.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x68
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	mov	x17, #0xd40             // =3392
               	movk	x17, #0x3, lsl #16
               	add	x0, x0, x17
               	mov	x17, #0x1b58            // =7000
               	add	x0, x0, x17
               	add	x0, x0, #0xfa0
               	add	x0, x0, #0x1e
               	add	x0, x0, #0x3
               	add	x0, x0, #0x5
               	mov	x17, #0x7a9e            // =31390
               	movk	x17, #0x12, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
