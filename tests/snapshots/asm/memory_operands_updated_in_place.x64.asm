
memory_operands_updated_in_place.x64:	file format elf64-x86-64

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
               	movzbq	0x6(%rdi), %rax
               	xorq	$0x81, %rax
               	orq	$0x2, %rax
               	movb	%al, 0x6(%rdi)
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
               	subq	$0x28, %rsp
               	leaq	0x10(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	movl	0x10(%rsp), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x0, 0x10(%rsp)
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movb	$-0x6, (%rsp)
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	movzbq	(%rsp), %rax
               	cmpl	$0x26, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x10(%rsp), %rdi
               	movl	$0xc, %esi
               	callq	<addr>
               	leaq	0x10(%rsp), %rdi
               	movswq	0x14(%rsp), %rax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0xff00ff, %esi         # imm = 0xFF00FF
               	movl	$0x5, %edx
               	callq	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0xff01fa, %rax         # imm = 0xFF01FA
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	movzbq	0x16(%rsp), %rax
               	cmpl	$0x8e, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x8(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	callq	<addr>
               	movzwq	0xc(%rsp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
