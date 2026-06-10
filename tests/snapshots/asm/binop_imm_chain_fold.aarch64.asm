
binop_imm_chain_fold.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf0
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0xa                // =10
               	add	x1, x0, #0x3
               	sxtw	x1, w1
               	add	x1, x1, #0x7
               	sxtw	x1, w1
               	add	x2, x0, #0x8
               	sxtw	x2, w2
               	sub	x2, x2, #0x3
               	sxtw	x2, w2
               	sub	x3, x0, #0x4
               	sxtw	x3, w3
               	add	x3, x3, #0x9
               	sxtw	x3, w3
               	sub	x4, x0, #0x2
               	sxtw	x4, w4
               	sub	x4, x4, #0x5
               	sxtw	x4, w4
               	mov	x17, #0x3f              // =63
               	and	x5, x0, x17
               	mov	x17, #0x3               // =3
               	orr	x6, x0, x17
               	mov	x17, #0x3               // =3
               	eor	x0, x0, x17
               	sxtw	x1, w1
               	sxtw	x2, w2
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sxtw	x2, w3
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sxtw	x2, w4
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sxtw	x2, w5
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sxtw	x2, w6
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sxtw	x20, w0
               	adrp	x0, <page>
               	add	x0, x0, #0x11c
               	sxtw	x1, w20
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w20
               	cmp	x0, #0x53
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
