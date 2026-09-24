
inline_asm_named_operands.aarch64:	file format elf64-littleaarch64

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

<move_named>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	str	x0, [sp]
               	ldr	x1, [sp]
               	mov	w0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<add_mixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	add	x0, x1, x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<modifier_named>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	str	x0, [sp]
               	ldr	x1, [sp]
               	add	w0, w1, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<rw_named>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	w0, w0
               	str	x0, [sp]
               	ldr	x0, [sp]
               	add	w0, w0, #0x5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x16, #0x7               // =7
               	str	x16, [sp]
               	ldr	x1, [sp]
               	mov	w0, w1
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x1e              // =30
               	str	x16, [sp]
               	mov	x16, #0xc               // =12
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	add	x0, x1, x2
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x15              // =21
               	str	x16, [sp]
               	ldr	x1, [sp]
               	add	w0, w1, w1
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x25               // =37
               	str	x0, [sp]
               	ldr	x0, [sp]
               	add	w0, w0, #0x5
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
