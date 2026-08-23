
vla_param_decay.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	sub	x5, x29, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x5]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	sub	x6, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x6]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x6, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x6
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	lsl	x3, x2, #2
               	add	x4, x5, x3
               	ldrsw	x4, [x4]
               	add	x3, x6, x3
               	ldrsw	x3, [x3]
               	madd	x1, x4, x3, x1
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sxtw	x0, w1
               	cmp	w0, #0x46
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
