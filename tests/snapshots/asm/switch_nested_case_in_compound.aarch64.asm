
switch_nested_case_in_compound.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf0
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x0               // =0
               	mov	x0, #0x2                // =2
               	cmp	x0, #0x1
               	b.eq	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x7
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	add	x1, x20, x0
               	cmp	x0, #0x64
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	add	x20, x0, #0x4
               	b	<addr>
               	mov	x17, #0x4000            // =16384
               	orr	x20, x20, x17
               	b	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0x1000            // =4096
               	orr	x20, x0, x17
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0x2000            // =8192
               	orr	x20, x0, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x11c
               	sxtw	x1, w20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x1
               	b.eq	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	mov	x17, #0x106b            // =4203
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	add	x1, x20, x0
               	cmp	x0, #0x64
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	add	x20, x0, #0x4
               	b	<addr>
               	mov	x17, #0x4000            // =16384
               	orr	x20, x20, x17
               	b	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0x1000            // =4096
               	orr	x20, x0, x17
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0x2000            // =8192
               	orr	x20, x0, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x131
               	sxtw	x1, w20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
