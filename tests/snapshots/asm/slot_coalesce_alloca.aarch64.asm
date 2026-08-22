
slot_coalesce_alloca.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #-0xf0]!
               	stp	x29, x30, [sp, #0xe0]
               	add	x29, sp, #0xe0
               	mov	x0, #0x40               // =64
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x2
               	add	x0, x2, #0x0
               	mov	x1, #0x74               // =116
               	str	x1, [x0]
               	mov	x0, #0x75               // =117
               	str	x0, [x2, #0x8]
               	mov	x0, #0x76               // =118
               	str	x0, [x2, #0x10]
               	mov	x0, #0x77               // =119
               	str	x0, [x2, #0x18]
               	mov	x0, #0x78               // =120
               	str	x0, [x2, #0x20]
               	mov	x0, #0x79               // =121
               	str	x0, [x2, #0x28]
               	mov	x0, #0x7a               // =122
               	str	x0, [x2, #0x30]
               	mov	x0, #0x7b               // =123
               	str	x0, [x2, #0x38]
               	mov	x1, #0x0                // =0
               	mov	x5, #0x74               // =116
               	mov	x0, x1
               	b	<addr>
               	sub	x4, x29, #0xc0
               	sxtw	x3, w0
               	lsl	x6, x3, #3
               	add	x6, x4, x6
               	add	x4, x3, #0x1
               	sxtw	x4, w4
               	mul	x4, x4, x5
               	str	x4, [x6]
               	add	x0, x3, #0x1
               	cmp	x0, #0x18
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0xc0
               	sxtw	x3, w0
               	lsl	x5, x3, #3
               	add	x4, x4, x5
               	ldr	x4, [x4]
               	add	x1, x1, x4
               	add	x0, x3, #0x1
               	cmp	x0, #0x18
               	b.lt	<addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0xe0
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x3, [x2, x1, lsl #3]
               	add	x4, x1, #0x74
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0xe0
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0xe0
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x19, [sp], #0xf0
               	ret
