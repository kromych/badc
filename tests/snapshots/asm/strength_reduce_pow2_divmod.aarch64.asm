
strength_reduce_pow2_divmod.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x0, #-0x7               // =-7
               	stur	w0, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x20]
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x20]
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	and	x0, x0, #0x1
               	sub	x0, x0, x1
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x10              // =-16
               	stur	w0, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x20]
               	lsr	x1, x0, #60
               	add	x0, x0, x1
               	asr	x0, x0, #4
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x20]
               	lsr	x1, x0, #60
               	add	x0, x0, x1
               	and	x0, x0, #0xf
               	sub	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x11              // =-17
               	stur	w0, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x20]
               	lsr	x1, x0, #60
               	add	x0, x0, x1
               	asr	x0, x0, #4
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x20]
               	lsr	x1, x0, #60
               	add	x0, x0, x1
               	and	x0, x0, #0xf
               	sub	x0, x0, x1
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x20]
               	lsr	x1, x0, #61
               	add	x0, x0, x1
               	asr	x0, x0, #3
               	cmp	x0, #0xc
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x20]
               	lsr	x1, x0, #61
               	add	x0, x0, x1
               	and	x0, x0, #0x7
               	sub	x0, x0, x1
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x80000000        // =-2147483648
               	stur	w0, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x20]
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	mov	x17, #-0x40000000       // =-1073741824
               	cmp	x0, x17
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x20]
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	and	x0, x0, #0x1
               	sub	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffffffff         // =4294967295
               	stur	w0, [x29, #-0x18]
               	ldur	w0, [x29, #-0x18]
               	lsr	x0, x0, #1
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x18]
               	and	x0, x0, #0x1
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x80000000         // =2147483648
               	stur	w0, [x29, #-0x18]
               	ldur	w0, [x29, #-0x18]
               	lsr	x0, x0, #4
               	mov	x17, #0x8000000         // =134217728
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x18]
               	and	x0, x0, #0xf
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0xd687            // =-54919
               	movk	x0, #0xffed, lsl #16
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	asr	x1, x0, #63
               	lsr	x1, x1, #54
               	add	x0, x0, x1
               	asr	x0, x0, #10
               	mov	x17, #-0x4b5            // =-1205
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	asr	x1, x0, #63
               	lsr	x1, x1, #54
               	add	x0, x0, x1
               	and	x0, x0, #0x3ff
               	sub	x0, x0, x1
               	mov	x17, #-0x287            // =-647
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	mov	x17, #-0x4000000000000000 // =-4611686018427387904
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	and	x0, x0, #0x1
               	sub	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x1               // =-1
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x0, x0, #1
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	and	x0, x0, #0xff
               	cmp	w0, #0xff
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x5               // =-5
               	stur	w0, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x20]
               	mov	x17, #-0x5              // =-5
               	cmp	w0, w17
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
