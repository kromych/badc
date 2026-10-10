
overflow_builtin_result_pointer_operand.aarch64:	file format elf64-littleaarch64

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

<scaled>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x1
               	ret

<decremented>:
               	sub	x0, x0, #0x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x0, x2, #0x29
               	str	x0, [x3]
               	eor	x2, x2, x0
               	mov	x17, #0x29              // =41
               	eor	x0, x0, x17
               	and	x0, x2, x0
               	cmp	x0, #0x0
               	b.lt	<addr>
               	ldr	x0, [x3]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x1]
               	sub	x2, x0, #0x1
               	stur	x2, [x29, #-0x8]
               	eor	x3, x0, #0x1
               	eor	x0, x0, x2
               	and	x0, x3, x0
               	cmp	x0, #0x0
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	ldr	x1, [x1]
               	blr	x1
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x3, [x1]
               	mov	x17, #0x5               // =5
               	mul	x2, x0, x17
               	str	x2, [x3]
               	cmp	x0, #0x0
               	cset	x4, eq
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	cset	x3, eq
               	orr	x4, x4, x3
               	eor	x5, x4, #0x1
               	madd	x0, x0, x5, x4
               	sdiv	x0, x2, x0
               	cmp	x0, #0x5
               	cset	x0, ne
               	and	x0, x5, x0
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x2, x17
               	cset	x2, eq
               	and	x2, x3, x2
               	orr	x0, x0, x2
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x1]
               	ldr	x0, [x0]
               	cmp	x0, #0x5
               	b.ne	<addr>
               	ldr	x0, [x1]
               	ldr	x1, [x0, #0x8]
               	mov	x0, #0x7                // =7
               	blr	x1
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
