
struct_conditional_reads_its_arm.x64:	file format elf64-x86-64

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

<pick>:
               	movl	$0x8, %eax
               	movl	$0x9, %ecx
               	testl	%esi, %esi
               	cmovneq	%rcx, %rax
               	retq

<sum>:
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	addq	%rcx, %rdx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movq	(%rdi,%rax,8), %rcx
               	orq	$0x1, %rcx
               	jmp	<addr>
               	movq	(%rdi,%rax,8), %rcx
               	jmp	<addr>
               	movq	%rdx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movl	$0x8, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x8, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	cmpq	$0xa2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
