
variadic_via_fnptr.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r13
               	movq	(%r13), %rax
               	leaq	0x10(%rax), %rax
               	movq	%rax, (%r13)
               	leaq	-0x10(%rax), %rax
               	movslq	(%rax), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, %r13
               	movq	(%r13), %rcx
               	leaq	0x10(%rcx), %rcx
               	movq	%rcx, (%r13)
               	leaq	-0x10(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdx, %r13
               	movq	(%r13), %rdx
               	leaq	0x10(%rdx), %rdx
               	movq	%rdx, (%r13)
               	leaq	-0x10(%rdx), %rdx
               	movslq	(%rdx), %rdx
               	leaq	-0x8(%rbp), %rsi
               	movslq	0x10(%rbp), %rsi
               	imulq	$0x3e8, %rsi, %rsi      # imm = 0x3E8
               	movslq	%esi, %rsi
               	imulq	$0x64, %rax, %rax
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	imulq	$0xa, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x9, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x23a3, %rax           # imm = 0x23A3
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax      # <addr>
               	movl	$0x9, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movq	%rax, %r11
               	callq	*%r11
               	cmpq	$0x23a3, %rax           # imm = 0x23A3
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax      # <addr>
               	movl	$0x9, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movq	%rax, %r11
               	callq	*%r11
               	cmpq	$0x23a3, %rax           # imm = 0x23A3
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
