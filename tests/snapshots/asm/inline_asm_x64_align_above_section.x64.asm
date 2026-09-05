
inline_asm_x64_align_above_section.x64:	file format elf64-x86-64

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
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	nopl	(%rax,%rax)
               	nopw	%cs:(%rax,%rax)
               	nopw	%cs:(%rax,%rax)
               	nopw	%cs:(%rax,%rax)
               	leaq	-<rip>, %rax        # <addr>
               	movq	-0x18(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x20(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	andq	$0x3f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	nopl	(%rax)
               	nopw	%cs:(%rax,%rax)
               	leaq	-<rip>, %rax        # <addr>
               	movq	-0x18(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x20(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	andq	$0x1f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
