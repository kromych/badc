
atomic_orders.aarch64:	file format elf64-littleaarch64

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

<int_ops>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x1170            // =-4464
               	movk	x1, #0xfffe, lsl #16
               	str	w1, [x0]
               	mov	x3, #0x3                // =3
               	ldaddal	w3, w4, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsw	x4, [x0]
               	mov	x17, #-0x116d           // =-4461
               	movk	x17, #0xfffe, lsl #16
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	neg	x16, x3
               	ldaddal	w16, w3, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w3, w17
               	b.ne	<addr>
               	ldrsw	x3, [x0]
               	mov	x17, #-0x1173           // =-4467
               	movk	x17, #0xfffe, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	mov	x3, #0x6                // =6
               	mvn	x16, x3
               	ldclral	w16, w4, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsw	x4, [x0]
               	cbz	w4, <addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	ldsetal	w3, w4, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsw	x4, [x0]
               	mov	x17, #-0x116a           // =-4458
               	movk	x17, #0xfffe, lsl #16
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	ldeoral	w3, w1, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsw	x0, [x0]
               	mov	x17, #-0x116a           // =-4458
               	movk	x17, #0xfffe, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x1170            // =-4464
               	movk	x1, #0xfffe, lsl #16
               	str	w1, [x0]
               	mov	x5, #0x9                // =9
               	swpal	w5, w4, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsw	x4, [x0]
               	cmp	w4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	mov	x4, #0x3                // =3
               	ldaddal	w4, w6, [x0]
               	add	x6, x6, #0x3
               	mov	x17, #-0x116d           // =-4461
               	movk	x17, #0xfffe, lsl #16
               	cmp	w6, w17
               	b.ne	<addr>
               	ldrsw	x6, [x0]
               	mov	x17, #-0x116d           // =-4461
               	movk	x17, #0xfffe, lsl #16
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	neg	x16, x4
               	ldaddal	w16, w6, [x0]
               	sub	x6, x6, #0x3
               	mov	x17, #-0x1173           // =-4467
               	movk	x17, #0xfffe, lsl #16
               	cmp	w6, w17
               	b.ne	<addr>
               	ldrsw	x6, [x0]
               	mov	x17, #-0x1173           // =-4467
               	movk	x17, #0xfffe, lsl #16
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	mvn	x16, x3
               	ldclral	w16, w6, [x0]
               	and	x3, x6, x3
               	cbnz	w3, <addr>
               	ldrsw	x3, [x0]
               	cbz	w3, <addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	mov	x3, #0x6                // =6
               	ldsetal	w3, w0, [x0]
               	orr	x0, x0, x3
               	mov	x17, #-0x116a           // =-4458
               	movk	x17, #0xfffe, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x17, #-0x116a           // =-4458
               	movk	x17, #0xfffe, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x1170            // =-4464
               	movk	x1, #0xfffe, lsl #16
               	str	w1, [x0]
               	ldeoral	w3, w6, [x0]
               	eor	x3, x6, x3
               	mov	x17, #-0x116a           // =-4458
               	movk	x17, #0xfffe, lsl #16
               	cmp	w3, w17
               	b.ne	<addr>
               	ldrsw	x3, [x0]
               	mov	x17, #-0x116a           // =-4458
               	movk	x17, #0xfffe, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	ldaddal	w4, w16, [x0]
               	mov	x3, #0x1                // =1
               	neg	x16, x3
               	ldaddal	w16, w17, [x0]
               	ldrsw	x6, [x0]
               	mov	x17, #-0x116e           // =-4462
               	movk	x17, #0xfffe, lsl #16
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	mov	x6, #0xe                // =14
               	mvn	x16, x6
               	ldclral	w16, w17, [x0]
               	ldsetal	w3, w16, [x0]
               	ldeoral	w4, w16, [x0]
               	ldrsw	x3, [x0]
               	cmp	w3, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	mov	x3, #0x5                // =5
               	swpal	w3, w16, [x0]
               	ldrsw	x3, [x0]
               	cmp	w3, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	mov	x3, x1
               	casal	w3, w5, [x0]
               	mov	x17, #0xee90            // =61072
               	movk	x17, #0xfffe, lsl #16
               	cmp	w3, w17
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x1170            // =-4464
               	movk	x1, #0xfffe, lsl #16
               	str	w1, [x0]
               	mov	x3, #-0x116f            // =-4463
               	movk	x3, #0xfffe, lsl #16
               	mov	x4, #0x9                // =9
               	mov	x5, x3
               	casal	w5, w4, [x0]
               	mov	x17, #0xee91            // =61073
               	movk	x17, #0xfffe, lsl #16
               	cmp	w5, w17
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldrsw	x6, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w6, w17
               	b.ne	<addr>
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	mov	x5, x3
               	casal	w5, w4, [x0]
               	mov	x17, #0xee91            // =61073
               	movk	x17, #0xfffe, lsl #16
               	cmp	w5, w17
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldrsw	x6, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w6, w17
               	b.ne	<addr>
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	str	w1, [x2]
               	mov	x5, x1
               	casal	w5, w4, [x0]
               	mov	x17, #0xee90            // =61072
               	movk	x17, #0xfffe, lsl #16
               	cmp	w5, w17
               	cset	x4, eq
               	cbz	x4, <addr>
               	cbz	x4, <addr>
               	ldrsw	x4, [x0]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldrsw	x4, [x2]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	str	w3, [x2]
               	mov	x3, #-0x116f            // =-4463
               	movk	x3, #0xfffe, lsl #16
               	mov	x4, #0x9                // =9
               	mov	x1, x3
               	casal	w1, w4, [x0]
               	mov	x17, #0xee91            // =61073
               	movk	x17, #0xfffe, lsl #16
               	cmp	w1, w17
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrsw	x0, [x2]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x1170            // =-4464
               	movk	x1, #0xfffe, lsl #16
               	str	w1, [x0]
               	ldr	w2, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	stlr	w3, [x0]
               	ldapr	w2, [x0]
               	mov	x17, #-0x116f           // =-4463
               	movk	x17, #0xfffe, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	ldapr	w2, [x0]
               	mov	x17, #-0x116f           // =-4463
               	movk	x17, #0xfffe, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	stlr	w1, [x0]
               	ldar	w2, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	mov	x2, #0x3                // =3
               	ldaddal	w2, w3, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w3, w17
               	b.ne	<addr>
               	ldrsw	x3, [x0]
               	mov	x17, #-0x116d           // =-4461
               	movk	x17, #0xfffe, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	neg	x16, x2
               	ldaddal	w16, w2, [x0]
               	sub	x2, x2, #0x3
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	ldrsw	x2, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	mov	x2, #0x6                // =6
               	ldeoral	w2, w2, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	ldrsw	x2, [x0]
               	mov	x17, #-0x116a           // =-4458
               	movk	x17, #0xfffe, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	str	w1, [x0]
               	casal	w1, w4, [x0]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #-0x1170            // =-4464
               	movk	x0, #0xfffe, lsl #16
               	mov	x2, #0x8                // =8
               	mov	x3, x0
               	casal	w3, w2, [x1]
               	cmp	w3, #0x9
               	b.ne	<addr>
               	ldrsw	x3, [x1]
               	cmp	w3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	mov	x3, #0x9                // =9
               	mov	x4, x3
               	casal	w4, w0, [x1]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldrsw	x0, [x1]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	mov	x0, x3
               	casal	w0, w2, [x1]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	ldrsw	x0, [x1]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	mov	x0, #0x7                // =7
               	swpa	w0, w0, [x1]
               	mov	x17, #-0x1170           // =-4464
               	movk	x17, #0xfffe, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrsw	x0, [x1]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	mov	x0, #0x0                // =0
               	stlr	w0, [x1]
               	ldrsw	x1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0x8e               // =142
               	ret
               	ret
               	str	w1, [x2]
               	b	<addr>
               	str	w5, [x2]
               	b	<addr>
               	mov	x1, x3
               	b	<addr>

<llong_ops>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	mov	x3, #0x3                // =3
               	ldadd	x3, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	neg	x16, x3
               	ldadd	x16, x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, #0x6                // =6
               	mvn	x16, x3
               	ldclr	x16, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	cbz	x4, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldset	x3, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldeor	x3, x2, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x1, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	mov	x4, #0x9                // =9
               	swp	x4, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	cmp	x4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x4, #0x3                // =3
               	ldadd	x4, x5, [x1]
               	add	x5, x5, #0x3
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	neg	x16, x4
               	ldadd	x16, x5, [x1]
               	sub	x5, x5, #0x3
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mvn	x16, x3
               	ldclr	x16, x5, [x1]
               	and	x3, x5, x3
               	cbnz	w3, <addr>
               	ldr	x3, [x1]
               	cbz	x3, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, #0x6                // =6
               	ldset	x3, x1, [x1]
               	orr	x1, x1, x3
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	ldeor	x3, x5, [x1]
               	eor	x3, x5, x3
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	stadd	x4, [x1]
               	mov	x3, #0x1                // =1
               	neg	x16, x3
               	stadd	x16, [x1]
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fe           // =-61950
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x5, #0xe                // =14
               	mvn	x16, x5
               	stclr	x16, [x1]
               	stset	x3, [x1]
               	steor	x4, [x1]
               	ldr	x3, [x1]
               	cmp	x3, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, #0x5                // =5
               	swp	x3, xzr, [x1]
               	ldr	x3, [x1]
               	cmp	x3, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldadda	x4, x1, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #-0xf200            // =-61952
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	str	x3, [x1]
               	mov	x4, #0x3                // =3
               	neg	x16, x4
               	ldadda	x16, x2, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x2, #0x6                // =6
               	mvn	x16, x2
               	ldclra	x16, x5, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	cbz	x5, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldseta	x2, x5, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldeora	x2, x5, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x3, #0x9                // =9
               	swpa	x3, x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x1, [x1]
               	cmp	x1, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #-0xf200            // =-61952
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	str	x3, [x1]
               	ldadda	x4, x4, [x1]
               	add	x4, x4, #0x3
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x4, #0x3                // =3
               	neg	x16, x4
               	ldadda	x16, x5, [x1]
               	sub	x5, x5, #0x3
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mvn	x16, x2
               	ldclra	x16, x5, [x1]
               	and	x5, x5, x2
               	cbnz	w5, <addr>
               	ldr	x5, [x1]
               	cbz	x5, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldseta	x2, x3, [x1]
               	orr	x2, x3, x2
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0x6                // =6
               	ldeora	x3, x5, [x1]
               	eor	x3, x5, x3
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldadda	x4, x16, [x1]
               	mov	x3, #0x1                // =1
               	neg	x16, x3
               	ldadda	x16, x17, [x1]
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fe           // =-61950
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x5, #0xe                // =14
               	mvn	x16, x5
               	ldclra	x16, x17, [x1]
               	ldseta	x3, x16, [x1]
               	ldeora	x4, x16, [x1]
               	ldr	x3, [x1]
               	cmp	x3, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, #0x5                // =5
               	swpa	x3, x16, [x1]
               	ldr	x3, [x1]
               	cmp	x3, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldadda	x4, x2, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x3, #-0xf200            // =-61952
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	str	x3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	neg	x16, x2
               	ldadda	x16, x2, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x2, #0x6                // =6
               	mvn	x16, x2
               	ldclra	x16, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	cbz	x4, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldseta	x2, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldeora	x2, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x3, #0x9                // =9
               	swpa	x3, x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	cmp	x3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x3, #-0xf200            // =-61952
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	str	x3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x4, #0x3                // =3
               	ldadda	x4, x5, [x1]
               	add	x5, x5, #0x3
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	neg	x16, x4
               	ldadda	x16, x4, [x1]
               	sub	x4, x4, #0x3
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mvn	x16, x2
               	ldclra	x16, x4, [x1]
               	and	x4, x4, x2
               	cbnz	w4, <addr>
               	ldr	x4, [x1]
               	cbz	x4, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldseta	x2, x4, [x1]
               	orr	x2, x4, x2
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x6                // =6
               	ldeora	x2, x3, [x1]
               	eor	x2, x3, x2
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	mov	x3, #0x3                // =3
               	ldadda	x3, x16, [x1]
               	mov	x4, #0x1                // =1
               	neg	x16, x4
               	ldadda	x16, x17, [x1]
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fe           // =-61950
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x5, #0xe                // =14
               	mvn	x16, x5
               	ldclra	x16, x17, [x1]
               	ldseta	x4, x16, [x1]
               	ldeora	x3, x16, [x1]
               	ldr	x4, [x1]
               	cmp	x4, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x4, #0x5                // =5
               	swpa	x4, x16, [x1]
               	ldr	x4, [x1]
               	cmp	x4, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldaddl	x3, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	neg	x16, x3
               	ldaddl	x16, x1, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	mov	x3, #0x6                // =6
               	mvn	x16, x3
               	ldclrl	x16, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	cbz	x4, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldsetl	x3, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldeorl	x3, x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, #0x9                // =9
               	swpl	x3, x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	cmp	x3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x4, #0x3                // =3
               	ldaddl	x4, x1, [x1]
               	add	x1, x1, #0x3
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #-0xf200            // =-61952
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	str	x3, [x1]
               	neg	x16, x4
               	ldaddl	x16, x2, [x1]
               	sub	x2, x2, #0x3
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x2, #0x6                // =6
               	mvn	x16, x2
               	ldclrl	x16, x5, [x1]
               	and	x5, x5, x2
               	cbnz	w5, <addr>
               	ldr	x5, [x1]
               	cbz	x5, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldsetl	x2, x5, [x1]
               	orr	x5, x5, x2
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldeorl	x2, x5, [x1]
               	eor	x5, x5, x2
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	staddl	x4, [x1]
               	mov	x4, #0x1                // =1
               	neg	x16, x4
               	staddl	x16, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x3, [x1]
               	mov	x17, #-0xf1fe           // =-61950
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x3, #-0xf200            // =-61952
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	str	x3, [x1]
               	mov	x5, #0xe                // =14
               	mvn	x16, x5
               	stclrl	x16, [x1]
               	stsetl	x4, [x1]
               	mov	x4, #0x3                // =3
               	steorl	x4, [x1]
               	ldr	x5, [x1]
               	cmp	x5, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x5, #0x5                // =5
               	swpl	x5, xzr, [x1]
               	ldr	x5, [x1]
               	cmp	x5, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldaddal	x4, x5, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	neg	x16, x4
               	ldaddal	x16, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mvn	x16, x2
               	ldclral	x16, x1, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cbz	x1, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	mov	x3, #0x6                // =6
               	ldsetal	x3, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldeoral	x3, x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, #0x9                // =9
               	swpal	x3, x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	cmp	x3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x4, #0x3                // =3
               	ldaddal	x4, x3, [x1]
               	add	x3, x3, #0x3
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	neg	x16, x4
               	ldaddal	x16, x2, [x1]
               	sub	x2, x2, #0x3
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x1, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #-0xf200            // =-61952
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	str	x3, [x1]
               	mov	x2, #0x6                // =6
               	mvn	x16, x2
               	ldclral	x16, x5, [x1]
               	and	x5, x5, x2
               	cbnz	w5, <addr>
               	ldr	x5, [x1]
               	cbz	x5, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldsetal	x2, x5, [x1]
               	orr	x5, x5, x2
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldeoral	x2, x5, [x1]
               	eor	x2, x5, x2
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldaddal	x4, x16, [x1]
               	mov	x2, #0x1                // =1
               	neg	x16, x2
               	ldaddal	x16, x17, [x1]
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fe           // =-61950
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x3, #0xe                // =14
               	mvn	x16, x3
               	ldclral	x16, x17, [x1]
               	ldsetal	x2, x16, [x1]
               	ldeoral	x4, x16, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	cmp	x2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	mov	x3, #0x5                // =5
               	swpal	x3, x16, [x1]
               	ldr	x3, [x1]
               	cmp	x3, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, #0x3                // =3
               	ldaddal	x3, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	neg	x16, x3
               	ldaddal	x16, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x4, #0x6                // =6
               	mvn	x16, x4
               	ldclral	x16, x5, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x1]
               	cbz	x5, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldsetal	x4, x2, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldeoral	x4, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x4, #0x9                // =9
               	swpal	x4, x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	cmp	x4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldaddal	x3, x4, [x1]
               	add	x4, x4, #0x3
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	neg	x16, x3
               	ldaddal	x16, x3, [x1]
               	sub	x3, x3, #0x3
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf203           // =-61955
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x6                // =6
               	mvn	x16, x2
               	ldclral	x16, x3, [x1]
               	and	x3, x3, x2
               	cbnz	w3, <addr>
               	ldr	x3, [x1]
               	cbz	x3, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x3, #-0xf200            // =-61952
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	str	x3, [x1]
               	ldsetal	x2, x4, [x1]
               	orr	x4, x4, x2
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	ldeoral	x2, x4, [x1]
               	eor	x2, x4, x2
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x2, #0x3                // =3
               	ldaddal	x2, x16, [x1]
               	mov	x4, #0x1                // =1
               	neg	x16, x4
               	ldaddal	x16, x17, [x1]
               	ldr	x5, [x1]
               	mov	x17, #-0xf1fe           // =-61950
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x5, #0xe                // =14
               	mvn	x16, x5
               	ldclral	x16, x17, [x1]
               	ldsetal	x4, x16, [x1]
               	ldeoral	x2, x16, [x1]
               	ldr	x2, [x1]
               	cmp	x2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x2, #0x5                // =5
               	swpal	x2, x16, [x1]
               	ldr	x2, [x1]
               	cmp	x2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x4, #0x9                // =9
               	mov	x3, x2
               	cas	x3, x4, [x1]
               	cmp	x3, x2
               	cset	x5, eq
               	cbz	x5, <addr>
               	mov	x3, x2
               	cbz	x5, <addr>
               	ldr	x5, [x1]
               	cmp	x5, #0x9
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, #-0xf1ff            // =-61951
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	mov	x5, x3
               	cas	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldr	x6, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x5, x3
               	cas	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldr	x6, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	str	x2, [x0]
               	mov	x5, x2
               	cas	x5, x4, [x1]
               	cmp	x5, x2
               	cset	x2, eq
               	cbz	x2, <addr>
               	cbz	x2, <addr>
               	ldr	x1, [x1]
               	cmp	x1, #0x9
               	b.ne	<addr>
               	ldr	x1, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	str	x3, [x0]
               	mov	x4, #0x9                // =9
               	mov	x5, x3
               	cas	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x3, eq
               	cbz	x3, <addr>
               	cbnz	w3, <addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, x2
               	casa	x3, x4, [x1]
               	cmp	x3, x2
               	cset	x5, eq
               	cbz	x5, <addr>
               	mov	x3, x2
               	cbz	x5, <addr>
               	ldr	x5, [x1]
               	cmp	x5, #0x9
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, #-0xf1ff            // =-61951
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	mov	x5, x3
               	casa	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldr	x6, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x2, x3
               	casa	x2, x4, [x1]
               	cmp	x2, x3
               	cset	x4, eq
               	cbz	x4, <addr>
               	mov	x2, x3
               	cbnz	w4, <addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	str	x2, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x4, #0x9                // =9
               	mov	x5, x2
               	casa	x5, x4, [x1]
               	cmp	x5, x2
               	cset	x6, eq
               	cbz	x6, <addr>
               	cbz	x6, <addr>
               	ldr	x5, [x1]
               	cmp	x5, #0x9
               	b.ne	<addr>
               	ldr	x5, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	str	x3, [x0]
               	mov	x5, x3
               	casa	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x3, eq
               	cbz	x3, <addr>
               	cbnz	w3, <addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, x2
               	casa	x3, x4, [x1]
               	cmp	x3, x2
               	cset	x5, eq
               	cbz	x5, <addr>
               	mov	x3, x2
               	cbz	x5, <addr>
               	ldr	x5, [x1]
               	cmp	x5, #0x9
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, #-0xf1ff            // =-61951
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	mov	x2, x3
               	casa	x2, x4, [x1]
               	cmp	x2, x3
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x2, x3
               	cbnz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	mov	x4, #0x9                // =9
               	mov	x5, x3
               	casa	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldr	x6, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	str	x2, [x0]
               	mov	x5, x2
               	casa	x5, x4, [x1]
               	cmp	x5, x2
               	cset	x6, eq
               	cbz	x6, <addr>
               	cbz	x6, <addr>
               	ldr	x5, [x1]
               	cmp	x5, #0x9
               	b.ne	<addr>
               	ldr	x5, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	str	x3, [x0]
               	mov	x5, x3
               	casa	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x3, eq
               	cbz	x3, <addr>
               	cbnz	w3, <addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x4, #0x9                // =9
               	mov	x3, x2
               	casl	x3, x4, [x1]
               	cmp	x3, x2
               	cset	x1, eq
               	cbz	x1, <addr>
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0x9
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	mov	x3, #-0xf1ff            // =-61951
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	mov	x5, x3
               	casl	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldr	x6, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x5, x3
               	casl	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldr	x6, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	str	x2, [x0]
               	mov	x5, x2
               	casl	x5, x4, [x1]
               	cmp	x5, x2
               	cset	x4, eq
               	cbz	x4, <addr>
               	cbz	x4, <addr>
               	ldr	x4, [x1]
               	cmp	x4, #0x9
               	b.ne	<addr>
               	ldr	x4, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	str	x3, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #-0xf1ff            // =-61951
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	mov	x4, #0x9                // =9
               	mov	x2, x3
               	casl	x2, x4, [x1]
               	cmp	x2, x3
               	cset	x5, eq
               	cbz	x5, <addr>
               	cbnz	w5, <addr>
               	ldr	x2, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	mov	x5, x2
               	casal	x5, x4, [x1]
               	cmp	x5, x2
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x2
               	cbz	x6, <addr>
               	ldr	x6, [x1]
               	cmp	x6, #0x9
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x5, x3
               	casal	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldr	x6, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x5, x3
               	casal	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x4, eq
               	cbz	x4, <addr>
               	cbnz	w4, <addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	str	x2, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x4, #0x9                // =9
               	mov	x3, x2
               	casal	x3, x4, [x1]
               	cmp	x3, x2
               	cset	x2, eq
               	cbz	x2, <addr>
               	cbz	x2, <addr>
               	ldr	x2, [x1]
               	cmp	x2, #0x9
               	b.ne	<addr>
               	ldr	x2, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x3, #-0xf200            // =-61952
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	str	x3, [x1]
               	mov	x2, #-0xf1ff            // =-61951
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x0]
               	mov	x5, x2
               	casal	x5, x4, [x1]
               	cmp	x5, x2
               	cset	x6, eq
               	cbz	x6, <addr>
               	cbnz	w6, <addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x5, x3
               	casal	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbz	x6, <addr>
               	ldr	x6, [x1]
               	cmp	x6, #0x9
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x5, x2
               	casal	x5, x4, [x1]
               	cmp	x5, x2
               	cset	x4, eq
               	cbz	x4, <addr>
               	mov	x5, x2
               	cbnz	w4, <addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x4, #0x9                // =9
               	mov	x5, x2
               	casal	x5, x4, [x1]
               	cmp	x5, x2
               	cset	x6, eq
               	cbz	x6, <addr>
               	cbnz	w6, <addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	str	x3, [x0]
               	mov	x3, #-0xf200            // =-61952
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	mov	x2, x3
               	casal	x2, x4, [x1]
               	cmp	x2, x3
               	cset	x5, eq
               	cbz	x5, <addr>
               	cbz	x5, <addr>
               	ldr	x2, [x1]
               	cmp	x2, #0x9
               	b.ne	<addr>
               	ldr	x2, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x2, #-0xf1ff            // =-61951
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x0]
               	mov	x5, x2
               	casal	x5, x4, [x1]
               	cmp	x5, x2
               	cset	x6, eq
               	cbz	x6, <addr>
               	cbnz	w6, <addr>
               	ldr	x5, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldr	x5, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x5, x3
               	casal	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbz	x6, <addr>
               	ldr	x6, [x1]
               	cmp	x6, #0x9
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x3, [x1]
               	mov	x5, x2
               	casal	x5, x4, [x1]
               	cmp	x5, x2
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x5, x2
               	cbnz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x3, [x1]
               	mov	x4, #0x9                // =9
               	mov	x3, x2
               	casal	x3, x4, [x1]
               	cmp	x3, x2
               	cset	x5, eq
               	cbz	x5, <addr>
               	cbnz	w5, <addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x2, #-0xf200            // =-61952
               	movk	x2, #0xd5fa, lsl #16
               	movk	x2, #0xfffe, lsl #32
               	str	x2, [x1]
               	str	x2, [x0]
               	mov	x3, x2
               	casal	x3, x4, [x1]
               	cmp	x3, x2
               	cset	x5, eq
               	cbz	x5, <addr>
               	cbz	x5, <addr>
               	ldr	x3, [x1]
               	cmp	x3, #0x9
               	b.ne	<addr>
               	ldr	x3, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x3, #-0xf1ff            // =-61951
               	movk	x3, #0xd5fa, lsl #16
               	movk	x3, #0xfffe, lsl #32
               	str	x3, [x0]
               	mov	x5, x3
               	casal	x5, x4, [x1]
               	cmp	x5, x3
               	cset	x4, eq
               	cbz	x4, <addr>
               	cbnz	w4, <addr>
               	ldr	x4, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x0, [x0]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	ldr	x0, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	stlr	x3, [x1]
               	ldapr	x0, [x1]
               	mov	x17, #-0xf1ff           // =-61951
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	ldapr	x0, [x1]
               	mov	x17, #-0xf1ff           // =-61951
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	stlr	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldar	x0, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x0, #0x3                // =3
               	ldaddal	x0, x3, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	mov	x17, #-0xf1fd           // =-61949
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	neg	x16, x0
               	ldaddal	x16, x0, [x1]
               	sub	x0, x0, #0x3
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	ldr	x0, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x0, #0x6                // =6
               	ldeoral	x0, x0, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	ldr	x0, [x1]
               	mov	x17, #-0xf1fa           // =-61946
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	str	x2, [x1]
               	mov	x0, #-0xf200            // =-61952
               	movk	x0, #0xd5fa, lsl #16
               	movk	x0, #0xfffe, lsl #32
               	mov	x2, #0x9                // =9
               	mov	x3, x0
               	casal	x3, x2, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x1]
               	cmp	x3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x3, #0x8                // =8
               	mov	x4, x0
               	casal	x4, x3, [x1]
               	cmp	x4, #0x9
               	b.ne	<addr>
               	ldr	x4, [x1]
               	cmp	x4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x4, x2
               	casal	x4, x0, [x1]
               	cmp	x4, #0x9
               	b.ne	<addr>
               	ldr	x0, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x0, x2
               	casal	x0, x3, [x1]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	ldr	x0, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x0, #0x7                // =7
               	swpa	x0, x0, [x1]
               	mov	x17, #-0xf200           // =-61952
               	movk	x17, #0xd5fa, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	ldr	x0, [x1]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x0, #0x0                // =0
               	stlr	x0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cbz	x1, <addr>
               	mov	x0, #0x8f               // =143
               	ret
               	ret
               	str	x5, [x0]
               	b	<addr>
               	str	x3, [x0]
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	str	x5, [x0]
               	b	<addr>
               	str	x2, [x0]
               	b	<addr>
               	mov	x2, x5
               	b	<addr>
               	str	x5, [x0]
               	b	<addr>
               	str	x3, [x0]
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	str	x2, [x0]
               	b	<addr>
               	str	x5, [x0]
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	str	x5, [x0]
               	b	<addr>
               	str	x5, [x0]
               	b	<addr>
               	str	x5, [x0]
               	b	<addr>
               	str	x5, [x0]
               	b	<addr>
               	str	x5, [x0]
               	b	<addr>
               	str	x5, [x0]
               	b	<addr>

<schar_ops>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x3               // =-3
               	strb	w1, [x0]
               	mov	x3, #0x3                // =3
               	ldaddalb	w3, w4, [x0]
               	sxtb	x4, w4
               	mov	x17, #-0x3              // =-3
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsb	x4, [x0]
               	cbz	w4, <addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	neg	x16, x3
               	ldaddalb	w16, w3, [x0]
               	sxtb	x3, w3
               	mov	x17, #-0x3              // =-3
               	cmp	w3, w17
               	b.ne	<addr>
               	ldrsb	x3, [x0]
               	mov	x17, #-0x6              // =-6
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	mov	x3, #0x6                // =6
               	mvn	x16, x3
               	ldclralb	w16, w4, [x0]
               	sxtb	x4, w4
               	mov	x17, #-0x3              // =-3
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsb	x4, [x0]
               	cmp	w4, #0x4
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	ldsetalb	w3, w4, [x0]
               	sxtb	x4, w4
               	mov	x17, #-0x3              // =-3
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsb	x4, [x0]
               	mov	x17, #-0x1              // =-1
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	ldeoralb	w3, w1, [x0]
               	sxtb	x1, w1
               	mov	x17, #-0x3              // =-3
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsb	x0, [x0]
               	mov	x17, #-0x5              // =-5
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x3               // =-3
               	strb	w1, [x0]
               	mov	x5, #0x9                // =9
               	swpalb	w5, w4, [x0]
               	sxtb	x4, w4
               	mov	x17, #-0x3              // =-3
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsb	x4, [x0]
               	cmp	w4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	mov	x4, #0x3                // =3
               	ldaddalb	w4, w6, [x0]
               	sxtb	x6, w6
               	add	x6, x6, #0x3
               	sxtb	x6, w6
               	cbnz	w6, <addr>
               	ldrsb	x6, [x0]
               	cbz	w6, <addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	neg	x16, x4
               	ldaddalb	w16, w6, [x0]
               	sxtb	x6, w6
               	sub	x6, x6, #0x3
               	sxtb	x6, w6
               	mov	x17, #-0x6              // =-6
               	cmp	w6, w17
               	b.ne	<addr>
               	ldrsb	x6, [x0]
               	mov	x17, #-0x6              // =-6
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	mvn	x16, x3
               	ldclralb	w16, w6, [x0]
               	sxtb	x6, w6
               	and	x3, x6, x3
               	cmp	w3, #0x4
               	b.ne	<addr>
               	ldrsb	x3, [x0]
               	cmp	w3, #0x4
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	mov	x3, #0x6                // =6
               	ldsetalb	w3, w0, [x0]
               	sxtb	x0, w0
               	orr	x0, x0, x3
               	sxtb	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x0, [x0]
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x3               // =-3
               	strb	w1, [x0]
               	ldeoralb	w3, w6, [x0]
               	sxtb	x6, w6
               	eor	x3, x6, x3
               	sxtb	x3, w3
               	mov	x17, #-0x5              // =-5
               	cmp	w3, w17
               	b.ne	<addr>
               	ldrsb	x3, [x0]
               	mov	x17, #-0x5              // =-5
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	ldaddalb	w4, w16, [x0]
               	mov	x3, #0x1                // =1
               	neg	x16, x3
               	ldaddalb	w16, w17, [x0]
               	ldrsb	x6, [x0]
               	mov	x17, #-0x1              // =-1
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	mov	x6, #0xe                // =14
               	mvn	x16, x6
               	ldclralb	w16, w17, [x0]
               	ldsetalb	w3, w16, [x0]
               	ldeoralb	w4, w16, [x0]
               	ldrsb	x3, [x0]
               	cmp	w3, #0xe
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	mov	x3, #0x5                // =5
               	swpalb	w3, w16, [x0]
               	ldrsb	x3, [x0]
               	cmp	w3, #0x5
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	mov	x3, x1
               	casalb	w3, w5, [x0]
               	cmp	w3, #0xfd
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x0, [x0]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	sxtb	x0, w1
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x3               // =-3
               	strb	w1, [x0]
               	mov	x3, #-0x2               // =-2
               	mov	x4, #0x9                // =9
               	mov	x5, x3
               	casalb	w5, w4, [x0]
               	cmp	w5, #0xfe
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldrsb	x6, [x0]
               	mov	x17, #-0x3              // =-3
               	cmp	w6, w17
               	b.ne	<addr>
               	sxtb	x5, w5
               	mov	x17, #-0x3              // =-3
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	mov	x5, x3
               	casalb	w5, w4, [x0]
               	cmp	w5, #0xfe
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldrsb	x6, [x0]
               	mov	x17, #-0x3              // =-3
               	cmp	w6, w17
               	b.ne	<addr>
               	sxtb	x5, w5
               	mov	x17, #-0x3              // =-3
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	strb	w1, [x2]
               	mov	x5, x1
               	casalb	w5, w4, [x0]
               	cmp	w5, #0xfd
               	cset	x4, eq
               	cbz	x4, <addr>
               	cbz	x4, <addr>
               	ldrsb	x4, [x0]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldrsb	x4, [x2]
               	mov	x17, #-0x3              // =-3
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	strb	w3, [x2]
               	mov	x3, #-0x2               // =-2
               	mov	x4, #0x9                // =9
               	mov	x1, x3
               	casalb	w1, w4, [x0]
               	cmp	w1, #0xfe
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x0, [x0]
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrsb	x0, [x2]
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x3               // =-3
               	strb	w1, [x0]
               	ldrb	w2, [x0]
               	sxtb	x2, w2
               	mov	x17, #-0x3              // =-3
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	stlrb	w3, [x0]
               	ldaprb	w2, [x0]
               	sxtb	x2, w2
               	mov	x17, #-0x2              // =-2
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	ldaprb	w2, [x0]
               	sxtb	x2, w2
               	mov	x17, #-0x2              // =-2
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	stlrb	w1, [x0]
               	ldarb	w2, [x0]
               	sxtb	x2, w2
               	mov	x17, #-0x3              // =-3
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	mov	x2, #0x3                // =3
               	ldaddalb	w2, w3, [x0]
               	sxtb	x3, w3
               	mov	x17, #-0x3              // =-3
               	cmp	w3, w17
               	b.ne	<addr>
               	ldrsb	x3, [x0]
               	cbz	w3, <addr>
               	mov	x0, #0x90               // =144
               	ret
               	neg	x16, x2
               	ldaddalb	w16, w2, [x0]
               	sxtb	x2, w2
               	sub	x2, x2, #0x3
               	sxtb	x2, w2
               	mov	x17, #-0x3              // =-3
               	cmp	w2, w17
               	b.ne	<addr>
               	ldrsb	x2, [x0]
               	mov	x17, #-0x3              // =-3
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	mov	x2, #0x6                // =6
               	ldeoralb	w2, w2, [x0]
               	sxtb	x2, w2
               	mov	x17, #-0x3              // =-3
               	cmp	w2, w17
               	b.ne	<addr>
               	ldrsb	x2, [x0]
               	mov	x17, #-0x5              // =-5
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	strb	w1, [x0]
               	casalb	w1, w4, [x0]
               	sxtb	x0, w1
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x0, [x0]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #-0x3               // =-3
               	mov	x2, #0x8                // =8
               	mov	x3, x0
               	casalb	w3, w2, [x1]
               	sxtb	x3, w3
               	cmp	w3, #0x9
               	b.ne	<addr>
               	ldrsb	x3, [x1]
               	cmp	w3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	mov	x3, #0x9                // =9
               	mov	x4, x3
               	casalb	w4, w0, [x1]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldrsb	x0, [x1]
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	mov	x0, x3
               	casalb	w0, w2, [x1]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	ldrsb	x0, [x1]
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	mov	x0, #0x7                // =7
               	swpab	w0, w0, [x1]
               	sxtb	x0, w0
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrsb	x0, [x1]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x90               // =144
               	ret
               	mov	x0, #0x0                // =0
               	stlrb	w0, [x1]
               	ldrsb	x1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0x90               // =144
               	ret
               	ret
               	strb	w1, [x2]
               	b	<addr>
               	strb	w5, [x2]
               	b	<addr>
               	mov	x1, x3
               	b	<addr>

<uchar_ops>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xfa               // =250
               	strb	w1, [x0]
               	mov	x3, #0x3                // =3
               	ldaddab	w3, w4, [x0]
               	and	x4, x4, #0xff
               	cmp	w4, #0xfa
               	b.ne	<addr>
               	ldrb	w4, [x0]
               	cmp	w4, #0xfd
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	neg	x16, x3
               	ldaddab	w16, w3, [x0]
               	and	x3, x3, #0xff
               	cmp	w3, #0xfa
               	b.ne	<addr>
               	ldrb	w3, [x0]
               	cmp	w3, #0xf7
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	mov	x3, #0x6                // =6
               	mvn	x16, x3
               	ldclrab	w16, w4, [x0]
               	and	x4, x4, #0xff
               	cmp	w4, #0xfa
               	b.ne	<addr>
               	ldrb	w4, [x0]
               	cmp	w4, #0x2
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	ldsetab	w3, w4, [x0]
               	and	x4, x4, #0xff
               	cmp	w4, #0xfa
               	b.ne	<addr>
               	ldrb	w4, [x0]
               	cmp	w4, #0xfe
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	ldeorab	w3, w1, [x0]
               	and	x1, x1, #0xff
               	cmp	w1, #0xfa
               	b.ne	<addr>
               	ldrb	w0, [x0]
               	cmp	w0, #0xfc
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xfa               // =250
               	strb	w1, [x0]
               	mov	x5, #0x9                // =9
               	swpab	w5, w4, [x0]
               	and	x4, x4, #0xff
               	cmp	w4, #0xfa
               	b.ne	<addr>
               	ldrb	w4, [x0]
               	cmp	w4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	mov	x4, #0x3                // =3
               	ldaddab	w4, w6, [x0]
               	and	x6, x6, #0xff
               	add	x6, x6, #0x3
               	and	x6, x6, #0xff
               	cmp	w6, #0xfd
               	b.ne	<addr>
               	ldrb	w6, [x0]
               	cmp	w6, #0xfd
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	neg	x16, x4
               	ldaddab	w16, w6, [x0]
               	and	x6, x6, #0xff
               	sub	x6, x6, #0x3
               	and	x6, x6, #0xff
               	cmp	w6, #0xf7
               	b.ne	<addr>
               	ldrb	w6, [x0]
               	cmp	w6, #0xf7
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	mvn	x16, x3
               	ldclrab	w16, w6, [x0]
               	and	x6, x6, #0xff
               	and	x3, x6, x3
               	cmp	w3, #0x2
               	b.ne	<addr>
               	ldrb	w3, [x0]
               	cmp	w3, #0x2
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	mov	x3, #0x6                // =6
               	ldsetab	w3, w0, [x0]
               	and	x0, x0, #0xff
               	orr	x0, x0, x3
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	cmp	w0, #0xfe
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xfa               // =250
               	strb	w1, [x0]
               	ldeorab	w3, w6, [x0]
               	and	x6, x6, #0xff
               	eor	x3, x6, x3
               	cmp	w3, #0xfc
               	b.ne	<addr>
               	ldrb	w3, [x0]
               	cmp	w3, #0xfc
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	ldaddab	w4, w16, [x0]
               	mov	x3, #0x1                // =1
               	neg	x16, x3
               	ldaddab	w16, w17, [x0]
               	ldrb	w6, [x0]
               	cmp	w6, #0xfc
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	mov	x6, #0xe                // =14
               	mvn	x16, x6
               	ldclrab	w16, w17, [x0]
               	ldsetab	w3, w16, [x0]
               	ldeorab	w4, w16, [x0]
               	ldrb	w3, [x0]
               	cmp	w3, #0x8
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	mov	x3, #0x5                // =5
               	swpab	w3, w16, [x0]
               	ldrb	w3, [x0]
               	cmp	w3, #0x5
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	mov	x3, x1
               	casab	w3, w5, [x0]
               	cmp	w3, #0xfa
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	cmp	w1, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xfa               // =250
               	strb	w1, [x0]
               	mov	x3, #0xfb               // =251
               	mov	x4, #0x9                // =9
               	mov	x5, x3
               	casab	w5, w4, [x0]
               	cmp	w5, #0xfb
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldrb	w6, [x0]
               	cmp	w6, #0xfa
               	b.ne	<addr>
               	cmp	w5, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	mov	x5, x3
               	casab	w5, w4, [x0]
               	cmp	w5, #0xfb
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldrb	w6, [x0]
               	cmp	w6, #0xfa
               	b.ne	<addr>
               	cmp	w5, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	strb	w1, [x2]
               	mov	x5, x1
               	casab	w5, w4, [x0]
               	cmp	w5, #0xfa
               	cset	x4, eq
               	cbz	x4, <addr>
               	cbz	x4, <addr>
               	ldrb	w4, [x0]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldrb	w4, [x2]
               	cmp	w4, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	strb	w3, [x2]
               	mov	x3, #0xfb               // =251
               	mov	x4, #0x9                // =9
               	mov	x1, x3
               	casab	w1, w4, [x0]
               	cmp	w1, #0xfb
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	cmp	w0, #0xfa
               	b.ne	<addr>
               	ldrb	w0, [x2]
               	cmp	w0, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xfa               // =250
               	strb	w1, [x0]
               	ldrb	w2, [x0]
               	cmp	w2, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	stlrb	w3, [x0]
               	ldaprb	w2, [x0]
               	cmp	w2, #0xfb
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	ldaprb	w2, [x0]
               	cmp	w2, #0xfb
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	stlrb	w1, [x0]
               	ldarb	w2, [x0]
               	cmp	w2, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	mov	x2, #0x3                // =3
               	ldaddalb	w2, w3, [x0]
               	and	x3, x3, #0xff
               	cmp	w3, #0xfa
               	b.ne	<addr>
               	ldrb	w3, [x0]
               	cmp	w3, #0xfd
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	neg	x16, x2
               	ldaddalb	w16, w2, [x0]
               	and	x2, x2, #0xff
               	sub	x2, x2, #0x3
               	and	x2, x2, #0xff
               	cmp	w2, #0xfa
               	b.ne	<addr>
               	ldrb	w2, [x0]
               	cmp	w2, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	mov	x2, #0x6                // =6
               	ldeoralb	w2, w2, [x0]
               	and	x2, x2, #0xff
               	cmp	w2, #0xfa
               	b.ne	<addr>
               	ldrb	w2, [x0]
               	cmp	w2, #0xfc
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	strb	w1, [x0]
               	casalb	w1, w4, [x0]
               	cmp	w1, #0xfa
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0xfa               // =250
               	mov	x2, #0x8                // =8
               	mov	x3, x0
               	casalb	w3, w2, [x1]
               	cmp	w3, #0x9
               	b.ne	<addr>
               	ldrb	w3, [x1]
               	cmp	w3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	mov	x3, #0x9                // =9
               	mov	x4, x3
               	casalb	w4, w0, [x1]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	mov	x0, x3
               	casalb	w0, w2, [x1]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	mov	x0, #0x7                // =7
               	swpab	w0, w0, [x1]
               	and	x0, x0, #0xff
               	cmp	w0, #0xfa
               	b.ne	<addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x91               // =145
               	ret
               	mov	x0, #0x0                // =0
               	stlrb	w0, [x1]
               	ldrb	w1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0x91               // =145
               	ret
               	ret
               	strb	w1, [x2]
               	b	<addr>
               	strb	w5, [x2]
               	b	<addr>
               	mov	x1, x3
               	b	<addr>

<short_ops>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x12c             // =-300
               	strh	w1, [x0]
               	mov	x3, #0x3                // =3
               	ldaddlh	w3, w4, [x0]
               	sxth	x4, w4
               	mov	x17, #-0x12c            // =-300
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsh	x4, [x0]
               	mov	x17, #-0x129            // =-297
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	neg	x16, x3
               	ldaddlh	w16, w3, [x0]
               	sxth	x3, w3
               	mov	x17, #-0x12c            // =-300
               	cmp	w3, w17
               	b.ne	<addr>
               	ldrsh	x3, [x0]
               	mov	x17, #-0x12f            // =-303
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	mov	x3, #0x6                // =6
               	mvn	x16, x3
               	ldclrlh	w16, w4, [x0]
               	sxth	x4, w4
               	mov	x17, #-0x12c            // =-300
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsh	x4, [x0]
               	cmp	w4, #0x4
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	ldsetlh	w3, w4, [x0]
               	sxth	x4, w4
               	mov	x17, #-0x12c            // =-300
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsh	x4, [x0]
               	mov	x17, #-0x12a            // =-298
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	ldeorlh	w3, w1, [x0]
               	sxth	x1, w1
               	mov	x17, #-0x12c            // =-300
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsh	x0, [x0]
               	mov	x17, #-0x12e            // =-302
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x12c             // =-300
               	strh	w1, [x0]
               	mov	x5, #0x9                // =9
               	swplh	w5, w4, [x0]
               	sxth	x4, w4
               	mov	x17, #-0x12c            // =-300
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrsh	x4, [x0]
               	cmp	w4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	mov	x4, #0x3                // =3
               	ldaddlh	w4, w6, [x0]
               	sxth	x6, w6
               	add	x6, x6, #0x3
               	sxth	x6, w6
               	mov	x17, #-0x129            // =-297
               	cmp	w6, w17
               	b.ne	<addr>
               	ldrsh	x6, [x0]
               	mov	x17, #-0x129            // =-297
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	neg	x16, x4
               	ldaddlh	w16, w6, [x0]
               	sxth	x6, w6
               	sub	x6, x6, #0x3
               	sxth	x6, w6
               	mov	x17, #-0x12f            // =-303
               	cmp	w6, w17
               	b.ne	<addr>
               	ldrsh	x6, [x0]
               	mov	x17, #-0x12f            // =-303
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	mvn	x16, x3
               	ldclrlh	w16, w6, [x0]
               	sxth	x6, w6
               	and	x3, x6, x3
               	cmp	w3, #0x4
               	b.ne	<addr>
               	ldrsh	x3, [x0]
               	cmp	w3, #0x4
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	mov	x3, #0x6                // =6
               	ldsetlh	w3, w0, [x0]
               	sxth	x0, w0
               	orr	x0, x0, x3
               	sxth	x0, w0
               	mov	x17, #-0x12a            // =-298
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsh	x0, [x0]
               	mov	x17, #-0x12a            // =-298
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x12c             // =-300
               	strh	w1, [x0]
               	ldeorlh	w3, w6, [x0]
               	sxth	x6, w6
               	eor	x3, x6, x3
               	sxth	x3, w3
               	mov	x17, #-0x12e            // =-302
               	cmp	w3, w17
               	b.ne	<addr>
               	ldrsh	x3, [x0]
               	mov	x17, #-0x12e            // =-302
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	staddlh	w4, [x0]
               	mov	x3, #0x1                // =1
               	neg	x16, x3
               	staddlh	w16, [x0]
               	ldrsh	x6, [x0]
               	mov	x17, #-0x12a            // =-298
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	mov	x6, #0xe                // =14
               	mvn	x16, x6
               	stclrlh	w16, [x0]
               	stsetlh	w3, [x0]
               	steorlh	w4, [x0]
               	ldrsh	x3, [x0]
               	cmp	w3, #0x6
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	mov	x3, #0x5                // =5
               	swplh	w3, wzr, [x0]
               	ldrsh	x3, [x0]
               	cmp	w3, #0x5
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	mov	x3, x1
               	caslh	w3, w5, [x0]
               	mov	x17, #0xfed4            // =65236
               	cmp	w3, w17
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsh	x0, [x0]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	sxth	x0, w1
               	mov	x17, #-0x12c            // =-300
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x12c             // =-300
               	strh	w1, [x0]
               	mov	x3, #-0x12b             // =-299
               	mov	x4, #0x9                // =9
               	mov	x5, x3
               	caslh	w5, w4, [x0]
               	mov	x17, #0xfed5            // =65237
               	cmp	w5, w17
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldrsh	x6, [x0]
               	mov	x17, #-0x12c            // =-300
               	cmp	w6, w17
               	b.ne	<addr>
               	sxth	x5, w5
               	mov	x17, #-0x12c            // =-300
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	mov	x5, x3
               	caslh	w5, w4, [x0]
               	mov	x17, #0xfed5            // =65237
               	cmp	w5, w17
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x3
               	cbnz	w6, <addr>
               	ldrsh	x6, [x0]
               	mov	x17, #-0x12c            // =-300
               	cmp	w6, w17
               	b.ne	<addr>
               	sxth	x5, w5
               	mov	x17, #-0x12c            // =-300
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	strh	w1, [x2]
               	mov	x5, x1
               	caslh	w5, w4, [x0]
               	mov	x17, #0xfed4            // =65236
               	cmp	w5, w17
               	cset	x4, eq
               	cbz	x4, <addr>
               	cbz	x4, <addr>
               	ldrsh	x4, [x0]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldrsh	x4, [x2]
               	mov	x17, #-0x12c            // =-300
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	strh	w3, [x2]
               	mov	x3, #-0x12b             // =-299
               	mov	x4, #0x9                // =9
               	mov	x1, x3
               	caslh	w1, w4, [x0]
               	mov	x17, #0xfed5            // =65237
               	cmp	w1, w17
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsh	x0, [x0]
               	mov	x17, #-0x12c            // =-300
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrsh	x0, [x2]
               	mov	x17, #-0x12c            // =-300
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x12c             // =-300
               	strh	w1, [x0]
               	ldrh	w2, [x0]
               	sxth	x2, w2
               	mov	x17, #-0x12c            // =-300
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	stlrh	w3, [x0]
               	ldaprh	w2, [x0]
               	sxth	x2, w2
               	mov	x17, #-0x12b            // =-299
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	ldaprh	w2, [x0]
               	sxth	x2, w2
               	mov	x17, #-0x12b            // =-299
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	stlrh	w1, [x0]
               	ldarh	w2, [x0]
               	sxth	x2, w2
               	mov	x17, #-0x12c            // =-300
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	mov	x2, #0x3                // =3
               	ldaddalh	w2, w3, [x0]
               	sxth	x3, w3
               	mov	x17, #-0x12c            // =-300
               	cmp	w3, w17
               	b.ne	<addr>
               	ldrsh	x3, [x0]
               	mov	x17, #-0x129            // =-297
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	neg	x16, x2
               	ldaddalh	w16, w2, [x0]
               	sxth	x2, w2
               	sub	x2, x2, #0x3
               	sxth	x2, w2
               	mov	x17, #-0x12c            // =-300
               	cmp	w2, w17
               	b.ne	<addr>
               	ldrsh	x2, [x0]
               	mov	x17, #-0x12c            // =-300
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	mov	x2, #0x6                // =6
               	ldeoralh	w2, w2, [x0]
               	sxth	x2, w2
               	mov	x17, #-0x12c            // =-300
               	cmp	w2, w17
               	b.ne	<addr>
               	ldrsh	x2, [x0]
               	mov	x17, #-0x12e            // =-302
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	strh	w1, [x0]
               	casalh	w1, w4, [x0]
               	sxth	x0, w1
               	mov	x17, #-0x12c            // =-300
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsh	x0, [x0]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #-0x12c             // =-300
               	mov	x2, #0x8                // =8
               	mov	x3, x0
               	casalh	w3, w2, [x1]
               	sxth	x3, w3
               	cmp	w3, #0x9
               	b.ne	<addr>
               	ldrsh	x3, [x1]
               	cmp	w3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	mov	x3, #0x9                // =9
               	mov	x4, x3
               	casalh	w4, w0, [x1]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldrsh	x0, [x1]
               	mov	x17, #-0x12c            // =-300
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	mov	x0, x3
               	casalh	w0, w2, [x1]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	ldrsh	x0, [x1]
               	mov	x17, #-0x12c            // =-300
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	mov	x0, #0x7                // =7
               	swpah	w0, w0, [x1]
               	sxth	x0, w0
               	mov	x17, #-0x12c            // =-300
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrsh	x0, [x1]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x92               // =146
               	ret
               	mov	x0, #0x0                // =0
               	stlrh	w0, [x1]
               	ldrsh	x1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0x92               // =146
               	ret
               	ret
               	strh	w1, [x2]
               	b	<addr>
               	strh	w5, [x2]
               	b	<addr>
               	mov	x1, x3
               	b	<addr>

<ushort_ops>:
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xfde8             // =65000
               	strh	w1, [x0]
               	mov	x2, #0x3                // =3
               	ldaddalh	w2, w4, [x0]
               	and	x4, x4, #0xffff
               	mov	x17, #0xfde8            // =65000
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrh	w4, [x0]
               	mov	x17, #0xfdeb            // =65003
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	neg	x16, x2
               	ldaddalh	w16, w2, [x0]
               	and	x2, x2, #0xffff
               	mov	x17, #0xfde8            // =65000
               	cmp	w2, w17
               	b.ne	<addr>
               	ldrh	w2, [x0]
               	mov	x17, #0xfde5            // =64997
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	mov	x2, #0x6                // =6
               	mvn	x16, x2
               	ldclralh	w16, w4, [x0]
               	and	x4, x4, #0xffff
               	mov	x17, #0xfde8            // =65000
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrh	w4, [x0]
               	cbz	w4, <addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	ldsetalh	w2, w4, [x0]
               	and	x4, x4, #0xffff
               	mov	x17, #0xfde8            // =65000
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrh	w4, [x0]
               	mov	x17, #0xfdee            // =65006
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	ldeoralh	w2, w1, [x0]
               	and	x1, x1, #0xffff
               	mov	x17, #0xfde8            // =65000
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrh	w0, [x0]
               	mov	x17, #0xfdee            // =65006
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xfde8             // =65000
               	strh	w1, [x0]
               	mov	x5, #0x9                // =9
               	swpalh	w5, w4, [x0]
               	and	x4, x4, #0xffff
               	mov	x17, #0xfde8            // =65000
               	cmp	w4, w17
               	b.ne	<addr>
               	ldrh	w4, [x0]
               	cmp	w4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	mov	x4, #0x3                // =3
               	ldaddalh	w4, w6, [x0]
               	and	x6, x6, #0xffff
               	add	x6, x6, #0x3
               	and	x6, x6, #0xffff
               	mov	x17, #0xfdeb            // =65003
               	cmp	w6, w17
               	b.ne	<addr>
               	ldrh	w6, [x0]
               	mov	x17, #0xfdeb            // =65003
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	neg	x16, x4
               	ldaddalh	w16, w6, [x0]
               	and	x6, x6, #0xffff
               	sub	x6, x6, #0x3
               	and	x6, x6, #0xffff
               	mov	x17, #0xfde5            // =64997
               	cmp	w6, w17
               	b.ne	<addr>
               	ldrh	w6, [x0]
               	mov	x17, #0xfde5            // =64997
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	mvn	x16, x2
               	ldclralh	w16, w6, [x0]
               	and	x6, x6, #0xffff
               	and	x2, x6, x2
               	cbnz	w2, <addr>
               	ldrh	w2, [x0]
               	cbz	w2, <addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	mov	x2, #0x6                // =6
               	ldsetalh	w2, w0, [x0]
               	and	x0, x0, #0xffff
               	orr	x0, x0, x2
               	mov	x17, #0xfdee            // =65006
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	mov	x17, #0xfdee            // =65006
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xfde8             // =65000
               	strh	w1, [x0]
               	ldeoralh	w2, w6, [x0]
               	and	x6, x6, #0xffff
               	eor	x2, x6, x2
               	mov	x17, #0xfdee            // =65006
               	cmp	w2, w17
               	b.ne	<addr>
               	ldrh	w2, [x0]
               	mov	x17, #0xfdee            // =65006
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	ldaddalh	w4, w16, [x0]
               	mov	x2, #0x1                // =1
               	neg	x16, x2
               	ldaddalh	w16, w17, [x0]
               	ldrh	w6, [x0]
               	mov	x17, #0xfdea            // =65002
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	mov	x6, #0xe                // =14
               	mvn	x16, x6
               	ldclralh	w16, w17, [x0]
               	ldsetalh	w2, w16, [x0]
               	ldeoralh	w4, w16, [x0]
               	ldrh	w2, [x0]
               	cmp	w2, #0xa
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	mov	x2, #0x5                // =5
               	swpalh	w2, w16, [x0]
               	ldrh	w2, [x0]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	mov	x2, x1
               	casalh	w2, w5, [x0]
               	cmp	w2, w1
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	mov	x17, #0xfde8            // =65000
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xfde8             // =65000
               	strh	w1, [x0]
               	mov	x2, #0xfde9             // =65001
               	mov	x4, #0x9                // =9
               	mov	x5, x2
               	casalh	w5, w4, [x0]
               	cmp	w5, w2
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x2
               	cbnz	w6, <addr>
               	ldrh	w6, [x0]
               	mov	x17, #0xfde8            // =65000
               	cmp	w6, w17
               	b.ne	<addr>
               	mov	x17, #0xfde8            // =65000
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	mov	x5, x2
               	casalh	w5, w4, [x0]
               	cmp	w5, w2
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x2
               	cbnz	w6, <addr>
               	ldrh	w6, [x0]
               	mov	x17, #0xfde8            // =65000
               	cmp	w6, w17
               	b.ne	<addr>
               	mov	x17, #0xfde8            // =65000
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	strh	w1, [x3]
               	mov	x5, x1
               	casalh	w5, w4, [x0]
               	cmp	w5, w1
               	cset	x4, eq
               	cbz	x4, <addr>
               	cbz	x4, <addr>
               	ldrh	w4, [x0]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldrh	w4, [x3]
               	mov	x17, #0xfde8            // =65000
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	strh	w2, [x3]
               	mov	x2, #0xfde9             // =65001
               	mov	x4, #0x9                // =9
               	mov	x1, x2
               	casalh	w1, w4, [x0]
               	cmp	w1, w2
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	mov	x17, #0xfde8            // =65000
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrh	w0, [x3]
               	mov	x17, #0xfde8            // =65000
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xfde8             // =65000
               	strh	w1, [x0]
               	ldrh	w3, [x0]
               	mov	x17, #0xfde8            // =65000
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	stlrh	w2, [x0]
               	ldaprh	w2, [x0]
               	mov	x17, #0xfde9            // =65001
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	ldaprh	w2, [x0]
               	mov	x17, #0xfde9            // =65001
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	stlrh	w1, [x0]
               	ldarh	w2, [x0]
               	mov	x17, #0xfde8            // =65000
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	mov	x2, #0x3                // =3
               	ldaddalh	w2, w3, [x0]
               	and	x3, x3, #0xffff
               	mov	x17, #0xfde8            // =65000
               	cmp	w3, w17
               	b.ne	<addr>
               	ldrh	w3, [x0]
               	mov	x17, #0xfdeb            // =65003
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	neg	x16, x2
               	ldaddalh	w16, w2, [x0]
               	and	x2, x2, #0xffff
               	sub	x2, x2, #0x3
               	and	x2, x2, #0xffff
               	mov	x17, #0xfde8            // =65000
               	cmp	w2, w17
               	b.ne	<addr>
               	ldrh	w2, [x0]
               	mov	x17, #0xfde8            // =65000
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	mov	x2, #0x6                // =6
               	ldeoralh	w2, w2, [x0]
               	and	x2, x2, #0xffff
               	mov	x17, #0xfde8            // =65000
               	cmp	w2, w17
               	b.ne	<addr>
               	ldrh	w2, [x0]
               	mov	x17, #0xfdee            // =65006
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	strh	w1, [x0]
               	casalh	w1, w4, [x0]
               	mov	x17, #0xfde8            // =65000
               	cmp	w1, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0xfde8             // =65000
               	mov	x2, #0x8                // =8
               	mov	x3, x0
               	casalh	w3, w2, [x1]
               	cmp	w3, #0x9
               	b.ne	<addr>
               	ldrh	w3, [x1]
               	cmp	w3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	mov	x3, #0x9                // =9
               	mov	x4, x3
               	casalh	w4, w0, [x1]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldrh	w0, [x1]
               	mov	x17, #0xfde8            // =65000
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	mov	x0, x3
               	casalh	w0, w2, [x1]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	ldrh	w0, [x1]
               	mov	x17, #0xfde8            // =65000
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	mov	x0, #0x7                // =7
               	swpah	w0, w0, [x1]
               	and	x0, x0, #0xffff
               	mov	x17, #0xfde8            // =65000
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrh	w0, [x1]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ret
               	mov	x0, #0x0                // =0
               	stlrh	w0, [x1]
               	ldrh	w1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0x93               // =147
               	ret
               	ret
               	strh	w1, [x3]
               	b	<addr>
               	strh	w5, [x3]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>

<uint_ops>:
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2800             // =10240
               	movk	x1, #0xee6b, lsl #16
               	str	w1, [x0]
               	mov	x2, #0x3                // =3
               	ldadd	w2, w4, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w4, w17
               	b.ne	<addr>
               	ldr	w4, [x0]
               	mov	x17, #0x2803            // =10243
               	movk	x17, #0xee6b, lsl #16
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	neg	x16, x2
               	ldadd	w16, w2, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	ldr	w2, [x0]
               	mov	x17, #0x27fd            // =10237
               	movk	x17, #0xee6b, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	mov	x2, #0x6                // =6
               	mvn	x16, x2
               	ldclr	w16, w4, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w4, w17
               	b.ne	<addr>
               	ldr	w4, [x0]
               	cbz	w4, <addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	ldset	w2, w4, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w4, w17
               	b.ne	<addr>
               	ldr	w4, [x0]
               	mov	x17, #0x2806            // =10246
               	movk	x17, #0xee6b, lsl #16
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	ldeor	w2, w1, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	w0, [x0]
               	mov	x17, #0x2806            // =10246
               	movk	x17, #0xee6b, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2800             // =10240
               	movk	x1, #0xee6b, lsl #16
               	str	w1, [x0]
               	mov	x5, #0x9                // =9
               	swp	w5, w4, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w4, w17
               	b.ne	<addr>
               	ldr	w4, [x0]
               	cmp	w4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	mov	x4, #0x3                // =3
               	ldadd	w4, w6, [x0]
               	add	x6, x6, #0x3
               	mov	x17, #0x2803            // =10243
               	movk	x17, #0xee6b, lsl #16
               	cmp	w6, w17
               	b.ne	<addr>
               	ldr	w6, [x0]
               	mov	x17, #0x2803            // =10243
               	movk	x17, #0xee6b, lsl #16
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	neg	x16, x4
               	ldadd	w16, w6, [x0]
               	sub	x6, x6, #0x3
               	mov	x17, #0x27fd            // =10237
               	movk	x17, #0xee6b, lsl #16
               	cmp	w6, w17
               	b.ne	<addr>
               	ldr	w6, [x0]
               	mov	x17, #0x27fd            // =10237
               	movk	x17, #0xee6b, lsl #16
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	mvn	x16, x2
               	ldclr	w16, w6, [x0]
               	and	x2, x6, x2
               	cbnz	w2, <addr>
               	ldr	w2, [x0]
               	cbz	w2, <addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	mov	x2, #0x6                // =6
               	ldset	w2, w0, [x0]
               	orr	x0, x0, x2
               	mov	x17, #0x2806            // =10246
               	movk	x17, #0xee6b, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x2806            // =10246
               	movk	x17, #0xee6b, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2800             // =10240
               	movk	x1, #0xee6b, lsl #16
               	str	w1, [x0]
               	ldeor	w2, w6, [x0]
               	eor	x2, x6, x2
               	mov	x17, #0x2806            // =10246
               	movk	x17, #0xee6b, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	ldr	w2, [x0]
               	mov	x17, #0x2806            // =10246
               	movk	x17, #0xee6b, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	stadd	w4, [x0]
               	mov	x2, #0x1                // =1
               	neg	x16, x2
               	stadd	w16, [x0]
               	ldr	w6, [x0]
               	mov	x17, #0x2802            // =10242
               	movk	x17, #0xee6b, lsl #16
               	cmp	w6, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	mov	x6, #0xe                // =14
               	mvn	x16, x6
               	stclr	w16, [x0]
               	stset	w2, [x0]
               	steor	w4, [x0]
               	ldr	w2, [x0]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	mov	x2, #0x5                // =5
               	swp	w2, wzr, [x0]
               	ldr	w2, [x0]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	mov	x2, x1
               	cas	w2, w5, [x0]
               	cmp	w2, w1
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2800             // =10240
               	movk	x1, #0xee6b, lsl #16
               	str	w1, [x0]
               	mov	x2, #0x2801             // =10241
               	movk	x2, #0xee6b, lsl #16
               	mov	x4, #0x9                // =9
               	mov	x5, x2
               	cas	w5, w4, [x0]
               	cmp	w5, w2
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x2
               	cbnz	w6, <addr>
               	ldr	w6, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w6, w17
               	b.ne	<addr>
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	mov	x5, x2
               	cas	w5, w4, [x0]
               	cmp	w5, w2
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x2
               	cbnz	w6, <addr>
               	ldr	w6, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w6, w17
               	b.ne	<addr>
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	str	w1, [x3]
               	mov	x5, x1
               	cas	w5, w4, [x0]
               	cmp	w5, w1
               	cset	x4, eq
               	cbz	x4, <addr>
               	cbz	x4, <addr>
               	ldr	w4, [x0]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldr	w4, [x3]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w4, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	str	w2, [x3]
               	mov	x2, #0x2801             // =10241
               	movk	x2, #0xee6b, lsl #16
               	mov	x4, #0x9                // =9
               	mov	x1, x2
               	cas	w1, w4, [x0]
               	cmp	w1, w2
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [x3]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2800             // =10240
               	movk	x1, #0xee6b, lsl #16
               	str	w1, [x0]
               	ldr	w3, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	stlr	w2, [x0]
               	ldapr	w2, [x0]
               	mov	x17, #0x2801            // =10241
               	movk	x17, #0xee6b, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	ldapr	w2, [x0]
               	mov	x17, #0x2801            // =10241
               	movk	x17, #0xee6b, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	stlr	w1, [x0]
               	ldar	w2, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	mov	x2, #0x3                // =3
               	ldaddal	w2, w3, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w3, w17
               	b.ne	<addr>
               	ldr	w3, [x0]
               	mov	x17, #0x2803            // =10243
               	movk	x17, #0xee6b, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	neg	x16, x2
               	ldaddal	w16, w2, [x0]
               	sub	x2, x2, #0x3
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	ldr	w2, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	mov	x2, #0x6                // =6
               	ldeoral	w2, w2, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	ldr	w2, [x0]
               	mov	x17, #0x2806            // =10246
               	movk	x17, #0xee6b, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	str	w1, [x0]
               	casal	w1, w4, [x0]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x2800             // =10240
               	movk	x0, #0xee6b, lsl #16
               	mov	x2, #0x8                // =8
               	mov	x3, x0
               	casal	w3, w2, [x1]
               	cmp	w3, #0x9
               	b.ne	<addr>
               	ldr	w3, [x1]
               	cmp	w3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	mov	x3, #0x9                // =9
               	mov	x4, x3
               	casal	w4, w0, [x1]
               	cmp	w4, #0x9
               	b.ne	<addr>
               	ldr	w0, [x1]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	mov	x0, x3
               	casal	w0, w2, [x1]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	ldr	w0, [x1]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	mov	x0, #0x7                // =7
               	swpa	w0, w0, [x1]
               	mov	x17, #0x2800            // =10240
               	movk	x17, #0xee6b, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [x1]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x94               // =148
               	ret
               	mov	x0, #0x0                // =0
               	stlr	w0, [x1]
               	ldr	w1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0x94               // =148
               	ret
               	ret
               	str	w1, [x3]
               	b	<addr>
               	str	w5, [x3]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>

<ullong_ops>:
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x7000000000000000 // =-8070450532247928832
               	str	x1, [x0]
               	mov	x2, #0x3                // =3
               	ldadda	x2, x4, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x0]
               	mov	x17, #0x3               // =3
               	movk	x17, #0x9000, lsl #48
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	neg	x16, x2
               	ldadda	x16, x2, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x0]
               	mov	x17, #-0x3              // =-3
               	movk	x17, #0x8fff, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	mov	x2, #0x6                // =6
               	mvn	x16, x2
               	ldclra	x16, x4, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x0]
               	cbz	x4, <addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	ldseta	x2, x4, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x0]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x9000, lsl #48
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	ldeora	x2, x1, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	x0, [x0]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x9000, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x7000000000000000 // =-8070450532247928832
               	str	x1, [x0]
               	mov	x5, #0x9                // =9
               	swpa	x5, x4, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x4, x17
               	b.ne	<addr>
               	ldr	x4, [x0]
               	cmp	x4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	mov	x4, #0x3                // =3
               	ldadda	x4, x6, [x0]
               	add	x6, x6, #0x3
               	mov	x17, #0x3               // =3
               	movk	x17, #0x9000, lsl #48
               	cmp	x6, x17
               	b.ne	<addr>
               	ldr	x6, [x0]
               	mov	x17, #0x3               // =3
               	movk	x17, #0x9000, lsl #48
               	cmp	x6, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	neg	x16, x4
               	ldadda	x16, x6, [x0]
               	sub	x6, x6, #0x3
               	mov	x17, #-0x3              // =-3
               	movk	x17, #0x8fff, lsl #48
               	cmp	x6, x17
               	b.ne	<addr>
               	ldr	x6, [x0]
               	mov	x17, #-0x3              // =-3
               	movk	x17, #0x8fff, lsl #48
               	cmp	x6, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	mvn	x16, x2
               	ldclra	x16, x6, [x0]
               	and	x2, x6, x2
               	cbnz	w2, <addr>
               	ldr	x2, [x0]
               	cbz	x2, <addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	mov	x2, #0x6                // =6
               	ldseta	x2, x0, [x0]
               	orr	x0, x0, x2
               	mov	x17, #0x6               // =6
               	movk	x17, #0x9000, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x9000, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x7000000000000000 // =-8070450532247928832
               	str	x1, [x0]
               	ldeora	x2, x6, [x0]
               	eor	x2, x6, x2
               	mov	x17, #0x6               // =6
               	movk	x17, #0x9000, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x0]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x9000, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	ldadda	x4, x16, [x0]
               	mov	x2, #0x1                // =1
               	neg	x16, x2
               	ldadda	x16, x17, [x0]
               	ldr	x6, [x0]
               	mov	x17, #0x2               // =2
               	movk	x17, #0x9000, lsl #48
               	cmp	x6, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	mov	x6, #0xe                // =14
               	mvn	x16, x6
               	ldclra	x16, x17, [x0]
               	ldseta	x2, x16, [x0]
               	ldeora	x4, x16, [x0]
               	ldr	x2, [x0]
               	cmp	x2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	mov	x2, #0x5                // =5
               	swpa	x2, x16, [x0]
               	ldr	x2, [x0]
               	cmp	x2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	mov	x2, x1
               	casa	x2, x5, [x0]
               	cmp	x2, x1
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x7000000000000000 // =-8070450532247928832
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	movk	x2, #0x9000, lsl #48
               	mov	x4, #0x9                // =9
               	mov	x5, x2
               	casa	x5, x4, [x0]
               	cmp	x5, x2
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x2
               	cbnz	w6, <addr>
               	ldr	x6, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	mov	x5, x2
               	casa	x5, x4, [x0]
               	cmp	x5, x2
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x5, x2
               	cbnz	w6, <addr>
               	ldr	x6, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	str	x1, [x3]
               	mov	x5, x1
               	casa	x5, x4, [x0]
               	cmp	x5, x1
               	cset	x4, eq
               	cbz	x4, <addr>
               	cbz	x4, <addr>
               	ldr	x4, [x0]
               	cmp	x4, #0x9
               	b.ne	<addr>
               	ldr	x4, [x3]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	str	x2, [x3]
               	mov	x2, #0x1                // =1
               	movk	x2, #0x9000, lsl #48
               	mov	x4, #0x9                // =9
               	mov	x1, x2
               	casa	x1, x4, [x0]
               	cmp	x1, x2
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x0, x17
               	b.ne	<addr>
               	ldr	x0, [x3]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x7000000000000000 // =-8070450532247928832
               	str	x1, [x0]
               	ldr	x3, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	stlr	x2, [x0]
               	ldapr	x2, [x0]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x9000, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	ldapr	x2, [x0]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x9000, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	stlr	x1, [x0]
               	ldar	x2, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	mov	x2, #0x3                // =3
               	ldaddal	x2, x3, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	x3, [x0]
               	mov	x17, #0x3               // =3
               	movk	x17, #0x9000, lsl #48
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	neg	x16, x2
               	ldaddal	x16, x2, [x0]
               	sub	x2, x2, #0x3
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	mov	x2, #0x6                // =6
               	ldeoral	x2, x2, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x2, x17
               	b.ne	<addr>
               	ldr	x2, [x0]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x9000, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	str	x1, [x0]
               	casal	x1, x4, [x0]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x1, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #-0x7000000000000000 // =-8070450532247928832
               	mov	x2, #0x8                // =8
               	mov	x3, x0
               	casal	x3, x2, [x1]
               	cmp	x3, #0x9
               	b.ne	<addr>
               	ldr	x3, [x1]
               	cmp	x3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	mov	x3, #0x9                // =9
               	mov	x4, x3
               	casal	x4, x0, [x1]
               	cmp	x4, #0x9
               	b.ne	<addr>
               	ldr	x0, [x1]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	mov	x0, x3
               	casal	x0, x2, [x1]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	ldr	x0, [x1]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	mov	x0, #0x7                // =7
               	swpa	x0, x0, [x1]
               	mov	x17, #-0x7000000000000000 // =-8070450532247928832
               	cmp	x0, x17
               	b.ne	<addr>
               	ldr	x0, [x1]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x95               // =149
               	ret
               	mov	x0, #0x0                // =0
               	stlr	x0, [x1]
               	ldr	x1, [x1]
               	cbz	x1, <addr>
               	mov	x0, #0x95               // =149
               	ret
               	ret
               	str	x1, [x3]
               	b	<addr>
               	str	x5, [x3]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>

<other_ops>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x1]
               	add	x3, x0, #0x4
               	mov	x2, x0
               	casal	x2, x3, [x1]
               	cmp	x2, x0
               	cset	x4, eq
               	cbz	x4, <addr>
               	mov	x2, x0
               	cbz	x4, <addr>
               	ldr	x4, [x1]
               	cmp	x4, x3
               	b.eq	<addr>
               	mov	x0, #0xa6               // =166
               	ret
               	mov	x4, x2
               	casal	x4, x0, [x1]
               	cmp	x4, x2
               	cset	x5, eq
               	cbz	x5, <addr>
               	cbnz	w5, <addr>
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0xa7               // =167
               	ret
               	swpl	x0, x2, [x1]
               	cmp	x2, x3
               	b.ne	<addr>
               	ldr	x1, [x1]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0xa8               // =168
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa                // =10
               	str	w1, [x0]
               	mov	x3, #0x5                // =5
               	ldaddal	w3, w1, [x0]
               	cmp	w1, #0xa
               	b.ne	<addr>
               	ldar	w1, [x0]
               	cmp	w1, #0xf
               	b.eq	<addr>
               	mov	x0, #0xab               // =171
               	ret
               	mov	x1, #0x3                // =3
               	neg	x16, x1
               	ldaddl	w16, w1, [x0]
               	cmp	w1, #0xf
               	b.eq	<addr>
               	mov	x0, #0xac               // =172
               	ret
               	mov	x1, #0x40               // =64
               	ldseta	w1, w1, [x0]
               	cmp	w1, #0xc
               	b.eq	<addr>
               	mov	x0, #0xad               // =173
               	ret
               	mov	x1, #0x48               // =72
               	mvn	x16, x1
               	ldclral	w16, w1, [x0]
               	cmp	w1, #0x4c
               	b.eq	<addr>
               	mov	x0, #0xae               // =174
               	ret
               	mov	x2, #0x1                // =1
               	ldeor	w2, w1, [x0]
               	cmp	w1, #0x48
               	b.eq	<addr>
               	mov	x0, #0xaf               // =175
               	ret
               	mov	x1, #-0x1               // =-1
               	swpa	w1, w4, [x0]
               	cmp	w4, #0x49
               	b.eq	<addr>
               	mov	x0, #0xb0               // =176
               	ret
               	mov	x5, #0x4                // =4
               	mov	x4, x1
               	casal	w4, w5, [x0]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w4, w17
               	cset	x5, eq
               	cbz	x5, <addr>
               	cbz	x5, <addr>
               	ldar	w4, [x0]
               	cmp	w4, #0x4
               	b.eq	<addr>
               	mov	x0, #0xb2               // =178
               	ret
               	mov	x4, x1
               	casa	w4, w3, [x0]
               	cmp	w4, w1
               	cset	x0, eq
               	cbz	x0, <addr>
               	cbnz	w0, <addr>
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0xb3               // =179
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0xf200            // =-61952
               	movk	x1, #0xd5fa, lsl #16
               	movk	x1, #0xfffe, lsl #32
               	stlr	x1, [x0]
               	mov	x3, #0x7                // =7
               	mov	x4, x1
               	casal	x4, x3, [x0]
               	cmp	x4, x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldapr	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xb8               // =184
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	swpab	w2, w0, [x1]
               	sxtb	x0, w0
               	cbz	w0, <addr>
               	mov	x0, #0xbc               // =188
               	ret
               	swpalb	w2, w0, [x1]
               	sxtb	x0, w0
               	cbnz	w0, <addr>
               	mov	x0, #0xbd               // =189
               	ret
               	mov	x0, #0x0                // =0
               	stlrb	w0, [x1]
               	swpalb	w2, w3, [x1]
               	sxtb	x3, w3
               	cbz	w3, <addr>
               	mov	x0, #0xbf               // =191
               	ret
               	stlrb	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	swpb	w2, w3, [x1]
               	and	x3, x3, #0xff
               	cbnz	w3, <addr>
               	swpalb	w2, w2, [x1]
               	and	x2, x2, #0xff
               	cbnz	w2, <addr>
               	mov	x0, #0xc1               // =193
               	ret
               	stlrb	w0, [x1]
               	ldrb	w1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0xc3               // =195
               	ret
               	ret
               	mov	x1, x4
               	b	<addr>
               	mov	x1, x4
               	b	<addr>
               	mov	x2, x4
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
