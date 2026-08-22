
gcc_vector_size_attribute.x64:	file format elf64-x86-64

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

<identity>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x30(%rbp), %rbx
               	xorq	%rax, %rax
               	movq	%rax, (%rbx)
               	movq	%rax, 0x8(%rbx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movzbq	(%rcx), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %edx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x7(%rcx), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rbx,%rcx), %rdx
               	movzbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movzbq	(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %edx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0xf(%rax), %rcx
               	xorq	$0x10, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	leaq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rsi
               	movq	%rcx, %rsi
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movq	%rax, %rdx
               	movzbq	(%rax), %rdx
               	xorq	$0x9, %rdx
               	movl	%edx, %esi
               	testl	%esi, %esi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rsi, %rsi
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
