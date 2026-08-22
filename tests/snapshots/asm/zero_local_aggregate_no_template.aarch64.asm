
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
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #0x10]
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x10
               	sxtw	x0, w0
               	ldr	x0, [x1, x0, lsl #3]
               	br	x0
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x1                // =1
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	w1, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x2, #0x9                // =9
               	sub	x1, x29, #0x18
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x18
               	str	w2, [x1]
               	sub	x1, x29, #0x18
               	str	w0, [x1, #0x4]
               	sub	x1, x29, #0x18
               	str	w0, [x1, #0x8]
               	sub	x1, x29, #0x18
               	str	w0, [x1, #0xc]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1]
               	cmp	x1, #0x9
               	cset	x1, eq
               	cbz	x1, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x208
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x1, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x1, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [x1, #0x50]
               	str	x10, [x0, #0x50]
               	ldr	x10, [x1, #0x58]
               	str	x10, [x0, #0x58]
               	ldr	x10, [x1, #0x60]
               	str	x10, [x0, #0x60]
               	ldr	x10, [x1, #0x68]
               	str	x10, [x0, #0x68]
               	ldr	x10, [x1, #0x70]
               	str	x10, [x0, #0x70]
               	ldr	x10, [x1, #0x78]
               	str	x10, [x0, #0x78]
               	ldr	x10, [x1, #0x80]
               	str	x10, [x0, #0x80]
               	ldr	x10, [x1, #0x88]
               	str	x10, [x0, #0x88]
               	ldr	x10, [x1, #0x90]
               	str	x10, [x0, #0x90]
               	ldr	x10, [x1, #0x98]
               	str	x10, [x0, #0x98]
               	ldr	x10, [x1, #0xa0]
               	str	x10, [x0, #0xa0]
               	ldr	x10, [x1, #0xa8]
               	str	x10, [x0, #0xa8]
               	ldr	x10, [x1, #0xb0]
               	str	x10, [x0, #0xb0]
               	ldr	x10, [x1, #0xb8]
               	str	x10, [x0, #0xb8]
               	ldr	x10, [x1, #0xc0]
               	str	x10, [x0, #0xc0]
               	ldr	x10, [x1, #0xc8]
               	str	x10, [x0, #0xc8]
               	ldr	x10, [x1, #0xd0]
               	str	x10, [x0, #0xd0]
               	ldr	x10, [x1, #0xd8]
               	str	x10, [x0, #0xd8]
               	ldr	x10, [x1, #0xe0]
               	str	x10, [x0, #0xe0]
               	ldr	x10, [x1, #0xe8]
               	str	x10, [x0, #0xe8]
               	ldr	x10, [x1, #0xf0]
               	str	x10, [x0, #0xf0]
               	ldr	x10, [x1, #0xf8]
               	str	x10, [x0, #0xf8]
               	ldr	x10, [x1, #0x100]
               	str	x10, [x0, #0x100]
               	ldr	x10, [x1, #0x108]
               	str	x10, [x0, #0x108]
               	ldr	x10, [x1, #0x110]
               	str	x10, [x0, #0x110]
               	ldr	x10, [x1, #0x118]
               	str	x10, [x0, #0x118]
               	ldr	x10, [x1, #0x120]
               	str	x10, [x0, #0x120]
               	ldr	x10, [x1, #0x128]
               	str	x10, [x0, #0x128]
               	ldr	x10, [x1, #0x130]
               	str	x10, [x0, #0x130]
               	ldr	x10, [x1, #0x138]
               	str	x10, [x0, #0x138]
               	ldr	x10, [x1, #0x140]
               	str	x10, [x0, #0x140]
               	ldr	x10, [x1, #0x148]
               	str	x10, [x0, #0x148]
               	ldr	x10, [x1, #0x150]
               	str	x10, [x0, #0x150]
               	ldr	x10, [x1, #0x158]
               	str	x10, [x0, #0x158]
               	ldr	x10, [x1, #0x160]
               	str	x10, [x0, #0x160]
               	ldr	x10, [x1, #0x168]
               	str	x10, [x0, #0x168]
               	ldr	x10, [x1, #0x170]
               	str	x10, [x0, #0x170]
               	ldr	x10, [x1, #0x178]
               	str	x10, [x0, #0x178]
               	ldr	x10, [x1, #0x180]
               	str	x10, [x0, #0x180]
               	ldr	x10, [x1, #0x188]
               	str	x10, [x0, #0x188]
               	ldr	x10, [x1, #0x190]
               	str	x10, [x0, #0x190]
               	ldr	x10, [x1, #0x198]
               	str	x10, [x0, #0x198]
               	ldr	x10, [x1, #0x1a0]
               	str	x10, [x0, #0x1a0]
               	ldr	x10, [x1, #0x1a8]
               	str	x10, [x0, #0x1a8]
               	ldr	x10, [x1, #0x1b0]
               	str	x10, [x0, #0x1b0]
               	ldr	x10, [x1, #0x1b8]
               	str	x10, [x0, #0x1b8]
               	ldr	x10, [x1, #0x1c0]
               	str	x10, [x0, #0x1c0]
               	ldr	x10, [x1, #0x1c8]
               	str	x10, [x0, #0x1c8]
               	ldr	x10, [x1, #0x1d0]
               	str	x10, [x0, #0x1d0]
               	ldr	x10, [x1, #0x1d8]
               	str	x10, [x0, #0x1d8]
               	ldr	x10, [x1, #0x1e0]
               	str	x10, [x0, #0x1e0]
               	ldr	x10, [x1, #0x1e8]
               	str	x10, [x0, #0x1e8]
               	ldr	x10, [x1, #0x1f0]
               	str	x10, [x0, #0x1f0]
               	ldr	x10, [x1, #0x1f8]
               	str	x10, [x0, #0x1f8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x208
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x200
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	sub	x0, x29, #0x18
               	mov	x20, #0x0               // =0
               	str	x20, [x0]
               	str	x20, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x0, x29, #0x18
               	str	w20, [x0, #0x8]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0]
               	mov	x9, x0
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x20, ne
               	sxtw	x0, w20
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
