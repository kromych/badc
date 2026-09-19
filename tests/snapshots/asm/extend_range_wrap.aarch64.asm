
extend_range_wrap.aarch64:	file format elf64-littleaarch64

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

<wrap_up>:
               	mov	x4, x1
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w0, #0x0
               	b.le	<addr>
               	sxtw	x3, w0
               	add	x2, x2, x3
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.gt	<addr>
               	str	w1, [x4]
               	mov	x0, x2
               	ret

<le_max>:
               	mov	x3, x1
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w0, w3
               	b.gt	<addr>
               	sxtw	x4, w0
               	add	x2, x2, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.le	<addr>
               	mov	x0, x2
               	ret

<ne_bound>:
               	mov	x2, x1
               	mov	x1, #0x0                // =0
               	cmp	w0, w2
               	b.eq	<addr>
               	sxtw	x3, w0
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.ne	<addr>
               	mov	x0, x1
               	ret

<step_var>:
               	mov	x3, x1
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w0, w3
               	b.ge	<addr>
               	sxtw	x4, w0
               	add	x2, x2, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.eq	<addr>
               	add	x0, x0, #0x4
               	cmp	w0, w3
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<wrap_down>:
               	mov	x4, x1
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	sxtw	x3, w0
               	add	x2, x2, x3
               	add	x1, x1, #0x1
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	str	w1, [x4]
               	mov	x0, x2
               	ret

<count_down>:
               	mov	x2, x0
               	sxtw	x1, w1
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x0
               	b.lt	<addr>
               	ldrsw	x3, [x2, x1, lsl #2]
               	add	x0, x0, x3
               	sub	x1, x1, #0x1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	ret

<two_back_edges>:
               	mov	x4, x1
               	mov	x5, x3
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	cmp	w0, w4
               	b.ge	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x5
               	b.eq	<addr>
               	and	x3, x1, #0x1
               	cbz	x3, <addr>
               	add	x0, x0, #0x1
               	b	<addr>
               	sxtw	x0, w0
               	add	x2, x2, x0
               	add	x0, x0, #0x2
               	cmp	w0, w4
               	b.lt	<addr>
               	str	w0, [x5]
               	mov	x0, x2
               	ret

<other_guard>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<guard_then_join>:
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x64
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	add	x0, x0, x1
               	ret

<guarded>:
               	sxtw	x1, w0
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x64
               	b.ge	<addr>
               	add	x0, x1, #0x1
               	ret

<uwrap>:
               	mov	x1, #0x0                // =0
               	eor	x2, x0, #0x2
               	cbz	w2, <addr>
               	mov	w2, w0
               	add	x1, x1, x2
               	add	x0, x0, #0x1
               	eor	x2, x0, #0x2
               	cbnz	w2, <addr>
               	mov	x0, x1
               	ret

<as_ulong>:
               	add	x0, x0, #0x2
               	mov	w0, w0
               	ret

<shr4>:
               	add	x0, x0, #0x2
               	mov	w0, w0
               	lsr	x0, x0, #4
               	ret

<div3>:
               	add	x0, x0, #0x2
               	mov	w0, w0
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0xaaaa, lsl #16
               	mul	x0, x0, x17
               	lsr	x0, x0, #33
               	ret

<divv>:
               	add	x0, x0, #0x2
               	mov	w0, w0
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0xaaaa, lsl #16
               	mul	x0, x0, x17
               	lsr	x0, x0, #33
               	ret

<modv>:
               	add	x0, x0, #0x8
               	mov	w0, w0
               	mov	x1, #0x5                // =5
               	mov	x17, #0xcccd            // =52429
               	movk	x17, #0xcccc, lsl #16
               	mul	x2, x0, x17
               	lsr	x2, x2, #34
               	msub	x0, x2, x1, x0
               	mov	w0, w0
               	ret

<less64>:
               	add	x0, x0, #0x2
               	mov	w0, w0
               	cmp	x0, #0x2
               	cset	x0, lt
               	ret

<store8>:
               	add	x0, x0, #0x2
               	mov	w0, w0
               	str	x0, [x2]
               	ret

<pass>:
               	ret

<as_arg>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, #0x2
               	mov	w0, w0
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<index_of>:
               	add	x1, x1, #0x2
               	ldr	x0, [x0, w1, uxtw #3]
               	ret

<as_double>:
               	add	x0, x0, #0x2
               	mov	w0, w0
               	scvtf	d0, x0
               	ret

<sum_nonzero>:
               	add	x0, x0, x1
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<usum_nonzero>:
               	add	x0, x0, x1
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<diff_zero>:
               	sub	x0, x0, x1
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x9                // =9
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0x7fffffff         // =2147483647
               	stur	w0, [x29, #-0x38]
               	mov	x0, #-0x80000000        // =-2147483648
               	stur	w0, [x29, #-0x30]
               	mov	x0, #0xffffffff         // =4294967295
               	stur	w0, [x29, #-0x28]
               	mov	x0, #0x80000000         // =2147483648
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x38]
               	sub	x0, x0, #0x2
               	sub	x1, x29, #0x18
               	bl	<addr>
               	mov	x17, #0xfffa            // =65530
               	movk	x17, #0x7fff, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x38]
               	sub	x0, x0, #0x1
               	ldursw	x1, [x29, #-0x38]
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x38]
               	sub	x0, x0, #0x1
               	ldursw	x1, [x29, #-0x30]
               	add	x1, x1, #0x2
               	bl	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x38]
               	sub	x0, x0, #0x5
               	ldursw	x1, [x29, #-0x38]
               	mov	x2, #0x4                // =4
               	mov	x3, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0xfffa            // =65530
               	movk	x17, #0x7fff, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x30]
               	add	x0, x0, #0x1
               	sub	x1, x29, #0x18
               	bl	<addr>
               	mov	x17, #-0xffffffff       // =-4294967295
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0x10e1            // =4321
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x1               // =-1
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x38]
               	sub	x0, x0, #0x2
               	ldursw	x1, [x29, #-0x38]
               	mov	x2, #0x5                // =5
               	sub	x3, x29, #0x10
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	mov	x17, #-0x7ffffffd       // =-2147483645
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x38]
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x38]
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x63               // =99
               	bl	<addr>
               	cmp	x0, #0x64
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x30]
               	bl	<addr>
               	mov	x17, #-0x7fffffff       // =-2147483647
               	cmp	x0, x17
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x28]
               	sub	x0, x0, #0x1
               	mov	w0, w0
               	bl	<addr>
               	mov	x17, #0x1fffffffe       // =8589934590
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x28]
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x28]
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x28]
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x28]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x28]
               	mov	x1, #0x8                // =8
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	eor	x0, x0, #0x2
               	cbz	w0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x28]
               	mov	x1, #0x2                // =2
               	mov	x2, x1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x1               // =-1
               	stur	x0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x28]
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x8
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x28]
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	w1, [x29, #-0x28]
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x28]
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x30]
               	ldursw	x1, [x29, #-0x30]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x38]
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x20]
               	ldur	w1, [x29, #-0x20]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x20]
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x30]
               	ldursw	x1, [x29, #-0x30]
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x30]
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
