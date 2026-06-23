
large_stack_frame.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	sub	sp, sp, #0x2c0
               	sxtw	x0, w0
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	add	sp, sp, #0x2c0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	mov	x0, #0x28               // =40
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ret
