
brace_elision_anon_and_automatic.x64:	file format elf64-x86-64

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
               	subq	$0xa8, %rsp
               	pushq	%rbx
               	leaq	-0xa0(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	movl	$0x1, -0xa0(%rbp)
               	movl	$0x0, -0x98(%rbp)
               	movl	$0x2, -0x78(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0xa0(%rbp), %rbx
               	addq	$0x30, %rbx
               	movq	(%rdi), %r10
               	movq	%r10, (%rbx)
               	movl	$0x3, -0x68(%rbp)
               	movq	$0x0, -0x60(%rbp)
               	movl	$0x4, -0x58(%rbp)
               	movl	$0x3, -0x50(%rbp)
               	movl	$0x7, -0x48(%rbp)
               	movl	$0x8, -0x44(%rbp)
               	movl	$0x5, -0x40(%rbp)
               	movq	$0x0, -0x38(%rbp)
               	movl	$0x6, -0x30(%rbp)
               	leaq	-0xa0(%rbp), %rax
               	movl	$0x4, -0x28(%rbp)
               	addq	$0x80, %rax
               	movl	$0x7, (%rax)
               	movl	$0xe, 0x4(%rax)
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
