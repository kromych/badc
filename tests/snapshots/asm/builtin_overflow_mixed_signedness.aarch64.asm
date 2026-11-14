
builtin_overflow_mixed_signedness.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #-0x1               // =-1
               	stur	x0, [x29, #-0x8]
               	stur	x0, [x29, #-0x8]
               	stur	x0, [x29, #-0x8]
               	mov	x2, #-0x2               // =-2
               	stur	x2, [x29, #-0x8]
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x6                // =6
               	stur	x1, [x29, #-0x8]
               	stur	x0, [x29, #-0x8]
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	stur	x1, [x29, #-0x8]
               	stur	x0, [x29, #-0x8]
               	stur	x1, [x29, #-0x8]
               	mov	x3, #0x7fffffffffffffff // =9223372036854775807
               	stur	x3, [x29, #-0x8]
               	stur	x1, [x29, #-0x8]
               	stur	x2, [x29, #-0x8]
               	stur	x2, [x29, #-0x8]
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x8]
               	mov	x0, #-0x8               // =-8
               	stur	x0, [x29, #-0x8]
               	stur	x1, [x29, #-0x8]
               	mov	x0, #0x7ffffffffffffffe // =9223372036854775806
               	stur	x0, [x29, #-0x8]
               	stur	x1, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	stur	x1, [x29, #-0x8]
               	stur	x3, [x29, #-0x8]
               	stur	x0, [x29, #-0x8]
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0xffffffff         // =4294967295
               	stur	w1, [x29, #-0x8]
               	ldur	w2, [x29, #-0x8]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w1, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x5                // =5
               	stur	w1, [x29, #-0x8]
               	mov	x1, #0x7fffffff         // =2147483647
               	stur	w1, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
