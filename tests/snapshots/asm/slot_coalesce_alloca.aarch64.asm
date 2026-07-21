
slot_coalesce_alloca.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x180
               	str	x19, [sp]
               	mov	x0, #0x40               // =64
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x3, sp
               	sub	x3, x3, x17
               	mov	sp, x3
               	add	x0, x3, #0x0
               	mov	x1, #0x74               // =116
               	str	x1, [x0]
               	mov	x0, #0x75               // =117
               	str	x0, [x3, #0x8]
               	mov	x0, #0x76               // =118
               	str	x0, [x3, #0x10]
               	mov	x0, #0x77               // =119
               	str	x0, [x3, #0x18]
               	mov	x0, #0x78               // =120
               	str	x0, [x3, #0x20]
               	mov	x0, #0x79               // =121
               	str	x0, [x3, #0x28]
               	mov	x0, #0x7a               // =122
               	str	x0, [x3, #0x30]
               	mov	x0, #0x7b               // =123
               	str	x0, [x3, #0x38]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	sub	x4, x29, #0x150
               	lsl	x5, x2, #3
               	add	x5, x4, x5
               	add	x4, x2, #0x1
               	sxtw	x4, w4
               	mov	x17, #0x74              // =116
               	mul	x4, x4, x17
               	str	x4, [x5]
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x18
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x150
               	lsl	x5, x2, #3
               	add	x4, x4, x5
               	ldr	x4, [x4]
               	add	x1, x1, x4
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x18
               	b.lt	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x180
               	ldr	x19, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	ldr	x2, [x3, x1, lsl #3]
               	add	x4, x1, #0x74
               	cmp	x2, x4
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x180
               	ldr	x19, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x180
               	ldr	x19, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
