
inline_two_word_struct_return.x64:	file format elf64-x86-64

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
               	subq	$0xb0, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rcx
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	leaq	(%rcx,%rsi), %rdi
               	imulq	$0xa, %rdx, %rsi
               	leaq	-0xa0(%rbp), %rcx
               	movl	%esi, (%rcx)
               	movl	$0x1, %esi
               	movq	%rsi, 0x8(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x90(%rbp), %rax
               	leaq	(%rax), %rcx
               	movslq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	addq	%rdx, %rcx
               	leaq	(%rcx), %rdx
               	movslq	0x10(%rax), %rsi
               	leaq	0x10(%rax), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movslq	0x20(%rax), %rdx
               	addq	$0x20, %rax
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	leaq	(%rcx,%rax), %rdx
               	leaq	-0x90(%rbp), %rax
               	movslq	0x30(%rax), %rsi
               	leaq	0x30(%rax), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	movslq	0x40(%rax), %rsi
               	leaq	0x40(%rax), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movslq	0x50(%rax), %rdx
               	addq	$0x50, %rax
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	leaq	(%rcx,%rax), %rdx
               	leaq	-0x90(%rbp), %rax
               	movslq	0x60(%rax), %rsi
               	leaq	0x60(%rax), %rcx
               	movq	0x8(%rcx), %rcx
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	movslq	0x70(%rax), %rdx
               	addq	$0x70, %rax
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	$0x16665, %rax          # imm = 0x16665
               	cmpq	$0x16785, %rax          # imm = 0x16785
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
