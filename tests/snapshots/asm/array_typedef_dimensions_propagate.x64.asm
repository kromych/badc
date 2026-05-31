
array_typedef_dimensions_propagate.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movl	$0x200, %r11d           # imm = 0x200
               	movslq	%r11d, %r11
               	cmpq	$0x200, %r11            # imm = 0x200
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movl	$0x200, %r11d           # imm = 0x200
               	movslq	%r11d, %r11
               	cmpq	$0x200, %r11            # imm = 0x200
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movl	$0x200, %r11d           # imm = 0x200
               	movslq	%r11d, %r11
               	cmpq	$0x200, %r11            # imm = 0x200
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movl	$0x200, %r11d           # imm = 0x200
               	movslq	%r11d, %r11
               	cmpq	$0x200, %r11            # imm = 0x200
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, 0x41(%rdx)
