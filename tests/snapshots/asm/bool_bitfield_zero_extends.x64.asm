
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
               	movq	%rcx, %rdx
               	orq	$0x800, %rdx            # imm = 0x800
               	movl	%edx, (%rax)
               	movzbq	0x1(%rax), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movzbq	0x1(%rax), %rax
               	sarq	%rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40, %esi
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x1(%rax), %rcx
               	andq	$0x1, %rcx
               	shlq	$0x3, %rcx
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	cmpl	$0x38, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movzbq	0x1(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	0x1(%rax), %rax
               	sarq	%rax
               	andq	$0x1, %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	%edx, %eax
               	movq	%rax, %rcx
               	sarq	$0xb, %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	sarq	$0xa, %rax
               	andq	$0x1, %rax
               	shlq	$0x3f, %rax
               	sarq	$0x3f, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
