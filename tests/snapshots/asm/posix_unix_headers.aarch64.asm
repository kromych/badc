
posix_unix_headers.aarch64:	file format elf64-littleaarch64

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
               	sub	x2, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	strb	w1, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x80]
               	orr	x0, x0, #0x8
               	sturb	w0, [x29, #-0x80]
               	ldurb	w0, [x29, #-0x7b]
               	orr	x0, x0, #0x1
               	sturb	w0, [x29, #-0x7b]
               	ldurb	w0, [x29, #-0x80]
               	tbz	w0, #0x3, <addr>
               	ldurb	w0, [x29, #-0x7b]
               	tbnz	w0, #0x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x80]
               	tbz	w0, #0x4, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x80]
               	and	x0, x0, #0xfffffffffffffff7
               	sturb	w0, [x29, #-0x80]
               	ldurb	w0, [x29, #-0x80]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
