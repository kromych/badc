
typeof_row_bounds.aarch64:	file format elf64-littleaarch64

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
               	sub	x1, x29, #0x30
               	mov	x0, #0x0                // =0
               	mov	x2, #0x100000000        // =4294967296
               	stur	x2, [x29, #-0x30]
               	mov	x2, #0x2                // =2
               	movk	x2, #0x3, lsl #32
               	stur	x2, [x29, #-0x28]
               	mov	x2, #0xa                // =10
               	movk	x2, #0xb, lsl #32
               	stur	x2, [x29, #-0x20]
               	mov	x2, #0xc                // =12
               	movk	x2, #0xd, lsl #32
               	stur	x2, [x29, #-0x18]
               	mov	x2, #0x14               // =20
               	movk	x2, #0x15, lsl #32
               	stur	x2, [x29, #-0x10]
               	mov	x2, #0x16               // =22
               	movk	x2, #0x17, lsl #32
               	stur	x2, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x20]
               	cmp	w2, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x1, #0x10
               	sub	x1, x2, x1
               	asr	x2, x1, #63
               	add	x1, x1, x2, lsr #62
               	asr	x1, x1, #2
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
