
vla_param_decay.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x4, x0
               	mov	x6, x2
               	mov	x5, x1
               	sxtw	x4, w4
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	lsl	x3, x2, #2
               	add	x7, x5, x3
               	ldrsw	x7, [x7]
               	add	x3, x6, x3
               	ldrsw	x3, [x3]
               	mul	x3, x7, x3
               	add	x1, x1, x3
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, x4
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x4                // =4
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x20
               	bl	<addr>
               	cmp	x0, #0x46
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
