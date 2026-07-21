
inline_asm_goto_output.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	sub	x1, x29, #0x8
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	add	w0, w1, #0x1
               	cmp	w1, #0xa
               	b.gt	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x64
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<accumulate>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	stur	w0, [x29, #0x10]
               	add	x0, x29, #0x10
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x16, [sp]
               	ldr	w0, [x16]
               	add	w0, w0, #0x5
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	ldursw	x0, [x29, #0x10]
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x3                // =3
               	sub	x1, x29, #0x10
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	add	w0, w1, #0x1
               	cmp	w1, #0xa
               	b.gt	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	sub	x1, x29, #0x18
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	add	w0, w1, #0x1
               	cmp	w1, #0xa
               	b.gt	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	add	sp, sp, #0x20
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x79
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x25               // =37
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x18]
               	add	x0, x0, #0x64
               	sxtw	x1, w0
               	sxtw	x0, w1
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x64
               	sxtw	x1, w0
               	sxtw	x0, w1
               	b	<addr>
