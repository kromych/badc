
c11_atomic_specifier.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x0, #0xc8               // =200
               	sturb	w0, [x29, #-0x10]
               	ldurb	w0, [x29, #-0x10]
               	mov	x17, #0xc8              // =200
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfa               // =250
               	sturb	w0, [x29, #-0x10]
               	ldurb	w0, [x29, #-0x10]
               	mov	x17, #0xfa              // =250
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x7               // =-7
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0xd                // =13
               	sturh	w0, [x29, #-0x8]
               	ldursh	x0, [x29, #-0x8]
               	cmp	w0, #0xd
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	stur	w0, [x29, #-0x10]
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
