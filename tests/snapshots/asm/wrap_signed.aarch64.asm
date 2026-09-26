
wrap_signed.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0x0                // =0
               	mov	x3, x2
               	cmp	w0, #0x0
               	b.le	<addr>
               	sxtw	x4, w0
               	add	x3, x3, x4
               	add	x2, x2, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.gt	<addr>
               	str	w2, [x1]
               	mov	x0, x3
               	ret

<le_max>:
               	mov	x2, #0x0                // =0
               	mov	x3, x2
               	cmp	w0, w1
               	b.gt	<addr>
               	sxtw	x4, w0
               	add	x3, x3, x4
               	add	x2, x2, #0x1
               	cmp	w2, #0x4
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.le	<addr>
               	mov	x0, x3
               	ret

<ne_bound>:
               	mov	x2, #0x0                // =0
               	cmp	w0, w1
               	b.eq	<addr>
               	sxtw	x3, w0
               	add	x2, x2, x3
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x0, x2
               	ret

<step_var>:
               	mov	x2, #0x0                // =0
               	mov	x3, x2
               	cmp	w0, w1
               	b.ge	<addr>
               	sxtw	x4, w0
               	add	x3, x3, x4
               	add	x2, x2, #0x1
               	cmp	w2, #0x3
               	b.eq	<addr>
               	add	x0, x0, #0x4
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x3
               	ret

<wrap_down>:
               	mov	x2, #0x0                // =0
               	mov	x3, x2
               	cmp	w0, #0x0
               	b.ge	<addr>
               	sxtw	x4, w0
               	add	x3, x3, x4
               	add	x2, x2, #0x1
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	str	w2, [x1]
               	mov	x0, x3
               	ret

<two_back_edges>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	mov	x4, x0
               	cmp	w2, w1
               	b.ge	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.eq	<addr>
               	tbz	w0, #0x0, <addr>
               	add	x2, x2, #0x1
               	b	<addr>
               	sxtw	x2, w2
               	add	x4, x4, x2
               	add	x2, x2, #0x2
               	cmp	w2, w1
               	b.lt	<addr>
               	str	w2, [x3]
               	mov	x0, x4
               	ret

<other_guard>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<guard_then_join>:
               	mov	x1, #0x0                // =0
               	cmp	w0, #0x64
               	b.ge	<addr>
               	mov	x1, #0x1                // =1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	add	x0, x1, x0
               	ret

<sum_nonzero>:
               	add	x0, x0, x1
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<pre_inc>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<step_by>:
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	ret

<neg>:
               	neg	x0, x0
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x7fffffff         // =2147483647
               	stur	w0, [x29, #-0x10]
               	mov	x0, #-0x80000000        // =-2147483648
               	stur	w0, [x29, #-0x8]
               	stur	wzr, [x29, #-0x20]
               	stur	wzr, [x29, #-0x18]
               	ldursw	x0, [x29, #-0x10]
               	sub	x0, x0, #0x2
               	sub	x1, x29, #0x20
               	bl	<addr>
               	mov	x17, #0xfffa            // =65530
               	movk	x17, #0x7fff, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	sub	x0, x0, #0x1
               	ldursw	x1, [x29, #-0x10]
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	sub	x0, x0, #0x1
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, #0x2
               	bl	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	sub	x0, x0, #0x5
               	ldursw	x1, [x29, #-0x10]
               	mov	x2, #0x4                // =4
               	mov	x3, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0xfffa            // =65530
               	movk	x17, #0x7fff, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	sub	x1, x29, #0x20
               	bl	<addr>
               	mov	x17, #-0xffffffff       // =-4294967295
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	sub	x0, x0, #0x2
               	ldursw	x1, [x29, #-0x10]
               	mov	x2, #0x5                // =5
               	sub	x3, x29, #0x18
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x18]
               	mov	x17, #-0x7ffffffd       // =-2147483645
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x17, #-0x7fffffff       // =-2147483647
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
