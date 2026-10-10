
tag_scopes.x64:	file format elf64-x86-64

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
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movl	-0x8(%rbp), %edx
               	cmpl	$0x3, %edx
               	je	<addr>
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzwq	(%rax), %r10
               	movw	%r10w, (%rcx)
               	movzbq	0x2(%rax), %r10
               	movb	%r10b, 0x2(%rcx)
               	xorl	%eax, %eax
               	leave
               	retq
