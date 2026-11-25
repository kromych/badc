
tailrec_bitwise_accumulates.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<load_le32>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	shlxq	%rsi, %rdx, %rdx
               	incq	%rax
               	orq	%rdx, %rcx
               	nopl	(%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<mix>:
               	movl	$0x64, %eax
               	movl	$0x9e3779b9, %edx       # imm = 0x9E3779B9
               	xorl	%ecx, %ecx
               	movq	%rax, %rsi
               	imulq	%rdx, %rsi
               	decq	%rax
               	xorq	%rsi, %rcx
               	nopl	(%rax)
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	xorq	$0x5a5a5a5a, %rax       # imm = 0x5A5A5A5A
               	retq

<clear_down>:
               	movl	$0x14, %eax
               	movq	$-0x1, %rcx
               	movl	$0x1, %edx
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	shlxq	%rsi, %rdx, %rdx
               	xorq	$-0x1, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	decq	%rax
               	andq	%rdx, %rcx
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq

<set_down>:
               	movl	$0x9, %ecx
               	xorl	%eax, %eax
               	movl	$0x1, %esi
               	imulq	$0x24924925, %rcx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	shlxq	%rdi, %rsi, %rdx
               	movsbq	%dl, %rdx
               	decq	%rcx
               	orq	%rdx, %rax
               	testl	%ecx, %ecx
               	jg	<addr>
               	retq

<main>:
               	subq	$0x28, %rsp
               	leaq	0x18(%rsp), %rdi
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rdi)
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0x12345678, %eax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x5a5a5a5a, %ecx       # imm = 0x5A5A5A5A
               	movl	$0x1, %eax
               	movl	$0x9e3779b9, %edx       # imm = 0x9E3779B9
               	movq	%rax, %rsi
               	imulq	%rdx, %rsi
               	xorq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x64, %eax
               	jbe	<addr>
               	movl	$0x64, %edi
               	movq	%rcx, 0x8(%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xffff, %ecx           # imm = 0xFFFF
               	movl	$0x1, %esi
               	movq	%rsi, %rax
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	shlxq	%rdx, %rsi, %rdx
               	xorq	$-0x1, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	andq	%rdx, %rcx
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x14, %eax
               	jbe	<addr>
               	movl	$0x14, %edi
               	movq	%rcx, 0x8(%rsp)
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	movsbq	%al, %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
