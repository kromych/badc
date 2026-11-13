
stores_overwritten_before_a_read.x64:	file format elf64-x86-64

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

<observe>:
               	movl	(%rdi), %eax
               	movl	%eax, <rip> # <addr>
               	retq

<alias_read>:
               	movl	$0x1, (%rdi)
               	movl	(%rsi), %eax
               	movl	$0x2, (%rdi)
               	retq

<through_call>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movl	$0x3, (%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x4, (%rbx)
               	popq	%rbx
               	leave
               	retq

<via_volatile>:
               	movl	$0x5, (%rdi)
               	movl	(%rdi), %eax
               	movl	$0x6, (%rdi)
               	retq

<partial>:
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, (%rdi)
               	retq

<overwrite>:
               	leaq	0x2(%rsi), %rax
               	movl	%eax, (%rdi)
               	retq

<fields>:
               	movq	0x8(%rdi), %rax
               	andq	%rsi, %rax
               	orq	$0x100, %rax            # imm = 0x100
               	xorq	$0x5, %rax
               	movq	%rax, 0x8(%rdi)
               	movl	$0x3, (%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x0, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	movq	%rdi, %rsi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x20(%rbp), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	-0x20(%rbp), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	-0x20(%rbp), %eax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movl	-0x18(%rbp), %eax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x14(%rbp)
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x28, %esi
               	callq	<addr>
               	movl	-0x20(%rbp), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	$0xff00, %esi           # imm = 0xFF00
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xf105, %rax           # imm = 0xF105
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
