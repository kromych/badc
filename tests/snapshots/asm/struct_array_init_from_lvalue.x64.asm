
struct_array_init_from_lvalue.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	xorl	%eax, %eax
               	leaq	(%rsp), %rsi
               	movq	$0x8, (%rsp)
               	movq	$0x3, 0x8(%rsp)
               	leaq	0x10(%rsp), %rdx
               	movq	$0x2, 0x10(%rsp)
               	movq	$0x1, 0x18(%rsp)
               	leaq	0x10(%rdx), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rax, %rcx
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	movq	(%rsi), %rsi
               	orq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x2, %eax
               	jb	<addr>
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
