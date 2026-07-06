
switch_nested_case_in_compound.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	mov	x2, #0x0                // =0
               	mov	x0, #0x2                // =2
               	cmp	x0, #0x2
               	b.lt	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x7
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	add	x1, x2, x0
               	cmp	x0, #0x64
               	b.ne	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	add	x0, x0, #0x2
               	add	x2, x0, #0x4
               	b	<addr>
               	mov	x17, #0x4000            // =16384
               	orr	x2, x2, x17
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x3
               	b.lt	<addr>
               	b	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x1000            // =4096
               	orr	x2, x1, x17
               	b	<addr>
               	mov	x17, #0x2000            // =8192
               	orr	x2, x1, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x2
               	b.lt	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	mov	x17, #0x106b            // =4203
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	add	x1, x2, x0
               	cmp	x0, #0x64
               	b.ne	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	add	x0, x0, #0x2
               	add	x2, x0, #0x4
               	b	<addr>
               	mov	x17, #0x4000            // =16384
               	orr	x2, x2, x17
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x3
               	b.lt	<addr>
               	b	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x1000            // =4096
               	orr	x2, x1, x17
               	b	<addr>
               	mov	x17, #0x2000            // =8192
               	orr	x2, x1, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
