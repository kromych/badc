
va_copy.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	0x10(%rbp), %rcx
               	leaq	0x10(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	movslq	0x10(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	jge	<addr>
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rdx
               	movq	%rdx, %r13
               	movq	(%r13), %rdx
               	leaq	0x10(%rdx), %rdx
               	movq	%rdx, (%r13)
               	leaq	-0x10(%rdx), %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x8(%rbp), %rcx
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x4, %edi
               	movl	$0xa, %esi
               	movl	$0x14, %edx
               	movl	$0x1e, %ecx
               	movl	$0x28, %r8d
               	subq	$0x10, %rsp
               	movq	%r8, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x50, %rsp
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
