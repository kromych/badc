
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
               	ldr	w4, [x3, #0x4]
               	ldr	w5, [x3, #0x8]
               	ldr	w3, [x3, #0xc]
               	eor	x0, x0, x4
               	eor	x0, x0, x5
               	eor	x0, x0, x3
               	and	x0, x0, #0xff
               	strb	w0, [x7]
               	ret

<stream_xor>:
               	stp	x20, x21, [sp, #-0x80]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x20, x0
               	mov	x23, x4
               	mov	x22, #0x0               // =0
               	mov	x0, #0x40               // =64
               	sub	x1, x29, #0x50
               	str	x22, [x1]
               	str	x22, [x1, #0x8]
               	add	x2, x1, #0x0
               	add	x4, x3, #0x0
               	ldrb	w4, [x4]
               	strb	w4, [x2]
               	ldrb	w2, [x3, #0x1]
               	strb	w2, [x1, #0x1]
               	ldrb	w2, [x3, #0x2]
               	strb	w2, [x1, #0x2]
               	ldrb	w2, [x3, #0x3]
               	strb	w2, [x1, #0x3]
               	ldrb	w2, [x3, #0x4]
               	strb	w2, [x1, #0x4]
               	ldrb	w2, [x3, #0x5]
               	strb	w2, [x1, #0x5]
               	ldrb	w2, [x3, #0x6]
               	strb	w2, [x1, #0x6]
               	ldrb	w2, [x3, #0x7]
               	strb	w2, [x1, #0x7]
               	cmp	w0, #0x40
               	b.lo	<addr>
               	sub	x21, x29, #0x40
               	sub	x1, x29, #0x50
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x21
               	mov	x2, x23
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x40
               	b.hs	<addr>
               	ldrb	w1, [x21, x0]
               	mov	x17, #0x0               // =0
               	eor	x1, x1, x17
               	strb	w1, [x20, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	add	x20, x20, #0x40
               	cmp	w0, #0x40
               	b.hs	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
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
               	cmp	w0, #0x20
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	strb	w0, [x1, x0]
               	add	x0, x0, #0x1
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
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
