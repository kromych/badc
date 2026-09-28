
block_scope_object_alignment.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	leaq	0x10(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$0x9, (%rsp)
               	leaq	<rip>, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi
               	testb	$0x1f, %sil
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	leaq	(%rsp), %rdx
               	testb	$0x1f, %dl
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rdx
               	addq	$-0x18, %rdx
               	testb	$0x7, %dl
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rdi
               	addq	$-0x8, %rdi
               	testb	$0x7, %dil
               	je	<addr>
               	movl	$0x7, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	movq	(%rax), %r8
               	cmpq	$0x1, %r8
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	(%rsi), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	movq	(%rcx), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	0x10(%rcx), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	movl	$0xd, %eax
               	movq	%rax, (%rdx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x10, %rcx
               	movb	$0xe, (%rcx)
               	movq	$0xf, (%rdi)
               	movq	(%rdx), %rdx
               	cmpq	$0xd, %rdx
               	jne	<addr>
               	movsbq	(%rcx), %rcx
               	cmpl	$0xe, %ecx
               	jne	<addr>
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0xf, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x63, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x65, %ecx
               	je	<addr>
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	leaq	(%rbp), %rsp
               	popq	%rbp
               	retq
