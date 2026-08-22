
inline_asm_goto.aarch64:	file format elf64-littleaarch64

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

<take_or_fall>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<pick>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbz	w0, <addr>
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<count_down>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x0                // =0
               	add	x1, x1, #0x1
               	sub	x0, x0, #0x1
               	sxtw	x2, w0
               	str	x0, [sp, #0x8]
               	str	x2, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<same_target>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<splice_then_goto>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cmp	w0, #0x1
               	b.gt	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<phi_merge>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sxtw	x1, w1
               	mov	x0, #0x5                // =5
               	cmp	w1, #0xa
               	b.le	<addr>
               	mov	x0, #0x9                // =9
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x0, [sp, #0x8]
               	str	x1, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1                // =1
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x1, x0
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	x0, [sp, #0x8]
               	str	x1, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x0, [sp, #0x8]
               	str	x1, [sp]
               	ldr	x0, [sp]
               	cbz	w0, <addr>
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x0, #0xa                // =10
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbz	w0, <addr>
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x0, #0xa                // =10
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	x1, x1, #0x1
               	sub	x0, x0, #0x1
               	sxtw	x2, w0
               	str	x0, [sp, #0x8]
               	str	x2, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cmp	w0, #0x1
               	b.gt	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x1, x0
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x1, #0x2                // =2
               	str	x0, [sp, #0x8]
               	str	x1, [sp]
               	ldr	x0, [sp]
               	cmp	w0, #0x1
               	b.gt	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	cmp	x0, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x5                // =5
               	str	x0, [sp, #0x8]
               	str	x2, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x0, #0x7                // =7
               	sxtw	x0, w0
               	cmp	w0, #0x7
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	b	<addr>
               	mov	x1, #0x7                // =7
               	sxtw	x0, w1
               	cmp	w0, #0x5
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x14               // =20
               	b	<addr>
               	mov	x0, #0x14               // =20
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
