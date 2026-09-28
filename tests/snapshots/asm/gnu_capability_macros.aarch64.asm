
gnu_capability_macros.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x0, #0x0                // =0
               	sturb	w0, [x29, #-0x28]
               	sub	x2, x29, #0x28
               	mov	x1, #0x1                // =1
               	swpalb	w1, w3, [x2]
               	and	x3, x3, #0xff
               	cbz	x3, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w3, [x29, #-0x28]
               	eor	x3, x3, #0x1
               	cbz	w3, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	swpalb	w1, w3, [x2]
               	and	x3, x3, #0xff
               	cbnz	w3, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stlrb	w0, [x2]
               	ldurb	w2, [x29, #-0x28]
               	cbz	w2, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sturb	w1, [x29, #-0x20]
               	sturh	w1, [x29, #-0x18]
               	stur	w1, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x3, x29, #0x20
               	mov	x2, #0x2                // =2
               	mov	x4, x1
               	casalb	w4, w2, [x3]
               	cmp	w4, #0x1
               	b.ne	<addr>
               	ldurb	w3, [x29, #-0x20]
               	eor	x3, x3, #0x2
               	cbz	w3, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x18
               	mov	x4, x1
               	casalh	w4, w2, [x3]
               	cmp	w4, #0x1
               	b.ne	<addr>
               	ldursh	x3, [x29, #-0x18]
               	cmp	w3, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x10
               	mov	x4, x1
               	casal	w4, w2, [x3]
               	cmp	w4, #0x1
               	b.ne	<addr>
               	ldursw	x3, [x29, #-0x10]
               	cmp	w3, #0x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x8
               	casal	x1, x2, [x3]
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldur	x1, [x29, #-0x8]
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
