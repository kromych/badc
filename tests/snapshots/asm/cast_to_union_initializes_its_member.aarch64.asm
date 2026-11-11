
cast_to_union_initializes_its_member.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x78               // =120
               	sturb	w0, [x29, #-0x8]
               	ldurb	w0, [x29, #-0x8]
               	cmp	w0, #0x78
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	x1, x1, x0, lsl #1
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x8]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	cmp	w0, #0x78
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
