
bool_bitfield_zero_extends.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x100, %rcx
               	orq	$0x10, %rcx
               	movl	%ecx, (%rax)
               	movzbq	0x1(%rax), %rcx
               	andq	$-0x2, %rcx
               	orq	$0x1, %rcx
               	movb	%cl, 0x1(%rax)
               	andq	$0xff, %rcx
               	andq	$-0x3, %rcx
               	orq	$0x0, %rcx
               	movb	%cl, 0x1(%rax)
               	movl	(%rax), %ecx
               	andq	$-0x401, %rcx           # imm = 0xFBFF
               	orq	$0x400, %rcx            # imm = 0x400
               	movl	%ecx, (%rax)
               	movl	%ecx, %ecx
               	andq	$-0x801, %rcx           # imm = 0xF7FF
               	orq	$0x800, %rcx            # imm = 0x800
               	movl	%ecx, (%rax)
               	movzbq	0x1(%rax), %rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movzbq	0x1(%rax), %rax
               	sarq	%rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x40, %esi
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x1(%rax), %rdx
               	andq	$0x1, %rdx
               	shlq	$0x3, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	cmpl	$0x38, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movzbq	0x1(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movzbq	0x1(%rax), %rax
               	sarq	%rax
               	andq	$0x1, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	%ecx, %eax
               	movq	%rax, %rdx
               	sarq	$0xb, %rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	sarq	$0xa, %rax
               	andq	$0x1, %rax
               	shlq	$0x3f, %rax
               	sarq	$0x3f, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	movl	$0x4, %eax
               	leave
               	retq
