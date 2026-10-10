
struct_copy_comma_side_effect.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x0, 0x4(%rcx)
               	leaq	<rip>, %rdi      # <addr>
               	leaq	<rip>, %rsi      # <addr>
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rsi), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movl	$0x9, (%rdi)
               	movl	0x4(%rcx), %edx
               	cmpl	$0xf, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movl	$0x0, 0x4(%rdx)
               	movl	$0x3, %eax
               	movq	(%rsi), %r10
               	movq	%r10, (%rdx)
               	movl	0x8(%rsi), %r10d
               	movl	%r10d, 0x8(%rdx)
               	movb	%al, (%rdx)
               	movl	0x4(%rdx), %edx
               	cmpl	$0xf, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%edx, %edx
               	movl	%edx, 0x4(%rcx)
               	leaq	<rip>, %rsi      # <addr>
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %r8       # <addr>
               	movq	(%r8), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%r8), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movb	$0x1, (%rsi)
               	movl	0x4(%rcx), %ecx
               	cmpl	$0xf, %ecx
               	je	<addr>
               	retq
               	movq	%rdx, %rax
               	retq
