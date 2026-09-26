
large_struct_copy.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x420
               	sub	x1, x29, #0x420
               	mov	x0, #0x64               // =100
               	str	w0, [x1]
               	mov	x0, #0xc8               // =200
               	str	w0, [x1, #0x4]
               	mov	x0, #0x12c              // =300
               	str	w0, [x1, #0x8]
               	mov	x0, #0x190              // =400
               	str	w0, [x1, #0xc]
               	mov	x0, #-0x1               // =-1
               	str	w0, [x1, #0xb0]
               	mov	x0, #-0x2               // =-2
               	str	w0, [x1, #0x154]
               	mov	x0, #-0x3               // =-3
               	str	w0, [x1, #0x1f8]
               	mov	x0, #0x1f4              // =500
               	str	w0, [x1, #0x1fc]
               	mov	x0, #0x258              // =600
               	str	w0, [x1, #0x200]
               	mov	x0, #0x2bc              // =700
               	str	w0, [x1, #0x204]
               	mov	x0, #0x320              // =800
               	str	w0, [x1, #0x208]
               	mov	x0, #0x0                // =0
               	add	x2, x1, #0x10
               	add	x3, x0, #0x3e8
               	str	w3, [x2, x0, lsl #2]
               	add	x2, x1, #0xb4
               	add	x3, x0, #0x7d0
               	str	w3, [x2, x0, lsl #2]
               	add	x2, x1, #0x158
               	add	x3, x0, #0xbb8
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lt	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x7e               // =126
               	mov	x2, #0x20c              // =524
               	bl	<addr>
               	sub	x1, x29, #0x210
               	sub	x0, x29, #0x420
               	mov	x16, x1
               	add	x17, x0, #0x200
               	ldp	x9, x10, [x0], #0x10
               	stp	x9, x10, [x16], #0x10
               	cmp	x0, x17
               	b.ne	<addr>
               	ldr	x9, [x0]
               	str	x9, [x16]
               	ldr	w9, [x0, #0x8]
               	str	w9, [x16, #0x8]
               	ldrsw	x0, [x1]
               	cmp	w0, #0x64
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x4]
               	cmp	w0, #0xc8
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x8]
               	cmp	w0, #0x12c
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x190
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1, #0x1fc]
               	cmp	w0, #0x1f4
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x200]
               	cmp	w0, #0x258
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x204]
               	cmp	w0, #0x2bc
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x208]
               	cmp	w0, #0x320
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1, #0xb0]
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1, #0x154]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1, #0x1f8]
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	x2, x1, #0x10
               	ldrsw	x2, [x2, x0, lsl #2]
               	add	x3, x0, #0x3e8
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x2, x1, #0xb4
               	ldrsw	x2, [x2, x0, lsl #2]
               	add	x3, x0, #0x7d0
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x2, x1, #0x158
               	ldrsw	x2, [x2, x0, lsl #2]
               	add	x3, x0, #0xbb8
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x6e
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x3c
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0xa
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
