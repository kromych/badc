
comparison_imm_lhs_swap.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x118
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x11e
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x125
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x5               // =5
               	mov	x21, #0x0               // =0
               	cmp	x20, #0x0
               	b.le	<addr>
               	add	x0, x21, #0x1
               	sxtw	x21, w0
               	b	<addr>
               	cmp	x20, #0x0
               	b.lt	<addr>
               	sxtw	x0, w21
               	add	x0, x0, #0x1
               	sxtw	x21, w0
               	b	<addr>
               	cmp	x20, #0xa
               	b.ge	<addr>
               	sxtw	x0, w21
               	add	x0, x0, #0x1
               	sxtw	x21, w0
               	b	<addr>
               	cmp	x20, #0xa
               	b.gt	<addr>
               	sxtw	x0, w21
               	add	x0, x0, #0x1
               	sxtw	x21, w0
               	b	<addr>
               	cmp	x20, #0x0
               	b.ls	<addr>
               	sxtw	x0, w21
               	add	x0, x0, #0x1
               	sxtw	x21, w0
               	b	<addr>
               	cmp	x20, #0x0
               	b.lo	<addr>
               	sxtw	x0, w21
               	add	x0, x0, #0x1
               	sxtw	x21, w0
               	b	<addr>
               	cmp	x20, #0xa
               	b.hs	<addr>
               	sxtw	x0, w21
               	add	x0, x0, #0x1
               	sxtw	x21, w0
               	b	<addr>
               	cmp	x20, #0xa
               	b.hi	<addr>
               	sxtw	x0, w21
               	add	x0, x0, #0x1
               	sxtw	x21, w0
               	b	<addr>
               	cmp	x20, #0xa
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	sxtw	x1, w21
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w21
               	cmp	x0, #0x8
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
