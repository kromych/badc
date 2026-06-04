
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
               	movl	$0x68, %eax
               	movb	%al, (%rsi)
               	movl	$0x1, %edi
               	movq	%rsi, %rax
               	addq	$0x1, %rax
               	movl	$0x69, %ecx
               	movb	%cl, (%rax)
               	movq	%rsi, %rax
               	addq	$0x2, %rax
               	movl	$0xa, %ecx
               	movb	%cl, (%rax)
               	movl	$0x3, %edx
               	movq	%rsi, %rax
               	addq	$0x3, %rax
               	movb	%bl, (%rax)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
