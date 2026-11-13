
c17_library_interfaces.aarch64:	file format elf64-littleaarch64

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

<h1>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x3c]
               	add	x3, x1, #0x1
               	str	w3, [x0, #0x3c]
               	mov	x0, #0x1                // =1
               	str	w0, [x2, x1, lsl #2]
               	ret

<h2>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x3c]
               	add	x3, x1, #0x1
               	str	w3, [x0, #0x3c]
               	mov	x0, #0x2                // =2
               	str	w0, [x2, x1, lsl #2]
               	ret

<last>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x3c]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	brk	#0x1
               	mov	x0, #0x14               // =20
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x3, x29, #0x8
               	stur	xzr, [x29, #-0x8]
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x40]
               	cmp	w0, #0x41
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.ne	<addr>
               	sub	x0, x29, #0x10
               	ldur	x1, [x29, #-0x10]
               	mov	x17, #0xf100            // =61696
               	movk	x17, #0x6553, lsl #16
               	cmp	x1, x17
               	b.lt	<addr>
               	ldur	x1, [x29, #-0x8]
               	cmp	x1, #0x0
               	b.lt	<addr>
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x1, x17
               	b.lt	<addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	cbz	x0, <addr>
               	and	x1, x0, #0xf
               	cbz	x1, <addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x0, #0x40               // =64
               	mov	x1, #0x80               // =128
               	bl	<addr>
               	cbz	x0, <addr>
               	and	x1, x0, #0x3f
               	cbz	x1, <addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	bl	<addr>
               	brk	#0x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x3, x29, #0x40
               	stur	xzr, [x29, #-0x40]
               	sub	x0, x29, #0x38
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x38]
               	cmp	w0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x1
               	mov	x2, #0x1                // =1
               	sub	x3, x29, #0x40
               	bl	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x2
               	mov	x2, #0x5                // =5
               	sub	x3, x29, #0x40
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x38]
               	cmp	w0, #0xe9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x3
               	mov	x2, #0x4                // =4
               	sub	x3, x29, #0x40
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x38]
               	mov	x17, #0xf600            // =62976
               	movk	x17, #0x1, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	sub	x3, x29, #0x40
               	stur	xzr, [x29, #-0x40]
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x3
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	sub	x0, x29, #0x30
               	ldurh	w1, [x29, #-0x30]
               	mov	x17, #0xd83d            // =55357
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	add	x0, x0, #0x2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x7
               	mov	x2, #0x0                // =0
               	sub	x3, x29, #0x40
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x2e]
               	mov	x17, #0xde00            // =56832
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	sub	x2, x29, #0x40
               	stur	xzr, [x29, #-0x40]
               	sub	x0, x29, #0x20
               	ldurh	w1, [x29, #-0x30]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	sub	x0, x29, #0x20
               	ldurh	w1, [x29, #-0x2e]
               	sub	x2, x29, #0x40
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x3
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, #0xe9               // =233
               	sub	x2, x29, #0x40
               	bl	<addr>
               	cmp	x0, #0x2
               	b.ne	<addr>
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x1
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, #0xd800             // =55296
               	sub	x2, x29, #0x40
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, #0xdc00             // =56320
               	sub	x2, x29, #0x40
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	sub	x3, x29, #0x40
               	bl	<addr>
               	cbnz	x0, <addr>
               	ldur	w0, [x29, #-0x38]
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	sub	x3, x29, #0x8
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x38]
               	cmp	w0, #0x7a
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	b	<addr>
               	sub	x0, x29, #0x30
               	mov	x1, #0x71               // =113
               	sub	x2, x29, #0x8
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	sub	x0, x29, #0x30
               	ldurb	w1, [x29, #-0x30]
               	cmp	w1, #0x71
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	b	<addr>
               	mov	x1, #0x72               // =114
               	sub	x2, x29, #0x8
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x30]
               	cmp	w0, #0x72
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
