
attributed_aggregate_align_floor.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x0, x2, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x0, x3, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	and	x0, x4, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	and	x0, x5, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	and	x0, x6, #0xf
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	and	x1, x0, #0x7
               	cbz	w1, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7                // =7
               	mov	x7, #0x0                // =0
               	str	x1, [x0]
               	str	x7, [x0, #0x8]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x2]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldr	x0, [x3]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x4]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	ldr	x0, [x5]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x6]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x31              // =49
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x35              // =53
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
