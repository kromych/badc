
ssa_call_result_spill.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	ror	x0, x0, x1
               	ret

<ch>:
               	and	x1, x0, x1
               	mvn	x0, x0
               	and	x0, x0, x2
               	eor	x0, x1, x0
               	ret

<bs1>:
               	ror	x1, x0, #0xe
               	ror	x2, x0, #0x12
               	eor	x1, x1, x2
               	ror	x0, x0, #0x29
               	eor	x0, x1, x0
               	ret

<main>:
               	mov	x9, #0x100              // =256
               	mov	x8, #0x200              // =512
               	mov	x7, #0x400              // =1024
               	mov	x6, #0x800              // =2048
               	mov	x5, #0x1000             // =4096
               	mov	x4, #0x2000             // =8192
               	mov	x3, #0x4000             // =16384
               	mov	x2, #0x8000             // =32768
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ror	x10, x5, #0xe
               	ror	x11, x5, #0x12
               	eor	x10, x10, x11
               	ror	x11, x5, #0x29
               	eor	x10, x10, x11
               	and	x11, x5, x4
               	mvn	x12, x5
               	and	x12, x12, x3
               	eor	x11, x11, x12
               	add	x10, x10, x11
               	add	x2, x10, x2
               	ror	x10, x9, #0xe
               	ror	x11, x9, #0x12
               	eor	x10, x10, x11
               	ror	x11, x9, #0x29
               	eor	x10, x10, x11
               	add	x6, x6, x2
               	add	x2, x2, x10
               	add	x1, x0, #0x1
               	mov	x16, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x6
               	mov	x6, x7
               	mov	x7, x8
               	mov	x8, x9
               	mov	x9, x2
               	mov	x2, x16
               	sxtw	x0, w1
               	cmp	x0, #0x4
               	b.lt	<addr>
               	mov	x17, #0xbb19            // =47897
               	movk	x17, #0xde61, lsl #16
               	movk	x17, #0x5d88, lsl #32
               	movk	x17, #0x30a5, lsl #48
               	cmp	x9, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x17, #0xc800            // =51200
               	movk	x17, #0x8, lsl #32
               	movk	x17, #0x4400, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
