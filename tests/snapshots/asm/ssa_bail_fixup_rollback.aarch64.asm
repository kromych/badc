
ssa_bail_fixup_rollback.aarch64:	file format elf64-littleaarch64

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

<core>:
               	mov	x7, x0
               	add	x0, x3, #0x0
               	ldr	w0, [x0]
               	mov	w0, w0
               	ldr	w4, [x3, #0x4]
               	mov	w4, w4
               	ldr	w5, [x3, #0x8]
               	mov	w5, w5
               	ldr	w3, [x3, #0xc]
               	mov	w3, w3
               	mov	x1, #0x0                // =0
               	mov	w0, w0
               	mov	w2, w4
               	eor	x0, x0, x2
               	mov	w2, w5
               	eor	x0, x0, x2
               	mov	w2, w3
               	eor	x0, x0, x2
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x7]
               	mov	x0, x1
               	ret

<stream_xor>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x21, x0
               	mov	x24, x4
               	mov	x20, #0x0               // =0
               	mov	x23, #0x40              // =64
               	sub	x0, x29, #0x50
               	str	x20, [x0]
               	str	x20, [x0, #0x8]
               	add	x1, x0, #0x0
               	add	x2, x3, #0x0
               	ldrb	w2, [x2]
               	strb	w2, [x1]
               	ldrb	w1, [x3, #0x1]
               	strb	w1, [x0, #0x1]
               	ldrb	w1, [x3, #0x2]
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x3, #0x3]
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x3, #0x4]
               	strb	w1, [x0, #0x4]
               	ldrb	w1, [x3, #0x5]
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x3, #0x6]
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x3, #0x7]
               	strb	w1, [x0, #0x7]
               	b	<addr>
               	sub	x22, x29, #0x40
               	sub	x1, x29, #0x50
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x22
               	mov	x2, x24
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	b	<addr>
               	add	x4, x21, x1
               	cbz	x20, <addr>
               	add	x3, x20, x1
               	ldrb	w3, [x3]
               	add	x5, x22, x1
               	ldrb	w5, [x5]
               	eor	x3, x3, x5
               	strb	w3, [x4]
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	add	x0, x1, #0x1
               	mov	w1, w0
               	cmp	w1, #0x40
               	b.lo	<addr>
               	sub	x23, x23, #0x40
               	add	x21, x21, #0x40
               	cbz	x20, <addr>
               	add	x20, x20, #0x40
               	b	<addr>
               	cmp	x23, #0x40
               	b.hs	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x2, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x20
               	sxtw	x1, w0
               	add	x3, x3, x1
               	and	x4, x1, x2
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x0, x29, #0x68
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	sub	x3, x29, #0x28
               	sub	x4, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x68
               	ldrb	w0, [x0]
               	mov	x17, #0x4d              // =77
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
