
over_aligned_local_in_an_inlined_function.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	add	x0, sp, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	add	x8, sp, #0x20
               	mov	x0, #0x0                // =0
               	str	w0, [sp, #0x20]
               	mov	x1, #0x1                // =1
               	str	w1, [sp, #0x24]
               	mov	x2, #0x2                // =2
               	str	w2, [sp, #0x28]
               	mov	x3, #0x3                // =3
               	str	w3, [sp, #0x2c]
               	mov	x4, #0x4                // =4
               	str	w4, [sp, #0x30]
               	mov	x5, #0x5                // =5
               	str	w5, [sp, #0x34]
               	mov	x6, #0x6                // =6
               	str	w6, [sp, #0x38]
               	mov	x7, #0x7                // =7
               	str	w7, [sp, #0x3c]
               	and	x8, x8, #0x1f
               	cbz	x8, <addr>
               	mov	x8, #0x3e8              // =1000
               	ldrsw	x9, [sp, #0x24]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0x28]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0x2c]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0x30]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0x34]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0x38]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0x3c]
               	add	x8, x8, x9
               	mov	x9, sp
               	strb	w0, [sp]
               	strb	w1, [sp, #0x1]
               	strb	w2, [sp, #0x2]
               	and	x1, x9, #0x3f
               	cbz	x1, <addr>
               	mov	x0, #0x3e8              // =1000
               	ldrb	w1, [sp, #0x1]
               	add	x0, x0, x1
               	ldrb	w1, [sp, #0x2]
               	add	x0, x0, x1
               	add	x8, x8, x0
               	mov	x0, #0x1                // =1
               	str	w0, [sp, #0x20]
               	add	x0, sp, #0x20
               	mov	x1, #0x2                // =2
               	str	w1, [sp, #0x24]
               	str	w3, [sp, #0x28]
               	str	w4, [sp, #0x2c]
               	str	w5, [sp, #0x30]
               	str	w6, [sp, #0x34]
               	str	w7, [sp, #0x38]
               	mov	x2, #0x8                // =8
               	str	w2, [sp, #0x3c]
               	and	x0, x0, #0x1f
               	cbz	x0, <addr>
               	mov	x0, #0x3e8              // =1000
               	ldrsw	x1, [sp, #0x20]
               	add	x0, x0, x1
               	ldrsw	x1, [sp, #0x24]
               	add	x0, x0, x1
               	ldrsw	x1, [sp, #0x28]
               	add	x0, x0, x1
               	ldrsw	x1, [sp, #0x2c]
               	add	x0, x0, x1
               	ldrsw	x1, [sp, #0x30]
               	add	x0, x0, x1
               	ldrsw	x1, [sp, #0x34]
               	add	x0, x0, x1
               	add	x3, sp, #0x20
               	ldrsw	x1, [sp, #0x38]
               	add	x0, x0, x1
               	ldrsw	x1, [sp, #0x3c]
               	add	x4, x0, x1
               	mov	x1, sp
               	mov	x0, #0x1                // =1
               	strb	w0, [sp]
               	strb	w0, [sp, #0x1]
               	mov	x0, #0x2                // =2
               	strb	w0, [sp, #0x2]
               	and	x1, x1, #0x3f
               	cbz	x1, <addr>
               	mov	x1, #0x3e8              // =1000
               	ldrb	w5, [sp]
               	add	x1, x1, x5
               	ldrb	w5, [sp, #0x1]
               	add	x1, x1, x5
               	ldrb	w5, [sp, #0x2]
               	add	x1, x1, x5
               	add	x1, x4, x1
               	add	x4, x8, x1
               	str	w0, [sp, #0x20]
               	mov	x1, #0x3                // =3
               	str	w1, [sp, #0x24]
               	mov	x1, #0x4                // =4
               	str	w1, [sp, #0x28]
               	mov	x1, #0x5                // =5
               	str	w1, [sp, #0x2c]
               	mov	x1, #0x6                // =6
               	str	w1, [sp, #0x30]
               	mov	x1, #0x7                // =7
               	str	w1, [sp, #0x34]
               	str	w2, [sp, #0x38]
               	mov	x1, #0x9                // =9
               	str	w1, [sp, #0x3c]
               	and	x1, x3, #0x1f
               	cbz	x1, <addr>
               	mov	x1, #0x3e8              // =1000
               	ldrsw	x2, [sp, #0x20]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x24]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x28]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x2c]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x30]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x34]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x38]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x3c]
               	add	x1, x1, x2
               	mov	x2, sp
               	strb	w0, [sp]
               	mov	x3, #0x1                // =1
               	strb	w3, [sp, #0x1]
               	strb	w0, [sp, #0x2]
               	and	x0, x2, #0x3f
               	cbz	x0, <addr>
               	mov	x0, #0x3e8              // =1000
               	ldrb	w2, [sp]
               	add	x0, x0, x2
               	ldrb	w2, [sp, #0x1]
               	add	x0, x0, x2
               	ldrb	w2, [sp, #0x2]
               	add	x0, x0, x2
               	add	x0, x1, x0
               	add	x0, x4, x0
               	cmp	w0, #0x78
               	b.ne	<addr>
               	add	x0, sp, #0x40
               	and	x0, x0, #0xf
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x8, x0
               	b	<addr>
