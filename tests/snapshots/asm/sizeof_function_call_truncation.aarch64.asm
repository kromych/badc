
sizeof_function_call_truncation.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	asr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtw	x1, w1
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sxtw	x0, w0
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1234             // =4660
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	asr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtw	x1, w1
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sxtw	x0, w0
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
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
               	sxtw	x1, w1
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sxtw	x0, w0
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
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
               	sxtw	x1, w1
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sxtw	x0, w0
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x1fe
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
