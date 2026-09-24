
return_low_word.aarch64:	file format elf64-littleaarch64

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

<square>:
               	mul	x0, x0, x0
               	ret

<usquare>:
               	mul	x0, x0, x0
               	ret

<sum_min>:
               	add	x0, x0, x1
               	ret

<shalf>:
               	sxtw	x0, w0
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	sxth	x0, w0
               	ret

<cbyte>:
               	sxtb	x0, w0
               	ret

<zero_if>:
               	and	x0, x0, #0x1
               	ret

<as_long>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<as_ulong>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	w0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<as_int>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xb505             // =46341
               	bl	<addr>
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<as_test>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	b	<addr>

<as_index>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x0, x1
               	bl	<addr>
               	ldr	x0, [x20, w0, sxtw #3]
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<as_short>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxth	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<as_char>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtb	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<as_diff>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x0, #0x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<through_ptr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x10000            // =65536
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb505             // =46341
               	bl	<addr>
               	mov	x17, #-0xede7           // =-60903
               	movk	x17, #0x8000, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0xb505            // =-46341
               	bl	<addr>
               	mov	x17, #-0xede7           // =-60903
               	movk	x17, #0x8000, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb505             // =46341
               	bl	<addr>
               	mov	x17, #-0xede6           // =-60902
               	movk	x17, #0x8000, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10000            // =65536
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffffffff         // =4294967295
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0x5
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0xb
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x1170            // =-4464
               	movk	x0, #0xfffe, lsl #16
               	bl	<addr>
               	mov	x17, #0x7748            // =30536
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd40              // =3392
               	movk	x0, #0x3, lsl #16
               	bl	<addr>
               	mov	x17, #-0x7960           // =-31072
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x80000000        // =-2147483648
               	mov	x1, x0
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7fffffff         // =2147483647
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	mov	x17, #-0x80000001       // =-2147483649
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x80000000        // =-2147483648
               	mov	x1, #-0x1               // =-1
               	bl	<addr>
               	mov	x17, #0x7ffffffe        // =2147483646
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x10000            // =65536
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xb505             // =46341
               	bl	<addr>
               	mov	x17, #-0xede7           // =-60903
               	movk	x17, #0x8000, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
