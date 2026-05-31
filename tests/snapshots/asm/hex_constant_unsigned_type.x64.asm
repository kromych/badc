
hex_constant_unsigned_type.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movabsq	$-0x1, %r11
               	movslq	%r11d, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	xorq	%r10, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	%r11d, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	xorq	%r10, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	%r11d, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	cmpq	%r10, %r11
               	setne	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
