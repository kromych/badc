
designator_scopes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	movl	0x8(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0xc(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0x10(%rax), %edx
               	addq	%rdx, %rcx
               	cmpl	$0x17, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	<rip>, %rax # <addr>
               	movl	0x28(%rax), %ecx
               	movl	0x2c(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0x8(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0xc(%rax), %edx
               	addq	%rdx, %rcx
               	cmpl	$0x12, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0x8(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0xc(%rax), %edx
               	addq	%rdx, %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %esi
               	addq	%rsi, %rdx
               	movl	0x8(%rcx), %esi
               	addq	%rsi, %rdx
               	movl	0xc(%rcx), %esi
               	addq	%rsi, %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	movl	$0x13, %eax
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	0x28(%rcx), %edx
               	movl	0x2c(%rcx), %esi
               	addq	%rsi, %rdx
               	movl	0x8(%rcx), %esi
               	addq	%rsi, %rdx
               	movl	0xc(%rcx), %ecx
               	addq	%rdx, %rcx
               	cmpl	$0x12, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x1c(%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	0x4(%rax), %ecx
               	movl	0xc(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0x14(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0x1c(%rax), %edx
               	addq	%rdx, %rcx
               	cmpl	$0xd, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	cmpl	$0x0, 0x18(%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %edx
               	movl	0x8(%rcx), %esi
               	addq	%rsi, %rdx
               	movl	0xc(%rcx), %esi
               	addq	%rsi, %rdx
               	movl	0x10(%rcx), %esi
               	addq	%rsi, %rdx
               	cmpl	$0x17, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x0, 0x10(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rcx)
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	0x8(%rcx), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
