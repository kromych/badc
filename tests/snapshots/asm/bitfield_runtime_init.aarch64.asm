
bitfield_runtime_init.aarch64:	file format elf64-littleaarch64

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

<build_packed>:
               	mov	x4, x1
               	mov	x6, x3
               	mov	x5, x2
               	sxtw	x5, w5
               	and	x3, x0, #0xf
               	mov	x17, #0x0               // =0
               	orr	x1, x3, x17
               	and	x7, x4, #0xf
               	lsl	x2, x7, #4
               	orr	x1, x1, x2
               	and	x2, x5, #0x1f
               	mov	w1, w1
               	and	x1, x1, #0xffffffffffffe0ff
               	lsl	x8, x2, #8
               	orr	x1, x1, x8
               	and	x8, x6, #0xfffff
               	mov	x17, #0x0               // =0
               	orr	x9, x8, x17
               	mov	w2, w1
               	and	x10, x2, #0xf
               	eor	x3, x10, x3
               	mov	x0, #0x0                // =0
               	cbnz	x3, <addr>
               	asr	x3, x2, #4
               	and	x3, x3, #0xf
               	eor	x3, x3, x7
               	cmp	w3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	asr	x1, x2, #8
               	and	x1, x1, #0x1f
               	lsl	x1, x1, #59
               	asr	x1, x1, #59
               	cmp	x1, x5
               	cset	x1, eq
               	cbz	x1, <addr>
               	eor	x0, x9, x8
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>

<build_mixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x5, x0
               	mov	x8, x3
               	mov	x7, x2
               	mov	x6, x1
               	sub	x0, x29, #0x10
               	str	xzr, [x0]
               	str	wzr, [x0, #0x8]
               	strh	w5, [x0]
               	and	x3, x6, #0x7
               	ldr	w1, [x0]
               	and	x1, x1, #0xfffffffffff8ffff
               	lsl	x2, x3, #16
               	orr	x1, x1, x2
               	str	w1, [x0]
               	and	x9, x7, #0x3ff
               	mov	w1, w1
               	and	x1, x1, #0xffffffffe007ffff
               	lsl	x2, x9, #19
               	orr	x1, x1, x2
               	str	w1, [x0]
               	and	x10, x8, #0x7ffff
               	mov	x17, #0x0               // =0
               	orr	x2, x10, x17
               	str	w2, [x0, #0x4]
               	str	w4, [x0, #0x8]
               	ldrh	w0, [x0]
               	and	x5, x5, #0xffff
               	cmp	w0, w5
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	mov	w5, w1
               	asr	x5, x5, #16
               	and	x5, x5, #0x7
               	eor	x3, x5, x3
               	cmp	w3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	mov	w1, w1
               	asr	x1, x1, #19
               	and	x1, x1, #0x3ff
               	eor	x1, x1, x9
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	eor	x1, x2, x10
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	cmp	w4, w4
               	cset	x0, eq
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	mov	x1, #0xa                // =10
               	mov	x2, #-0x3               // =-3
               	mov	x3, #0x2345             // =9029
               	movk	x3, #0x1, lsl #16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	mov	x1, #0x1f               // =31
               	mov	x2, #0xf                // =15
               	mov	x3, #0xfffffff          // =268435455
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, #-0x10              // =-16
               	mov	x1, x0
               	mov	x3, x0
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1234             // =4660
               	mov	x1, #0x6                // =6
               	mov	x2, #0x1f4              // =500
               	mov	x3, #0x86a0             // =34464
               	movk	x3, #0x1, lsl #16
               	mov	x4, #-0x4d              // =-77
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	mov	x1, #0x7                // =7
               	mov	x2, #0x3ff              // =1023
               	mov	x3, #0x7ffff            // =524287
               	mov	x4, #0x7fffffff         // =2147483647
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
