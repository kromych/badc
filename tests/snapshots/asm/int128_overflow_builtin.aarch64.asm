
int128_overflow_builtin.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<chk>:
               	sub	sp, sp, #0x40
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x6
               	sxtw	x0, w0
               	sxtw	x2, w2
               	cmp	x0, x2
               	b.eq	<addr>
               	sxtw	x0, w5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, x4
               	b.eq	<addr>
               	add	x0, x5, #0x1
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	cmp	x1, x3
               	b.eq	<addr>
               	add	x0, x5, #0x2
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x490
               	mov	x3, #0x0                // =0
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x450
               	mov	x1, #0x0                // =0
               	mov	x4, #0x0                // =0
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x450
               	mov	x4, x3
               	mov	x6, x2
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x450
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x450
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x5, #0x4                // =4
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x450
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x450
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x5, #0x7                // =7
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	sub	x0, x29, #0x450
               	mov	x1, #0x0                // =0
               	mov	x4, #0x0                // =0
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x450
               	mov	x5, #0xa                // =10
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x450
               	mov	x1, #0x0                // =0
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x450
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	mov	x5, #0xd                // =13
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x2
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x450
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	mov	x3, #0x2                // =2
               	movk	x3, #0x8000, lsl #48
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x450
               	mov	x3, #0x2                // =2
               	movk	x3, #0x8000, lsl #48
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	mov	x5, #0x10               // =16
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	mov	x4, #0x0                // =0
               	sub	x0, x29, #0x460
               	mov	x1, #0x0                // =0
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x460
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	mov	x5, #0x13               // =19
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	sub	x0, x29, #0x460
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0x7fff, lsl #48
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x460
               	mov	x2, #0x1                // =1
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	mov	x5, #0x16               // =22
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x460
               	mov	x1, #0xfffe             // =65534
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0x7fff, lsl #48
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x460
               	mov	x2, #0x0                // =0
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	mov	x4, #0xfffe             // =65534
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x5, #0x19               // =25
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x460
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x460
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x5, #0x1c               // =28
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x460
               	mov	x4, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x460
               	mov	x2, #0x1                // =1
               	mov	x5, #0x1f               // =31
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x460
               	mov	x1, #0x0                // =0
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x460
               	mov	x5, #0x22               // =34
               	mov	x3, x2
               	mov	x6, x5
               	mov	x5, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	mov	x4, #0x0                // =0
               	sub	x0, x29, #0x460
               	mov	x1, #0x0                // =0
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	mov	x5, #-0x8000000000000000 // =-9223372036854775808
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x460
               	mov	x3, #0x25               // =37
               	mov	x6, x3
               	mov	x3, x2
               	mov	x16, x4
               	mov	x4, x5
               	mov	x5, x16
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x460
               	mov	x1, #0x0                // =0
               	mov	x3, #0x0                // =0
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x460
               	mov	x5, #0x28               // =40
               	mov	x3, x2
               	mov	x6, x5
               	mov	x5, x2
               	mov	x4, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	sub	x0, x29, #0x450
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x450
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	mov	x5, #0x2b               // =43
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x450
               	mov	x3, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x0                // =0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x450
               	mov	x2, #0x1                // =1
               	mov	x5, #0x2e               // =46
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x460
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x460
               	mov	x2, #0x1                // =1
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x5, #0x31               // =49
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x460
               	mov	x3, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x460
               	mov	x2, #0x1                // =1
               	mov	x5, #0x34               // =52
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x2
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x480
               	mov	x1, #0x7b               // =123
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	sub	x16, x29, #0x480
               	ldr	w3, [x16]
               	sub	x1, x29, #0x2e0
               	str	x3, [x1]
               	str	x2, [x1, #0x8]
               	mov	x4, #0x7b               // =123
               	mov	x5, #0x37               // =55
               	mov	x3, x2
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x480
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x0, #0x1                // =1
               	mov	x4, #0x0                // =0
               	sub	x1, x29, #0x310
               	str	x4, [x1]
               	str	x3, [x1, #0x8]
               	mov	x5, #0x3a               // =58
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x478
               	mov	x1, #0xfffe             // =65534
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	w1, [x0]
               	mov	x3, #0x0                // =0
               	sub	x16, x29, #0x478
               	ldrsw	x0, [x16]
               	sub	x1, x29, #0x340
               	str	x0, [x1]
               	asr	x0, x0, #63
               	str	x0, [x1, #0x8]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x4, #0xfffe             // =65534
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x5, #0x3d               // =61
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x0
               	mov	x0, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	sub	x0, x29, #0x478
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x0, #0x1                // =1
               	mov	x2, #0x0                // =0
               	sub	x1, x29, #0x370
               	str	x2, [x1]
               	mov	x2, #0x0                // =0
               	str	x2, [x1, #0x8]
               	mov	x2, #0x1                // =1
               	mov	x5, #0x40               // =64
               	mov	x4, x3
               	mov	x6, x5
               	mov	x5, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x470
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	x1, [x0]
               	mov	x0, #0x1                // =1
               	sub	x16, x29, #0x470
               	ldr	x4, [x16]
               	sub	x1, x29, #0x3a0
               	str	x4, [x1]
               	str	x3, [x1, #0x8]
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x5, #0x43               // =67
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x468
               	mov	x1, #0xfff1             // =65521
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	x1, [x0]
               	mov	x4, #0x0                // =0
               	sub	x16, x29, #0x468
               	ldr	x0, [x16]
               	sub	x1, x29, #0x3d0
               	str	x0, [x1]
               	asr	x0, x0, #63
               	str	x0, [x1, #0x8]
               	mov	x0, #0xfff1             // =65521
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x5, #0x46               // =70
               	mov	x6, x5
               	mov	x5, x0
               	mov	x0, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x468
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	str	x1, [x0]
               	mov	x3, #0x1                // =1
               	sub	x16, x29, #0x468
               	ldr	x0, [x16]
               	sub	x1, x29, #0x410
               	str	x0, [x1]
               	asr	x0, x0, #63
               	str	x0, [x1, #0x8]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	mov	x5, #0x49               // =73
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x0
               	mov	x0, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x460
               	mov	x2, #0x0                // =0
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	mov	x3, #0x0                // =0
               	mov	x5, #0x0                // =0
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	sub	x1, x29, #0x460
               	mov	x0, #0x4c               // =76
               	mov	x3, x2
               	mov	x6, x0
               	mov	x0, x5
               	mov	x5, x4
               	mov	x4, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x3, #0x1                // =1
               	sub	x0, x29, #0x450
               	mov	x1, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mov	x5, #0x0                // =0
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	sub	x1, x29, #0x450
               	mov	x0, #0x4f               // =79
               	mov	x4, x3
               	mov	x6, x0
               	mov	x0, x5
               	mov	x5, x2
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x450
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x4, #0x1                // =1
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	sub	x1, x29, #0x450
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x5, #0x52               // =82
               	mov	x0, x4
               	mov	x6, x5
               	mov	x5, x3
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
