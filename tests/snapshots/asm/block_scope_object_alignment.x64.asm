
block_scope_object_alignment.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	leaq	0x10(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movl	$0x9, %eax
               	movq	%rax, (%rsp)
               	leaq	<rip>, %rcx # <addr>
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testb	$0x1f, %cl
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	(%rsp), %rcx
               	testb	$0x1f, %cl
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x18, %rcx
               	testb	$0x7, %cl
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	%fs:0x0, %rdx
               	addq	$-0x8, %rdx
               	testb	$0x7, %dl
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x1, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x2, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x3, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x4, %rsi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x6, %rsi
               	je	<addr>
               	leave
               	retq
               	movl	$0xd, %eax
               	movq	%rax, (%rcx)
               	movq	%fs:0x0, %rsi
               	addq	$-0x10, %rsi
               	movb	$0xe, (%rsi)
               	movq	$0xf, (%rdx)
               	movq	(%rcx), %rcx
               	cmpq	$0xd, %rcx
               	jne	<addr>
               	movsbq	(%rsi), %rcx
               	cmpl	$0xe, %ecx
               	jne	<addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$0x63, %ecx
               	jne	<addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$0x65, %ecx
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xc, %eax
               	leave
               	retq
