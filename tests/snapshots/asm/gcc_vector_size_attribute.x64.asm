
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	-0xb0(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0xa0(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	leaq	-0x30(%rbp), %rax
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
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rax
               	leaq	(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x2(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x3(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x4(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x5(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x6(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x8(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x9(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xa(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xb(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xc(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xd(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xe(%rax), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
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
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
