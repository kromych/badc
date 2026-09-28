
fn_ptr_arith_byte_stride.aarch64:	file format elf64-littleaarch64

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

<f1>:
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	ret

<f2>:
               	madd	x0, x0, x1, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x0, x0, x1
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x5, x1, x0
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	mov	x2, #0x4                // =4
               	mov	x3, #0x5                // =5
               	mov	x4, #0x6                // =6
               	blr	x5
               	cmp	x0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x1
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x0, #0x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x3
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x3
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x0, #0x5
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x1, x1, #0x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	add	x1, x0, #0x10
               	cmp	x1, x1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x1, x0
               	asr	x3, x2, #63
               	lsr	x3, x3, #61
               	add	x2, x2, x3
               	asr	x2, x2, #3
               	cmp	x2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x0, #0x8
               	cmp	x2, x2
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x2, #0x8
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x5, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	mov	x2, #0x4                // =4
               	mov	x3, #0x5                // =5
               	mov	x4, #0x6                // =6
               	blr	x5
               	cmp	x0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x2, x0, #0xc
               	sub	x1, x2, x0
               	asr	x3, x1, #63
               	lsr	x3, x3, #62
               	add	x3, x1, x3
               	asr	x3, x3, #2
               	cmp	x3, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x1, #0xc
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x2, #0x4
               	add	x2, x0, #0x8
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x1, #0x8
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
