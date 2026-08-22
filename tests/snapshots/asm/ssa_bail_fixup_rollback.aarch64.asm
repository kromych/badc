
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
               	mov	x8, x0
               	add	x0, x3, #0x0
               	ldr	w0, [x0]
               	mov	w4, w0
               	add	x0, x3, #0x4
               	ldr	w0, [x0]
               	mov	w5, w0
               	add	x0, x3, #0x8
               	ldr	w0, [x0]
               	mov	w6, w0
               	add	x0, x3, #0xc
               	ldr	w0, [x0]
               	mov	w3, w0
               	mov	x0, #0x0                // =0
               	mov	w1, w4
               	mov	w2, w5
               	eor	x1, x1, x2
               	mov	w2, w6
               	eor	x1, x1, x2
               	mov	w2, w3
               	eor	x1, x1, x2
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x8]
               	ret

<stream_xor>:
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x21, x0
               	mov	x23, x4
               	mov	x20, #0x0               // =0
               	mov	x22, #0x40              // =64
               	sub	x0, x29, #0x50
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x50
               	add	x0, x0, #0x0
               	add	x1, x3, #0x0
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	sub	x0, x29, #0x50
               	ldrb	w1, [x3, #0x1]
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x50
               	ldrb	w1, [x3, #0x2]
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x50
               	ldrb	w1, [x3, #0x3]
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x50
               	ldrb	w1, [x3, #0x4]
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x50
               	ldrb	w1, [x3, #0x5]
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x50
               	ldrb	w1, [x3, #0x6]
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x50
               	ldrb	w1, [x3, #0x7]
               	strb	w1, [x0, #0x7]
               	b	<addr>
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x50
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x2, x23
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x2, x21, x1
               	cbz	x20, <addr>
               	mov	w1, w0
               	add	x1, x20, x1
               	ldrb	w1, [x1]
               	sub	x3, x29, #0x40
               	mov	w4, w0
               	add	x3, x3, x4
               	ldrb	w3, [x3]
               	eor	x1, x1, x3
               	strb	w1, [x2]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x40
               	b.lo	<addr>
               	sub	x22, x22, #0x40
               	add	x21, x21, #0x40
               	cbz	x20, <addr>
               	add	x20, x20, #0x40
               	b	<addr>
               	cmp	x22, #0x40
               	b.hs	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
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
               	b	<addr>
               	sub	x2, x29, #0x20
               	add	x2, x2, x1
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x20
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
