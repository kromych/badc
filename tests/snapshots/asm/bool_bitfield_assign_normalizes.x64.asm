
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
               	leaq	-0x8(%rbp), %rax
               	movl	$0x0, (%rax)
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x2, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x1, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x1, -0x8(%rbp)
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x1, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x2, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	movb	$0x3, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movl	-0x8(%rbp), %eax
               	andq	$-0x1d, %rax
               	orq	$0x8, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %edx
               	sarq	$0x2, %rdx
               	andq	$0x7, %rdx
               	cmpl	$0x2, %edx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	andq	$-0x1e1, %rax           # imm = 0xFE1F
               	orq	$0x20, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %edx
               	sarq	$0x5, %rdx
               	shlq	$0x3c, %rdx
               	sarq	$0x3c, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	andq	$-0x1d, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %edx
               	sarq	$0x2, %rdx
               	testb	$0x7, %dl
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	andq	$-0x1d, %rax
               	orq	$0x4, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %edx
               	sarq	$0x2, %rdx
               	andq	$0x7, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	andq	$-0x1e1, %rax           # imm = 0xFE1F
               	orq	$0x120, %rax            # imm = 0x120
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, %eax
               	sarq	$0x5, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpl	$-0x7, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	sarq	%rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	sarq	$0x2, %rax
               	andq	$0x7, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
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
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	movzbq	<rip>, %rax # <addr>
               	sarq	%rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	movl	$0x0, (%rcx)
               	xorl	%eax, %eax
               	movb	%al, -0x8(%rbp)
               	movb	$0x2, -0x8(%rbp)
               	movl	-0x8(%rbp), %edx
               	andq	$-0x1d, %rdx
               	movl	%edx, -0x8(%rbp)
               	andq	$-0x1e1, %rdx           # imm = 0xFE1F
               	movl	%edx, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rdx
               	sarq	%rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movb	$0x2, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	andq	$-0x3, %rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	sarq	%rcx
               	testb	$0x1, %cl
               	je	<addr>
               	movl	$0x26, %eax
               	leave
               	retq
               	leave
               	retq
