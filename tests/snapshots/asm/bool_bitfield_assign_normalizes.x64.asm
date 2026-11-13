
bool_bitfield_assign_normalizes.x64:	file format elf64-x86-64

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
               	movzbq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	sarq	%rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	movq	%rax, %rcx
               	sarq	$0x2, %rcx
               	andq	$0x7, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	sarq	$0x5, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	sarq	%rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x2, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	andq	$-0x3, %rax
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	sarq	%rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x26, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
