
for_init_decl_in_loop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, #0x0                // =0
               	mov	x1, #0x1                // =1
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w2
               	ret
               	sxtw	x0, w3
               	cmp	x0, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	b	<addr>
               	sxtw	x0, w2
               	sxtw	x2, w1
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	sxtw	x2, w2
               	sxtw	x4, w3
               	add	x2, x2, x4
               	sxtw	x2, w2
               	add	x2, x0, x2
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	x17, #0x4060            // =16480
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
