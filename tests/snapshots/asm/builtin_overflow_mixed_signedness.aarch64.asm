
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
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #-0x2               // =-2
               	stur	x3, [x29, #-0x8]
               	mov	x17, #-0x2              // =-2
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	stur	x0, [x29, #-0x8]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	stur	x2, [x29, #-0x8]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x2, [x29, #-0x8]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	stur	x1, [x29, #-0x8]
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x2, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x3, [x29, #-0x8]
               	mov	x17, #-0x2              // =-2
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x3, [x29, #-0x8]
               	mov	x17, #-0x2              // =-2
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x8               // =-8
               	stur	x0, [x29, #-0x8]
               	mov	x17, #-0x8              // =-8
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x2, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7ffffffffffffffe // =9223372036854775806
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x7ffffffffffffffe // =9223372036854775806
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x2, [x29, #-0x8]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	stur	x2, [x29, #-0x8]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x8]
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7fffffff         // =2147483647
               	stur	w1, [x29, #-0x8]
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
