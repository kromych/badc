
void_return.x64:	file format elf64-x86-64

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

<bump>:
               	movl	(%rdi), %eax
               	incq	%rax
               	movl	%eax, (%rdi)
               	retq

<copy_pair>:
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	retq

<clamp>:
               	movl	(%rdi), %eax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x0, (%rdi)
               	retq
               	movl	(%rdi), %eax
               	incq	%rax
               	movl	%eax, (%rdi)
               	retq

<forward>:
               	movl	$0x1, (%rdi)
               	retq

<pick>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1, (%rsi)
               	retq
               	movl	$0x2, (%rsi)
               	jmp	<addr>

<discard>:
               	movl	$0x2, (%rdi)
               	retq

<through_typedef>:
               	movl	$0x3, (%rdi)
               	retq

<call_last>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x4, (%rdi)
               	callq	<addr>
               	popq	%rbp
               	retq

<count_down>:
               	testl	%edi, %edi
               	je	<addr>
               	movl	(%rsi), %eax
               	addq	%rdi, %rax
               	movl	%eax, (%rsi)
               	decq	%rdi
               	testl	%edi, %edi
               	jne	<addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$-0x1, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	testl	%eax, %eax
               	je	<addr>
               	movl	%eax, -0x8(%rbp)
               	movl	$0x2, -0x8(%rbp)
               	movl	$0x3, -0x8(%rbp)
               	movl	$0x4, -0x8(%rbp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movl	$0x3, %edi
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x2, -0x8(%rbp)
               	jmp	<addr>
               	movl	-0x8(%rbp), %eax
               	incq	%rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
