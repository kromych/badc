
stores_overwritten_before_a_read.aarch64:	file format elf64-littleaarch64

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

<observe>:
               	adrp	x1, <page>
               	ldrsw	x0, [x0]
               	str	w0, [x1, #0x20]
               	ret

<alias_read>:
               	mov	x2, #0x1                // =1
               	str	w2, [x0]
               	ldrsw	x1, [x1]
               	mov	x2, #0x2                // =2
               	str	w2, [x0]
               	mov	x0, x1
               	ret

<through_call>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x0, #0x3                // =3
               	str	w0, [x20]
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x4                // =4
               	str	w0, [x20]
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<via_volatile>:
               	mov	x1, #0x5                // =5
               	str	w1, [x0]
               	ldrsw	x1, [x0]
               	mov	x2, #0x6                // =6
               	str	w2, [x0]
               	mov	x0, x1
               	ret

<partial>:
               	mov	x1, #0xffffffff         // =4294967295
               	str	x1, [x0]
               	ret

<overwrite>:
               	add	x1, x1, #0x2
               	str	w1, [x0]
               	ret

<fields>:
               	ldr	x2, [x0, #0x8]
               	and	x1, x2, x1
               	orr	x1, x1, #0x100
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	str	x1, [x0, #0x8]
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	wzr, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	mov	x1, x0
               	bl	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	bl	<addr>
               	cmp	w0, #0x5
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	bl	<addr>
               	ldur	w0, [x29, #-0x18]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x14]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x28               // =40
               	bl	<addr>
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x1, #0xff00             // =65280
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0xf105            // =61701
               	cmp	x0, x17
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
