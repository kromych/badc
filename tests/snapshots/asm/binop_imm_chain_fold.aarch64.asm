
binop_imm_chain_fold.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x15, #0xa               // =10
               	add	x14, x15, #0x3
               	sxtw	x14, w14
               	add	x14, x14, #0x7
               	sxtw	x14, w14
               	add	x13, x15, #0x8
               	sxtw	x13, w13
               	sub	x13, x13, #0x3
               	sxtw	x13, w13
               	sub	x12, x15, #0x4
               	sxtw	x12, w12
               	add	x12, x12, #0x9
               	sxtw	x12, w12
               	sub	x11, x15, #0x2
               	sxtw	x11, w11
               	sub	x11, x11, #0x5
               	sxtw	x11, w11
               	mov	x17, #0x3f              // =63
               	and	x10, x15, x17
               	mov	x17, #0x3               // =3
               	orr	x9, x15, x17
               	mov	x17, #0x3               // =3
               	eor	x15, x15, x17
               	sxtw	x14, w14
               	sxtw	x13, w13
               	add	x14, x14, x13
               	sxtw	x14, w14
               	sxtw	x12, w12
               	add	x14, x14, x12
               	sxtw	x14, w14
               	sxtw	x11, w11
               	add	x14, x14, x11
               	sxtw	x14, w14
               	sxtw	x10, w10
               	add	x14, x14, x10
               	sxtw	x14, w14
               	sxtw	x9, w9
               	add	x14, x14, x9
               	sxtw	x14, w14
               	sxtw	x15, w15
               	add	x14, x14, x15
               	sxtw	x20, w14
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x21, x19
               	sxtw	x22, w20
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x20, w20
               	cmp	x20, #0x53
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x60]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x60]
               	b	<addr>
               	ldur	x0, [x29, #-0x60]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
