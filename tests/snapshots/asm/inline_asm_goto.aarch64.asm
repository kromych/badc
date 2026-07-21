
inline_asm_goto.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	ret

<pick>:
               	sxtw	x0, w0
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbz	w0, <addr>
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x14               // =20
               	ret

<count_down>:
               	mov	x1, #0x0                // =0
               	add	x1, x1, #0x1
               	sub	x0, x0, #0x1
               	sxtw	x2, w0
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x2, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	ret

<same_target>:
               	sxtw	x0, w0
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x7                // =7
               	ret

<splice_then_goto>:
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cmp	w0, #0x1
               	b.gt	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	ret

<phi_merge>:
               	mov	x1, x0
               	sxtw	x1, w1
               	mov	x0, #0x5                // =5
               	cmp	x1, #0xa
               	b.le	<addr>
               	mov	x0, #0x9                // =9
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x1, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	b	<addr>

<main>:
               	mov	x0, #0x1                // =1
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbz	w0, <addr>
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0xa                // =10
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x3                // =3
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbz	w0, <addr>
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0xa                // =10
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x0                // =0
               	add	x1, x1, #0x1
               	sub	x0, x0, #0x1
               	sxtw	x2, w0
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x2, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cmp	w0, #0x1
               	b.gt	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cmp	w0, #0x1
               	b.gt	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, #0x5                // =5
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x1, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x7                // =7
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x7
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x1, #0x3                // =3
               	mov	x0, #0x5                // =5
               	sub	sp, sp, #0x10
               	str	x0, [sp, #0x8]
               	str	x1, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	ldr	x0, [sp, #0x8]
               	add	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0x7                // =7
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0xb                // =11
               	mov	x0, #0x9                // =9
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x2a               // =42
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x14               // =20
               	b	<addr>
               	mov	x0, #0x14               // =20
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
