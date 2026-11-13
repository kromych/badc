
memory_operands_updated_in_place.x64:	file format elf64-x86-64

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

<hold>:
               	addl	$0x1, (%rdi)
               	retq

<drop_ref>:
               	movl	(%rdi), %eax
               	decq	%rax
               	movl	%eax, (%rdi)
               	testl	%eax, %eax
               	setle	%al
               	movzbq	%al, %rax
               	retq

<bump>:
               	addb	$0x2c, (%rdi)
               	retq

<retag>:
               	movswq	%si, %rsi
               	subw	%si, 0x4(%rdi)
               	retq

<update>:
               	movq	0x8(%rdi), %rax
               	andq	%rsi, %rax
               	orq	$0x100, %rax            # imm = 0x100
               	xorq	%rdx, %rax
               	movq	%rax, 0x8(%rdi)
               	xorb	$-0x7f, 0x6(%rdi)
               	orb	$0x2, 0x6(%rdi)
               	retq

<add_from>:
               	leaq	0x2(%rsi), %rax
               	movslq	%eax, %rax
               	movzwq	(%rdi,%rax,2), %rcx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rcx
               	movw	%cx, (%rdi,%rax,2)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x0, -0x10(%rbp)
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movb	$-0x6, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movzbq	-0x20(%rbp), %rax
               	cmpl	$0x26, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movl	$0xc, %esi
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movswq	-0xc(%rbp), %rax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0xff00ff, %esi         # imm = 0xFF00FF
               	movl	$0x5, %edx
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xff01fa, %rax         # imm = 0xFF01FA
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movzbq	-0xa(%rbp), %rax
               	cmpl	$0x8e, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movzwq	-0x14(%rbp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
