
attributed_aggregate_align_floor.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	leaq	<rip>, %rcx
               	testb	$0xf, %cl
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	testb	$0xf, %dl
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	testb	$0xf, %sil
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rax
               	testb	$0x7, %al
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x7, %edi
               	xorl	%r8d, %r8d
               	movq	%rdi, (%rax)
               	movq	%r8, 0x8(%rax)
               	cmpl	$0x7, %edi
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	(%rcx), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	(%rdx), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	(%rsi), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x31, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x35, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	%r8, %rax
               	leave
               	retq
