
vla_param_decay.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	mov	x4, #0x0                // =0
               	mov	x3, x4
               	sxtw	x5, w4
               	cmp	x5, x0
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x4, w4
               	add	x4, x4, #0x1
               	b	<addr>
               	sxtw	x5, w4
               	lsl	x5, x5, #2
               	add	x6, x1, x5
               	ldrsw	x6, [x6]
               	add	x5, x2, x5
               	ldrsw	x5, [x5]
               	mul	x5, x6, x5
               	add	x3, x3, x5
               	b	<addr>
               	sxtw	x0, w3
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
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
