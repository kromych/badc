
declared_object_copied_whole.x64:	file format elf64-x86-64

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

<chain>:
               	movq	%rdi, %rcx
               	andq	$0x1, %rcx
               	leaq	<rip>, %rax      # <addr>
               	movb	$0x0, (%rax)
               	leaq	<rip>, %rdx      # <addr>
               	movb	%cl, (%rax)
               	movzbq	(%rax), %r10
               	movb	%r10b, (%rdx)
               	retq

<to_global>:
               	leaq	<rip>, %rax      # <addr>
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movq	$0x0, 0x50(%rax)
               	movl	%edi, 0x54(%rax)
               	leaq	0x1(%rdi), %rcx
               	movl	%ecx, 0x34(%rax)
               	leaq	0x2(%rdi), %rcx
               	movl	%ecx, 0x38(%rax)
               	leaq	0x3(%rdi), %rcx
               	movl	%ecx, 0x44(%rax)
               	retq

<to_local>:
               	leaq	0x1(%rdi), %rax
               	imulq	$0x64, %rdi, %rcx
               	addq	%rcx, %rax
               	retq

<through_member>:
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movups	%xmm14, 0x20(%rdi)
               	movups	%xmm14, 0x30(%rdi)
               	movups	%xmm14, 0x40(%rdi)
               	movq	$0x0, 0x50(%rdi)
               	leaq	0x44(%rdi), %rax
               	movl	%esi, 0x54(%rdi)
               	leaq	0x1(%rsi), %rcx
               	movl	%ecx, (%rax)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	<rip>, %rax      # <addr>
               	movzbq	(%rax), %rcx
               	andq	$-0x2, %rcx
               	movb	%cl, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movzbq	(%rax), %rcx
               	andq	$-0x2, %rcx
               	movb	%cl, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movzbq	(%rax), %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	$0x63, (%rax)
               	movl	$0x63, 0x50(%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x50(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	0x54(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	0x34(%rax), %ecx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movl	0x38(%rax), %ecx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	0x44(%rax), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	callq	<addr>
               	cmpl	$0x195, %eax            # imm = 0x195
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rdi
               	movq	$0x63, 0x10(%rdi)
               	movl	$0x63, 0x54(%rdi)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %esi
               	callq	<addr>
               	leaq	-0x58(%rbp), %rax
               	cmpq	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	0x54(%rax), %ecx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	0x44(%rax), %ecx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x30(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
