
int128_struct_fallback.aarch64:	file format elf64-littleaarch64

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

<rt>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	add	x20, x21, x0
               	cmp	x20, x21
               	cset	x21, lo
               	cbnz	x20, <addr>
               	cmp	w21, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sub	x1, x22, x0
               	cmp	x22, x0
               	cset	x0, lo
               	sub	x0, x23, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.ne	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mvn	x0, x0
               	add	x0, x0, #0x1
               	cmp	x0, #0x0
               	cset	x1, eq
               	sub	x1, x1, #0x1
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	sub	x1, x29, #0x10
               	stp	xzr, xzr, [x1]
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	lsl	x2, x1, #36
               	sub	x1, x29, #0x10
               	stp	xzr, xzr, [x1]
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	bl	<addr>
               	lsr	x1, x22, #4
               	lsl	x2, x0, #60
               	orr	x2, x1, x2
               	asr	x1, x0, #4
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #-0x800000000000000 // =-576460752303423488
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x20, x22
               	b.ne	<addr>
               	cmp	x21, x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	x20, x0
               	b.hs	<addr>
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x20, x0
               	b.hs	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
