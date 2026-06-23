
sizeof_function_call_truncation.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	asr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	mov	x0, #0x1234             // =4660
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	asr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	cmp	x0, #0x8c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	asr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0xff00             // =65280
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	asr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	cmp	x0, #0x1fe
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
