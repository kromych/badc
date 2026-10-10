
builtin_overflow.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #-0x80000000        // =-2147483648
               	stur	w2, [x29, #-0x10]
               	mov	x0, x2
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7b               // =123
               	stur	w0, [x29, #-0x10]
               	cmp	w0, #0x7b
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7fffffff         // =2147483647
               	stur	w0, [x29, #-0x10]
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x8]
               	mov	x3, #0xfffffffe         // =4294967294
               	stur	w3, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	mov	x17, #0xfffffffe        // =4294967294
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x10]
               	mov	x1, #0x15               // =21
               	stur	w1, [x29, #-0x10]
               	cmp	w1, #0x15
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	stur	x1, [x29, #-0x8]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x7fffffffffffffff // =9223372036854775807
               	stur	x4, [x29, #-0x8]
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	xzr, [x29, #-0x8]
               	mov	x4, #0x1000             // =4096
               	movk	x4, #0xd4a5, lsl #16
               	movk	x4, #0xe8, lsl #32
               	stur	x4, [x29, #-0x8]
               	ldur	x4, [x29, #-0x8]
               	mov	x17, #0x1000            // =4096
               	movk	x17, #0xd4a5, lsl #16
               	movk	x17, #0xe8, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x8]
               	ldur	x4, [x29, #-0x8]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #-0xf               // =-15
               	stur	x4, [x29, #-0x8]
               	ldur	x4, [x29, #-0x8]
               	mov	x17, #-0xf              // =-15
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	xzr, [x29, #-0x8]
               	mov	x4, #-0x2               // =-2
               	stur	x4, [x29, #-0x8]
               	mov	x17, #-0x2              // =-2
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	xzr, [x29, #-0x8]
               	mov	x0, #0x5385             // =21381
               	movk	x0, #0xfbff, lsl #16
               	movk	x0, #0x3114, lsl #32
               	movk	x0, #0x1b1, lsl #48
               	stur	x0, [x29, #-0x8]
               	mov	x17, #0x5385            // =21381
               	movk	x17, #0xfbff, lsl #16
               	movk	x17, #0x3114, lsl #32
               	movk	x17, #0x1b1, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w2, [x29, #-0x8]
               	mov	x0, x2
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7b               // =123
               	stur	w0, [x29, #-0x8]
               	cmp	w0, #0x7b
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7fffffff         // =2147483647
               	stur	w0, [x29, #-0x8]
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x8]
               	stur	w3, [x29, #-0x8]
               	ldur	w2, [x29, #-0x8]
               	mov	x17, #0xfffffffe        // =4294967294
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w0, [x29, #-0x8]
               	mov	x2, #0x3                // =3
               	stur	x2, [x29, #-0x8]
               	cmp	x2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x2                // =2
               	stur	x3, [x29, #-0x8]
               	cmp	x3, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x2a               // =42
               	stur	x4, [x29, #-0x8]
               	ldur	x4, [x29, #-0x8]
               	cmp	x4, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x2, [x29, #-0x8]
               	cmp	x2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #-0x1               // =-1
               	stur	x2, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x10]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	stur	x2, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x0, [x29, #-0x8]
               	stur	x3, [x29, #-0x10]
               	cmp	x3, #0x2
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
