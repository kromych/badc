
inline_struct_return_multi_block.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<reg_of>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x8, [x16]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	w0, w0
               	mov	w0, w0
               	lsr	x0, x0, #5
               	mov	w2, w0
               	cmp	x2, #0x9
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x1                // =1
               	str	w3, [x2]
               	mov	w2, w0
               	cmp	x2, #0x4
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x1                // =1
               	str	w3, [x2]
               	mov	w2, w0
               	mov	x17, #0x18              // =24
               	mul	x2, x2, x17
               	add	x2, x1, x2
               	ldr	w2, [x2]
               	cmp	x2, #0x0
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x1                // =1
               	str	w3, [x2]
               	mov	w0, w0
               	mov	x17, #0x18              // =24
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	mov	x16, x0
               	sub	x17, x29, #0x8
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<reg_slot>:
               	mov	w2, w1
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxtw	x0, w0
               	ret
               	mov	w1, w1
               	mov	x17, #0x3               // =3
               	and	x1, x1, x17
               	ldrsw	x0, [x0, x1, lsl #2]
               	b	<addr>

<probe>:
               	str	x20, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x20, x0
               	mov	w0, w1
               	sub	x8, x29, #0x18
               	bl	<addr>
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x30
               	ldr	w0, [x0]
               	mov	w1, w0
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	sub	x1, x29, #0x30
               	ldrsw	x1, [x1, #0x4]
               	add	x1, x0, x1
               	sub	x0, x29, #0x30
               	ldrh	w0, [x0, #0x8]
               	add	x1, x1, x0
               	sub	x0, x29, #0x30
               	ldrsb	x0, [x0, #0xa]
               	add	x1, x1, x0
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xb]
               	add	x1, x1, x0
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x10]
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	add	x0, x1, x0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	w0, w0
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	ldrsw	x0, [x20, x0, lsl #2]
               	b	<addr>

<direct>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	w0, w0
               	sub	x8, x29, #0x60
               	bl	<addr>
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x18
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	sub	x0, x29, #0x48
               	ldrsw	x0, [x0, #0x4]
               	add	x1, x1, x0
               	sub	x0, x29, #0x48
               	ldrh	w0, [x0, #0x8]
               	add	x1, x1, x0
               	sub	x0, x29, #0x48
               	ldrsb	x0, [x0, #0xa]
               	add	x1, x1, x0
               	sub	x0, x29, #0x48
               	ldrb	w0, [x0, #0xb]
               	add	x1, x1, x0
               	sub	x0, x29, #0x48
               	ldr	x0, [x0, #0x10]
               	asr	x0, x0, #48
               	add	x0, x1, x0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, #0x0                // =0
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0x7865            // =30821
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x20               // =32
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0xf1              // =241
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x60               // =96
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0xe5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x17, #0x11ec            // =4588
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x40               // =64
               	bl	<addr>
               	mov	x17, #0xcc              // =204
               	movk	x17, #0x8000, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x20               // =32
               	stur	w0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0xf1              // =241
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
