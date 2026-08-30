
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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x20(%rbp), %rbx
               	xorq	%rax, %rax
               	movq	%rax, (%rbx)
               	movq	%rax, 0x8(%rbx)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x7(%rax), %rdx
               	movzbq	0xf(%rax), %rsi
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	xorq	$0x1, %rax
               	movl	%eax, %ecx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rsi, %rax
               	andq	$0xff, %rax
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rbx), %rax
               	movzbq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movzbq	0x1(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x2(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x3(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x4(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x5(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x6(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x7(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x8(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x9(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xa(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xb(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xc(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xd(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xe(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rbx), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movzbq	(%rax), %rcx
               	movzbq	0xf(%rax), %rdx
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	xorq	$0x1, %rax
               	movl	%eax, %ecx
               	testl	%ecx, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
