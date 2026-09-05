
register_var_asm_operand_sp.x64:	file format elf64-x86-64

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

<bump>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rsp, %rax
               	movq	%rsp, %rcx
               	movq	%rax, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	movq	%rdx, -0x90(%rbp)
               	movq	%rsi, -0x88(%rbp)
               	movq	%rdi, -0x80(%rbp)
               	movq	%r8, -0x78(%rbp)
               	movq	%r9, -0x70(%rbp)
               	movq	%r10, -0x68(%rbp)
               	movq	%r11, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	callq	<addr>
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rcx
               	movq	-0x90(%rbp), %rdx
               	movq	-0x88(%rbp), %rsi
               	movq	-0x80(%rbp), %rdi
               	movq	-0x78(%rbp), %r8
               	movq	-0x70(%rbp), %r9
               	movq	-0x68(%rbp), %r10
               	movq	-0x60(%rbp), %r11
               	movq	%rsp, %rcx
               	movq	%rax, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	movq	%rdx, -0x90(%rbp)
               	movq	%rsi, -0x88(%rbp)
               	movq	%rdi, -0x80(%rbp)
               	movq	%r8, -0x78(%rbp)
               	movq	%r9, -0x70(%rbp)
               	movq	%r10, -0x68(%rbp)
               	movq	%r11, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	callq	<addr>
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rcx
               	movq	-0x90(%rbp), %rdx
               	movq	-0x88(%rbp), %rsi
               	movq	-0x80(%rbp), %rdi
               	movq	-0x78(%rbp), %r8
               	movq	-0x70(%rbp), %r9
               	movq	-0x68(%rbp), %r10
               	movq	-0x60(%rbp), %r11
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rsp, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	%rsp, %rcx
               	movq	%rax, -0xa0(%rbp)
               	movq	%rax, -0x98(%rbp)
               	movq	%rcx, -0x90(%rbp)
               	movq	%rsp, %rax
               	movq	-0x98(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0xa0(%rbp), %rax
               	leaq	-0x10(%rbp), %rax
               	movq	%rbp, %rcx
               	movq	%rax, -0xa0(%rbp)
               	movq	%rax, -0x98(%rbp)
               	movq	%rcx, -0x90(%rbp)
               	movq	%rbp, %rax
               	movq	-0x98(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0xa0(%rbp), %rax
               	leaq	-0x8(%rbp), %rax
               	movq	%rsp, %rcx
               	addq	$0x8, %rcx
               	movq	%rax, -0xa0(%rbp)
               	movq	%rbx, -0x98(%rbp)
               	movq	%rax, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	-0x88(%rbp), %rbx
               	movq	%rbx, %rax
               	movq	-0x90(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0xa0(%rbp), %rax
               	movq	-0x98(%rbp), %rbx
               	movq	-0x18(%rbp), %rax
               	movq	%rsp, %rsi
               	movq	-0x10(%rbp), %rdx
               	movq	-0x8(%rbp), %rdi
               	testq	%rax, %rax
               	je	<addr>
               	testq	%rdx, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	cmpq	%rax, %rdx
               	jae	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	addq	$0x8, %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
