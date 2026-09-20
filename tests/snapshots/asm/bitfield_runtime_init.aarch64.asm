
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
               	and	x0, x0, #0xf
               	and	x4, x1, #0xf
               	lsl	x1, x4, #4
               	orr	x1, x0, x1
               	and	x5, x2, #0x1f
               	and	x1, x1, #0xffffffffffffe0ff
               	lsl	x5, x5, #8
               	orr	x1, x1, x5
               	and	x3, x3, #0xfffff
               	and	x5, x1, #0xf
               	eor	x5, x5, x0
               	mov	x0, #0x0                // =0
               	cbnz	w5, <addr>
               	mov	w5, w1
               	asr	x5, x5, #4
               	and	x5, x5, #0xf
               	eor	x4, x5, x4
               	cmp	w4, #0x0
               	cset	x4, eq
               	cbz	x4, <addr>
               	mov	w1, w1
               	asr	x1, x1, #8
               	and	x1, x1, #0x1f
               	lsl	x1, x1, #59
               	asr	x1, x1, #59
               	cmp	w1, w2
               	cset	x1, eq
               	cbz	x1, <addr>
               	eor	x0, x3, x3
               	cmp	w0, #0x0
               	cset	x0, eq
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>

<build_mixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x5, x29, #0x10
               	str	xzr, [x5]
               	str	wzr, [x5, #0x8]
               	strh	w0, [x5]
               	and	x6, x1, #0x7
               	ldr	w1, [x5]
               	and	x1, x1, #0xfffffffffff8ffff
               	lsl	x7, x6, #16
               	orr	x1, x1, x7
               	str	w1, [x5]
               	and	x7, x2, #0x3ff
               	and	x1, x1, #0xffffffffe007ffff
               	lsl	x2, x7, #19
               	orr	x1, x1, x2
               	str	w1, [x5]
               	and	x2, x3, #0x7ffff
               	str	w2, [x5, #0x4]
               	str	w4, [x5, #0x8]
               	ldrh	w3, [x5]
               	and	x0, x0, #0xffff
               	cmp	w3, w0
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	mov	w3, w1
               	asr	x3, x3, #16
               	and	x3, x3, #0x7
               	eor	x3, x3, x6
               	cmp	w3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	mov	w1, w1
               	asr	x1, x1, #19
               	and	x1, x1, #0x3ff
               	eor	x1, x1, x7
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	eor	x1, x2, x2
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	cmp	w4, w4
               	cset	x0, eq
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
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	mov	x1, #0x1f               // =31
               	mov	x2, #0xf                // =15
               	mov	x3, #0xfffffff          // =268435455
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, #-0x10              // =-16
               	mov	x1, x0
               	mov	x3, x0
               	bl	<addr>
               	cbnz	w0, <addr>
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
               	cbnz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	mov	x1, #0x7                // =7
               	mov	x2, #0x3ff              // =1023
               	mov	x3, #0x7ffff            // =524287
               	mov	x4, #0x7fffffff         // =2147483647
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
