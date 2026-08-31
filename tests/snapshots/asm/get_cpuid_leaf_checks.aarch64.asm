
get_cpuid_leaf_checks.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x1c0
               	mov	x1, #0xa5a5             // =42405
               	movk	x1, #0xa5a5, lsl #16
               	stur	w1, [x29, #-0x8]
               	stur	w1, [x29, #-0x10]
               	stur	w1, [x29, #-0x18]
               	stur	w1, [x29, #-0x20]
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x2, x0
               	mov	x2, x0
               	mov	x2, x0
               	mov	x2, x0
               	stur	w1, [x29, #-0x68]
               	stur	w1, [x29, #-0x70]
               	stur	w1, [x29, #-0x78]
               	stur	w1, [x29, #-0x80]
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, #0xa5a5             // =42405
               	movk	x1, #0xa5a5, lsl #16
               	stur	w1, [x29, #-0xc8]
               	stur	w1, [x29, #-0xd0]
               	stur	w1, [x29, #-0xd8]
               	stur	w1, [x29, #-0xe0]
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, x1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
