
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
               	movslq	(%rdi), %rax
               	incq	%rax
               	movl	%eax, (%rdi)
               	retq

<copy_pair>:
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	retq

<clamp>:
               	movslq	(%rdi), %rax
               	testl	%eax, %eax
               	jge	<addr>
               	xorl	%eax, %eax
               	movl	%eax, (%rdi)
               	retq
               	movslq	(%rdi), %rax
               	incq	%rax
               	movl	%eax, (%rdi)
               	retq

<forward>:
               	movl	$0x1, %eax
               	movl	%eax, (%rdi)
               	retq

<pick>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	movl	%eax, (%rsi)
               	retq
               	movl	$0x2, %eax
               	movl	%eax, (%rsi)
               	jmp	<addr>

<discard>:
               	movl	$0x2, %eax
               	movl	%eax, (%rdi)
               	retq

<through_typedef>:
               	movl	$0x3, %eax
               	movl	%eax, (%rdi)
               	retq

<call_last>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x4, %eax
               	movl	%eax, (%rdi)
               	callq	<addr>
               	popq	%rbp
               	retq

<count_down>:
               	testl	%edi, %edi
               	je	<addr>
               	movslq	(%rsi), %rax
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
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	cmpl	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	%ecx, (%rax)
               	movl	$0x2, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x4, %ecx
               	movl	%ecx, (%rax)
               	movq	%rax, %rdi
               	callq	<addr>
               	movl	$0x3, %edi
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x2, %ecx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
