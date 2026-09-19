
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
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	b	<addr>
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
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
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
               	mov	x1, x0
               	mov	x2, #0x0                // =0
               	add	x2, x2, #0x1
               	sub	x1, x1, #0x1
               	sxtw	x0, w1
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<same_target>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	b	<addr>
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
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cmp	w0, #0x1
               	b.gt	<addr>
               	b	<addr>
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
               	sxtw	x0, w0
               	mov	x1, #0x5                // =5
               	cmp	w0, #0xa
               	b.le	<addr>
               	mov	x1, #0x9                // =9
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x7                // =7
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x16, #0x1               // =1
               	str	x16, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x0               // =0
               	str	x16, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x0               // =0
               	str	x16, [sp]
               	ldr	x0, [sp]
               	cbz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xa                // =10
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x3               // =3
               	str	x16, [sp]
               	ldr	x0, [sp]
               	cbz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xa                // =10
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7                // =7
               	mov	x2, #0x0                // =0
               	add	x2, x2, #0x1
               	sub	x1, x1, #0x1
               	sxtw	x0, w1
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x0               // =0
               	str	x16, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x16, #0x1               // =1
               	str	x16, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x16, #0x1               // =1
               	str	x16, [sp]
               	ldr	x0, [sp]
               	cmp	w0, #0x1
               	b.gt	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x16, #0x2               // =2
               	str	x16, [sp]
               	ldr	x0, [sp]
               	cmp	w0, #0x1
               	b.gt	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x5                // =5
               	mov	x16, #0x0               // =0
               	str	x16, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x7                // =7
               	cmp	w1, #0x7
               	b.ne	<addr>
               	mov	x1, #0x5                // =5
               	mov	x16, #0x3               // =3
               	str	x16, [sp]
               	ldr	x0, [sp]
               	cbnz	w0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x7                // =7
               	cmp	w1, #0x5
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
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
