
goto.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x8(%rbp)
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0x5, %r9
               	jge	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %r11
               	addq	$0x64, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x8(%rbp)
               	jmp	<addr>
