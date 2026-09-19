
inline_asm_goto_output.aarch64:	file format elf64-littleaarch64

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

<classify>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sxtw	x0, w0
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	add	w0, w1, #0x1
               	cmp	w1, #0xa
               	b.gt	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<accumulate>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	x0, [x29, #-0x10]
               	stur	w0, [x29, #-0x10]
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	ldr	x16, [sp]
               	ldr	w0, [x16]
               	add	w0, w0, #0x5
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	b	<addr>
               	mov	x0, #-0x1               // =-1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0x3               // =3
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	add	w0, w1, #0x1
               	cmp	w1, #0xa
               	b.gt	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0x14              // =20
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	add	w0, w1, #0x1
               	cmp	w1, #0xa
               	b.gt	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x79
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x25               // =37
               	stur	w0, [x29, #-0x8]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	ldr	x16, [sp]
               	ldr	w0, [x16]
               	add	w0, w0, #0x5
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	b	<addr>
               	ldr	x16, [sp]
               	str	w0, [x16]
               	b	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x64
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x64
               	b	<addr>
