
zero_local_aggregate_no_template.aarch64:	file format elf64-littleaarch64

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

<seven>:
               	mov	x0, #0x7                // =7
               	ret

<label_template>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x1, x0
               	stur	w1, [x29, #-0x20]
               	sub	x0, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sxtw	x1, w1
               	ldr	x0, [x0, x1, lsl #3]
               	br	x0
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x210
               	str	x20, [sp]
               	mov	x2, #0x1                // =1
               	mov	x0, x2
               	sub	x1, x29, #0x10
               	str	xzr, [x1]
               	str	wzr, [x1, #0x8]
               	mov	x0, x2
               	mov	x0, x2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x1, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x1, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x1, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, x2
               	mov	x0, #0x9                // =9
               	stp	xzr, xzr, [x1]
               	str	w0, [x1]
               	mov	x0, #0x0                // =0
               	str	w0, [x1, #0x4]
               	str	w0, [x1, #0x8]
               	str	w0, [x1, #0xc]
               	mov	x1, x2
               	mov	x1, x2
               	sub	x1, x29, #0x200
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	stp	xzr, xzr, [x1, #0x40]
               	stp	xzr, xzr, [x1, #0x50]
               	stp	xzr, xzr, [x1, #0x60]
               	stp	xzr, xzr, [x1, #0x70]
               	stp	xzr, xzr, [x1, #0x80]
               	stp	xzr, xzr, [x1, #0x90]
               	stp	xzr, xzr, [x1, #0xa0]
               	stp	xzr, xzr, [x1, #0xb0]
               	stp	xzr, xzr, [x1, #0xc0]
               	stp	xzr, xzr, [x1, #0xd0]
               	stp	xzr, xzr, [x1, #0xe0]
               	stp	xzr, xzr, [x1, #0xf0]
               	stp	xzr, xzr, [x1, #0x100]
               	stp	xzr, xzr, [x1, #0x110]
               	stp	xzr, xzr, [x1, #0x120]
               	stp	xzr, xzr, [x1, #0x130]
               	stp	xzr, xzr, [x1, #0x140]
               	stp	xzr, xzr, [x1, #0x150]
               	stp	xzr, xzr, [x1, #0x160]
               	stp	xzr, xzr, [x1, #0x170]
               	stp	xzr, xzr, [x1, #0x180]
               	stp	xzr, xzr, [x1, #0x190]
               	stp	xzr, xzr, [x1, #0x1a0]
               	stp	xzr, xzr, [x1, #0x1b0]
               	stp	xzr, xzr, [x1, #0x1c0]
               	stp	xzr, xzr, [x1, #0x1d0]
               	stp	xzr, xzr, [x1, #0x1e0]
               	add	x17, x1, #0x1f0
               	stp	xzr, xzr, [x17]
               	cmp	w0, #0x200
               	b.ge	<addr>
               	sxtw	x2, w0
               	ldrb	w2, [x1, x2]
               	cbnz	x2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x1                // =1
               	mov	x2, x1
               	mov	x2, x1
               	stp	xzr, xzr, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	mov	x20, #0x0               // =0
               	str	w20, [x0, #0x8]
               	bl	<addr>
               	cmp	w0, #0x7
               	b.ne	<addr>
               	mov	x20, #0x1               // =1
               	cbnz	x20, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
