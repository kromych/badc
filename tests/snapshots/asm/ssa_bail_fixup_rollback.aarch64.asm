
ssa_bail_fixup_rollback.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldrb	w1, [x0, #0x3]
               	mov	w1, w1
               	lsl	x1, x1, #8
               	mov	w1, w1
               	ldrb	w2, [x0, #0x2]
               	orr	x1, x1, x2
               	mov	w1, w1
               	lsl	x1, x1, #8
               	mov	w1, w1
               	ldrb	w2, [x0, #0x1]
               	orr	x1, x1, x2
               	mov	w1, w1
               	lsl	x1, x1, #8
               	mov	w1, w1
               	ldrb	w0, [x0]
               	orr	x0, x1, x0
               	ret

<core>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	mov	x20, x0
               	mov	x23, x3
               	mov	x22, x2
               	mov	x21, x1
               	mov	x24, #0x0               // =0
               	sxtw	x0, w24
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x24, x0, #0x1
               	b	<addr>
               	sub	x25, x29, #0x40
               	sxtw	x0, w24
               	mov	x17, #0x5               // =5
               	mul	x1, x0, x17
               	sxtw	x26, w1
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	add	x0, x23, x0
               	bl	<addr>
               	str	w0, [x25, x26, lsl #2]
               	sub	x25, x29, #0x40
               	sxtw	x0, w24
               	add	x1, x0, #0x1
               	sxtw	x26, w1
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	add	x0, x22, x0
               	bl	<addr>
               	str	w0, [x25, x26, lsl #2]
               	sub	x25, x29, #0x40
               	sxtw	x0, w24
               	add	x1, x0, #0x6
               	sxtw	x26, w1
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	add	x0, x21, x0
               	bl	<addr>
               	str	w0, [x25, x26, lsl #2]
               	sub	x25, x29, #0x40
               	sxtw	x0, w24
               	add	x1, x0, #0xb
               	sxtw	x26, w1
               	add	x1, x22, #0x10
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	add	x0, x1, x0
               	bl	<addr>
               	str	w0, [x25, x26, lsl #2]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x40
               	ldr	w1, [x1]
               	sub	x2, x29, #0x40
               	ldr	w2, [x2, #0x14]
               	eor	x1, x1, x2
               	sub	x2, x29, #0x40
               	ldr	w2, [x2, #0x28]
               	eor	x1, x1, x2
               	sub	x2, x29, #0x40
               	ldr	w2, [x2, #0x3c]
               	eor	x1, x1, x2
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret

<stream_xor>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x21, x0
               	mov	x20, x4
               	mov	x23, x2
               	mov	x22, x1
               	cmp	x23, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	w0, w1
               	cmp	x0, #0x10
               	b.hs	<addr>
               	b	<addr>
               	mov	w0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x10
               	mov	w2, w1
               	add	x0, x0, x2
               	mov	x2, #0x0                // =0
               	strb	w2, [x0]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	w0, w1
               	cmp	x0, #0x8
               	b.hs	<addr>
               	b	<addr>
               	mov	w0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x10
               	mov	w2, w1
               	add	x0, x0, x2
               	add	x2, x3, x2
               	ldrb	w2, [x2]
               	strb	w2, [x0]
               	b	<addr>
               	cmp	x23, #0x40
               	b.lo	<addr>
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x2, x20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, w1
               	cmp	x0, #0x40
               	b.hs	<addr>
               	b	<addr>
               	mov	w0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	w0, w1
               	add	x0, x21, x0
               	cbz	x22, <addr>
               	b	<addr>
               	sub	x23, x23, #0x40
               	add	x21, x21, #0x40
               	cbz	x22, <addr>
               	b	<addr>
               	mov	w2, w1
               	add	x2, x22, x2
               	ldrb	w3, [x2]
               	b	<addr>
               	mov	x3, #0x0                // =0
               	sub	x2, x29, #0x50
               	mov	w4, w1
               	add	x2, x2, x4
               	ldrb	w2, [x2]
               	eor	x2, x3, x2
               	strb	w2, [x0]
               	b	<addr>
               	add	x22, x22, #0x40
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x20
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x68
               	sxtw	x2, w1
               	add	x0, x0, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0]
               	b	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	sub	x3, x29, #0x48
               	sub	x4, x29, #0x68
               	bl	<addr>
               	sub	x0, x29, #0x40
               	ldrb	w0, [x0]
               	mov	x17, #0x4d              // =77
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
