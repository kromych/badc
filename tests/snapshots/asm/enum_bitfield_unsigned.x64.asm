
enum_bitfield_unsigned.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<dispatch>:
               	movslq	%edi, %rdi
               	cmpq	$0x5, %rdi
               	jl	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x28, %eax
               	retq
               	movl	$0x32, %eax
               	retq
               	movl	$0x3c, %eax
               	retq
               	movabsq	$-0x1, %rax
               	retq
               	cmpq	$0x4, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x6, %rdi
               	jl	<addr>
               	jmp	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x4, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x5, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x6, %rdi
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	$0x6, %ecx
               	movl	(%rax), %edx
               	andq	$-0x8, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x4, %ecx
               	movl	(%rax), %edx
               	andq	$-0x8, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x2, %ecx
               	movl	(%rax), %edx
               	andq	$-0x8, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	(%rax), %edx
               	andq	$-0x8, %rdx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	andq	$0x7, %rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %edi
               	callq	<addr>
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x32, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
