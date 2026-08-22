
select_operand_guard_folds.aarch64:	file format elf64-littleaarch64

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

<add_page>:
               	mov	x2, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	orr	x0, x0, x2
               	str	x0, [x1]
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	str	x0, [x2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldr	x1, [x1]
               	mov	x17, #0x400000          // =4194304
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x1, #0x4                // =4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldr	x1, [x1]
               	mov	x17, #0x400000          // =4194304
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x1, #0x4                // =4
               	mov	x17, #0x173             // =371
               	movk	x17, #0x10, lsl #16
               	orr	x1, x1, x17
               	mov	x17, #0x173             // =371
               	movk	x17, #0x10, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x400000           // =4194304
               	str	x1, [x2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldr	x1, [x1]
               	mov	x17, #0x400000          // =4194304
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x1, #0x4                // =4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldr	x1, [x1]
               	mov	x17, #0x400000          // =4194304
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	mov	x17, #0x173             // =371
               	movk	x17, #0x10, lsl #16
               	orr	x0, x0, x17
               	mov	x17, #0x177             // =375
               	movk	x17, #0x10, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	mov	x17, #0x1000            // =4096
               	orr	x0, x0, x17
               	str	x0, [x2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x1                // =1
               	str	w0, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x3, [x3]
               	cbz	x3, <addr>
               	mov	x1, x0
               	mov	x17, #0x1000            // =4096
               	orr	x1, x1, x17
               	str	x1, [x2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x3               // =3
               	and	x1, x1, x17
               	sxtw	x1, w1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x1001            // =4097
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cbz	x1, <addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
