
write_stdout.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x4, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	xorq	%rbx, %rbx
               	movl	$0x68, %r8d
               	movb	%r8b, (%rsi)
               	movl	$0x1, %edi
               	movq	%rsi, %r8
               	addq	$0x1, %r8
               	movl	$0x69, %r11d
               	movb	%r11b, (%r8)
               	movq	%rsi, %rdx
               	addq	$0x2, %rdx
               	movl	$0xa, %r11d
               	movb	%r11b, (%rdx)
               	movl	$0x3, %edx
               	movq	%rsi, %r11
               	addq	$0x3, %r11
               	movb	%bl, (%r11)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
