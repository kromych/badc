
volatile_local_mem2reg.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	cmp	w1, #0x2
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldursw	x1, [x29, #-0x8]
               	cmp	w1, #0x2
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
