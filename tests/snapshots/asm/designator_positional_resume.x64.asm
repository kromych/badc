
designator_positional_resume.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x18, %rsp
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rcx)
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movsbq	(%rsp,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
