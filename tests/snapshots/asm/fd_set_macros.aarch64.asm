
fd_set_macros.aarch64:	file format elf64-littleaarch64

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
               	sub	x1, x29, #0x80
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cbnz	w2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	sub	x2, x29, #0x80
               	ldurb	w0, [x29, #-0x80]
               	orr	x0, x0, #0x1
               	sturb	w0, [x29, #-0x80]
               	ldurb	w0, [x29, #-0x80]
               	orr	x0, x0, #0x80
               	sturb	w0, [x29, #-0x80]
               	ldurb	w0, [x29, #-0x7f]
               	orr	x0, x0, #0x1
               	sturb	w0, [x29, #-0x7f]
               	ldurb	w0, [x29, #-0x74]
               	orr	x0, x0, #0x10
               	sturb	w0, [x29, #-0x74]
               	ldurb	w0, [x29, #-0x80]
               	tbnz	w0, #0x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x80]
               	tbnz	w0, #0x7, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x7f]
               	tbnz	w0, #0x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x74]
               	tbnz	w0, #0x4, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x80]
               	tbz	w0, #0x1, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x7a]
               	tbz	w0, #0x2, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x80]
               	mov	x17, #0x81              // =129
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x7f]
               	eor	x0, x0, #0x1
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x74]
               	eor	x0, x0, #0x10
               	cbz	w0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x80]
               	and	x0, x0, #0xffffffffffffff7f
               	sturb	w0, [x29, #-0x80]
               	ldurb	w0, [x29, #-0x80]
               	tbz	w0, #0x7, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x80]
               	tbnz	w0, #0x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x7f]
               	tbnz	w0, #0x0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x80]
               	orr	x0, x0, #0x1
               	sturb	w0, [x29, #-0x80]
               	ldurb	w0, [x29, #-0x80]
               	tbnz	w0, #0x0, <addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	strb	w1, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x80]
               	tbz	w0, #0x0, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x74]
               	tbz	w0, #0x4, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
