
return_cleanup_shared.aarch64:	file format elf64-littleaarch64

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

<three>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x2, w0
               	sxtw	x1, w1
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	cbz	x2, <addr>
               	mov	x0, #0x8                // =8
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x4, x2, #0x1
               	str	w4, [x1]
               	mov	x1, #0x61               // =97
               	strb	w1, [x3, x2]
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	b	<addr>

<two_lists>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x8]
               	cbnz	w0, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x3, x1, #0x1
               	str	w3, [x0]
               	mov	x0, #0x61               // =97
               	strb	w0, [x2, x1]
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0x8]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x4, x3, #0x1
               	str	w4, [x1]
               	mov	x4, #0x62               // =98
               	strb	w4, [x2, x3]
               	mov	x3, #-0x2               // =-2
               	stur	w3, [x29, #-0x8]
               	ldrsw	x3, [x1]
               	add	x4, x3, #0x1
               	str	w4, [x1]
               	mov	x1, #0x61               // =97
               	strb	w1, [x2, x3]
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	b	<addr>

<nested>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	cbnz	w2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x4, x3, #0x1
               	str	w4, [x1]
               	mov	x4, #0x63               // =99
               	strb	w4, [x2, x3]
               	ldrsw	x3, [x1]
               	add	x4, x3, #0x1
               	str	w4, [x1]
               	mov	x1, #0x61               // =97
               	strb	w1, [x2, x3]
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w2, #0x1
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x4, x0, #0x1
               	str	w4, [x1]
               	mov	x4, #0x63               // =99
               	strb	w4, [x3, x0]
               	cmp	w2, #0x2
               	b.ne	<addr>
               	mov	x0, #0x1e               // =30
               	ldrsw	x2, [x1]
               	add	x4, x2, #0x1
               	str	w4, [x1]
               	mov	x1, #0x61               // =97
               	strb	w1, [x3, x2]
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x28               // =40
               	b	<addr>

<void_returns>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	wzr, [x29, #-0x8]
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x3, x1, #0x1
               	str	w3, [x0]
               	mov	x0, #0x62               // =98
               	strb	w0, [x2, x1]
               	mov	x0, #-0x2               // =-2
               	stur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	str	w0, [x1]
               	b	<addr>
               	mov	x0, #0x3                // =3
               	str	w0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x3, x1, #0x1
               	str	w3, [x0]
               	mov	x0, #0x62               // =98
               	strb	w0, [x2, x1]
               	mov	x0, #-0x2               // =-2
               	stur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<pairs>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x8, [x29, #-0x20]
               	mov	x1, #0x4                // =4
               	stur	w1, [x29, #-0x28]
               	mov	x4, #0x1                // =1
               	mov	x3, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cbnz	w0, <addr>
               	stur	x4, [x29, #-0x18]
               	stur	x3, [x29, #-0x10]
               	stur	x2, [x29, #-0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x3, x1, #0x1
               	str	w3, [x0]
               	mov	x0, #0x61               // =97
               	strb	w0, [x2, x1]
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0x28]
               	sub	x0, x29, #0x18
               	mov	x16, x0
               	ldur	x17, [x29, #-0x20]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x1
               	b.ne	<addr>
               	stur	x1, [x29, #-0x18]
               	stur	x3, [x29, #-0x10]
               	stur	x2, [x29, #-0x8]
               	b	<addr>
               	mov	x0, #0x8                // =8
               	stur	x1, [x29, #-0x18]
               	stur	x0, [x29, #-0x10]
               	stur	x2, [x29, #-0x8]
               	b	<addr>

<looped>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	wzr, [x29, #-0x8]
               	mov	x1, #0x4                // =4
               	cmp	w0, #0x4
               	b.ne	<addr>
               	mov	x17, #0x3               // =3
               	mul	x0, x1, x17
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x4, x2, #0x1
               	str	w4, [x1]
               	mov	x1, #0x63               // =99
               	strb	w1, [x3, x2]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x5                // =5
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x1, #0x6                // =6
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x1, #0x7                // =7
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x1, #0x8                // =8
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x63               // =99
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x20]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	w1, [x20]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x8
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x9
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	mov	x1, x0
               	bl	<addr>
               	cmp	w0, #0x7
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	bl	<addr>
               	cmp	w0, #0xa
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x3
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	w0, #0x14
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x14
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	bl	<addr>
               	cmp	w0, #0x5
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x6
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	w0, #0x1e
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x28
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	sub	x1, x29, #0x20
               	bl	<addr>
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x20
               	bl	<addr>
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x2                // =2
               	sub	x1, x29, #0x20
               	bl	<addr>
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	sub	x8, x29, #0x18
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x10]
               	ldur	x2, [x29, #-0x8]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	cmp	x1, #0x2
               	b.ne	<addr>
               	cmp	x2, #0x3
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x1                // =1
               	sub	x8, x29, #0x18
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x10]
               	cmp	x0, #0x4
               	b.ne	<addr>
               	cmp	x1, #0x2
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x2                // =2
               	sub	x8, x29, #0x18
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x10]
               	cmp	x0, #0x4
               	b.ne	<addr>
               	cmp	x1, #0x8
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0xc
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	wzr, [x20]
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	cmp	w0, #0x63
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrsw	x3, [x20]
               	cmp	w0, w3
               	b.ge	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x1, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
