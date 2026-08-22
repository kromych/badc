
netinet_addr_class_macros.x64:	file format elf64-x86-64

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
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rax
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x20(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movzbq	(%rdx), %rcx
               	xorq	$0xff, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rax), %rcx
               	xorq	$0xff, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	(%rax), %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	0x8(%rax), %edx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movzbq	0xc(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	0xd(%rax), %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movzbq	0xe(%rcx), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x20(%rbp), %rcx
               	movzbq	0xf(%rcx), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rcx
               	movl	(%rcx), %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	0x4(%rcx), %edx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	0x8(%rcx), %edx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movzbq	0xc(%rcx), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x30(%rbp), %rax
               	movzbq	0xd(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x30(%rbp), %rax
               	movzbq	0xe(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x30(%rbp), %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movzbq	(%rax), %rdx
               	xorq	$0xff, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x1(%rax), %rax
               	andq	$0xf, %rax
               	cmpq	$0x2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	$0x1, %edx
               	movq	%rdx, %rsi
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
